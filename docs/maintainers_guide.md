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

1.  Update CHANGELOG.md at the top. You may want to use the following template:

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

2.  Bump `version` in version.bzl to the new version.
3.  Ensure that the commits for steps 1 and 2 have been merged. All further
    steps must be performed on a single, known-good git commit.
4.  `bazel build //distro`
5.  Copy the `stardoc-$VERSION.tar.gz` tarball to the mirror (you'll need Bazel
    developer gcloud credentials; assuming you are a Bazel developer, you can
    obtain them via `gcloud init`):

```
gsutil cp bazel-bin/distro/stardoc-$VERSION.tar.gz gs://bazel-mirror/github.com/bazelbuild/stardoc/releases/download/$VERSION/stardoc-$VERSION.tar.gz
gsutil setmeta -h "Cache-Control: public, max-age=31536000" "gs://bazel-mirror/github.com/bazelbuild/stardoc/releases/download/$VERSION/stardoc-$VERSION.tar.gz"
```

6.  Run `sha256sum bazel-bin/distro/stardoc-$VERSION.tar.gz`; you'll need the
    checksum for the release notes.
7.  Draft a new release with a new tag named $VERSION in github. Attach
    `stardoc-$VERSION.tar.gz` to the release. For the release notes, use the
    CHANGELOG.md entry plus the following template:

--------------------------------------------------------------------------------

**WORKSPACE setup**

To use Stardoc, add the following to your `WORKSPACE` file:

```
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
```

The load statement and function call after the `io_bazel_stardoc` repository
definition ensure that this repository's dependencies are loaded.

**Using the rules**

See [the source](https://github.com/bazelbuild/stardoc/tree/$VERSION).

--------------------------------------------------------------------------------

