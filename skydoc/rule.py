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

"""Representations used for rendering documentation templates."""

import mistune
from skydoc import build_pb2

class Attribute(object):
  """Representation of an attribute used to render documentation templates."""

  NAME_LINK = '<a href="http://bazel.io/docs/build-ref.html#name">Name</a>'
  LABEL_LINK = '<a href="http://bazel.io/docs/build-ref.html#labels">Label</a>'
  LABELS_LINK = (
      '<a href="http://bazel.io/docs/build-ref.html#labels">labels</a>')

  def __init__(self, proto):
    self.__proto = proto
    self.name = proto.name
    self.type = self._get_type_str(proto)
    if proto.name == 'name' and not proto.documentation:
      self.documentation = 'A unique name for this rule.'
    else:
      self.documentation = mistune.markdown(proto.documentation)

  def _get_type_str(self, proto):
    type_str = ''
    if proto.type == build_pb2.Attribute.INTEGER:
      type_str = 'Integer'
    elif proto.type == build_pb2.Attribute.STRING:
      type_str = 'String'
    elif proto.type == build_pb2.Attribute.LABEL:
      type_str = self.LABEL_LINK
    elif proto.type == build_pb2.Attribute.OUTPUT:
      type_str = 'Output'
    elif proto.type == build_pb2.Attribute.STRING_LIST:
      type_str = 'List of strings'
    elif proto.type == build_pb2.Attribute.LABEL_LIST:
      type_str = 'List of %s' % self.LABELS_LINK
    elif proto.type == build_pb2.Attribute.OUTPUT_LIST:
      type_str = 'List of outputs'
    elif proto.type == build_pb2.Attribute.DISTRIBUTION_SET:
      type_str = 'Distribution Set'
    elif proto.type == build_pb2.Attribute.LICENSE:
      type_str = 'License'
    elif proto.type == build_pb2.Attribute.STRING_DICT:
      type_str = 'Dictionary mapping strings to string'
    elif proto.type == build_pb2.Attribute.FILESET_ENTRY_LIST:
      type_str = 'List of FilesetEntry'
    elif proto.type == build_pb2.Attribute.LABEL_LIST_DICT:
      type_str = 'Dictionary mapping strings to lists of %s' % self.LABELS_LINK
    elif proto.type == build_pb2.Attribute.STRING_LIST_DICT:
      type_str = 'Dictionary mapping strings to lists of strings'
    elif proto.type == build_pb2.Attribute.BOOLEAN:
      type_str = 'Boolean'
    elif proto.type == build_pb2.Attribute.TRISTATE:
      type_str = 'Tristate'
    elif proto.type == build_pb2.Attribute.INTEGER_LIST:
      type_str = 'List of integers'
    elif proto.type == build_pb2.Attribute.STRING_DICT_UNARY:
      type_str = 'String Dict Unary'
    elif proto.type == build_pb2.Attribute.LABEL_DICT_UNARY:
      type_str = 'Label Dict Unary'
    elif proto.type == build_pb2.Attribute.SELECTOR_LIST:
      type_str = 'Selector List'
    else:
      if proto.name == 'name':
        type_str = self.NAME_LINK
      else:
        type_str = 'Unknown'
    type_str += '; Required' if proto.mandatory else '; Optional'
    return type_str

class Rule(object):
  """Representation of a rule used to render documentation templates."""

  def __init__(self, proto):
    self.__proto = proto
    self.name = proto.name
    self.documentation = proto.documentation
    self.signature = self._get_signature(proto)
    self.attributes = []
    for attribute in proto.attribute:
      self.attributes.append(Attribute(attribute))

  def _get_signature(self, proto):
    """Returns the rule signature for this rule."""
    signature = proto.name + '('
    for i in range(len(proto.attribute)):
      attr = proto.attribute[i]
      signature += '<a href="#%s.%s">%s</a>' % (proto.name, attr.name,
                                                attr.name)
      if i < len(proto.attribute) - 1:
        signature += ', '
    signature += ')'
    return signature

class RuleSet(object):
  """Representation of a rule set used to render documentation templates."""

  def __init__(self, file_name, language, title, description):
    self.file_name = file_name
    self.name = file_name.replace('.bzl', '')
    self.language = language
    self.title = title if title else "%s Rules" % self.name
    self.description = description
    self.rules = []
    for rule_proto in language.rule:
      self.rules.append(Rule(rule_proto))
