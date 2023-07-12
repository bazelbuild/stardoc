load("@rules_java//java:defs.bzl", "java_library")

package(
    default_applicable_licenses = ["//:license"],
    default_visibility = ["//src:__subpackages__"],
)

filegroup(
    name = "srcs",
    srcs = glob(["**"]),
    visibility = ["//src:__subpackages__"],
)

java_library(
    name = "rendering",
    srcs = glob(
        ["*.java"],
    ),
    deps = [
        "//stardoc/proto:stardoc_output_java_proto",
        "@maven//:com_google_guava_guava",
        "@maven//:org_apache_velocity_velocity",
    ],
)
