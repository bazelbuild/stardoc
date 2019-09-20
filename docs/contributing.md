We welcome your contributions! To contribute to Stardoc, fork the
[Stardoc](https://github.com/bazelbuild/stardoc) GitHub repository and start
submitting pull requests.

In general, we prefer contributions that fix bugs or add features (as opposed to
purely stylistic, refactoring, or "cleanup" changes). Please check with us by
opening a [GitHub Issue](https://github.com/bazelbuild/stardoc/issues) or emailing the
[bazel-dev](https://groups.google.com/forum/#!forum/bazel-dev) mailing list.

## Stardoc code structure

* The [bazelbuild/stardoc](https://github.com/bazelbuild/stardoc) repository
  contains Stardoc's Starlark code alongside Stardoc's prebuilt java binaries (jars).
* The source code for Stardoc's jars can be found under the bazelbuild/bazel source tree
  [here](https://github.com/bazelbuild/bazel/tree/master/src/main/java/com/google/devtools/build/skydoc).
  Changes to Stardoc's java binaries will thus require creation of pull requests to the
  [bazelbuild/bazel](https://github.com/bazelbuild/bazel) repository.
* Changes to Stardoc's source are pulled in by updating bazelbuild/stardoc's dependency
  on the bazel source tree and and then rebuilding the binary using bazel. This process
  is done periodically by Stardoc's [core contributors](#core-contributors) (generally
  with large changes to Stardoc source, and right before cutting a new Stardoc release).

## Contributing to Stardoc

* Stardoc is part of the Bazel project. Read the [Bazel governance
  plan](https://www.bazel.build/governance.html) and Stardoc's [contribution
  guidelines](../CONTRIBUTING.md).
* Open an [Issue](https://github.com/bazelbuild/stardoc/issues) or discuss your
  plan or design on the [bazel-dev](https://groups.google.com/forum/#!forum/bazel-dev)
  mailing list.
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
* [cparsons](https://github.com/c-parsons)
* [jin](https://github.com/jin)
* [laurentlb](https://github.com/laurentlb)



