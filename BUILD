load("@rules_license//rules:license.bzl", "license")

package(default_applicable_licenses = [":license"])

license(
    name = "license",
    package_name = "bazelbuild/stardoc",
    license_kinds = ["@rules_license//licenses/spdx:Apache-2.0"],
)

licenses(["notice"])

exports_files(
    ["LICENSE"],
    visibility = ["//visibility:public"],
)

# Inputs for distro transformations and consistency tests.
exports_files(
    [
        "WORKSPACE",
        "WORKSPACE.bzlmod",
        "MODULE.bazel",
        "deps.bzl",
        "version.bzl",
    ],
    visibility = ["//:__subpackages__"],
)

filegroup(
    name = "stardoc_rule_doc",
    testonly = 1,
    srcs = ["docs/stardoc_rule.md"],
    visibility = ["//test:__pkg__"],
)

# Sources needed for release tarball.
filegroup(
    name = "distro_srcs",
    srcs = [
        "AUTHORS",
        "BUILD",
        "CHANGELOG.md",
        "CONTRIBUTORS",
        "LICENSE",
        "maven_install.json",
        "//src/main/java/com/google/devtools/build/stardoc/renderer:srcs",
        "//src/main/java/com/google/devtools/build/stardoc/rendering:srcs",
        "//stardoc:distro_srcs",
        "//stardoc/private:distro_srcs",
        "//stardoc/proto:distro_srcs",
    ] + glob(["*.bzl"]),
    visibility = ["//:__subpackages__"],
)
