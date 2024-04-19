load("@bazel_skylib//:bzl_library.bzl", "bzl_library")
load("@bazel_skylib//rules:diff_test.bzl", "diff_test")
load(":stardoc_test.bzl", "self_gen_test", "stardoc_test")

package(default_applicable_licenses = ["//:license"])

licenses(["notice"])  # Apache 2.0

self_gen_test(
    name = "stardoc_self_gen_test",
    golden_file = "//stardoc:stardoc_doc.md",
    require_starlark_doc_extract = True,
    stardoc_doc = "//:stardoc_rule_doc",
)

exports_files(["testdata/fakedeps/dep.bzl"])

stardoc_test(
    name = "input_template_test",
    aspect_template = "testdata/input_template_test/aspect.vm",
    func_template = "testdata/input_template_test/func.vm",
    golden_file = "testdata/input_template_test/golden.md",
    header_template = "testdata/input_template_test/header.vm",
    input_file = "testdata/input_template_test/input.bzl",
    provider_template = "testdata/input_template_test/provider.vm",
    rule_template = "testdata/input_template_test/rule.vm",
)

stardoc_test(
    name = "angle_bracket_test",
    golden_file = "testdata/angle_bracket_test/golden.md",
    input_file = "testdata/angle_bracket_test/input.bzl",
)

stardoc_test(
    name = "proto_format_test",
    format = "proto",
    golden_file = "testdata/proto_format_test/golden.binaryproto",
    input_file = "testdata/proto_format_test/input.bzl",
)

stardoc_test(
    name = "cc_api_test",
    golden_file = "testdata/cc_api_test/golden.md",
    input_file = "testdata/cc_api_test/input.bzl",
)

stardoc_test(
    name = "simple_test",
    golden_file = "testdata/simple_test/golden.md",
    input_file = "testdata/simple_test/input.bzl",
    symbol_names = ["my_rule"],
)

stardoc_test(
    name = "repo_rules_test",
    golden_file = "testdata/repo_rules_test/golden.md",
    input_file = "testdata/repo_rules_test/input.bzl",
)

stardoc_test(
    name = "module_extension_test",
    golden_file = "testdata/module_extension_test/golden.md",
    input_file = "testdata/module_extension_test/input.bzl",
)

stardoc_test(
    name = "unknown_name_test",
    golden_file = "testdata/unknown_name_test/golden.md",
    input_file = "testdata/unknown_name_test/input.bzl",
)

stardoc_test(
    name = "multiple_rules_test",
    golden_file = "testdata/multiple_rules_test/golden.md",
    input_file = "testdata/multiple_rules_test/input.bzl",
)

stardoc_test(
    name = "android_basic_test",
    golden_file = "testdata/android_basic_test/golden.md",
    input_file = "testdata/android_basic_test/input.bzl",
    symbol_names = ["android_related_rule"],
)

stardoc_test(
    name = "apple_basic_test",
    golden_file = "testdata/apple_basic_test/golden.md",
    input_file = "testdata/apple_basic_test/input.bzl",
    symbol_names = ["apple_related_rule"],
)

stardoc_test(
    name = "cpp_basic_test",
    golden_file = "testdata/cpp_basic_test/golden.md",
    input_file = "testdata/cpp_basic_test/input.bzl",
    symbol_names = ["cpp_related_rule"],
)

stardoc_test(
    name = "java_basic_test",
    golden_file = "testdata/java_basic_test/golden.md",
    input_file = "testdata/java_basic_test/input.bzl",
    symbol_names = ["java_related_rule"],
)

stardoc_test(
    name = "multiple_files_test",
    golden_file = "testdata/multiple_files_test/golden.md",
    input_file = "testdata/multiple_files_test/input.bzl",
    deps = [
        "testdata/multiple_files_test/dep.bzl",
        "testdata/multiple_files_test/inner_dep.bzl",
    ],
)

stardoc_test(
    name = "same_level_file_test",
    golden_file = "//test/testdata/same_level_file_test:golden.md",
    input_file = "//test/testdata/same_level_file_test:input.bzl",
    symbol_names = ["my_rule"],
    deps = [
        "//test/testdata/same_level_file_test:dep.bzl",
    ],
)

