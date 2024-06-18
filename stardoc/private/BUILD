load("@bazel_skylib//:bzl_library.bzl", "bzl_library")
load("//stardoc/private:stamp_detector.bzl", "stamp_detector")

bzl_library(
    name = "stardoc_lib",
    srcs = [
        "stamp_detector.bzl",
        "stardoc.bzl",
    ],
    visibility = ["//stardoc:__pkg__"],
)

config_setting(
    name = "stamp_enabled",
    values = {"stamp": "1"},
    visibility = ["//visibility:private"],
)

stamp_detector(
    name = "stamp_detector",
    enabled = select({
        "stamp_enabled": True,
        "//conditions:default": False,
    }),
    visibility = ["//visibility:public"],
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
