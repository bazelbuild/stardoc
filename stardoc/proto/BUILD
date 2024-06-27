load("@rules_java//java:defs.bzl", "java_proto_library")

licenses(["notice"])

package(
    default_applicable_licenses = ["//:license"],
    default_visibility = ["//visibility:public"],
)

exports_files(["stardoc_output.proto"])

proto_library(
    name = "stardoc_output_proto",
    srcs = ["stardoc_output.proto"],
)

java_proto_library(
    name = "stardoc_output_java_proto",
    deps = [":stardoc_output_proto"],
)
