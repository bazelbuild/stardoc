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
        sha256 = "9f38886a40548c6e96c106b752f242130ee11aaa068a56ba7e56f4511f33e4f2",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.6.1/bazel-skylib-1.6.1.tar.gz",
            "https://github.com/bazelbuild/bazel-skylib/releases/download/1.6.1/bazel-skylib-1.6.1.tar.gz",
        ],
    )

    ##maybe(
    ##    http_archive,
    ##    name = "com_google_protobuf",
    ##    sha256 = "75be42bd736f4df6d702a0e4e4d30de9ee40eac024c4b845d17ae4cc831fe4ae",
    ##    strip_prefix = "protobuf-21.7",
    ##    urls = [
    ##        "https://mirror.bazel.build/github.com/protocolbuffers/protobuf/archive/v21.7.tar.gz",
    ##        "https://github.com/protocolbuffers/protobuf/archive/v21.7.tar.gz",
    ##    ],
    ##)

    maybe(
        http_archive,
        name = "com_google_protobuf",
        sha256 = "23082dca1ca73a1e9c6cbe40097b41e81f71f3b4d6201e36c134acc30a1b3660",
        url = "https://github.com/protocolbuffers/protobuf/releases/download/v29.0-rc2/protobuf-29.0-rc2.zip",
        strip_prefix = "protobuf-29.0-rc2",
    )

    ##maybe(
    ##    http_archive,
    ##    name = "rules_java",
    ##    urls = [
    ##        "https://mirror.bazel.build/github.com/bazelbuild/rules_java/releases/download/7.6.1/rules_java-7.6.1.tar.gz",
    ##        "https://github.com/bazelbuild/rules_java/releases/download/7.6.1/rules_java-7.6.1.tar.gz",
    ##    ],
    ##    sha256 = "f8ae9ed3887df02f40de9f4f7ac3873e6dd7a471f9cddf63952538b94b59aeb3",
    ##)
    maybe(
        http_archive,
        name = "rules_java",
        urls = [
            "https://github.com/bazelbuild/rules_java/releases/download/7.12.1/rules_java-7.12.1.tar.gz",
        ],
        sha256 = "dfbadbb37a79eb9e1cc1e156ecb8f817edf3899b28bc02410a6c1eb88b1a6862",
    )

    RULES_JVM_EXTERNAL_TAG = "6.1"
    RULES_JVM_EXTERNAL_SHA = "08ea921df02ffe9924123b0686dc04fd0ff875710bfadb7ad42badb931b0fd50"
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
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_license/releases/download/0.0.7/rules_license-0.0.7.tar.gz",
            "https://github.com/bazelbuild/rules_license/releases/download/0.0.7/rules_license-0.0.7.tar.gz",
        ],
        sha256 = "4531deccb913639c30e5c7512a054d5d875698daeb75d8cf90f284375fe7c360",
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
        sha256 = "a644da969b6824cc87f8fe7b18101a8a6c57da5db39caa6566ec6109f37d2141",
        strip_prefix = "rules_python-0.20.0",
        url = "https://github.com/bazelbuild/rules_python/releases/download/0.20.0/rules_python-0.20.0.tar.gz",
    )

    ##maybe(
    ##    http_archive,
    ##    name = "rules_cc",
    ##    sha256 = "4b12149a041ddfb8306a8fd0e904e39d673552ce82e4296e96fac9cbf0780e59",
    ##    strip_prefix = "rules_cc-0.1.0",
    ##    urls = ["https://github.com/bazelbuild/rules_cc/releases/download/0.1.0/rules_cc-0.1.0.tar.gz"],
    ##)
    maybe(
        http_archive,
        name = "rules_cc",
        urls = ["https://github.com/bazelbuild/rules_cc/releases/download/0.0.17/rules_cc-0.0.17.tar.gz"],
        sha256 = "abc605dd850f813bb37004b77db20106a19311a96b2da1c92b789da529d28fe1",
        strip_prefix = "rules_cc-0.0.17",
    )
