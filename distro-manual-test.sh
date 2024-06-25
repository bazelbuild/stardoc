#!/usr/bin/env bash
# Copyright 2024 The Bazel Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Tests Stardoc's distro tarball generation

set -eu

# Allow users to override the bazel command with e.g. bazelisk.
: "${BAZEL:=bazelisk}"

: "${TMPDIR:=/tmp}"

function make_stardoc_distro_repo () {
    local distro_target
    distro_target=$(bazel query 'kind(pkg_tar, //distro:all)' | grep stardoc-)
    ${BAZEL} build ${distro_target}
    local distro_tgz
    distro_tgz="${PWD}/bazel-bin/${distro_target/://}.tar.gz"
    echo "Creating ${TMPDIR}/stardoc_distro from ${distro_tgz} ..."
    [[ -e "${TMPDIR}/stardoc_distro" ]] && rm -r "${TMPDIR}/stardoc_distro"
    mkdir -p "${TMPDIR}/stardoc_distro"
    pushd "${TMPDIR}/stardoc_distro"
    local distro_tgz
    tar -xzvf "${distro_tgz}"
    popd
}

function make_stardoc_distro_test_repo () {
    echo "Creating ${TMPDIR}/stardoc_distro_test ..."
    [[ -e "${TMPDIR}/stardoc_distro_test" ]] && rm -r "${TMPDIR}/stardoc_distro_test"
    mkdir -p "${TMPDIR}/stardoc_distro_test"
    pushd "${TMPDIR}/stardoc_distro_test"
    cat > MODULE.bazel <<EOF
module(name = "stardoc_distro_test")

bazel_dep(name = "stardoc", version = "0.7.0", repo_name = "io_bazel_stardoc")
local_path_override(
    module_name = "stardoc",
    path = "../stardoc_distro",
)
EOF

    cat > WORKSPACE <<EOF
local_repository(
    name = "io_bazel_stardoc",
    path = "../stardoc_distro",
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
EOF

    cat > BUILD <<EOF
load("@io_bazel_stardoc//stardoc:stardoc.bzl", "stardoc")

stardoc(
    name = "doc",
    input = "foo.bzl",
    out = "foo_doc.md",
)
EOF

    cat > foo.bzl <<EOF
"""Test module"""

def my_function(*, a = "hello"):
    """
    This is my function
    """
    pass
EOF
    popd
}

make_stardoc_distro_repo

make_stardoc_distro_test_repo

pushd "${TMPDIR}/stardoc_distro_test"
echo "Testing with --enable_bzlmod --incompatible_enable_proto_toolchain_resolution ..."
${BAZEL} build :doc --enable_bzlmod --incompatible_enable_proto_toolchain_resolution
echo "Testing with --enable_bzlmod --noincompatible_enable_proto_toolchain_resolution ..."
${BAZEL} build :doc --enable_bzlmod --noincompatible_enable_proto_toolchain_resolution
echo "Testing with --noenable_bzlmod --incompatible_enable_proto_toolchain_resolution ..."
${BAZEL} build :doc --noenable_bzlmod --incompatible_enable_proto_toolchain_resolution
echo "Testing with --noenable_bzlmod --noincompatible_enable_proto_toolchain_resolution ..."
${BAZEL} build :doc --noenable_bzlmod --noincompatible_enable_proto_toolchain_resolution
