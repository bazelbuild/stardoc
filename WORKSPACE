workspace(name = "io_bazel_skydoc")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load(":setup.bzl", "stardoc_repositories")

stardoc_repositories()

#######################################################################
##### MOST USERS SHOULD NOT NEED TO COPY ANYTHING BELOW THIS LINE #####
#######################################################################
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

# Needed for generating the Stardoc release binary.
git_repository(
    name = "io_bazel",
    commit = "cfebb18ad206162c1309962e8d396a5fd0ef234e",  # Dec 30, 2020
    remote = "https://github.com/bazelbuild/bazel.git",
    shallow_since = "1609373204 -0800",
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

# Needed only because of java_tools.
http_archive(
    name = "rules_cc",
    sha256 = "36fa66d4d49debd71d05fba55c1353b522e8caef4a20f8080a3d17cdda001d89",
    strip_prefix = "rules_cc-0d5f3f2768c6ca2faca0079a997a97ce22997a0c",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_cc/archive/0d5f3f2768c6ca2faca0079a997a97ce22997a0c.zip",
        "https://github.com/bazelbuild/rules_cc/archive/0d5f3f2768c6ca2faca0079a997a97ce22997a0c.zip",
    ],
)

# Needed as a transitive dependency of @io_bazel
git_repository(
    name = "rules_python",
    commit = "4b84ad270387a7c439ebdccfd530e2339601ef27",
    remote = "https://github.com/bazelbuild/rules_python.git",
    shallow_since = "1564776078 -0400",
)

# Needed as a transitive dependency of @io_bazel
http_archive(
    name = "rules_pkg",
    sha256 = "5bdc04987af79bd27bc5b00fe30f59a858f77ffa0bd2d8143d5b31ad8b1bd71c",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_pkg/rules_pkg-0.2.0.tar.gz",
        "https://github.com/bazelbuild/rules_pkg/releases/download/0.2.0/rules_pkg-0.2.0.tar.gz",
    ],
)

# Needed as a transitive dependency of @io_bazel
http_archive(
    name = "rules_proto",
    sha256 = "88b0a90433866b44bb4450d4c30bc5738b8c4f9c9ba14e9661deb123f56a833d",
    strip_prefix = "rules_proto-b0cc14be5da05168b01db282fe93bdf17aa2b9f4",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_proto/archive/b0cc14be5da05168b01db282fe93bdf17aa2b9f4.tar.gz",
        "https://github.com/bazelbuild/rules_proto/archive/b0cc14be5da05168b01db282fe93bdf17aa2b9f4.tar.gz",
    ],
)

# Needed only for testing stardoc across local-repository bounds.
local_repository(
    name = "local_repository_test",
    path = "test/testdata/local_repository_test",
)

load("@rules_proto//proto:repositories.bzl", "rules_proto_dependencies", "rules_proto_toolchains")

rules_proto_dependencies()

rules_proto_toolchains()
