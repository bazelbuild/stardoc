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

Edit your `WORKSPACE` file as shown in the `WORKSPACE` setup section for
[the current Stardoc release](https://github.com/bazelbuild/stardoc/releases).

Then add

```python
load("@io_bazel_stardoc//stardoc:stardoc.bzl", "stardoc")
```

to your `BUILD` or .bzl file to start using the `stardoc` rule.

## Next Steps

Now you are ready to document your Starlark rules.

* Learn about the [docstring format](writing_stardoc.md) used to document Starlark rules.
* Learn about how you can use Stardoc's [build rules](generating_stardoc.md) to generate your
  documentation in Markdown format.


