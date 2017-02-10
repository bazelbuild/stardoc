workspace(name = "io_bazel_skydoc")

git_repository(
    name = "io_bazel_rules_sass",
    remote = "https://github.com/bazelbuild/rules_sass.git",
    tag = "0.0.2",
)
load("@io_bazel_rules_sass//sass:sass.bzl", "sass_repositories")
sass_repositories()

load("//skylark:skylark.bzl", "skydoc_repositories")
skydoc_repositories()
