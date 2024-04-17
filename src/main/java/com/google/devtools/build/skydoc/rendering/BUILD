load("@rules_java//java:defs.bzl", "java_library")

package(
    default_applicable_licenses = ["//:license"],
    default_visibility = ["//src:__subpackages__"],
)

filegroup(
    name = "srcs",
    srcs = glob(["**"]),
    visibility = ["//:__pkg__"],
)

java_library(
    name = "rendering",
    srcs = glob(
        ["*.java"],
    ),
    deps = [
        "//stardoc/proto:stardoc_output_java_proto",
        "@stardoc_maven//:com_google_escapevelocity_escapevelocity",
        "@stardoc_maven//:com_google_guava_guava",
    ],
)
