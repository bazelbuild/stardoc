# Copyright 2016 The Bazel Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""Extractor for Skylark rule documentation."""

import ast


from skydoc import build_pb2
from skydoc import common
from skydoc.stubs import attr
from skydoc.stubs import skylark_globals


SKYLARK_STUBS = {
    "attr": attr,
    "aspect": skylark_globals.aspect,
    "DATA_CFG": skylark_globals.DATA_CFG,
    "HOST_CFG": skylark_globals.HOST_CFG,
    "PACKAGE_NAME": skylark_globals.PACKAGE_NAME,
    "REPOSITORY_NAME": skylark_globals.REPOSITORY_NAME,
    "provider": skylark_globals.provider,
    "FileType": skylark_globals.FileType,
    "Label": skylark_globals.Label,
    "select": skylark_globals.select,
    "struct": skylark_globals.struct,
    "repository_rule": skylark_globals.repository_rule,
    "rule": skylark_globals.rule,
}
"""Stubs for Skylark globals to be used to evaluate the .bzl file."""


class RuleDocExtractor(object):
  """Extracts documentation for rules from a .bzl file."""

  def __init__(self):
    """Inits RuleDocExtractor with a new BuildLanguage proto"""
    self.__language = build_pb2.BuildLanguage()
    self.__extracted_rules = {}

  def _process_skylark(self, bzl_file):
    """Evaluates the Skylark code in the .bzl file.

    This function evaluates the Skylark code in the .bzl file as Python against
    Skylark stubs to extract the rules and attributes defined in the file. The
    extracted rules are kept in the __extracted_rules map keyed by rule name.

    Args:
      bzl_file: The .bzl file to evaluate.
    """
    skylark_locals = {}
    compiled = compile(open(bzl_file).read(), bzl_file, "exec")
    exec(compiled) in SKYLARK_STUBS, skylark_locals

    for name, obj in skylark_locals.iteritems():
      if hasattr(obj, "is_rule") and not name.startswith("_"):
        obj.attrs["name"] = attr.AttrDescriptor(
            type=build_pb2.Attribute.UNKNOWN, mandatory=True, name="name")
        self.__extracted_rules[name] = obj

  def _add_rule_doc(self, name, doc):
    """Parses the attribute documentation from the docstring.

    Parses the attribute documentation in the given docstring and associates the
    rule and attribute documentation with the corresponding rule extracted from
    the .bzl file.

    Args:
      name: The name of the rule.
      doc: The docstring extracted for the rule.
    """
    extracted_docs = common.parse_docstring(doc)
    if name in self.__extracted_rules:
      rule = self.__extracted_rules[name]
      rule.doc = extracted_docs.doc
      rule.example_doc = extracted_docs.example_doc
      for attr_name, desc in extracted_docs.attr_docs.iteritems():
        if attr_name in rule.attrs:
          rule.attrs[attr_name].doc = desc

      # Match the output name from the docstring with the corresponding output
      # template name extracted from rule() and store a mapping of output
      # template name to documentation.
      for output_name, desc in extracted_docs.output_docs.iteritems():
        if output_name in rule.outputs:
          output_template = rule.outputs[output_name]
          rule.output_docs[output_template] = desc

  def _extract_docstrings(self, bzl_file):
    """Extracts the docstrings for all public rules in the .bzl file.

    This function parses the .bzl file and extracts the docstrings for all
    public rules in the file that were extracted in _process_skylark. It calls
    _add_rule_doc for to parse the attribute documentation in each docstring
    and associate them with the extracted rules and attributes.

    Args:
      bzl_file: The .bzl file to extract docstrings from.
    """
    try:
      tree = ast.parse(open(bzl_file).read(), bzl_file)
      key = None
      for node in ast.iter_child_nodes(tree):
        if isinstance(node, ast.Assign):
          name = node.targets[0].id
          if not name.startswith("_"):
            key = name
          continue
        elif isinstance(node, ast.Expr) and key:
          self._add_rule_doc(key, node.value.s.strip())
        key = None
    except IOError:
      print("Failed to parse {0}: {1}".format(bzl_file, e.strerror))
      pass

  def _assemble_protos(self):
    """Builds the BuildLanguage protos for the extracted rule documentation.

    Iterates through the map of extracted rule documentation and builds a
    BuildLanguage proto containing the documentation for publid rules extracted
    from the .bzl file.
    """
    rules = []
    for rule_name, rule_desc in self.__extracted_rules.iteritems():
      rule_desc.name = rule_name
      rules.append(rule_desc)
    rules = sorted(rules, key=lambda rule_desc: rule_desc.name)

    for rule_desc in rules:
      rule = self.__language.rule.add()
      rule.name = rule_desc.name
      if rule_desc.doc:
        rule.documentation = rule_desc.doc
      if rule_desc.example_doc:
        rule.example_documentation = rule_desc.example_doc

      attrs = sorted(rule_desc.attrs.values(), cmp=attr.attr_compare)
      for attr_desc in attrs:
        if attr_desc.name.startswith("_"):
          continue
        attr_proto = rule.attribute.add()
        attr_proto.name = attr_desc.name
        if attr_desc.doc:
          attr_proto.documentation = attr_desc.doc
        attr_proto.type = attr_desc.type
        attr_proto.mandatory = attr_desc.mandatory
        # TODO(dzc): Save the default value of the attribute. This will require
        # adding a proto field to the AttributeDefinition proto, perhaps as a
        # oneof.

      for template, doc in rule_desc.output_docs.iteritems():
        output = rule.output.add()
        output.template = template
        output.documentation = doc

  def parse_bzl(self, bzl_file):
    """Extracts the documentation for all public rules from the given .bzl file.

    The Skylark code is first evaluated against stubs to extract rule and
    attributes with complete type information. Then, the .bzl file is parsed
    to extract the docstrings for each of the rules. Finally, the BuildLanguage
    proto is assembled with the extracted rule documentation.

    Args:
      bzl_file: The .bzl file to extract rule documentation from.
    """
    self._process_skylark(bzl_file)
    self._extract_docstrings(bzl_file)
    self._assemble_protos()

  def proto(self):
    """Returns the proto containing the macro documentation."""
    return self.__language

