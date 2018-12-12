---
layout: default
title: Generating Documentation
stylesheet: docs
---

<nav class="toc">
  <h2>Contents</h2>
  <ul>
    <li><a href="#single-target">Single Target</a></li>
    <li><a href="#multiple-targets">Multiple Targets</a></li>
  </ul>
</nav>

The following are some examples of how to use Skydoc.

<a name="single-target"></a>
## Single Target

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

<a name="multiple-targets"></a>
## Multiple Targets

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
load("@bazel_skylib//:skylark_library.bzl", "skylark_library")

skylark_library(
    name = "checkstyle-rules",
    srcs = ["checkstyle.bzl"],
)
```

`lua/BUILD`:

```python
load("@bazel_skylib//:skylark_library.bzl", "skylark_library")

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
    srcs = [
        "//checkstyle:checkstyle-rules",
        "//lua:lua-rules",
    ],
)
```

Running `bazel build //:docs` would build a single zip containing documentation
for all the `.bzl` files contained in the two `skylark_library` targets' `srcs`.

