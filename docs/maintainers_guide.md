# Stardoc Maintainer's Guide

## Updating Proto

Stardoc proto definition is vendored from the Bazel source tree at
https://github.com/bazelbuild/bazel/tree/master/src/main/protobuf/stardoc_output.proto

To update the proto definition from Bazel's master branch, run
`update-release-binary.sh`

To vendor the proto definition from a particular branch or commit in the Bazel
tree, run `BAZEL_BRANCH=$BRANCH_OR_SHA ./update-release-binary.sh`

## Making a New Release

1.  Verify tests. Verify that dependencies are consistent between `setup.bzl` +
    `WORKSPACE` and `MODULE.bazel` (but note that `MODULE.bazel` does not
    include dependencies on `io_bazel` and its transitive deps).
2.  Update `CHANGELOG.md` at the top. You may want to use the following \
    template:

--------------------------------------------------------------------------------

## Release $VERSION

**New Features**

-   Feature
-   Feature

**Incompatible Changes**

-   Change
-   Change

**Contributors**

Name 1, Name 2, Name 3 (alphabetically)

--------------------------------------------------------------------------------

3.  Bump `version` in `version.bzl` *and* `MODULE.bazel` to the new version.
4.  Ensure that the commits for steps 1-3 have been merged. All further steps
    must be performed on a single, known-good git commit.
5.  `bazel build //distro`
6.  Copy the `stardoc-$VERSION.tar.gz` tarball to the mirror (you'll need Bazel
    developer gcloud credentials; assuming you are a Bazel developer, you can
    obtain them via `gcloud init`):

    ```bash
    gsutil cp bazel-bin/distro/stardoc-$VERSION.tar.gz gs://bazel-mirror/github.com/bazelbuild/stardoc/releases/download/$VERSION/stardoc-$VERSION.tar.gz
    gsutil setmeta -h "Cache-Control: public, max-age=31536000" "gs://bazel-mirror/github.com/bazelbuild/stardoc/releases/download/$VERSION/stardoc-$VERSION.tar.gz"
    ```

7.  Obtain checksum for release notes:

    ```bash
    sha256sum bazel-bin/distro/stardoc-$VERSION.tar.gz
    ```

8.  Draft a new release with a new tag named $VERSION in github. Attach
    `stardoc-$VERSION.tar.gz` to the release. For the release notes, use the
    CHANGELOG.md entry plus the following template:

--------------------------------------------------------------------------------

**WORKSPACE setup**

To use Stardoc, add the following to your `WORKSPACE` file:

```starlark
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "io_bazel_stardoc",
    sha256 = "$SHA256SUM",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/stardoc/releases/download/$VERSION/stardoc-$VERSION.tar.gz",
        "https://github.com/bazelbuild/stardoc/releases/download/$VERSION/stardoc-$VERSION.tar.gz",
    ],
)

load("@io_bazel_stardoc//:setup.bzl", "stardoc_repositories")

stardoc_repositories()

load("@rules_jvm_external//:repositories.bzl", "rules_jvm_external_deps")

rules_jvm_external_deps()

load("@rules_jvm_external//:setup.bzl", "rules_jvm_external_setup")

rules_jvm_external_setup()

load("@io_bazel_stardoc//:deps.bzl", "stardoc_external_deps")

stardoc_external_deps()

load("@stardoc_maven//:defs.bzl", stardoc_pinned_maven_install = "pinned_maven_install")

stardoc_pinned_maven_install()
```

The sequence of function calls and load statements after the `io_bazel_stardoc`
repository definition ensures that this repository's dependencies are loaded
(each function call defines additional repositories for Stardoc's dependencies,
which are then used by subsequent load statements).

Note that `WORKSPACE` files are sensitive to the order of dependencies. If,
after updating to a newer version of Stardoc, you encounter "not a valid
maven_install.json file" or other repository fetch errors (example: #186), try
moving the Stardoc dependency block above or below other dependencies in your
`WORKSPACE` file.

<!-- Uncomment after updating Stardoc in Bazel Central Registry
**MODULE.bazel setup**

```starlark
bazel_dep(name = "stardoc", version = "$VERSION")
```

For compatibility with `WORKSPACE` setup, add `repo_name = "io_bazel_stardoc"`
to the `bazel_dep` call.
-->

**Using the rules**

See [the source](https://github.com/bazelbuild/stardoc/tree/$VERSION).

--------------------------------------------------------------------------------

9.  Obtain [Subresource Integrity](https://w3c.github.io/webappsec-subresource-integrity/#integrity-metadata-description)
    format checksum for bzlmod:

```bash
echo -n sha256-; cat bazel-bin/distro/stardoc-$VERSION.tar.gz | openssl dgst -sha256 -binary | base64
```

10. Create a PR at [Bazel Central Registry](https://github.com/bazelbuild/bazel-central-registry)
    to update the registry's versions of Stardoc.

    Use https://github.com/bazelbuild/bazel-central-registry/pull/677 as the
    model; you will need to update `modules/stardoc/metadata.json` to list the
    new version in `versions`, and create new $VERSION subdirectories for the
    updated module, using the latest existing version subdirectories as the
    guide. Use Subresource Integrity checksums obtained above in the new
    `source.json` file.

    Ensure that the `MODULE.bazel` file you add in the new $VERSION
    subdirectory exactly matches the `MODULE.bazel` file packaged in the
    stardoc-$VERSION.tar.gz tarball - or buildkite checks will fail.

11. Once the Bazel Central Registry PR is merged, uncomment the MODULE.bazel
    block in the release description.