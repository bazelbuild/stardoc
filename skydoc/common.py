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

"""Common functions for skydoc."""

import re
import textwrap
from xml.sax.saxutils import escape


ARGS_HEADING = "Args:"
EXAMPLES_HEADING = "Examples:"
EXAMPLE_HEADING = "Example:"
OUTPUTS_HEADING = "Outputs:"


class InputError(Exception):
  pass


class ExtractedDocs(object):
  """Simple class to contain the documentation extracted from a docstring."""

  def __init__(self, doc, attr_docs, example_doc, output_docs):
    self.doc = doc
    self.attr_docs = attr_docs
    self.example_doc = example_doc
    self.output_docs = output_docs


def leading_whitespace(line):
  """Returns the number of leading whitespace in the line."""
  return len(line) - len(line.lstrip())


def validate_strip_prefix(strip_prefix, bzl_files):
  if not strip_prefix:
    return strip_prefix
  prefix = strip_prefix if strip_prefix.endswith('/') else strip_prefix + '/'
  for path in bzl_files:
    if not path.startswith(prefix):
      raise InputError(
          'Input file %s does not have path prefix %s. Directory prefix set '
          'with --strip_prefix must be common to all input files.'
          % (path, strip_prefix))
  return prefix

def _parse_attribute_docs(attr_docs, lines, index):
  """Extracts documentation in the form of name: description.

  This includes documentation for attributes and outputs.

  Args:
    attr_docs: A dict used to store the extracted documentation.
    lines: List containing the input docstring split into lines.
    index: The index in lines containing the heading that begins the
        documentation, such as "Args:" or "Outputs:".

  Returns:
    Returns the next index after the documentation to resume processing
    documentation in the caller.
  """
  attr = None  # Current attribute name
  desc = None  # Description for current attribute
  args_leading_ws = leading_whitespace(lines[index])
  i = index + 1
  while i < len(lines):
    line = lines[i]
    # If a blank line is encountered, we have finished parsing the "Args"
    # section.
    if line.strip() and leading_whitespace(line) == args_leading_ws:
      break
    # In practice, users sometimes add a "-" prefix, so we strip it even
    # though it is not recommended by the style guide
    match = re.search(r"^\s*-?\s*([`\{\}\%\.\w]+):\s*(.*)", line)
    if match:  # We have found a new attribute
      if attr:
        attr_docs[attr] = escape(desc)
      attr, desc = match.group(1), match.group(2)
    elif attr:
      # Merge documentation when it is multiline
      desc = desc + "\n" + line.strip()
    i += + 1

  if attr:
    attr_docs[attr] = escape(desc).strip()

  return i


def _parse_example_docs(examples, lines, index):
  """Extracts example documentation.

  Args:
    examples: A list to contain the lines containing the example documentation.
    lines: List containing the input docstring split into lines.
    index: The index in lines containing "Example[s]:", which begins the
        example documentation.

  Returns:
    Returns the next index after the attribute documentation to resume
    processing documentation in the caller.
  """
  heading_leading_ws = leading_whitespace(lines[index])
  i = index + 1
  while i < len(lines):
    line = lines[i]
    if line.strip() and leading_whitespace(line) == heading_leading_ws:
      break
    examples.append(line)
    i += 1

  return i


def parse_docstring(doc):
  """Analyzes the documentation string for attributes.

  This looks for the "Args:" separator to fetch documentation for each
  attribute. The "Args" section ends at the first blank line.

  Args:
    doc: The documentation string

  Returns:
    The new documentation string and a dictionary that maps each attribute to
    its documentation
  """
  attr_docs = {}
  output_docs = {}
  examples = []
  lines = doc.split("\n")
  docs = []
  i = 0
  while i < len(lines):
    line = lines[i]
    if line.strip() == ARGS_HEADING:
      i = _parse_attribute_docs(attr_docs, lines, i)
      continue
    elif line.strip() == EXAMPLES_HEADING or line.strip() == EXAMPLE_HEADING:
      i = _parse_example_docs(examples, lines, i)
      continue
    elif line.strip() == OUTPUTS_HEADING:
      i = _parse_attribute_docs(output_docs, lines, i)
      continue

    docs.append(line)
    i += 1

  doc = "\n".join(docs).strip()
  examples_doc = textwrap.dedent("\n".join(examples)).strip()
  return ExtractedDocs(doc, attr_docs, examples_doc, output_docs)
