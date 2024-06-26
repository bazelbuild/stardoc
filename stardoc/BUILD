load("@bazel_skylib//:bzl_library.bzl", "bzl_library")
load("//stardoc:stardoc.bzl", "stardoc")

licenses(["notice"])

package(
    default_applicable_licenses = ["//:license"],
    default_visibility = ["//visibility:public"],
)

exports_files(glob(["templates/**"]))

filegroup(
    name = "test_deps",
    testonly = True,
    srcs = [
        "BUILD",
    ] + glob(["*.bzl"]),
    visibility = ["//visibility:public"],
)

bzl_library(
    name = "stardoc_lib",
    srcs = ["stardoc.bzl"],
    visibility = ["//visibility:public"],
    deps = [
        "//stardoc/private:stardoc_lib",
        "@bazel_skylib//rules:copy_file",
        "@rules_java//java:rules",
    ],
)

bzl_library(
    name = "html_tables_stardoc",
    srcs = ["html_tables_stardoc.bzl"],
    visibility = ["//visibility:public"],
    deps = [
        ":stardoc_lib",
    ],
)

stardoc(
    name = "stardoc_doc",
    out = "stardoc_doc.md",
    input = ":stardoc.bzl",
    symbol_names = [
        "stardoc",
    ],
    deps = [":stardoc_lib"],
)

alias(
    name = "renderer",
    actual = "//src/main/java/com/google/devtools/build/stardoc/renderer",
)

# Sources needed for release tarball.
filegroup(
    name = "distro_srcs",
    srcs = [
        "BUILD",
    ] + glob([
        "*.bzl",
        "templates/**",
    ]),
    visibility = ["//:__pkg__"],
)
