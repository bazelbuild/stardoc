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
# Renerates most Stardoc golden files for Stardoc golden tests.
#
# When run, every golden file which is changed as a result of this script should
# be manually examined and *heavily* scrutinized, as this usually indicates a large
# in-place change of core rendering functionality of Stardoc.

set -eu

function run_buildozer () {
  # buildozer uses return code 3 to signal a no-op, so we can't use "set -e"
  set +e
  buildozer "$@"
  ret=$?
  set -e
  if [[ $ret != 0 && $ret != 3 ]]; then
    return $ret
  fi
}

function update_non_manual_tests () {
  echo "** Querying for non-manual tests..."
  regenerate $(${BAZEL} query "kind(sh_binary, //test:all) - attr(tags, manual, //test:all)" | grep _regenerate)
}

function update_manual_tests_with_tag () {
  local manual_tag="$1"; shift
  echo "** Querying for tests tagged \"${manual_tag}\", \"manual\" using 'USE_BAZEL_VERSION=${USE_BAZEL_VERSION} ${BAZEL}' ..."
  regenerate $(${BAZEL} query "attr(tags, ${manual_tag}, attr(tags, manual, kind(sh_binary, //test:all)))" | grep _regenerate)
}

function regenerate () {
  echo "** Regenerating and copying goldens..."
  for regen_target in $@; do
    if [[ -z ${USE_BAZEL_VERSION+x} ]]; then
      echo "** Running '${BAZEL} run ${regen_target}' ..."
    else
      echo "** Running 'USE_BAZEL_VERSION=${USE_BAZEL_VERSION} ${BAZEL} run ${regen_target}' ..."
    fi
    ${BAZEL} run "${regen_target}"
  done
}

# Allow users to override the bazel command with e.g. bazelisk.
: "${BAZEL:=bazelisk}"

update_non_manual_tests
USE_BAZEL_VERSION="7.2.0" update_manual_tests_with_tag "bazel_7_2"
USE_BAZEL_VERSION="8.0.0-pre.20240603.2" update_manual_tests_with_tag "bazel_8"

echo "** Files copied."
echo "Please note that not all golden files are correctly copied by this script."
echo "You may want to manually run:"
echo ""
echo "${BAZEL} test //test:all"
echo ""
echo "...and manually update tests which are still broken."
