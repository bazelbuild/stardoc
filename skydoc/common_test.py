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

import unittest

from skydoc import common


class CommonTest(unittest.TestCase):
  """Unit tests for common functions."""

  def test_rule_doc_only(self):
    doc = '"""Rule documentation only docstring."""\n'
    doc, attr_doc = common.parse_attribute_doc(doc)
    self.assertEqual('Rule documentation only docstring.', doc)
    self.assertDictEqual({}, attr_doc)

  def test_rule_and_attribute_doc(self):
    doc = (
        '"""Rule and attribute documentation.\n'
        '\n'
        'Args:\n'
        '  name: A unique name for this rule.\n'
        '  visibility: The visibility of this rule.\n'
        '"""\n')
    expected_attrs = {
        'name': 'A unique name for this rule.',
        'visibility': 'The visibility of this rule.'
    }

    doc, attr_doc = common.parse_attribute_doc(doc)
    self.assertEqual('Rule and attribute documentation.', doc)
    self.assertDictEqual(expected_attrs, attr_doc)

  def test_multi_line_doc(self):
    doc = (
        '"""Multi-line rule and attribute documentation.\n'
        '\n'
        'Rule doc continued here.\n'
        '\n'
        'Args:\n'
        '  name: A unique name for this rule.\n'
        '\n'
        '    Documentation for name continued here.\n'
        '  visibility: The visibility of this rule.\n'
        '\n'
        '    Documentation for visibility continued here.\n'
        '"""\n')
    expected_doc = (
        'Multi-line rule and attribute documentation.\n'
        'Rule doc continued here.')
    expected_attrs = {
        'name': ('A unique name for this rule.\n'
            'Documentation for name continued here'),
        'visibility': ('The visibility of this rule.\n'
            'Documentation for visibility continued here.')
    }

    doc, attr_doc = common.parse_attribute_doc(doc)
    self.assertEqual(expected_doc, doc)
    self.assertDictEqual(expected_attrs, attr_doc)

  def test_invalid_args(self):
    doc = (
        '"""Rule and attribute documentation.\n'
        '\n'
        'Foo:\n'
        '  name: A unique name for this rule.\n'
        '  visibility: The visibility of this rule.\n'
        '"""\n')

    doc, attr_doc = common.parse_attribute_doc(doc)
    self.assertEqual('Rule and attribute documentation.', doc)
    self.assertDictEqual({}, attr_doc)
