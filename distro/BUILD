load("@rules_pkg//:pkg.bzl", "pkg_tar")
load("@stardoc//:version.bzl", "version")
load(":distro.bzl", "strip_internal_only")

package(
    default_applicable_licenses = ["//:license"],
    default_visibility = ["//visibility:private"],
)

alias(
    name = "distro",
    actual = "stardoc-%s" % version,
)

strip_internal_only(
    name = "distro_module_bazel",
    src = "//:MODULE.bazel",
    out = "MODULE.bazel",
)

strip_internal_only(
    name = "distro_workspace",
    src = "//:WORKSPACE",
    out = "WORKSPACE",
)

strip_internal_only(
    name = "distro_workspace_bzlmod",
    src = "//:WORKSPACE.bzlmod",
    out = "WORKSPACE.bzlmod",
)

# Build the artifact to put on the github release page.
pkg_tar(
    name = "stardoc-%s" % version,
    srcs = [
        "distro_module_bazel",
        "distro_workspace",
        "distro_workspace_bzlmod",
        "//:distro_srcs",
    ],
    extension = "tar.gz",
    mode = "0644",
    # Make it owned by root so it does not have the uid of the CI robot.
    owner = "0.0",
    package_dir = "",
    strip_prefix = ".",
)
