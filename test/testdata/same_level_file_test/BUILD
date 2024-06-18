filegroup(
    name = "srcs",
    testonly = 0,
    srcs = glob(["**"]),
    visibility = ["//src:__subpackages__"],
)

exports_files(
    [
        "dep.bzl",
        "golden.md",
        "noenable_bzlmod_golden.md",
        "input.bzl",
    ],
)
