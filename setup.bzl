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

"""Repository external dependency resolution functions."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def _include_if_not_defined(repo_rule, name, **kwargs):
    if not native.existing_rule(name):
        repo_rule(name = name, **kwargs)

def stardoc_repositories():
    """Adds the external repositories used by the Starlark rules."""
    _include_if_not_defined(
        http_archive,
        name = "bazel_skylib",
        urls = ["https://github.com/bazelbuild/bazel-skylib/archive/16de038c484145363340eeaf0e97a0c9889a931b.tar.gz"], # 2020-08-11
        sha256 = "96e0cd3f731f0caef9e9919aa119ecc6dace36b149c2f47e40aa50587790402b",
        strip_prefix = "bazel-skylib-16de038c484145363340eeaf0e97a0c9889a931b",
    )
    _include_if_not_defined(
        http_archive,
        name = "rules_java",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_java/archive/7cf3cefd652008d0a64a419c34c13bdca6c8f178.zip",
            "https://github.com/bazelbuild/rules_java/archive/7cf3cefd652008d0a64a419c34c13bdca6c8f178.zip",
        ],
        sha256 = "bc81f1ba47ef5cc68ad32225c3d0e70b8c6f6077663835438da8d5733f917598",
        strip_prefix = "rules_java-7cf3cefd652008d0a64a419c34c13bdca6c8f178",
    )
