workspace(name = "io_bazel_stardoc")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load(":setup.bzl", "stardoc_repositories")

stardoc_repositories()

load("@rules_jvm_external//:repositories.bzl", "rules_jvm_external_deps")

rules_jvm_external_deps()

load("@rules_jvm_external//:setup.bzl", "rules_jvm_external_setup")

rules_jvm_external_setup()

load(":deps.bzl", "stardoc_external_deps")

stardoc_external_deps()

load("@stardoc_maven//:defs.bzl", stardoc_pinned_maven_install = "pinned_maven_install")

stardoc_pinned_maven_install()

### INTERNAL ONLY - lines after this are not included in the release packaging.
#
# Include dependencies which are only needed for development of Stardoc here.

load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

# Needed for generating the Stardoc release binary.
git_repository(
    name = "io_bazel",
    commit = "ff36d875b9b236ad141dce40e65cae5f4ffbfdcb",  # Bazel 7.0.1 - 2024-01-18
    patch_cmds = [
        # Used by update-release-binary.sh for vendoring files from @io_bazel
        "git log -n 1 --format=%H > .io_bazel.sha",
    ],
    remote = "https://github.com/bazelbuild/bazel.git",
)

# The following binds are needed for building protobuf java libraries.
bind(
    name = "guava",
    actual = "@io_bazel//third_party:guava",
)

bind(
    name = "gson",
    actual = "@io_bazel//third_party:gson",
)

bind(
    name = "error_prone_annotations",
    actual = "@io_bazel//third_party:error_prone_annotations",
)

# Needed for //distro:__pkg__
http_archive(
    name = "rules_pkg",
    sha256 = "d250924a2ecc5176808fc4c25d5cf5e9e79e6346d79d5ab1c493e289e722d1d0",
    urls = [
        "https://github.com/bazelbuild/rules_pkg/releases/download/0.10.1/rules_pkg-0.10.1.tar.gz",
    ],
)

load("@rules_pkg//:deps.bzl", "rules_pkg_dependencies")

rules_pkg_dependencies()

# Needed only for testing stardoc across local-repository bounds.
local_repository(
    name = "stardoc",  # alias the Bzlmod name of the Stardoc repo for local_repository_test
    path = ".",
)

local_repository(
    name = "local_repository_test",
    path = "test/testdata/local_repository_test",
)

load("@rules_proto//proto:repositories.bzl", "rules_proto_dependencies")

rules_proto_dependencies()

load("@rules_proto//proto:setup.bzl", "rules_proto_setup")

rules_proto_setup()

load("@rules_proto//proto:toolchains.bzl", "rules_proto_toolchains")

rules_proto_toolchains()
