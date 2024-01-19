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

load("@rules_jvm_external//:defs.bzl", "maven_install")

# Bazel's Maven dependencies - must live in @maven
maven_install(
    artifacts = [
        "com.github.ben-manes.caffeine:caffeine:3.0.5",
        "com.github.stephenc.jcip:jcip-annotations:1.0-1",
        "com.google.auto.service:auto-service-annotations:1.0.1",
        "com.google.auto.service:auto-service:1.0",
        "com.google.auto.value:auto-value-annotations:1.9",
        "com.google.auto.value:auto-value:1.8.2",
        "com.google.auto:auto-common:1.2.1",
        "com.google.code.findbugs:jsr305:3.0.2",
        "com.google.code.gson:gson:2.9.0",
        "com.google.errorprone:error_prone_annotations:2.18.0",
        "com.google.errorprone:error_prone_type_annotations:2.18.0",
        "com.google.flogger:flogger-system-backend:0.5.1",
        "com.google.flogger:flogger:0.5.1",
        "com.google.flogger:google-extensions:0.5.1",
        "com.google.guava:failureaccess:1.0.1",
        "com.google.guava:guava:31.1-jre",
        "com.google.j2objc:j2objc-annotations:1.3",
        "com.ryanharter.auto.value:auto-value-gson-extension:1.3.1",
        "com.ryanharter.auto.value:auto-value-gson-runtime:1.3.1",
        "com.ryanharter.auto.value:auto-value-gson-factory:1.3.1",
        "com.squareup:javapoet:1.12.0",
        "commons-collections:commons-collections:3.2.2",
        "commons-lang:commons-lang:2.6",
        "org.apache.tomcat:tomcat-annotations-api:8.0.5",
        "org.apache.velocity:velocity:1.7",
        "org.checkerframework:checker-qual:3.19.0",
    ],
    fail_if_repin_required = True,
    maven_install_json = "//:legacy_maven_install.json",
    repositories = [
        "https://repo1.maven.org/maven2",
    ],
    strict_visibility = True,
)

load("@maven//:defs.bzl", "pinned_maven_install")

pinned_maven_install()

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
http_archive(
    name = "rules_python",
    sha256 = "a644da969b6824cc87f8fe7b18101a8a6c57da5db39caa6566ec6109f37d2141",
    strip_prefix = "rules_python-0.20.0",
    urls = ["https://github.com/bazelbuild/rules_python/releases/download/0.20.0/rules_python-0.20.0.tar.gz"],
)

# Needed for //distro:__pkg__ and as a transitive dependency of @io_bazel
http_archive(
    name = "rules_pkg",
    sha256 = "eea0f59c28a9241156a47d7a8e32db9122f3d50b505fae0f33de6ce4d9b61834",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_pkg/releases/download/0.8.0/rules_pkg-0.8.0.tar.gz",
        "https://github.com/bazelbuild/rules_pkg/releases/download/0.8.0/rules_pkg-0.8.0.tar.gz",
    ],
)

load("@rules_pkg//:deps.bzl", "rules_pkg_dependencies")

rules_pkg_dependencies()

# Needed as a transitive dependency of @io_bazel
http_archive(
    name = "rules_proto",
    sha256 = "dc3fb206a2cb3441b485eb1e423165b231235a1ea9b031b4433cf7bc1fa460dd",
    strip_prefix = "rules_proto-5.3.0-21.7",
    urls = [
        "https://github.com/bazelbuild/rules_proto/archive/refs/tags/5.3.0-21.7.tar.gz",
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

# Needed as a transitive dependency of @io_bazel
http_archive(
    name = "blake3",
    build_file = "@io_bazel//third_party:blake3/blake3.BUILD",
    sha256 = "bb529ba133c0256df49139bd403c17835edbf60d2ecd6463549c6a5fe279364d",
    strip_prefix = "BLAKE3-1.3.3",
    urls = [
        "https://github.com/BLAKE3-team/BLAKE3/archive/refs/tags/1.3.3.zip",
    ],
)
