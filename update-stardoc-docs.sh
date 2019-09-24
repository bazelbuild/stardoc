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
# Renerates the Stardoc rule documentation from source in @io_bazel.
#
# This should only need to be run for cutting a new Stardoc release.

set -eu

echo "** Generating Stardoc documentation..."
bazel build //stardoc:stardoc_doc.md

echo "** Copying result to docs/stardoc_rule.md ..."
cp bazel-bin/stardoc/stardoc_doc.md docs/stardoc_rule.md

echo "** Done! Please manually verify the new documentation looks good before committing."

