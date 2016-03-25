package(default_visibility = ["//visibility:public"])

py_library(
    name = "common",
    srcs = ["common.py"],
    deps = [
        "@bazel_tools//src/main/protobuf:build_pb_py",
    ],
)

py_test(
    name = "common_test",
    srcs = ["common_test.py"],
    deps = [
        ":common",
    ],
)

py_library(
    name = "macro_extractor",
    srcs = ["macro_extractor.py"],
    deps = [":common"],
)

py_test(
    name = "macro_extractor_test",
    srcs = ["macro_extractor_test.py"],
    deps = [
        ":macro_extractor",
        "@bazel_tools//src/main/protobuf:build_pb_py",
    ],
)

py_library(
    name = "rule_extractor",
    srcs = ["rule_extractor.py"],
    deps = [
        ":common",
        "//skydoc/stubs",
    ],
)

py_test(
    name = "rule_extractor_test",
    srcs = ["rule_extractor_test.py"],
    deps = [
        ":rule_extractor",
        "@bazel_tools//src/main/protobuf:build_pb_py",
    ],
)

py_library(
    name = "rule",
    srcs = ["rule.py"],
    deps = [
        "//external:mistune",
        "@bazel_tools//src/main/protobuf:build_pb_py",
    ],
)

py_binary(
    name = "skydoc",
    srcs = ["main.py"],
    main = "main.py",
    deps = [
        ":macro_extractor",
        ":rule",
        ":rule_extractor",
        "//external:jinja2",
        "//external:gflags",
    ],
    data = [
        "//skydoc/templates",
        "//skydoc/sass:main.css",
    ],
)
