load("@bazel_skylib//:bzl_library.bzl", "bzl_library")
load("@stardoc//stardoc:stardoc.bzl", "stardoc")

package(
    default_visibility = ["//visibility:public"],
)

licenses(["notice"])  # Apache 2.0

exports_files([
    "input.bzl",
    "golden.md",
])

stardoc(
    name = "input_doc",
    out = "output.md",
    input = ":input.bzl",
    deps = [":lib"],
)

bzl_library(
    name = "lib",
    srcs = [
        "input.bzl",
        "@stardoc//test:testdata/fakedeps/dep.bzl",
    ],
)
