package(default_visibility = ["//visibility:public"])

load("@protobuf//:protobuf.bzl", "py_proto_library")

py_proto_library(
    name = "build_pb_py",
    srcs = ["build.proto"],
    default_runtime = "@protobuf//:protobuf_python",
    protoc = "@protobuf//:protoc",
)

py_library(
    name = "common",
    srcs = ["common.py"],
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
        ":build_pb_py",
        ":macro_extractor",
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
        ":build_pb_py",
        ":rule_extractor",
    ],
)

py_library(
    name = "rule",
    srcs = ["rule.py"],
    deps = [
        ":build_pb_py",
        "//external:mistune",
    ],
)

py_binary(
    name = "skydoc",
    srcs = ["main.py"],
    data = [
        "//skydoc/sass:main.css",
        "//skydoc/templates",
    ],
    main = "main.py",
    deps = [
        ":common",
        ":macro_extractor",
        ":rule",
        ":rule_extractor",
        "//external:gflags",
        "//external:jinja2",
    ],
)
