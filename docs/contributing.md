Before contributing, please see the note on our [current
priorities](future_plans.md). In short, we're able to take bugfixes to critical
features, but cannot guarantee that we'll be able to review new features in a
timely manner.

To contribute to Stardoc, first see the official [contributing
notice](../CONTRIBUTING.md), then feel free to fork the
[Stardoc](https://github.com/bazelbuild/stardoc) GitHub repository and start
submitting pull requests.

In general, we prefer contributions that fix bugs or add features (as opposed to
purely stylistic, refactoring, or "cleanup" changes). Please check with us by
opening a [GitHub Issue](https://github.com/bazelbuild/stardoc/issues) or
starting a [GitHub Discussion](https://github.com/bazelbuild/bazel/discussions).

## Stardoc code structure

* Stardoc internally relies on Bazel's `starlark_doc_extract` rule to extract
  documentation in [proto format](https://github.com/bazelbuild/bazel/blob/master/src/main/protobuf/stardoc_output.proto)
  (vendored into Stardoc's repo in [stardoc/proto/stardoc_output.proto](../src/proto/stardoc_output.proto))
* The [src](../src) directory contains Stardoc's renderer, written in Java, which
  transforms the proto output into Markdown.
* The [stardoc](../stardoc) directory contains the Starlark rule and wrapper
  macro which serves as the entry point for Stardoc users, and the default
  Velocity templates which configure Markdown output.
* Java unit tests live in the [src/test](../src/test/) directory, while
  integration tests are in the [test](../test/) directory.

## Contributing to Stardoc

* Stardoc is part of the Bazel project. Read the [Bazel governance
  plan](https://www.bazel.build/governance.html) and Stardoc's [contribution
  guidelines](../CONTRIBUTING.md).
* Open an [Issue](https://github.com/bazelbuild/stardoc/issues) or discuss your
  plan or design on [Github Discussions](https://github.com/bazelbuild/bazel/discussions)
* Prepare a Git commit that implements your feature or bug fix. Don't forget to
  add tests and reference the corresponding bug, if any.
* Open a [Pull Request](https://github.com/bazelbuild/stardoc/pulls) on the Stardoc
  repository. This will require that you have signed a
  [Contributor License Agreement](https://cla.developers.google.com/).
* Complete a code review with a [core contributor](#core-contributors). Amend your
  patch by making additional commits or rebasing with HEAD if there are conflicts with new
  commits on the master branch.
* Once the code review is complete, your reviewer will squash/merge your pull
  request to the master branch.

## Core Contributors

The current group of Stardoc core contributors are:

* [brandjon](https://github.com/brandjon)
* [tetromino](https://github.com/tetromino)
