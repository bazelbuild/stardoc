#!/usr/bin/env bash
# Copyright 2016 The Bazel Authors. All rights reserved.
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

set -eu

readonly OUTPUT=${PWD}/$1
shift
readonly JEKYLL_BASE=${PWD}/$1
shift
readonly SKYLARK_DOCS=${PWD}/$1
shift
readonly STARDOC_DOC=${PWD}/$1

# Create temporary directory that is removed when this script exits.
readonly TMP=$(mktemp -d "${TMPDIR:-/tmp}/tmp.XXXXXXXX")
readonly OUT_DIR="$TMP/out"
trap "rm -rf ${TMP}" EXIT

function setup {
  mkdir -p "$OUT_DIR"
  cd "$OUT_DIR"
  tar -xf "${JEKYLL_BASE}"
}

function unpack_skylark_doc {
  local generated_dir="$TMP/skylark"
  mkdir -p $generated_dir

  # Unpack the generated documentation.
  unzip -qq "$SKYLARK_DOCS" -d "$generated_dir"

  for f in $(find "$generated_dir" -name "*.md"); do
    ( cat <<EOF
---
layout: default
title: Build Rule Reference
---
EOF
      cat $f; ) > "$OUT_DIR/docs/$(basename $f)"
  done
}

function include_skydoc_doc {
  ( cat <<EOF
---
layout: default
title: Build Rule Reference
---
EOF
    cat $STARDOC_DOC; ) > "$OUT_DIR/docs/stardoc_reference.md"
}

function package_output {
  cd "$OUT_DIR"
  tar -hcf $OUTPUT $(find . -type f | sort)
}

function main {
  setup
  unpack_skylark_doc
  include_skydoc_doc
  package_output
}
main