stardoc_test(
    name = "misc_apis_test",
    golden_file = "testdata/misc_apis_test/golden.md",
    input_file = "testdata/misc_apis_test/input.bzl",
)

stardoc_test(
    name = "attribute_types_test",
    golden_file = "testdata/attribute_types_test/golden.md",
    input_file = "testdata/attribute_types_test/input.bzl",
    symbol_names = ["my_rule"],
)

stardoc_test(
    name = "filter_rules_test",
    golden_file = "testdata/filter_rules_test/golden.md",
    input_file = "testdata/filter_rules_test/input.bzl",
    symbol_names = [
        "my_rule",
        "allowlisted_dep_rule",
    ],
    deps = [
        "testdata/filter_rules_test/dep.bzl",
    ],
)

stardoc_test(
    name = "provider_basic_test",
    golden_file = "testdata/provider_basic_test/golden.md",
    input_file = "testdata/provider_basic_test/input.bzl",
)

stardoc_test(
    name = "function_basic_test",
    golden_file = "testdata/function_basic_test/golden.md",
    input_file = "testdata/function_basic_test/input.bzl",
)

stardoc_test(
    name = "function_wrap_multiple_lines_test",
    golden_file = "testdata/function_wrap_multiple_lines_test/golden.md",
    input_file = "testdata/function_wrap_multiple_lines_test/input.bzl",
)

stardoc_test(
    name = "namespace_test",
    golden_file = "testdata/namespace_test/golden.md",
    input_file = "testdata/namespace_test/input.bzl",
)

stardoc_test(
    name = "namespace_test_with_allowlist",
    golden_file = "testdata/namespace_test/golden.md",
    input_file = "testdata/namespace_test/input.bzl",
    symbol_names = [
        "my_namespace",
    ],
)

stardoc_test(
    name = "multi_level_namespace_test",
    golden_file = "testdata/multi_level_namespace_test/golden.md",
    input_file = "testdata/multi_level_namespace_test/input.bzl",
)

stardoc_test(
    name = "multi_level_namespace_test_with_allowlist",
    golden_file = "testdata/multi_level_namespace_test_with_allowlist/golden.md",
    input_file = "testdata/multi_level_namespace_test_with_allowlist/input.bzl",
    symbol_names = [
        "my_namespace",
        "other_namespace.foo.nothing",
    ],
)

stardoc_test(
    name = "macro_kwargs_test",
    golden_file = "testdata/macro_kwargs_test/golden.md",
    input_file = "testdata/macro_kwargs_test/input.bzl",
)

stardoc_test(
    name = "pure_markdown_template_test",
    golden_file = "testdata/pure_markdown_template_test/golden.md",
    input_file = "testdata/pure_markdown_template_test/input.bzl",
)

stardoc_test(
    name = "py_rule_test",
    golden_file = "testdata/py_rule_test/golden.md",
    input_file = "testdata/py_rule_test/input.bzl",
    symbol_names = ["py_related_rule"],
)

stardoc_test(
    name = "struct_default_value_test",
    golden_file = "testdata/struct_default_value_test/golden.md",
    input_file = "testdata/struct_default_value_test/input.bzl",
)

stardoc_test(
    name = "aspect_test",
    golden_file = "testdata/aspect_test/golden.md",
    input_file = "testdata/aspect_test/input.bzl",
)

stardoc_test(
    name = "providers_for_attributes_test",
    golden_file = "testdata/providers_for_attributes_test/golden.md",
    input_file = "testdata/providers_for_attributes_test/input.bzl",
    deps = [
        "testdata/providers_for_attributes_test/dep.bzl",
    ],
)

stardoc_test(
    name = "html_tables_template_test",
    golden_file = "testdata/html_tables_template_test/golden.md",
    input_file = "testdata/html_tables_template_test/input.bzl",
    test = "html_tables",
)

stardoc_test(
    name = "attribute_defaults_test",
    golden_file = "testdata/attribute_defaults_test/golden.md",
    input_file = "testdata/attribute_defaults_test/input.bzl",
)

stardoc_test(
    name = "config_apis_test",
    golden_file = "testdata/config_apis_test/golden.md",
    input_file = "testdata/config_apis_test/input.bzl",
)

