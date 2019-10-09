load("@io_bazel_skydoc//stardoc:stardoc.bzl", "stardoc")

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
)
