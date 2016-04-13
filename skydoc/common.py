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


def leading_whitespace(line):
  """Returns the number of leading whitespace in the line."""
  return len(line) - len(line.lstrip())


def _parse_attribute_docs(attr_doc, lines, index):
  """Extracts attribute documentation.

  Args:
    attr_doc: A dict used to store the extracted attribute documentation.
    lines: List containing the input docstring split into lines.
    index: The index in lines containing "Args:", which begins the argument
        documentation.

  Returns:
    Returns the next index after the attribute documentation to resume
    processing documentation in the caller.
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
    match = re.search(r"^\s*-?\s*(\w+):\s*(.*)", line)
    if match:  # We have found a new attribute
      if attr:
        attr_doc[attr] = escape(desc)
      attr, desc = match.group(1), match.group(2)
    elif attr:
      # Merge documentation when it is multiline
      desc = desc + "\n" + line.strip()
    i += + 1

  if attr:
    attr_doc[attr] = escape(desc).strip()

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
  attr_doc = {}
  examples = []
  lines = doc.split("\n")
  docs = []
  i = 0
  while i < len(lines):
    line = lines[i]
    if line.strip() == ARGS_HEADING:
      i = _parse_attribute_docs(attr_doc, lines, i)
      continue
    elif line.strip() == EXAMPLES_HEADING or line.strip() == EXAMPLE_HEADING:
      i = _parse_example_docs(examples, lines, i)
      continue

    docs.append(line)
    i += 1

  doc = "\n".join(docs).strip()
  examples_doc = textwrap.dedent("\n".join(examples)).strip()
  return doc, attr_doc, examples_doc
