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
from xml.sax.saxutils import escape


def leading_whitespace(line):
  return len(line) - len(line.lstrip())

def parse_attribute_doc(doc):
  """Analyzes the documentation string for attributes.

  This looks for the "Args:" separator to fetch documentation for each
  attribute. The "Args" section ends at the first blank line.

  Args:
    doc: The documentation string

  Returns:
    The new documentation string and a dictionary that maps each attribute to
    its documentation
  """
  doc_attr = {}
  lines = doc.split("\n")
  if "Args:" not in lines:
    return doc, doc_attr
  start = lines.index("Args:")

  i = start + 1
  var = None  # Current attribute name
  desc = None  # Description for current attribute
  args_leading_ws = leading_whitespace(lines[start])
  for i in xrange(start + 1, len(lines)):
    # If a blank line is encountered, we have finished parsing the "Args"
    # section.
    if lines[i].strip() and leading_whitespace(lines[i]) == args_leading_ws:
      break
    # In practice, users sometimes add a "-" prefix, so we strip it even
    # though it is not recommended by the style guide
    match = re.search(r"^\s*-?\s*(\w+):\s*(.*)", lines[i])
    if match:  # We have found a new attribute
      if var:
        doc_attr[var] = escape(desc)
      var, desc = match.group(1), match.group(2)
    elif var:
      # Merge documentation when it is multiline
      desc = desc + "\n" + lines[i].strip()

  if var:
    doc_attr[var] = escape(desc)
  doc = "\n".join(lines[:start - 1])
  return doc, doc_attr
