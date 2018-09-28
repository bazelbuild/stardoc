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



import os
import tempfile
import textwrap
import unittest
# internal imports

from google.protobuf import text_format
from skydoc import build_pb2
from skydoc import macro_extractor


class MacroExtractorTest(unittest.TestCase):

  def check_protos(self, src, expected):
    with tempfile.NamedTemporaryFile(mode='w+') as tf:
      tf.write(src)
      tf.flush()

      expected_proto = build_pb2.BuildLanguage()
      text_format.Merge(expected, expected_proto)

      extractor = macro_extractor.MacroDocExtractor()
      extractor.parse_bzl(tf.name)
      proto = extractor.proto()
      self.assertEqual(expected_proto, proto)

  def test_multi_line_description(self):
    src = textwrap.dedent("""\
        def multiline(name, foo=False, visibility=None):
          \"\"\"A rule with multiline documentation.

          Some more documentation about this rule here.

          Args:
            name: A unique name for this rule.
            foo: A test argument.

              Documentation for foo continued here.
            visibility: The visibility of this rule.

              Documentation for visibility continued here.
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
          name: "multiline"
          documentation: "A rule with multiline documentation.\\n\\nSome more documentation about this rule here."
          attribute {
            name: "name"
            type: UNKNOWN
            mandatory: true
            documentation: "A unique name for this rule."
          }
          attribute {
            name: "foo"
            type: BOOLEAN
            mandatory: false
            default: "False"
            documentation: "A test argument.\\n\\nDocumentation for foo continued here."
          }
          attribute {
            name: "visibility"
            type: UNKNOWN
            mandatory: false
            documentation: "The visibility of this rule.\\n\\nDocumentation for visibility continued here."
          }
          type: MACRO
        }
        """)

    self.check_protos(src, expected)

  def test_kwargs(self):
    src = textwrap.dedent("""\
        def with_keyword_args(name, foo=False, **kwargs):
          \"\"\"A rule with keyword args.

          Args:
            name: A unique name for this rule.
            foo: A test argument.
            **kwargs: Keyword arguments.
          \"\"\"
          native.genrule(
              name = name,
              out = ["foo"],
              cmd = "touch $@",
              visibility = visibility,
              **kwargs
          )
        """)

    expected = textwrap.dedent("""\
        rule {
          name: "with_keyword_args"
          documentation: "A rule with keyword args."
          attribute {
            name: "name"
            type: UNKNOWN
            mandatory: true
            documentation: "A unique name for this rule."
          }
          attribute {
            name: "foo"
            type: BOOLEAN
            mandatory: false
            default: "False"
            documentation: "A test argument."
          }
          attribute {
            name: "**kwargs"
            type: UNKNOWN
            mandatory: false
            documentation: "Keyword arguments."
          }
          type: MACRO
        }
        """)

    self.check_protos(src, expected)

  def test_undocumented(self):
    src = textwrap.dedent("""\
        def undocumented(name, visibility=None):
          native.genrule(
              name = name,
              out = ["foo"],
              cmd = "touch $@",
              visibility = visibility,
          )
        """)

    expected = textwrap.dedent("""\
        rule {
          name: "undocumented"
          attribute {
            name: "name"
            type: UNKNOWN
            mandatory: true
          }
          attribute {
            name: "visibility"
            type: UNKNOWN
            mandatory: false
          }
          type: MACRO
        }
        """)

    self.check_protos(src, expected)

  def test_private_macros_skipped(self):
    src = textwrap.dedent("""\
        def _private(name, visibility=None):
          \"\"\"A private macro that should not appear in docs.

          Args:
            name: A unique name for this rule.
            visibility: The visibility of this rule.
          \"\"\"
          native.genrule(
              name = name,
              out = ["foo"],
              cmd = "touch $@",
              visibility = visibility,
          )

        def public(name, visibility=None):
          \"\"\"A public macro that should appear in docs.

          Args:
            name: A unique name for this rule.
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
          name: "public"
          documentation: "A public macro that should appear in docs."
          attribute {
            name: "name"
            type: UNKNOWN
            mandatory: true
            documentation: "A unique name for this rule."
          }
          attribute {
            name: "visibility"
            type: UNKNOWN
            mandatory: false
            documentation: "The visibility of this rule."
          }
          type: MACRO
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
          name: "example_macro"
          documentation: "An example macro."
          attribute {
            name: "name"
            type: UNKNOWN
            mandatory: true
            documentation: "A unique name for this rule."
          }
          attribute {
            name: "foo"
            type: UNKNOWN
            mandatory: true
            documentation: "A test argument."
          }
          attribute {
            name: "visibility"
            type: UNKNOWN
            mandatory: false
            documentation: "The visibility of this rule."
          }
          type: MACRO
        }
        """)

    self.check_protos(src, expected)

  def test_macro_with_example_doc(self):
    src = textwrap.dedent("""\
        def macro_with_example(name, foo, visibility=None):
          \"\"\"Macro with examples.

          Args:
            name: A unique name for this rule.
            foo: A test argument.
            visibility: The visibility of this rule.

          Example:
            Here is an example of how to use this rule.
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
          name: "macro_with_example"
          documentation: "Macro with examples."
          example_documentation: "Here is an example of how to use this rule."
          attribute {
            name: "name"
            type: UNKNOWN
            mandatory: true
            documentation: "A unique name for this rule."
          }
          attribute {
            name: "foo"
            type: UNKNOWN
            mandatory: true
            documentation: "A test argument."
          }
          attribute {
            name: "visibility"
            type: UNKNOWN
            mandatory: false
            documentation: "The visibility of this rule."
          }
          type: MACRO
        }
        """)

    self.check_protos(src, expected)

  def test_macro_with_output_doc(self):
    src = textwrap.dedent("""\
        def macro_with_outputs(name, foo, visibility=None):
          \"\"\"Macro with output documentation.

          Outputs:
            %{name}.jar: A Java archive.
            %{name}_deploy.jar: A Java archive suitable for deployment.

                Only built if explicitly requested.

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
          name: "macro_with_outputs"
          documentation: "Macro with output documentation."
          attribute {
            name: "name"
            type: UNKNOWN
            mandatory: true
            documentation: "A unique name for this rule."
          }
          attribute {
            name: "foo"
            type: UNKNOWN
            mandatory: true
            documentation: "A test argument."
          }
          attribute {
            name: "visibility"
            type: UNKNOWN
            mandatory: false
            documentation: "The visibility of this rule."
          }
          output {
            template: "%{name}.jar"
            documentation: "A Java archive."
          }
          output {
            template: "%{name}_deploy.jar"
            documentation: "A Java archive suitable for deployment.\\n\\nOnly built if explicitly requested."
          }
          type: MACRO
        }
        """)

    self.check_protos(src, expected)

  def test_file_doc_title_only(self):
    src = textwrap.dedent("""\
        \"\"\"Example rules\"\"\"
        """)
    with tempfile.NamedTemporaryFile(mode='w+') as tf:
      tf.write(src)
      tf.flush()

      extractor = macro_extractor.MacroDocExtractor()
      extractor.parse_bzl(tf.name)
      self.assertEqual('Example rules', extractor.title)
      self.assertEqual('', extractor.description)

  def test_file_doc_title_description(self):
    src = textwrap.dedent("""\
        \"\"\"Example rules

        This file contains example Bazel rules.

        Documentation continued here.
        \"\"\"
        """)
    with tempfile.NamedTemporaryFile(mode='w+') as tf:
      tf.write(src)
      tf.flush()

      extractor = macro_extractor.MacroDocExtractor()
      extractor.parse_bzl(tf.name)
      self.assertEqual('Example rules', extractor.title)
      self.assertEqual('This file contains example Bazel rules.'
                       '\n\nDocumentation continued here.',
                       extractor.description)

  def test_file_doc_title_multiline(self):
    src = textwrap.dedent("""\
        \"\"\"Example rules
        for Bazel

        This file contains example Bazel rules.

        Documentation continued here.
        \"\"\"
        """)
    with tempfile.NamedTemporaryFile(mode='w+') as tf:
      tf.write(src)
      tf.flush()

      extractor = macro_extractor.MacroDocExtractor()
      extractor.parse_bzl(tf.name)
      self.assertEqual('Example rules for Bazel', extractor.title)
      self.assertEqual('This file contains example Bazel rules.'
                       '\n\nDocumentation continued here.',
                       extractor.description)

  def test_loads_ignored(self):
    src = textwrap.dedent("""\
      load("//foo/bar:baz.bzl", "foo_library")
      load("//foo/bar:baz.bzl", "foo_test", orig_foo_binary = "foo_binary")
      """)
    expected = ''
    self.check_protos(src, expected)

if __name__ == '__main__':
  unittest.main()
