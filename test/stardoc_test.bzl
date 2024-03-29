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
load("//stardoc:html_tables_stardoc.bzl", "html_tables_stardoc")
load("//stardoc:stardoc.bzl", "stardoc")

def stardoc_test(
        name,
        input_file,
        golden_file,
        legacy_golden_file = None,
        test_legacy_extractor = True,
        deps = [],
        test = "default",
        **kwargs):
    """Convenience macro for stardoc e2e test suites.

    Each invocation creates multiple targets:

    1. A sh_test target which verifies that stardoc-built-from-source, when run on an input file,
       creates output matching the contents of a golden file, named "{name}_e2e_legacy_test".
    2. A `stardoc` target which will generate a new golden file given an input file with the
       legacy extractor built from Bazel source. This target should be used to regenerate the
       legacy golden file when updating stardoc, named "regenerate_{name}_legacy_golden".
    3 & 4. Targets identical to (1) and (2) except they use the prebuilt-stardoc jar, and
       are named "{name}_e2e_jar_legacy_test" and "regenerate_with_jar_{name}_legacy_golden".
    5 & 6. Only if the host Bazel supports the `native.starlark_doc_extract` rule: Targets
       identical to (1) and (2) except they use starlark_doc_extract, and are named "{name}_e2e_test"
       and "regenerate_{name}_golden". The latter target should be used to regenerate the golden
       file when updating Stardoc.
    7. A bzl_library target for convenient wrapping of input bzl files, named "{name}_lib".

    Args:
      name: A unique name to qualify the created targets.
      input_file: The label string of the Starlark input file for which documentation is generated
          in this test.
      golden_file: The label string of the golden file containing the documentation when stardoc
          is run on the input file.
      legacy_golden_file: The label string of the golden file when using the legacy documentation
          extractor. If `legacy_golden_file` is not set, `golden_file` will be used for both extractors.
      test_legacy_extractor: Whether to create legacy extractor test targets.
      deps: A list of label strings of starlark file dependencies of the input_file.
      test: The type of test (default or html_tables).
      **kwargs: A dictionary of input template names mapped to template file path for which documentation is generated.
      """

    if legacy_golden_file == None:
        legacy_golden_file = golden_file

    bzl_library(
        name = "%s_lib" % name,
        srcs = [input_file],
        deps = deps,
    )

    if test_legacy_extractor:
        _create_test_targets(
            test_name = "%s_e2e_legacy_test" % name,
            genrule_name = "regenerate_%s_legacy_golden" % name,
            lib_name = "%s_lib" % name,
            input_file = input_file,
            golden_file = legacy_golden_file,
            stardoc_bin = "@io_bazel//src/main/java/com/google/devtools/build/skydoc:skydoc_deploy.jar",
            test = test,
            use_starlark_doc_extract = False,
            **kwargs
        )

        _create_test_targets(
            test_name = "%s_e2e_jar_legacy_test" % name,
            genrule_name = "regenerate_with_jar_%s_legacy_golden" % name,
            lib_name = "%s_lib" % name,
            input_file = input_file,
            golden_file = legacy_golden_file,
            stardoc_bin = "@io_bazel//src/main/java/com/google/devtools/build/skydoc:skydoc_deploy.jar",
            test = test,
            use_starlark_doc_extract = False,
            **kwargs
        )

    if hasattr(native, "starlark_doc_extract"):
        _create_test_targets(
            test_name = "%s_e2e_test" % name,
            genrule_name = "regenerate_%s_golden" % name,
            lib_name = "%s_lib" % name,
            input_file = input_file,
            golden_file = golden_file,
            stardoc_bin = None,
            test = test,
            use_starlark_doc_extract = True,
            **kwargs
        )

def _create_test_targets(
        test_name,
        genrule_name,
        lib_name,
        input_file,
        golden_file,
        stardoc_bin,
        test,
        **kwargs):
    actual_generated_doc = "%s.out" % genrule_name

    native.sh_test(
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
    )

    if test == "default":
        stardoc(
            name = genrule_name,
            out = actual_generated_doc,
            input = input_file,
            deps = [lib_name],
            stardoc = stardoc_bin,
            **kwargs
        )
    elif test == "html_tables":
        html_tables_stardoc(
            name = genrule_name,
            out = actual_generated_doc,
            input = input_file,
            deps = [lib_name],
            stardoc = stardoc_bin,
            **kwargs
        )
    else:
        fail("parameter 'test' must either be 'default' or 'html_tables', but was " + test)

def self_gen_test(
        name,
        stardoc_doc,
        golden_file,
        require_starlark_doc_extract,
        **kwargs):
    """
    A wrapper around `diff_test_runner.sh` for testing Stardoc's own generated documentation.

    Args:
      name: A unique name for the test target.
      stardoc_doc: The Stardoc output being tested.
      golden_file: Expected Stardoc output.
      require_starlark_doc_extract: If true, and the native `starlark_doc_extract` rule is not available,
        then no test target will not be created.
      **kwargs: Additional arguments for the test.
    """
    if require_starlark_doc_extract and not hasattr(native, "starlark_doc_extract"):
        return

    native.sh_test(
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
