licenses(["notice"])  # Apache 2.0

package(default_visibility = ["//visibility:public"])

load("@bazel_skylib//:skylark_library.bzl", "skylark_library")
load("//skylark:skylark.bzl", "skylark_doc")
load("//skylark:stardoc.bzl", "stardoc")

skylark_library(
    name = "skylark",
    srcs = ["skylark.bzl"],
    deps = [
        "@bazel_skylib//:skylark_library",
    ],
)

skylark_library(
    name = "stardoc_lib",
    srcs = ["stardoc.bzl"],
    deps = [
        "@bazel_skylib//:skylark_library",
    ],
)

skylark_doc(
    name = "skylark-docs",
    srcs = ["skylark.bzl"],
    overview = False,
    strip_prefix = "skylark",
    deps = [":skylark"],
)

stardoc(
    name = "stardoc_doc",
    out = "stardoc_doc.md",
    input = ":stardoc.bzl",
    symbol_names = ["stardoc"],
    deps = [":stardoc_lib"],
)
