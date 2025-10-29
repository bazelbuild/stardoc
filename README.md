# Stardoc - Starlark Documentation Generator

[![Build status](https://badge.buildkite.com/d8594eb71e4869c792cce22428b08e03b345f9c65dc603d70b.svg?branch=master)](https://buildkite.com/bazel/stardoc)

Stardoc is a documentation generator for [Bazel](https://bazel.build) APIs such as custom rules
written in [Starlark](https://bazel.build/rules/language).

Stardoc provides a Bazel rule (`stardoc`, see [documentation](docs/stardoc_rule.md)) that can
be used to generate Markdown documentation for Starlark rules.
Stardoc generates one documentation page per `.bzl` file.

## Design and Alternatives

Stardoc runs a [Velocity template](https://velocity.apache.org/engine/1.7/user-guide.html) on the output of the [native.starlark_doc_extract](https://bazel.build/reference/be/general#starlark_doc_extract) rule.

Modules published to the Bazel Central Registry do not need to use Stardoc.
They can simply publish the `starlark_doc_extract` outputs as a release artifact.
See https://github.com/bazelbuild/bazel-central-registry/blob/main/docs/stardoc.md.

## Get Started

* How to [set up Stardoc for your project](docs/getting_started_stardoc.md)
* Writing [docstrings](docs/writing_stardoc.md)
* How to [integrate Stardoc with your build](docs/generating_stardoc.md).
* See also [Advanced Topics](docs/advanced_stardoc_usage.md).

## About Stardoc

* Stardoc [rule reference](docs/stardoc_rule.md).
* How to [contribute to Stardoc](docs/contributing.md)

## Project Status

### Skydoc deprecation

Stardoc is a replacement for the **deprecated** "Skydoc" documentation generator.

See [Skydoc Deprecation](docs/skydoc_deprecation.md) for
details on the deprecation and migration details.

### Future plans

See our [future plans](docs/future_plans.md) for refactoring Stardoc to be more consistent with how Bazel evaluates .bzl files, and what it means for maintenance of this project.

### Maintainer's guide

See the [maintaner's guide](docs/maintainers_guide.md) for instructions for
cutting a new release.

