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
"""Convenience macro for stardoc e2e tests."""

load("@bazel_skylib//:bzl_library.bzl", "bzl_library")
load("@rules_shell//shell:sh_test.bzl", "sh_binary", "sh_test")
load("//stardoc:html_tables_stardoc.bzl", "html_tables_stardoc")
load("//stardoc:stardoc.bzl", "stardoc")

def stardoc_test(
        name,
        input_file,
        golden_file,
        deps = [],
        test = "default",
        **kwargs):
    """Convenience macro for stardoc e2e test suites.

    Each invocation creates multiple targets:

    1. A `stardoc` target which will generate a new golden file given an input
       file, named "{name}_stardoc".
    2. An `sh_test` target which verifies that the output of the `stardoc`
       target above matches a golden file.
    3. A shell script which can be executed via `bazel run` to update the golden
       file from the `stardoc` target's output, named "{name}_regenerate"
    4. A bzl_library target for convenient wrapping of input bzl files, named "{name}_lib".

    Args:
      name: A unique name to qualify the created targets.
      input_file: The label string of the Starlark input file for which documentation is generated
          in this test.
      golden_file: The label string of the golden file containing the documentation when stardoc
          is run on the input file.
      deps: A list of label strings of starlark file dependencies of the input_file.
      test: The type of test (default or html_tables).
      **kwargs: A dictionary of input template names mapped to template file path for which documentation is generated.
      """
    bzl_library(
        name = "%s_lib" % name,
        srcs = [input_file],
        deps = deps,
    )

    _create_test_targets(
        test_name = name,
        stardoc_name = "%s_stardoc" % name,
        regenerate_name = "%s_regenerate" % name,
        lib_name = "%s_lib" % name,
        input_file = input_file,
        golden_file = golden_file,
        test = test,
        **kwargs
    )

def _create_test_targets(
        test_name,
        stardoc_name,
        regenerate_name,
        lib_name,
        input_file,
        golden_file,
        test,
        **kwargs):
    actual_generated_doc = "%s.md" % stardoc_name
    tags = kwargs.get("tags", [])

    sh_test(
        name = test_name,
        srcs = ["diff_test_runner.sh"],
        args = [
            "$(location %s)" % actual_generated_doc,
            "$(location %s)" % golden_file,
        ],
        data = [
            actual_generated_doc,
            golden_file,
        ],
        tags = tags,
    )

    regenerate_sh = "%s.sh" % regenerate_name
    native.genrule(
        name = "%s_sh" % regenerate_name,
        cmd = """cat > $(location %s) <<EOF
#!/usr/bin/env bash
cd \\$${BUILD_WORKSPACE_DIRECTORY}
cp -fv $(location %s) $(location %s)
EOF""" % (regenerate_sh, actual_generated_doc, golden_file),
        outs = [regenerate_sh],
        srcs = [actual_generated_doc, golden_file],
        tags = tags,
    )

    sh_binary(
        name = regenerate_name,
        srcs = [regenerate_sh],
        data = [actual_generated_doc],
        tags = tags,
    )

    if test == "default":
        stardoc(
            name = stardoc_name,
            out = actual_generated_doc,
            input = input_file,
            deps = [lib_name],
            **kwargs
        )
    elif test == "html_tables":
        html_tables_stardoc(
            name = stardoc_name,
            out = actual_generated_doc,
            input = input_file,
            deps = [lib_name],
            **kwargs
        )
    else:
        fail("parameter 'test' must either be 'default' or 'html_tables', but was " + test)

def self_gen_test(
        name,
        stardoc_doc,
        golden_file,
        **kwargs):
    """
    A wrapper around `diff_test_runner.sh` for testing Stardoc's own generated documentation.

    Args:
      name: A unique name for the test target.
      stardoc_doc: The Stardoc output being tested.
      golden_file: Expected Stardoc output.
      **kwargs: Additional arguments for the test.
    """
    sh_test(
        name = name,
        srcs = ["diff_test_runner.sh"],
        args = [
            "$(location %s)" % golden_file,
            "$(location %s)" % stardoc_doc,
        ],
        data = [
            golden_file,
            stardoc_doc,
        ],
        **kwargs
    )
