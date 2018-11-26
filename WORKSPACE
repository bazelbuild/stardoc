workspace(name = "io_bazel_skydoc")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

git_repository(
    name = "io_bazel_rules_sass",
    remote = "https://github.com/bazelbuild/rules_sass.git",
    commit = "8b61ad6953fde55031658e1731c335220f881369"
)
git_repository(
    name = "bazel_skylib",
    remote = "https://github.com/bazelbuild/bazel-skylib.git",
    tag = "0.5.0",
)
git_repository(
    name = "io_bazel",
    remote = "https://github.com/bazelbuild/bazel.git",
    # TODO: Update to a newer tagged version when available.
    commit = "e7ebb7e68d35ae090d91fe6b4c92c1c831421faa",  # 2018-11-26
)
# Required by @io_bazel.
# Note that @protobuf is already created in skydoc_repositories().
# Maybe keep this in sync with that.
git_repository(
    name = "com_google_protobuf",
    remote = "https://github.com/protocolbuffers/protobuf.git",
    # Latest tagged version at time of writing is v3.6.1, which doesn't
    # include fixes for --incompatible_package_name_is_a_function,
    # --incompatible_new_actions_api, and possibly others.
    # TODO: Update to a newer tagged version when available.
    commit = "7b28271a61a3da0a37f6fda399b0c4c86464e5b3",  # 2018-11-16
)

load("@io_bazel_rules_sass//:package.bzl", "rules_sass_dependencies")
rules_sass_dependencies()

load("@build_bazel_rules_nodejs//:defs.bzl", "node_repositories")
node_repositories()

load("@io_bazel_rules_sass//:defs.bzl", "sass_repositories")
sass_repositories()

load("//skylark:skylark.bzl", "skydoc_repositories")
skydoc_repositories()
