---
layout: default
title: Writing Documentation
---

<nav class="toc">
  <h2>Contents</h2>
  <ul>
    <li><a href="#rule-documentation">Rule Documentation</a></li>
    <li><a href="#macro-documentation">Macro Documentation</a></li>
    <li><a href="#file-documentation">File Documentation</a></li>
  </ul>
</nav>

Since Skylark is a subset of Python, it uses Python docstrings for inline
documentation for Skylark rules and macros as well as file (module) docstrings
for documenting `.bzl` files.  Skydoc supports Markdown for all inline
documentation.

When generating documentation, Skydoc parses the `.bzl` file to extract the
inline documentation as well as evaluates the Skylark code to determine the
types for rule attributes. Skydoc will generate documentation for all public
rules and macros. For undocumented rules and macros, Skydoc will still generate
the rule signature and table of attributes.

Private rules and macros (i.e. those whose names begin with `_`) will not
appear in generated documentation.

<a name="rule-documentation"></a>
## Rule Documentation

[Skylark Rules](https://bazel.build/docs/skylark/rules.html) are declared using
the `rule()` function as global variables. As a result, they are documented
using variable docstrings, similar to those supported by
[epydoc](http://epydoc.sourceforge.net/manual-docstring.html).

Attributes are documented in a special `Args:` section. Begin the documentation
for each attribute on an indented line with the attribute name followed by a
colon `:`. The documentation for an attribute can span multiple lines as long as
each line is indented from the first line:

```python
checkstyle = rule(
    implementation = _impl,
    attrs = {
        "srcs": attr.label_list(allow_files = FileType([".java"]),
        "config": attr.label(),
    },
)
"""Runs checkstyle on the given source files.

This rule runs [Checkstyle](http://checkstyle.sourceforge.net/) on a set of
Java source files.

Args:
  srcs: The Java source files to run checkstyle against.
  config: The checkstyle configuration file to use.

    If no configuration file is provided, then the default `checkstyle.xml` will
    be used.
"""
```

The `name` attribute that is common to all rules is documented by default, but
the default documentation can be overwridden by adding documentation for `name`
in `Args`.

<a name="macro-documentation"></a>
## Macro Documentation

[Skylark Macros](https://bazel.build/docs/skylark/macros.html) are Python
functions and are thus documented using function docstrings:

```python
def rat_check(name, srcs=[], format, visibility):
  """Runs Apache Rat license checks on the given source files.

  This rule runs [Apache Rat](http://creadur.apache.org/rat/) license checks on
  a given set of source files. Use `bazel build` to run the check.

  Args:
    name: A unique name for this rule.
    srcs: Source files to run the Rat license checks against.

      Note that the Bazel glob() function can be used to specify which source
      files to include and which to exclude.
    format: The format to write the Rat check report in.
    visibility: The visibility of this rule.
  """
  if format not in ['text', 'html', 'xml']:
    fail('Invalid format: %s' % format, 'format')

  _rat_check(
      name = name,
      srcs = srcs,
      format = format,
      visibility = visibility,
  )
```

Note that the format of the docstrings for rules and macros are identical.

<a name="file-documentation"></a>
## File Documentation

Skydoc also supports file docstrings (similar to Python's module docstrings),
which can be used to document a `.bzl` file, such as providing an overview of
the rules and macros implemented in the file:

```python
"""Checkstyle Rules

Skylark rules for running [Checkstyle](http://checkstyle.sourceforge.net/) on
Java source files.
"""
```

If a file docstring is provided, the short docstring will be used as the title
on the generated documentation file, and the rest of the docstring (separated
from the title with an empty line) will be used to generate an Overview section
on the page.
