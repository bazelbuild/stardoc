# Copyright 2023 The Bazel Authors. All rights reserved.
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

"""WORKSPACE dependency definitions for Stardoc."""

load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")
load("@rules_jvm_external//:defs.bzl", "maven_install")
load("@rules_proto//proto:repositories.bzl", "rules_proto_dependencies")
load("@rules_proto//proto:setup.bzl", "rules_proto_setup")
load("@rules_proto//proto:toolchains.bzl", "rules_proto_toolchains")
load("@toolchains_protoc//protoc:toolchain.bzl", "protoc_toolchains")

# Maven artifacts required by Stardoc; keep consistent with MODULE.bazel
STARDOC_MAVEN_ARTIFACTS = [
    "com.beust:jcommander:1.82",
    "com.google.escapevelocity:escapevelocity:1.1",
    "com.google.guava:guava:31.1-jre",
    "com.google.truth:truth:1.1.3",
    "junit:junit:4.13.2",
    "com.google.protobuf:protobuf-java:4.27.1",
]

def stardoc_external_deps():
    """
    Sets up Stardoc's workspace dependencies.

    Requires stardoc_repositories() to be called first.

    Normally should be followed up by

    ```bzl
        load("@stardoc_maven//:defs.bzl", stardoc_pinned_maven_install = "pinned_maven_install")

        stardoc_pinned_maven_install()
    ```
    """
    maven_install(
        name = "stardoc_maven",
        artifacts = STARDOC_MAVEN_ARTIFACTS,
        fail_if_repin_required = True,
        maven_install_json = "@io_bazel_stardoc//:maven_install.json",
        repositories = [
            "https://repo1.maven.org/maven2",
        ],
        strict_visibility = True,
    )

    protobuf_deps()

    rules_proto_dependencies()

    # Note rules_proto_setup() requires @bazel_features - we define it in stardoc_repositories()
    rules_proto_setup()

# buildifier: disable=unnamed-macro
def stardoc_register_proto_toolchains():
    """
    Registers Stardoc's Java proto toolchains.

    When building with --incompatible_enable_proto_toolchain_resolution,
    Stardoc needs a Java proto toolchain to be explicitly registered.
    """
    rules_proto_toolchains()

    protoc_toolchains(
        name = "stardoc_protoc_toolchains",
        version = "v27.1",
    )

    native.register_toolchains("//toolchains:all")
