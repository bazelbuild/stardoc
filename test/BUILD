load(":stardoc_test.bzl", "stardoc_test")

licenses(["notice"])  # Apache 2.0

sh_test(
    name = "stardoc_self_gen_test",
    srcs = ["diff_test_runner.sh"],
    args = [
        "$(location //stardoc:stardoc_doc.md)",
        "$(location //:stardoc_rule_doc)",
    ],
    data = [
        "//:stardoc_rule_doc",
        "//stardoc:stardoc_doc.md",
    ],
)

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
    golden_file = "testdata/proto_format_test/golden.raw",
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
    semantic_flags = [
        "--experimental_google_legacy_api",
    ],
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
        "whitelisted_dep_rule",
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
    name = "namespace_test",
    golden_file = "testdata/namespace_test/golden.md",
    input_file = "testdata/namespace_test/input.bzl",
)

stardoc_test(
    name = "namespace_test_with_whitelist",
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
    name = "multi_level_namespace_test_with_whitelist",
    golden_file = "testdata/multi_level_namespace_test_with_whitelist/golden.md",
    input_file = "testdata/multi_level_namespace_test_with_whitelist/input.bzl",
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

genrule(
    name = "generate_bzl_test_dep",
    srcs = ["testdata/generated_bzl_test/dep.bzl.tpl"],
    outs = ["testdata/generated_bzl_test/dep.bzl"],
    cmd = "cp $< $@",
)

stardoc_test(
    name = "generated_bzl_test",
    golden_file = "testdata/generated_bzl_test/golden.md",
    input_file = "testdata/generated_bzl_test/input.bzl",
    deps = [
        "testdata/generated_bzl_test/dep.bzl",
    ],
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
