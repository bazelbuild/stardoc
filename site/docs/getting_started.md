---
layout: default
title: Getting started
stylesheet: docs
---

Skydoc is a documentation generator for [Bazel](https://bazel.build) build rules
written in [Skylark](https://bazel.build/docs/skylark/index.html).

Skydoc provides a set of Skylark rules (`skylark_library` and `skylark_doc`)
that can be used to build documentation for Skylark rules in either Markdown or
HTML. Skydoc generates one documentation page per `.bzl` file.

If you are new to writing build rules for Bazel, please read the Bazel
documentation on [writing
extensions](https://www.bazel.build/docs/skylark/concepts.html)

<img src="/images/screenshot.png" class="responsive"
    alt="A screenshot of Skydoc generated HTML documentation">

## Setup

To use Skydoc, add the following to your `WORKSPACE` file:

```python
git_repository(
    name = "io_bazel_rules_sass",
    remote = "https://github.com/bazelbuild/rules_sass.git",
    tag = "0.0.3",
)
load("@io_bazel_rules_sass//sass:sass.bzl", "sass_repositories")
sass_repositories()

git_repository(
    name = "bazel_skylib",
    remote = "https://github.com/bazelbuild/bazel-skylib.git",
    tag = "0.2.0",
)

git_repository(
    name = "io_bazel_skydoc",
    remote = "https://github.com/bazelbuild/skydoc.git",
    tag = "0.1.4",
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
    "skylark_doc",
)
```

## Next Steps

Now you are ready to document your Skylark rules.

* Learn about the [docstring format][format] used to document Skylark rules,
  macros, and files.
* Learn about how you can use Skydoc's [build rules][generate] to generate your
  documentation in Markdown or HTML format.

[format]: writing.md
[generate]: generating.md
