load("@rules_license//rules:license.bzl", "license")

package(default_applicable_licenses = [":license"])

license(
    name = "license",
    package_name = "bazelbuild/stardoc",
    license_kinds = ["@rules_license//licenses/spdx:Apache-2.0"],
)

licenses(["notice"])

exports_files([
    "LICENSE",
    "WORKSPACE",
])

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
        "MODULE.bazel",
        "//stardoc:distro_srcs",
        "//stardoc/private:distro_srcs",
        "//stardoc/proto:distro_srcs",
    ] + glob(["*.bzl"]),
    visibility = ["//:__subpackages__"],
)

# Binaries needed for release tarball.
filegroup(
    name = "distro_bins",
    srcs = [
        "//stardoc:distro_bins",
    ],
    visibility = ["//:__subpackages__"],
)
