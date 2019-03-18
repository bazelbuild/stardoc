workspace(name = "io_bazel_skydoc")

load(":setup.bzl", "skydoc_repositories")
skydoc_repositories()

load("@io_bazel_rules_sass//:package.bzl", "rules_sass_dependencies")
rules_sass_dependencies()

load("@build_bazel_rules_nodejs//:defs.bzl", "node_repositories")
node_repositories()

load("@io_bazel_rules_sass//:defs.bzl", "sass_repositories")
sass_repositories()

#######################################################################
##### MOST USERS SHOULD NOT NEED TO COPY ANYTHING BELOW THIS LINE #####
#######################################################################
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

# Needed for skydoc only (not Stardoc), which is deprecated. Users should include
# this in their WORKSPACE only if they need skydoc.
git_repository(
    name = "com_google_protobuf",
    remote = "https://github.com/protocolbuffers/protobuf.git",
    commit = "7b28271a61a3da0a37f6fda399b0c4c86464e5b3",  # 2018-11-16
)

# Needed for generating the Stardoc release binary.
git_repository(
    name = "io_bazel",
    remote = "https://github.com/bazelbuild/bazel.git",
    commit = "49107ad79ef08811db22636928dfd113a9acf902",  # Mar 08, 2019
)
