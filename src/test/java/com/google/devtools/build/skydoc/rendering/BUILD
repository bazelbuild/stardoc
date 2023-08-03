load("@rules_java//java:defs.bzl", "java_test")

package(
    default_applicable_licenses = ["//:license"],
    default_visibility = [
        "//src:__subpackages__",
        "//stardoc:__subpackages__",
    ],
)

filegroup(
    name = "srcs",
    testonly = 0,
    srcs = glob(["*"]),
    visibility = ["//:__pkg__"],
)

java_test(
    name = "MarkdownUtilTest",
    size = "small",
    srcs = ["MarkdownUtilTest.java"],
    deps = [
        "//src/main/java/com/google/devtools/build/skydoc/rendering",
        "@stardoc_maven//:com_google_truth_truth",
        "@stardoc_maven//:junit_junit",
    ],
)
