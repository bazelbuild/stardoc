load("@com_google_protobuf//bazel:java_proto_library.bzl", "java_proto_library")
load("@com_google_protobuf//bazel:proto_library.bzl", "proto_library")

licenses(["notice"])

package(
    default_applicable_licenses = ["//:license"],
    default_visibility = ["//visibility:public"],
)

exports_files(["stardoc_output.proto"])

# Sources needed for release tarball.
filegroup(
    name = "distro_srcs",
    srcs = [
        "BUILD",
    ] + glob(["*.proto"]),
    visibility = ["//:__pkg__"],
)

proto_library(
    name = "stardoc_output_proto",
    srcs = ["stardoc_output.proto"],
)

java_proto_library(
    name = "stardoc_output_java_proto",
    deps = [":stardoc_output_proto"],
)
