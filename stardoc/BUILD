licenses(["notice"])  # Apache 2.0

package(default_visibility = ["//visibility:public"])

load("@bazel_skylib//:bzl_library.bzl", "bzl_library")
load("//stardoc:stardoc.bzl", "stardoc")

bzl_library(
    name = "stardoc_lib",
    srcs = ["stardoc.bzl"],
    deps = [
        "@bazel_skylib//:bzl_library",
    ],
)

stardoc(
    name = "stardoc_doc",
    out = "stardoc_doc.md",
    input = ":stardoc.bzl",
    symbol_names = [
        "stardoc",
        "_stardoc_impl",
    ],
    deps = [":stardoc_lib"],
)
