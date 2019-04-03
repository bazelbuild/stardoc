licenses(["notice"])  # Apache 2.0

package(default_visibility = ["//visibility:public"])

load("@bazel_skylib//:bzl_library.bzl", "bzl_library")
load("//stardoc:stardoc.bzl", "stardoc")

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
)

stardoc(
    name = "stardoc_doc",
    out = "stardoc_doc.md",
    input = ":stardoc.bzl",
    symbol_names = [
        "stardoc",
        "_stardoc_impl",
    ],
    deps = [":stardoc_lib"],
)

java_binary(
    name = "stardoc",
    main_class = "com.google.devtools.build.skydoc.SkydocMain",
    runtime_deps = [
        ":prebuilt_stardoc_binary",
    ],
    jvm_flags = [
        # quiet warnings from com.google.protobuf.UnsafeUtil,
        # see: https://github.com/google/protobuf/issues/3781
        # TODO(cparsons): Remove once Stardoc has the fix.
        "-XX:+IgnoreUnrecognizedVMOptions",
        "--add-opens=java.base/java.nio=ALL-UNNAMED",
        "--add-opens=java.base/java.lang=ALL-UNNAMED",
    ],
)

java_import(
    name = "prebuilt_stardoc_binary",
    jars = ["stardoc_binary.jar"],
    visibility = ["//visibility:private"],
)
