# Copyright 2017 The Bazel Authors. All rights reserved.
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

from skydoc import load_extractor

class LoadExtractorTest(unittest.TestCase):

  def check_symbols(self, src, expected):
    with tempfile.NamedTemporaryFile() as tf:
      tf.write(src)
      tf.flush()

      extractor = load_extractor.LoadExtractor()
      load_symbols = extractor.extract(tf.name)

      self.assertEqual(expected, load_symbols)

  def test_load(self):
    src = textwrap.dedent("""\
      load("//foo/bar:bar.bzl", "foo_library")
      load("//foo/bar:baz.bzl", "foo_test", orig_foo_binary = "foo_binary")
      """)
    expected = [
      load_extractor.LoadSymbol('//foo/bar:bar.bzl', 'foo_library', None),
      load_extractor.LoadSymbol('//foo/bar:baz.bzl', 'foo_test', None),
      load_extractor.LoadSymbol('//foo/bar:baz.bzl', 'foo_binary',
                                'orig_foo_binary'),
    ]
    self.check_symbols(src, expected)

  def raises_error(self, src):
    with tempfile.NamedTemporaryFile() as tf:
      tf.write(src)
      tf.flush()

      extractor = load_extractor.LoadExtractor()
      self.assertRaises(load_extractor.LoadExtractorError,
                        extractor.extract, tf.name)

  def test_invalid_non_string_literal_in_label(self):
    src = textwrap.dedent("""\
      load(load_label, "foo_library")
      """)
    self.raises_error(src)

  def test_invalid_non_string_literal_in_keywords(self):
    src = textwrap.dedent("""\
        load("//foo/bar:bar.bzl", loaded_symbol)
      """)
    self.raises_error(src)

  def test_invalid_symbol_conflict(self):
    src = textwrap.dedent("""\
        load("//foo:bar.bzl", "foo_binary", "foo_library")
        load("//foo:baz.bzl", "foo_library")
      """)
    self.raises_error(src)

  def test_invalid_symbol_alias_conflict(self):
    src = textwrap.dedent("""\
        load("//foo:bar.bzl", foo_library="some_foo_library")
        load("//foo:baz.bzl", "foo_library")
      """)
    self.raises_error(src)

  def test_invalid_duplicate_symbol_loaded(self):
    src = textwrap.dedent("""\
        load("//foo:bar.bzl", "foo_library", "foo_library")
      """)
    self.raises_error(src)


if __name__ == '__main__':
  unittest.main()
