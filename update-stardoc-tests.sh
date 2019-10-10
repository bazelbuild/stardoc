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

# Some tests cannot be automatically regenerated using this script, as they don't fall under the normal
# golden test pattern
EXCLUDED_TESTS="namespace_test_with_whitelist|proto_format_test|multi_level_namespace_test_with_whitelist|local_repository_test"
echo "** Querying for tests..."
regen_targets=$(bazel query //test:all | grep regenerate_with_jar | grep -vE "$EXCLUDED_TESTS")

echo "** Building goldens..."
bazel build $regen_targets

echo "** Copying goldens..."
for regen_target in $regen_targets; do
  base_target_name=$(echo $regen_target | sed 's/\/\/test://g')
  testdata_pkg_name=$(echo $base_target_name | sed 's/regenerate_with_jar_//g' | sed 's/_golden//g')
  out_file="bazel-bin/test/${base_target_name}.out"
  cp $out_file "test/testdata/${testdata_pkg_name}/golden.md"
done

echo "** Files copied."
echo "Please note that not all golden files are correctly copied by this script."
echo "You may want to manually run:"
echo ""
echo "bazel test //test:all"
echo ""
echo "...and manually update tests which are still broken."
