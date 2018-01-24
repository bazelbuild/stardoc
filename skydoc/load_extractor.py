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

"""Extracts information about symbols loaded from other .bzl files."""

import ast
from collections import namedtuple

LoadSymbol = namedtuple('LoadSymbol', ['label', 'symbol', 'alias'])
"""Information about a symbol loaded from another .bzl file."""


class LoadExtractorError(Exception):
  """Error raised by LoadExtractor"""
  pass


class LoadExtractor(object):
  """Extracts information on symbols load()ed from other .bzl files."""

  def _extract_loads(self, bzl_file):
    """Walks the AST and extracts information on loaded symbols."""
    load_symbols = []
    try:
      tree = None
      with open(bzl_file) as f:
        tree = ast.parse(f.read(), bzl_file)
      key = None
      for node in ast.iter_child_nodes(tree):
        if not isinstance(node, ast.Expr):
          continue
        call = node.value
        if (not isinstance(call, ast.Call) or
            not isinstance(call.func, ast.Name) or
            call.func.id != 'load'):
          continue

        args = []
        for arg in call.args:
          if not isinstance(arg, ast.Str):
            raise LoadExtractorError(
                'Only string literals in load statments are supported.')
          args.append(arg.s)
        kwargs = {}
        for keyword in call.keywords:
          if not isinstance(keyword.value, ast.Str):
            raise LoadExtractorError(
                'Only string literals in load statments are supported.')
          kwargs[keyword.arg] = keyword.value.s

        label = args[0]
        for arg in args[1:]:
          load_symbol = LoadSymbol(label, arg, None)
          load_symbols.append(load_symbol)
        for alias, symbol in kwargs.iteritems():
          load_symbol = LoadSymbol(label, symbol, alias)
          load_symbols.append(load_symbol)

    except IOError:
      print("Failed to parse {0}: {1}".format(bzl_file, e.strerror))
      pass

    return load_symbols

  def _validate_loads(self, load_symbols):
    """Checks that there are no collisions from the extracted symbols."""
    symbols = set()
    for load in load_symbols:
      if load.alias:
        if load.alias in symbols:
          raise LoadExtractorError(
              "Load symbol conflict: %s (aliased from %s) loaded from %s" %
              (load.alias, load.symbol, load.label))
        else:
          symbols.add(load.alias)
      elif load.symbol in symbols:
        raise LoadExtractorError(
            "Load symbol conflict: %s loaded from %s" %
            (load.alias, load.label))
      else:
        symbols.add(load.symbol)

  def extract(self, bzl_file):
    """Extracts symbols loaded from other .bzl files.

    Walks the AST of the .bzl files and extracts information about symbols
    loaded from other .bzl files from load() calls. Then, validate the
    extracted symbols to check that all symbols are unique.

    Note that only load() calls where all arguments are string literals
    (ast.Str) are supported.

    Args:
      bzl_file: The .bzl file to extract load symbols from.

    Returns:
      List of LoadSymbol objects.
    """
    load_symbols = self._extract_loads(bzl_file)
    self._validate_loads(load_symbols)
    return load_symbols
