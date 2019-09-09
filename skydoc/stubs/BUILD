licenses(["notice"])  # Apache 2.0

package(default_visibility = ["//skydoc:__pkg__"])

load("@rules_python//python:defs.bzl", "py_library")

py_library(
    name = "stubs",
    srcs = [
        "attr.py",
        "skylark_globals.py",
    ],
    deps = [
        "//skydoc:build_pb_py",
    ],
)
