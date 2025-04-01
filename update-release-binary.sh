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
# Updates vendored Stardoc output protos from @io_bazel git.

set -eu

echo "** Copying stardoc_output.proto from source..."
# Path of proto definition relative to Bazel source tree root
PROTO_SRC=src/main/protobuf/stardoc_output.proto
# Branch or commit in https://github.com/bazelbuild/bazel
: "${BAZEL_BRANCH:=master}"
# Retrieve the first commit to modify ${PROTO_SRC} in the history of ${BAZEL_BRANCH}
# using Github API; see https://docs.github.com/en/rest/commits/commits?apiVersion=2022-11-28
PROTO_SRC_SHA="$(curl -s -L -H "Accept: application/vnd.github+json" \
    "https://api.github.com/repos/bazelbuild/bazel/commits?sha=${BAZEL_BRANCH}&path=${PROTO_SRC}" \
    | grep -m 1 '"sha":' | sed 's/.*"sha": "\(.*\)",.*/\1/')"
# Copy proto file and insert "Vendored from" slug immediately below the license.
curl -s -L "https://raw.githubusercontent.com/bazelbuild/bazel/${PROTO_SRC_SHA}/${PROTO_SRC}" \
    | sed '/^\/\/ limitations under the License./ a \
//\
// Vendored from '"${PROTO_SRC}"'\
// in the Bazel source tree at commit '"${PROTO_SRC_SHA}"'\
' > stardoc/proto/stardoc_output.proto
echo "** stardoc_output.proto copied."
