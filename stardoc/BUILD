licenses(["notice"])  # Apache 2.0

package(default_visibility = ["//visibility:public"])

load("@bazel_skylib//:skylark_library.bzl", "skylark_library")
load("//stardoc:stardoc.bzl", "stardoc")

skylark_library(
    name = "stardoc_lib",
    srcs = ["stardoc.bzl"],
    deps = [
        "@bazel_skylib//:skylark_library",
    ],
)

stardoc(
    name = "stardoc_doc",
    out = "stardoc_doc.md",
    input = ":stardoc.bzl",
    symbol_names = ["stardoc"],
    deps = [":stardoc_lib"],
)
