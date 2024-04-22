load("@rules_pkg//:pkg.bzl", "pkg_tar")
load("@stardoc//:version.bzl", "version")

package(
    default_applicable_licenses = ["//:license"],
    default_visibility = ["//visibility:private"],
)

alias(
    name = "distro",
    actual = "stardoc-%s" % version,
)

genrule(
    name = "distro_workspace",
    srcs = ["//:WORKSPACE"],
    outs = ["WORKSPACE"],
    cmd = "sed -e '/### INTERNAL ONLY/,/### END INTERNAL ONLY/d' $(location //:WORKSPACE) >$@",
)

pkg_tar(
    name = "distro_srcs",
    srcs = [
        "distro_workspace",
        "//:distro_srcs",
    ],
    mode = "0644",
    # Make it owned by root so it does not have the uid of the CI robot.
    owner = "0.0",
    package_dir = "",
    strip_prefix = ".",
)

pkg_tar(
    name = "distro_bins",
    srcs = ["//:distro_bins"],
    mode = "0755",
    # Make it owned by root so it does not have the uid of the CI robot.
    owner = "0.0",
    package_dir = "",
    strip_prefix = ".",
)

# Build the artifact to put on the github release page.
pkg_tar(
    name = "stardoc-%s" % version,
    extension = "tar.gz",
    # Make it owned by root so it does not have the uid of the CI robot.
    owner = "0.0",
    strip_prefix = ".",
    deps = [
        ":distro_bins.tar",
        ":distro_srcs.tar",
    ],
)
