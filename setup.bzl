# Copyright 2019 The Bazel Authors. All rights reserved.
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

"""WORKSPACE prerequisites for Stardoc."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def stardoc_repositories():
    """Adds the external repositories for rules used by Stardoc."""
    maybe(
        http_archive,
        name = "bazel_skylib",
        sha256 = "bc283cdfcd526a52c3201279cda4bc298652efa898b10b4db0837dc51652756f",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.7.1/bazel-skylib-1.7.1.tar.gz",
            "https://github.com/bazelbuild/bazel-skylib/releases/download/1.7.1/bazel-skylib-1.7.1.tar.gz",
        ],
    )

    maybe(
        http_archive,
        name = "com_google_protobuf",
        sha256 = "537d1c4edb6cbfa96d98a021650e3c455fffcf80dbdcea7fe46cb356e6e9732d",
        strip_prefix = "protobuf-29.0-rc3",
        urls = [
            "https://mirror.bazel.build/github.com/protocolbuffers/protobuf/releases/download/v29.0-rc3/protobuf-29.0-rc3.zip",
            "https://github.com/protocolbuffers/protobuf/releases/download/v29.0-rc3/protobuf-29.0-rc3.zip",
        ],
    )

    maybe(
        http_archive,
        name = "rules_java",
        sha256 = "1389206b2208c5f33a05dd96e51715b0855c480c082b7bb4889a8e07fcff536c",
        url = "https://github.com/bazelbuild/rules_java/releases/download/8.5.1/rules_java-8.5.1.tar.gz",
    )

    RULES_JVM_EXTERNAL_TAG = "6.3"
    RULES_JVM_EXTERNAL_SHA = "c18a69d784bcd851be95897ca0eca0b57dc86bb02e62402f15736df44160eb02"
    maybe(
        http_archive,
        name = "rules_jvm_external",
        strip_prefix = "rules_jvm_external-%s" % RULES_JVM_EXTERNAL_TAG,
        sha256 = RULES_JVM_EXTERNAL_SHA,
        url = "https://github.com/bazelbuild/rules_jvm_external/releases/download/%s/rules_jvm_external-%s.tar.gz" % (RULES_JVM_EXTERNAL_TAG, RULES_JVM_EXTERNAL_TAG),
    )

    maybe(
        http_archive,
        name = "rules_license",
        sha256 = "26d4021f6898e23b82ef953078389dd49ac2b5618ac564ade4ef87cced147b38",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_license/releases/download/1.0.0/rules_license-1.0.0.tar.gz",
            "https://github.com/bazelbuild/rules_license/releases/download/1.0.0/rules_license-1.0.0.tar.gz",
        ],
    )

    # Transitive dep of com_google_protobuf. Unfortunately, protobuf_deps()
    # pulls in a dep that's too old.
    maybe(
        http_archive,
        name = "rules_proto",
        sha256 = "6fb6767d1bef535310547e03247f7518b03487740c11b6c6adb7952033fe1295",
        strip_prefix = "rules_proto-6.0.2",
        url = "https://github.com/bazelbuild/rules_proto/releases/download/6.0.2/rules_proto-6.0.2.tar.gz",
    )

    # Transitive dep of rules_proto. Pull in explicitly to allow calling both
    # rules_proto_dependencies() and rules_proto_setup() in stardoc_external_deps() without forcing
    # users to add yet another intermediate load() in their WORKSPACE files.
    maybe(
        http_archive,
        name = "bazel_features",
        sha256 = "0f23d75c7623d6dba1fd30513a94860447de87c8824570521fcc966eda3151c2",
        strip_prefix = "bazel_features-1.4.1",
        url = "https://github.com/bazel-contrib/bazel_features/releases/download/v1.4.1/bazel_features-v1.4.1.tar.gz",
    )

    # Transitive dep of com_google_protobuf. Unfortunately, protobuf_deps()
    # pulls in a dep that's too old.
    maybe(
        http_archive,
        name = "rules_python",
        sha256 = "690e0141724abb568267e003c7b6d9a54925df40c275a870a4d934161dc9dd53",
        strip_prefix = "rules_python-0.40.0",
        url = "https://github.com/bazelbuild/rules_python/releases/download/0.40.0/rules_python-0.40.0.tar.gz",
    )
