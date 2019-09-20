Stardoc is a documentation generator for [Bazel](https://bazel.build) build rules
written in [Starlark](https://bazel.build/docs/skylark/index.html).

Stardoc provides a Starlark rule (`stardoc`)
that can be used to build Markdown documentation for Starlark rules, providers,
and functions.
Starlark generates one documentation page per `stardoc` target.

If you are new to writing build rules for Bazel, please read the Bazel
documentation on [writing
extensions](https://www.bazel.build/docs/skylark/concepts.html)

## Setup

To use Stardoc, add the following to your `WORKSPACE` file:

```python
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

git_repository(
    name = "io_bazel_stardoc",
    remote = "https://github.com/bazelbuild/stardoc.git",
    tag = "0.4.0",
)

load("@io_bazel_stardoc//:setup.bzl", "stardoc_repositories")
stardoc_repositories()
```

The load statement and function call after the `io_bazel_stardoc` repository
definition ensure that this repository's dependencies are loaded.

## Next Steps

Now you are ready to document your Starlark rules.

* Learn about the [docstring format](writing_stardoc.md) used to document Starlark rules.
* Learn about how you can use Stardoc's [build rules](generating_stardoc.md) to generate your
  documentation in Markdown format.


