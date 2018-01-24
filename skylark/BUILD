licenses(["notice"]) # Apache 2.0

package(default_visibility = ["//visibility:public"])

load("@bazel_skylib//:skylark_library.bzl", "skylark_library")
load("//skylark:skylark.bzl", "skylark_doc")

skylark_library(
    name = "skylark",
    srcs = ["skylark.bzl"],
    deps = ["@bazel_skylib//:skylark_library"],
)

skylark_doc(
    name = "skylark-docs",
    srcs = ["skylark.bzl"],
    overview = False,
    strip_prefix = "skylark",
    deps = [":skylark"],
)
