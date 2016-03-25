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

import os
import tempfile
import textwrap
from google.protobuf import text_format
from skydoc import rule_extractor
from src.main.protobuf import build_pb2


class RuleExtractorTest(unittest.TestCase):

  def check_protos(self, src, expected):
    with tempfile.NamedTemporaryFile() as tf:
      tf.write(src)
      tf.flush()

      expected_proto = build_pb2.BuildLanguage()
      text_format.Merge(expected, expected_proto)

      extractor = rule_extractor.RuleDocExtractor()
      extractor.parse_bzl(tf.name)
      proto = extractor.proto()
      self.assertEqual(expected_proto, proto)

  def test_all_types(self):
    src = textwrap.dedent("""\
        def impl(ctx):
          return struct()

        all_types = rule(
            implementation = impl,
            attrs = {
                "arg_bool": attr.bool(),
                "arg_int": attr.int(),
                "arg_int_list": attr.int_list(),
                "arg_label": attr.label(),
                "arg_label_list": attr.label_list(),
                "arg_license": attr.license(),
                "arg_output": attr.output(),
                "arg_output_list": attr.output_list(),
                "arg_string": attr.string(),
                "arg_string_dict": attr.string_dict(),
                "arg_string_list": attr.string_list(),
                "arg_string_list_dict": attr.string_list_dict(),
            },
        )
        \"\"\"Test rule with all types.

        Args:
          name: A unique name for this rule.
          arg_bool: A boolean argument.
          arg_int: An integer argument.
          arg_int_list: A list of integers argument.
          arg_label: A label argument.
          arg_label_list: A list of labels argument.
          arg_license: A license argument.
          arg_output: An output argument.
          arg_output_list: A list of outputs argument.
          arg_string: A string argument.
          arg_string_dict: A dictionary mapping string to string argument.
          arg_string_list: A list of strings argument.
          arg_string_list_dict: A dictionary mapping string to list of string argument.
        \"\"\"
        """)

    expected = textwrap.dedent("""
        rule {
          name: "all_types"
          documentation: "Test rule with all types."
          attribute {
            name: "name"
            type: UNKNOWN
            mandatory: true
            documentation: "A unique name for this rule."
          }
          attribute {
            name: "arg_bool"
            type: BOOLEAN
            mandatory: false
            documentation: "A boolean argument."
          }
          attribute {
            name: "arg_int"
            type: INTEGER
            mandatory: false
            documentation: "An integer argument."
          }
          attribute {
            name: "arg_int_list"
            type: INTEGER_LIST
            mandatory: false
            documentation: "A list of integers argument."
          }
          attribute {
            name: "arg_label"
            type: LABEL
            mandatory: false
            documentation: "A label argument."
          }
          attribute {
            name: "arg_label_list"
            type: LABEL_LIST
            mandatory: false
            documentation: "A list of labels argument."
          }
          attribute {
            name: "arg_license"
            type: LICENSE
            mandatory: false
            documentation: "A license argument."
          }
          attribute {
            name: "arg_output"
            type: OUTPUT
            mandatory: false
            documentation: "An output argument."
          }
          attribute {
            name: "arg_output_list"
            type: OUTPUT_LIST
            mandatory: false
            documentation: "A list of outputs argument."
          }
          attribute {
            name: "arg_string"
            type: STRING
            mandatory: false
            documentation: "A string argument."
          }
          attribute {
            name: "arg_string_dict"
            type: STRING_DICT
            mandatory: false
            documentation: "A dictionary mapping string to string argument."
          }
          attribute {
            name: "arg_string_list"
            type: STRING_LIST
            mandatory: false
            documentation: "A list of strings argument."
          }
          attribute {
            name: "arg_string_list_dict"
            type: STRING_LIST_DICT
            mandatory: false
            documentation: "A dictionary mapping string to list of string argument."
          }
        }
        """)

    self.check_protos(src, expected)

  def test_undocumented(self):
    src = textwrap.dedent("""\
        def _impl(ctx):
          return struct()

        undocumented = rule(
            implementation = _impl,
            attrs = {
                "arg_label": attr.label(),
                "arg_string": attr.string(),
            },
        )
        """)

    expected = textwrap.dedent("""\
        rule {
          name: "undocumented"
          documentation: ""
          attribute {
            name: "name"
            type: UNKNOWN
            mandatory: true
            documentation: ""
          }
          attribute {
            name: "arg_label"
            type: LABEL
            mandatory: false
            documentation: ""
          }
          attribute {
            name: "arg_string"
            type: STRING
            mandatory: false
            documentation: ""
          }
        }
        """)

    self.check_protos(src, expected)

  def test_private_rules_skipped(self):
    src = textwrap.dedent("""\
        def _private_impl(ctx):
          return struct()

        def _public_impl(ctx):
          return struct()

        _private = rule(
            implementation = _private_impl,
            attrs = {
                "arg_label": attr.label(),
                "arg_string": attr.string(),
            },
        )
        \"\"\"A private rule that should not appear in documentation.

        Args:
          name: A unique name for this rule.
          arg_label: A label argument.
          arg_string: A string argument.
        \"\"\"

        public = rule(
            implementation = _public_impl,
            attrs = {
                "arg_label": attr.label(),
                "arg_string": attr.string(),
            },
        )
        \"\"\"A public rule that should appear in documentation.

        Args:
          name: A unique name for this rule.
          arg_label: A label argument.
          arg_string: A string argument.
        \"\"\"
        """)

    expected = textwrap.dedent("""
        rule {
          name: "public"
          documentation: "A public rule that should appear in documentation."
          attribute {
            name: "name"
            type: UNKNOWN
            mandatory: true
            documentation: "A unique name for this rule."
          }
          attribute {
            name: "arg_label"
            type: LABEL
            mandatory: false
            documentation: "A label argument."
          }
          attribute {
            name: "arg_string"
            type: STRING
            mandatory: false
            documentation: "A string argument."
          }
        }
        """)

    self.check_protos(src, expected)

  def test_multi_line_description(self):
    src = textwrap.dedent("""\
        def _impl(ctx):
          return struct()

        multiline = rule(
            implementation = _impl,
            attrs = {
                "arg_bool": attr.bool(),
                "arg_label": attr.label(),
            },
        )
        \"\"\"A rule with multiline documentation.

        Some more documentation about this rule here.

        Args:
          name: A unique name for this rule.
          arg_bool: A boolean argument.

            Documentation for arg_bool continued here.
          arg_label: A label argument.

            Documentation for arg_label continued here.
        \"\"\"
        """)

    expected = textwrap.dedent("""\
        rule {
          name: "multiline"
          documentation: "A rule with multiline documentation.\\n\\nSome more documentation about this rule here."
          attribute {
            name: "name"
            type: UNKNOWN
            mandatory: true
            documentation: "A unique name for this rule."
          }
          attribute {
            name: "arg_bool"
            type: BOOLEAN
            mandatory: false
            documentation: "A boolean argument.\\n\\nDocumentation for arg_bool continued here."
          }
          attribute {
            name: "arg_label"
            type: LABEL
            mandatory: false
            documentation: "A label argument.\\n\\nDocumentation for arg_label continued here."
          }
        }
        """)

    self.check_protos(src, expected)

  def test_rule_macro_mix(self):
    src = textwrap.dedent("""\
        def _impl(ctx):
          return struct()

        example_rule = rule(
            implementation = _impl,
            attrs = {
                "arg_label": attr.label(),
                "arg_string": attr.string(),
            },
        )
        \"\"\"An example rule.

        Args:
          name: A unique name for this rule.
          arg_label: A label argument.
          arg_string: A string argument.
        \"\"\"

        def example_macro(name, foo, visibility=None):
          \"\"\"An example macro.

          Args:
            name: A unique name for this rule.
            foo: A test argument.
            visibility: The visibility of this rule.
          \"\"\"
          native.genrule(
              name = name,
              out = ["foo"],
              cmd = "touch $@",
              visibility = visibility,
          )
        """)

    expected = textwrap.dedent("""\
        rule {
          name: "example_rule"
          documentation: "An example rule."
          attribute {
            name: "name"
            type: UNKNOWN
            mandatory: true
            documentation: "A unique name for this rule."
          }
          attribute {
            name: "arg_label"
            type: LABEL
            mandatory: false
            documentation: "A label argument."
          }
          attribute {
            name: "arg_string"
            type: STRING
            mandatory: false
            documentation: "A string argument."
          }
        }
        """)

    self.check_protos(src, expected)

if __name__ == '__main__':
  unittest.main()
