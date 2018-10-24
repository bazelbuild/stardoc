workspace(name = "io_bazel_skydoc")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

git_repository(
    name = "io_bazel_rules_sass",
    remote = "https://github.com/bazelbuild/rules_sass.git",
    tag = "0.0.3",
)
git_repository(
    name = "bazel_skylib",
    remote = "https://github.com/bazelbuild/bazel-skylib.git",
    tag = "0.2.0",
)
git_repository(
    name = "io_bazel",
    remote = "https://github.com/bazelbuild/bazel.git",
    # TODO(cparsons): Depend on a release tag of bazel when there is
    # a valid release containing an updated stardoc binary.
    commit = "b749ab1f8549cdad0a574c356a57fe7181b07851",
)
http_archive(
    name = "com_google_protobuf",
    strip_prefix = "protobuf-3.5.1",
    urls = ["https://github.com/google/protobuf/archive/v3.5.1.zip"],
)

load("@io_bazel_rules_sass//sass:sass.bzl", "sass_repositories")
sass_repositories()

load("//skylark:skylark.bzl", "skydoc_repositories")
skydoc_repositories()
