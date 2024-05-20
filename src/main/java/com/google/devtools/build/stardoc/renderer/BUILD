load("@rules_java//java:defs.bzl", "java_binary", "java_library")

package(default_applicable_licenses = ["//:license"])

filegroup(
    name = "srcs",
    srcs = glob(["**"]),
    visibility = ["//:__pkg__"],
)

java_binary(
    name = "renderer",
    jvm_flags = [
        # quiet warnings from com.google.protobuf.UnsafeUtil,
        # see: https://github.com/google/protobuf/issues/3781
        # and: https://github.com/bazelbuild/bazel/issues/5599
        "--add-opens=java.base/java.nio=ALL-UNNAMED",
        "--add-opens=java.base/java.lang=ALL-UNNAMED",
        # ... but only on JDK >= 9
        "-XX:+IgnoreUnrecognizedVMOptions",
    ],
    main_class = "com.google.devtools.build.stardoc.renderer.RendererMain",
    visibility = ["//visibility:public"],
    runtime_deps = [
        ":renderer_lib",
    ],
)

java_library(
    name = "renderer_lib",
    srcs = glob(["*.java"]),
    deps = [
        "//src/main/java/com/google/devtools/build/stardoc/rendering",
        "//stardoc/proto:stardoc_output_java_proto",
        "@stardoc_maven//:com_beust_jcommander",
        "@stardoc_maven//:com_google_guava_guava",
    ],
)
