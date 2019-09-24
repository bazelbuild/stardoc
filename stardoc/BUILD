licenses(["notice"])  # Apache 2.0

package(default_visibility = ["//visibility:public"])

exports_files(glob(["templates/**"]))

load("@bazel_skylib//:bzl_library.bzl", "bzl_library")
load("//stardoc:stardoc.bzl", "stardoc")
load("@rules_java//java:defs.bzl", "java_binary", "java_import")

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
    deps = [
        "@bazel_skylib//:bzl_library",
    ],
    visibility = ["//visibility:public"],
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

java_binary(
    name = "stardoc",
    jvm_flags = [
        # quiet warnings from com.google.protobuf.UnsafeUtil,
        # see: https://github.com/google/protobuf/issues/3781
        # TODO(cparsons): Remove once Stardoc has the fix.
        "-XX:+IgnoreUnrecognizedVMOptions",
        "--add-opens=java.base/java.nio=ALL-UNNAMED",
        "--add-opens=java.base/java.lang=ALL-UNNAMED",
    ],
    main_class = "com.google.devtools.build.skydoc.SkydocMain",
    runtime_deps = [
        ":prebuilt_stardoc_binary",
    ],
)

java_import(
    name = "prebuilt_stardoc_binary",
    jars = ["stardoc_binary.jar"],
    visibility = ["//visibility:private"],
)

java_binary(
    name = "renderer",
    jvm_flags = [
        # quiet warnings from com.google.protobuf.UnsafeUtil,
        # see: https://github.com/google/protobuf/issues/3781
        # TODO(cparsons): Remove once Stardoc has the fix.
        "-XX:+IgnoreUnrecognizedVMOptions",
        "--add-opens=java.base/java.nio=ALL-UNNAMED",
        "--add-opens=java.base/java.lang=ALL-UNNAMED",
    ],
    main_class = "com.google.devtools.build.skydoc.renderer.RendererMain",
    runtime_deps = [
        ":prebuilt_renderer_binary",
    ],
)

java_import(
    name = "prebuilt_renderer_binary",
    jars = ["renderer_binary.jar"],
    visibility = ["//visibility:private"],
)
