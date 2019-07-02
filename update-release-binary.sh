#!/usr/bin/env bash
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
#
# Renerates the Stardoc release binary from source in @io_bazel.
#
# This should only need to be run for cutting a new Stardoc release.

set -eu

echo "** Building Stardoc from source..."
bazel build @io_bazel//src/main/java/com/google/devtools/build/skydoc:skydoc_deploy.jar

echo "** Copying Stardoc binary..."
cp bazel-bin/external/io_bazel/src/main/java/com/google/devtools/build/skydoc/skydoc_deploy.jar \
    stardoc/stardoc_binary.jar

echo "** Stardoc copied."

echo "** Building Renderer from source..."
bazel build @io_bazel//src/main/java/com/google/devtools/build/skydoc/renderer:renderer_deploy.jar

echo "** Copying Renderer binary..."
cp bazel-bin/external/io_bazel/src/main/java/com/google/devtools/build/skydoc/renderer/renderer_deploy.jar \
    stardoc/renderer_binary.jar

echo "** Renderer copied."
