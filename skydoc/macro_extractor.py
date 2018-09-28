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

"""Extractor for Skylark macro documentation."""

import ast
# internal imports

from skydoc import build_pb2
from skydoc import common


def get_type(expr):
  """Find the type of an expression.

  Args:
    expr: The expression to check.

  Returns:
    The type of the expression.
  """
  if isinstance(expr, ast.Num):
    return build_pb2.Attribute.INTEGER
  elif isinstance(expr, ast.Str):
    return build_pb2.Attribute.STRING
  elif isinstance(expr, ast.List):
    return build_pb2.Attribute.STRING_LIST
  elif isinstance(expr, ast.Name) and (expr.id == "True" or expr.id == "False"):
    return build_pb2.Attribute.BOOLEAN
  elif hasattr(ast, 'NameConstant') and isinstance(expr, ast.NameConstant) and (expr.value == True or expr.value == False):
    return build_pb2.Attribute.BOOLEAN
  else:
    return build_pb2.Attribute.UNKNOWN

class MacroDocExtractor(object):
  """Extracts documentation for macros from a .bzl file"""

  def __init__(self):
    """Inits MacroDocExtractor with a new BuildLanguage proto"""
    self.__language = build_pb2.BuildLanguage()
    self.title = ""
    self.description = ""

  def _add_file_docs(self, tree):
    """Extracts the file docstring of the .bzl file."""
    docstring = ast.get_docstring(tree)
    if docstring == None:
      return
    lines = docstring.split("\n")
    i = 0
    for line in lines:
      if line != '':
        i = i + 1
      else:
        break

    self.title = " ".join(lines[:i])
    self.description = "\n".join(lines[i + 1:])

  def _add_macro_doc(self, stmt):
    # The defaults array contains default values for the last arguments.
    # The first shift arguments are mandatory.
    shift = len(stmt.args.args) - len(stmt.args.defaults)

    rule = self.__language.rule.add()
    rule.name = stmt.name
    rule.type = build_pb2.RuleDefinition.MACRO

    doc = ast.get_docstring(stmt)
    if doc:
      extracted_docs = common.parse_docstring(doc)
      rule.documentation = extracted_docs.doc
      if extracted_docs.example_doc:
        rule.example_documentation = extracted_docs.example_doc
    else:
      extracted_docs = common.ExtractedDocs(
          doc="", attr_docs={}, example_doc="", output_docs={})

    for i in range(len(stmt.args.args)):
      attr = rule.attribute.add()
      attr_name = stmt.args.args[i].id if hasattr(stmt.args.args[i], 'id') else stmt.args.args[i].arg
      attr.name = attr_name

      if attr_name in extracted_docs.attr_docs:
        attr.documentation = extracted_docs.attr_docs[attr_name]

      if i < shift:  # The first arguments are mandatory
        attr.mandatory = True
        attr.type = build_pb2.Attribute.UNKNOWN
      else:
        node = stmt.args.defaults[i - shift]
        attr.mandatory = False
        attr.type = get_type(node)
        if attr.type == build_pb2.Attribute.BOOLEAN:
          attr.default = str(node.value) if hasattr(node, 'value') else node.id

    if stmt.args.kwarg:
      attr = rule.attribute.add()
      attr_name = '**' + (stmt.args.kwarg.arg if hasattr(stmt.args.kwarg, 'arg') else stmt.args.kwarg)
      attr.name = attr_name
      attr.mandatory = False
      attr.type = build_pb2.Attribute.UNKNOWN
      if attr_name in extracted_docs.attr_docs:
        attr.documentation = extracted_docs.attr_docs[attr_name]

    for template, doc in extracted_docs.output_docs.items():
      output = rule.output.add()
      output.template = template
      output.documentation = doc

  def parse_bzl(self, bzl_file):
    """Extracts documentation for all public macros from the given .bzl file.

    Args:
      bzl_file: The .bzl file to extract macro documentation from.
    """
    try:
      with open(bzl_file) as f:
        tree = ast.parse(f.read(), bzl_file)
      self._add_file_docs(tree)
      for stmt in tree.body:
        if isinstance(stmt, ast.FunctionDef) and not stmt.name.startswith("_"):
          self._add_macro_doc(stmt)
    except IOError as e:
      # Ignore missing extension
      print("Failed to parse {0}: {1}".format(bzl_file, e.strerror))
      pass

  def proto(self):
    """Returns the proto containing the macro documentation."""
    return self.__language

