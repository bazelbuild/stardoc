---
layout: default
title: Getting started
stylesheet: docs
---

Stardoc is a documentation generator for [Bazel](https://bazel.build) build rules
written in [Starlark](https://bazel.build/docs/skylark/index.html).

Stardoc provides a Starlark rule (`stardoc`)
that can be used to build Markdown documentation for Starlark rules, providers,
and functions.
Starlark generates one documentation page per `stardoc` target.

If you are new to writing build rules for Bazel, please read the Bazel
documentation on [writing
extensions](https://www.bazel.build/docs/skylark/concepts.html)

<img src="/images/screenshot.png" class="responsive"
    alt="A screenshot of Stardoc generated documentation">

## Setup

To use Stardoc, add the following to your `WORKSPACE` file:

```python
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

git_repository(
    name = "io_bazel_skydoc",
    remote = "https://github.com/bazelbuild/skydoc.git",
    tag = "0.3.0",
)

load("@io_bazel_skydoc//:setup.bzl", "skydoc_repositories")
skydoc_repositories()

load("@io_bazel_rules_sass//:package.bzl", "rules_sass_dependencies")
rules_sass_dependencies()

load("@build_bazel_rules_nodejs//:defs.bzl", "node_repositories")
node_repositories()

load("@io_bazel_rules_sass//:defs.bzl", "sass_repositories")
sass_repositories()
```

The load statements and function calls after the `io_bazel_skydoc` repository
definition ensure that this repository's dependencies are loaded.

## Next Steps

Now you are ready to document your Starlark rules.

* Learn about the [docstring format][format] used to document Starlark rules.
* Learn about how you can use Stardoc's [build rules][generate] to generate your
  documentation in Markdown format.

[format]: writing_stardoc.html
[generate]: generating_stardoc.html
