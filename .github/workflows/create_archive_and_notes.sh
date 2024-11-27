#!/usr/bin/env bash
# Copyright 2023 The Bazel Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -o errexit -o nounset -o pipefail

# Set by GH actions, see
# https://docs.github.com/en/actions/learn-github-actions/environment-variables#default-environment-variables
TAG=${GITHUB_REF_NAME}
# A prefix is added to better match the GitHub generated archives.
PREFIX="stardoc-${TAG}"
ARCHIVE="stardoc-$TAG.tar.gz"

bazel build //distro:distro
# Copy it locally so release.yml sees it
cp bazel-bin/distro/stardoc-*.tar.gz $ARCHIVE

SHA=$(shasum -a 256 $ARCHIVE | awk '{print $1}')

cat > release_notes.txt << EOF

## MODULE.bazel setup

Add to your \`MODULE.bazel\` file:

\`\`\`starlark
bazel_dep(name = "stardoc", version = "${TAG}")
\`\`\`

By default - in other words, when using Bzlmod for dependency management -
Stardoc uses @stardoc as its repo name. The legacy WORSKSPACE setup (see below)
used @io_bazel_stardoc instead. For compatibility with the legacy WORKSPACE
setup, you may add repo_name = "io_bazel_stardoc" to the bazel_dep call.

## Legacy WORKSPACE setup

To use Stardoc, add the following to your WORKSPACE file:

\`\`\`starlark
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "io_bazel_stardoc",
    sha256 = "${SHA}",
    strip_prefix = "${PREFIX}",
    url = "https://github.com/bazelbuild/stardoc/releases/download/${TAG}/stardoc-${TAG}.tar.gz",
)

load("@io_bazel_stardoc//:setup.bzl", "stardoc_repositories")

stardoc_repositories()

load("@rules_java//java:rules_java_deps.bzl", "rules_java_dependencies")

rules_java_dependencies()

load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")

protobuf_deps()

load("@rules_jvm_external//:repositories.bzl", "rules_jvm_external_deps")

rules_jvm_external_deps()

load("@rules_jvm_external//:setup.bzl", "rules_jvm_external_setup")

rules_jvm_external_setup()

load("@io_bazel_stardoc//:deps.bzl", "stardoc_external_deps")

stardoc_external_deps()

load("@stardoc_maven//:defs.bzl", stardoc_pinned_maven_install = "pinned_maven_install")

stardoc_pinned_maven_install()

\`\`\`

The sequence of function calls and load statements after the io_bazel_stardoc
repository definition ensures that this repository's dependencies are loaded
(each function call defines additional repositories for Stardoc's dependencies,
which are then used by subsequent load statements).

Note that WORKSPACE files are sensitive to the order of dependencies. If, after
updating to a newer version of Stardoc, you encounter "not a valid
maven_install.json file" or other repository fetch errors (example: #186), try
moving the Stardoc dependency block above or below other dependencies in your
WORKSPACE file.

EOF
