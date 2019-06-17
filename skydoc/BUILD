licenses(["notice"])  # Apache 2.0

package(default_visibility = ["//visibility:public"])

load("@com_google_protobuf//:protobuf.bzl", "py_proto_library")

py_proto_library(
    name = "build_pb_py",
    srcs = ["build.proto"],
    default_runtime = "@com_google_protobuf//:protobuf_python",
    protoc = "@com_google_protobuf//:protoc",
)

py_library(
    name = "common",
    srcs = ["common.py"],
)

py_test(
    name = "common_test",
    srcs = ["common_test.py"],
    python_version = "PY2",
    deps = [
        ":common",
    ],
)

py_library(
    name = "load_extractor",
    srcs = ["load_extractor.py"],
)

py_test(
    name = "load_extractor_test",
    srcs = ["load_extractor_test.py"],
    python_version = "PY2",
    deps = [
        ":load_extractor",
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
    python_version = "PY2",
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
        ":load_extractor",
        "//skydoc/stubs",
    ],
)

py_test(
    name = "rule_extractor_test",
    srcs = ["rule_extractor_test.py"],
    python_version = "PY2",
    deps = [
        ":build_pb_py",
        ":load_extractor",
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
    # no py_binary launcher
    main = "main.py",
    python_version = "PY2",
    deps = [
        ":common",
        ":macro_extractor",
        ":rule",
        ":rule_extractor",
        "//external:jinja2",
        "@bazel_tools//tools/python/runfiles",
    ],
)
