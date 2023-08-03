# Stardoc Maintainer's Guide

## Updating Bundled Jar

Stardoc's source code currently lives in the Bazel source tree at
https://github.com/bazelbuild/bazel/tree/master/src/main/java/com/google/devtools/build/skydoc

For simplicity of use and building, Stardoc bundles a pre-built jar built
from Bazel source: `stardoc_binary.jar` (emits protobuf documentation format).

To update the jar:

1.  Update `io_bazel` repo commit in `WORKSPACE`. Update transitive deps in
    `WORKSPACE` as needed.
2.  run `update-release-binary.sh`

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

The load statements and function calls after the `io_bazel_stardoc` repository
definition ensure that this repository's dependencies are loaded.

**Using the rules**

See [the source](https://github.com/bazelbuild/stardoc/tree/$VERSION).

--------------------------------------------------------------------------------

9.  Obtain [Subresource Integrity](https://w3c.github.io/webappsec-subresource-integrity/#integrity-metadata-description)
    format checksum for bzlmod:

```bash
echo -n sha256-; cat bazel-bin/distro/stardoc-$VERSION.tar.gz | openssl dgst -sha256 -binary | base64
```

10. Create a PR at [Bazel Central Registry](https://github.com/bazelbuild/bazel-central-registry)
    to update the registry's versions of bazel_skylib and
    bazel_skylib_gazelle_plugin.

    Use https://github.com/bazelbuild/bazel-central-registry/pull/677 as the
    model; you will need to update `modules/stardoc/metadata.json` to list the
    new version in `versions`, and create new $VERSION subdirectories for the
    updated module, using the latest existing version subdirectories as the
    guide. Use Subresource Integrity checksums obtained above in the new
    `source.json` file.

    Ensure that the `MODULE.bazel` file you add in the new $VERSION
    subdirectory exactly matches the `MODULE.bazel` file packaged in the
    stardoc-$VERSION.tar.gz tarball - or buildkite checks will fail.

11. Once the Bazel Central Registry PR is merged, insert in the release
    description after the `WORKSPACE` setup section:

--------------------------------------------------------------------------------

**MODULE.bazel setup**

```starlark
bazel_dep(name = "stardoc", version = "$VERSION")
```

For compatibility with `WORKSPACE` setup, add `repo_name = "io_bazel_stardoc"`
to the `bazel_dep` call.

--------------------------------------------------------------------------------