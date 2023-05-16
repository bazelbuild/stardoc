load("@bazel_skylib//:bzl_library.bzl", "bzl_library")

bzl_library(
    name = "stardoc_lib",
    srcs = ["stardoc.bzl"],
    visibility = ["//stardoc:__pkg__"],
)

# Sources needed for release tarball.
filegroup(
    name = "distro_srcs",
    srcs = [
        "BUILD",
    ] + glob([
        "*.bzl",
    ]),
    visibility = ["//:__pkg__"],
)