stardoc_test(
    name = "footer_test",
    footer_template = "testdata/footer_test/footer_template.vm",
    golden_file = "testdata/footer_test/golden.md",
    input_file = "testdata/footer_test/input.bzl",
)

bzl_library(
    name = "table_of_contents_test_deps",
    srcs = [
        "testdata/aspect_test/input.bzl",
        "testdata/function_basic_test/input.bzl",
        "testdata/module_extension_test/input.bzl",
        "testdata/provider_basic_test/input.bzl",
        "testdata/repo_rules_test/input.bzl",
        "testdata/simple_test/input.bzl",
    ],
)

stardoc_test(
    name = "table_of_contents_test",
    golden_file = "testdata/table_of_contents_test/golden.md",
    input_file = "testdata/table_of_contents_test/input.bzl",
    table_of_contents_template = "//stardoc:templates/markdown_tables/table_of_contents.vm",
    deps = [":table_of_contents_test_deps"],
)

stardoc_test(
    name = "stamping_test",
    golden_file = "testdata/stamping_test/golden.md",
    header_template = "testdata/stamping_test/stamping_header.vm",
    input_file = "testdata/stamping_test/input.bzl",
    stamp = True,
)

stardoc_test(
    name = "stamping_with_stamping_off_test",
    golden_file = "testdata/stamping_test/golden_stamping_off.md",
    header_template = "testdata/stamping_test/stamping_header_stamping_off.vm",
    input_file = "testdata/stamping_test/input.bzl",
    stamp = False,
)

sh_test(
    name = "local_repository_test_e2e_test",
    srcs = ["diff_test_runner.sh"],
    args = [
        "$(location @local_repository_test//:output.md)",
        "$(location @local_repository_test//:golden.md)",
    ],
    data = [
        "@local_repository_test//:golden.md",
        "@local_repository_test//:output.md",
    ],
)

# Consistency tests for WORKSPACE-related .bzl files vs. MODULE.bazel

genrule(
    name = "stardoc_maven_artifacts_in_deps_bzl",
    srcs = ["//:deps.bzl"],
    outs = ["stardoc_maven_artifacts_in_deps_bzl.txt"],
    # Remove all lines except those from 'STARDOC_MAVEN_ARTIFACTS = [' to next ']'
    cmd = "sed -e '/STARDOC_MAVEN_ARTIFACTS = \\[/,/\\]/!d' $< >$@",
)

genrule(
    name = "stardoc_maven_artifacts_in_module_bazel",
    srcs = ["//:MODULE.bazel"],
    outs = ["stardoc_maven_artifacts_in_module_bazel.txt"],
    # Remove all lines except those from 'STARDOC_MAVEN_ARTIFACTS = [' to next ']'
    cmd = "sed -e '/STARDOC_MAVEN_ARTIFACTS = \\[/,/\\]/!d' $< >$@",
)

diff_test(
    name = "stardoc_maven_artifacts_consistency_test",
    failure_message = "STARDOC_MAVEN_ARTIFACTS in deps.bzl and MODULE.bazel are inconsistent",
    file1 = "stardoc_maven_artifacts_in_deps_bzl",
    file2 = "stardoc_maven_artifacts_in_module_bazel",
)

genrule(
    name = "stardoc_version_in_version_bzl",
    srcs = ["//:version.bzl"],
    outs = ["stardoc_version_in_version_bzl.txt"],
    # Find first line starting containing 'version = ' and extract the string value
    cmd = "grep -m 1 'version = ' $< | sed -e 's/.*version = \\(\".*\"\\).*/\\1/' >$@",
)

genrule(
    name = "stardoc_version_in_module_bazel",
    srcs = ["//:MODULE.bazel"],
    outs = ["stardoc_version_in_module_bazel.txt"],
    # Find first line starting containing 'version = ' and extract the string value
    cmd = "grep -m 1 'version = ' $< | sed -e 's/.*version = \\(\".*\"\\).*/\\1/' >$@",
)

diff_test(
    name = "stardoc_version_consistency_test",
    failure_message = "version in version.bzl and MODULE.bazel is inconsistent",
    file1 = "stardoc_version_in_version_bzl",
    file2 = "stardoc_version_in_module_bazel",
)
