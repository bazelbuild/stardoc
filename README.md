# Skydoc - Skylark Documentation Generator

Skydoc is a documentation generator for [Bazel](http://bazel.io) build rules
written in [Skylark](http://bazel.io/docs/skylark/index.html).

Skydoc provides a set of Skylark rules (`skylark_library` and `skylark_doc`)
that can be used to build documentation for Skylark rules in either Markdown or
HTML. Skydoc generates one documentation page per `.bzl` file.

* [Setup](#setup)
* [Documentation Format](#format)
  * [Rule Documentation](#format-rule-documentation)
  * [Macro Documentation](#format-macro-documentation)
  * [File Documentation](#format-file-documentation)
* [Usage](#usage)
  * [Single Target](#usage-single-target)
  * [Multiple Targets](#usage-multiple-targets)
* [Roadmap](#roadmap)

![A screenshot of Skydoc generated HTML documentation](https://raw.githubusercontent.com/bazelbuild/skydoc/master/skydoc-screenshot.png)

<a name="setup"></a>
## Setup

To use Skydoc, add the following to your `WORKSPACE` file:

```python
git_repository(
    name = "io_bazel_rules_sass",
    remote = "https://github.com/bazelbuild/rules_sass.git",
    tag = "0.0.1",
)
load("@io_bazel_rules_sass//sass:sass.bzl", "sass_repositories")
sass_repositories()

git_repository(
    name = "io_bazel_skydoc",
    remote = "https://github.com/bazelbuild/skydoc.git",
    tag = "0.0.2",
)
load("@io_bazel_skydoc//skylark:skylark.bzl", "skydoc_repositories")
skydoc_repositories()
```

Note that the Sass repositories also need to be loaded since Skydoc uses the
Bazel Sass rules.

If you would like to load all Skydoc rules by default using Bazel's prelude, add
the following to the file `tools/build_rules/prelude_bazel` in your repository:

```python
load(
    "@io_bazel_skydoc//skylark:skylark.bzl",
    "skydoc_repositories",
    "skylark_library",
    "skylark_doc",
)
```

<a name="format"></a>
## Documentation Format

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

<a name="format-rule-documentation"></a>
### Rule Documentation

[Skylark Rules](http://bazel.io/docs/skylark/rules.html) are declared using the
`rule()` function as global variables. As a result, they are documented using
variable docstrings, similar to those supported by
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

<a name="format-macro-documentation"></a>
### Macro Documentation

[Skylark Macros](http://bazel.io/docs/skylark/macros.html) are Python functions
and are thus documented using function docstrings:

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

<a name="format-file-documentation"></a>
### File Documentation

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

<a name="usage"></a>
## Usage

The following are some examples of how to use Skydoc.

<a name="usage-single-target"></a>
### Single Target

Suppose you have a project containing Skylark rules you want to document:

```
[workspace]/
    WORKSPACE
    checkstyle/
        BUILD
        checkstyle.bzl
```

To generate documentation for the rules and macros in `checkstyle.bzl`, add the
following target to `rules/BUILD`:

```python
load("@io_bazel_skydoc//skylark:skylark.bzl", "skylark_doc")

skylark_doc(
    name = "checkstyle-docs",
    srcs = ["checkstyle.bzl"],
)
```

Running `bazel build //checkstyle:checkstyle-docs` will generate a zip file
containing documentation for the public rules and macros in `checkstyle.bzl`.

By default, Skydoc will generate documentation in Markdown. To generate
a set of HTML pages that is ready to be served, set `format = "html"`.

<a name="usage-multiple-targets"></a>
### Multiple Targets

If you would like to generate documentation for multiple .bzl files in various
packages in your workspace, you can use the `skylark_library` rule to create
logical collections of Skylark sources and add a single `skylark_doc` target for
building documentation for all of the rule sets.

Suppose your project has the following structure:

```
[workspace]/
    WORKSPACE
    BUILD
    checkstyle/
        BUILD
        checkstyle.bzl
    lua/
        BUILD
        lua.bzl
        luarocks.bzl
```

In this case, you can have `skylark_library` targets in `checkstyle/BUILD` and
`lua/BUILD`:

`checkstyle/BUILD`:

```python
load("@io_bazel_skydoc//skylark:skylark.bzl", "skylark_library")

skylark_library(
    name = "checkstyle-rules",
    srcs = ["checkstyle.bzl"],
)
```

`lua/BUILD`:

```python
load("@io_bazel_skydoc//skylark:skylark.bzl", "skylark_library")

skylark_library(
    name = "lua-rules",
    srcs = [
        "lua.bzl",
        "luarocks.bzl",
    ],
)
```

To build documentation for all the above `.bzl` files at once:

`BUILD`:

```python
load("@io_bazel_skydoc//skylark:skylark.bzl", "skylark_doc")

skylark_doc(
    name = "docs",
    deps = [
        "//checkstyle:checkstyle-rules",
        "//lua:lua-rules",
    ],
)
```

Running `bazel build //:docs` would build a single zip containing documentation
for all the `.bzl` files contained in the two `skylark_library` targets.

<a name="#roadmap"></a>
## Roadmap

* Support syntax for providing examples for rule and macro documentation.
* Document default values for rule and macro attributes.
