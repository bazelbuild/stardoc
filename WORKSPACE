workspace(name = "io_bazel_stardoc")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load(":setup.bzl", "stardoc_repositories")

stardoc_repositories()

### INTERNAL ONLY - lines after this are not included in the release packaging.
#
# Include dependencies which are only needed for development of Stardoc here.

load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

# Needed for generating the Stardoc release binary.
git_repository(
    name = "io_bazel",
    commit = "c6a8c0827061697fa8fa9dd21310b276d9887e8c",  # 2023-04-27
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

RULES_JVM_EXTERNAL_TAG = "4.5"

RULES_JVM_EXTERNAL_SHA = "b17d7388feb9bfa7f2fa09031b32707df529f26c91ab9e5d909eb1676badd9a6"

http_archive(
    name = "rules_jvm_external",
    sha256 = RULES_JVM_EXTERNAL_SHA,
    strip_prefix = "rules_jvm_external-%s" % RULES_JVM_EXTERNAL_TAG,
    url = "https://github.com/bazelbuild/rules_jvm_external/archive/refs/tags/%s.zip" % RULES_JVM_EXTERNAL_TAG,
)

load("@rules_jvm_external//:repositories.bzl", "rules_jvm_external_deps")

rules_jvm_external_deps()

load("@rules_jvm_external//:setup.bzl", "rules_jvm_external_setup")

rules_jvm_external_setup()

load("@rules_jvm_external//:defs.bzl", "maven_install")

maven_install(
    artifacts = [
        "com.beust:jcommander:1.48",
        "com.github.ben-manes.caffeine:caffeine:3.0.5",
        "com.github.kevinstern:software-and-algorithms:1.0",
        "com.github.stephenc.jcip:jcip-annotations:1.0-1",
        "com.google.api-client:google-api-client-gson:1.35.2",
        "com.google.api-client:google-api-client:1.35.2",
        "com.google.auth:google-auth-library-credentials:1.6.0",
        "com.google.auth:google-auth-library-oauth2-http:1.6.0",
        "com.google.auto.service:auto-service-annotations:1.0.1",
        "com.google.auto.service:auto-service:1.0",
        "com.google.auto.value:auto-value-annotations:1.9",
        "com.google.auto.value:auto-value:1.8.2",
        "com.google.auto:auto-common:1.2.1",
        "com.google.code.findbugs:jsr305:3.0.2",
        "com.google.code.gson:gson:2.9.0",
        "com.google.code.java-allocation-instrumenter:java-allocation-instrumenter:3.3.0",
        "com.google.errorprone:error_prone_annotation:2.18.0",
        "com.google.errorprone:error_prone_annotations:2.18.0",
        "com.google.errorprone:error_prone_check_api:2.18.0",
        "com.google.errorprone:error_prone_core:2.18.0",
        "com.google.errorprone:error_prone_type_annotations:2.18.0",
        "com.google.flogger:flogger-system-backend:0.5.1",
        "com.google.flogger:flogger:0.5.1",
        "com.google.flogger:google-extensions:0.5.1",
        "com.google.guava:failureaccess:1.0.1",
        "com.google.guava:guava:31.1-jre",
        "com.google.http-client:google-http-client-gson:1.42.0",
        "com.google.http-client:google-http-client:1.42.0",
        "com.google.j2objc:j2objc-annotations:1.3",
        "com.ryanharter.auto.value:auto-value-gson-extension:1.3.1",
        "com.ryanharter.auto.value:auto-value-gson-runtime:1.3.1",
        "com.ryanharter.auto.value:auto-value-gson-factory:1.3.1",
        "com.squareup:javapoet:1.12.0",
        "commons-collections:commons-collections:3.2.2",
        "commons-lang:commons-lang:2.6",
        "io.github.java-diff-utils:java-diff-utils:4.0",
        "io.grpc:grpc-api:1.47.0",
        "io.grpc:grpc-auth:1.47.0",
        "io.grpc:grpc-context:1.47.0",
        "io.grpc:grpc-core:1.47.0",
        "io.grpc:grpc-netty:1.47.0",
        "io.grpc:grpc-protobuf-lite:1.47.0",
        "io.grpc:grpc-protobuf:1.47.0",
        "io.grpc:grpc-stub:1.47.0",
        "io.netty:netty-buffer:4.1.87.Final",
        "io.netty:netty-codec-http2:4.1.87.Final",
        "io.netty:netty-codec-http:4.1.87.Final",
        "io.netty:netty-codec:4.1.87.Final",
        "io.netty:netty-common:4.1.87.Final",
        "io.netty:netty-handler-proxy:4.1.87.Final",
        "io.netty:netty-handler:4.1.87.Final",
        "io.netty:netty-resolver-dns:4.1.87.Final",
        "io.netty:netty-resolver:4.1.87.Final",
        "io.netty:netty-tcnative-boringssl-static:jar:linux-aarch_64:2.0.56.Final",
        "io.netty:netty-tcnative-boringssl-static:jar:linux-x86_64:2.0.56.Final",
        "io.netty:netty-tcnative-boringssl-static:jar:osx-aarch_64:2.0.56.Final",
        "io.netty:netty-tcnative-boringssl-static:jar:osx-x86_64:2.0.56.Final",
        "io.netty:netty-tcnative-boringssl-static:jar:windows-x86_64:2.0.56.Final",
        "io.netty:netty-tcnative-classes:2.0.56.Final",
        "io.netty:netty-transport-classes-epoll:4.1.87.Final",
        "io.netty:netty-transport-classes-kqueue:4.1.87.Final",
        "io.netty:netty-transport-native-epoll:jar:linux-aarch_64:4.1.87.Final",
        "io.netty:netty-transport-native-epoll:jar:linux-x86_64:4.1.87.Final",
        "io.netty:netty-transport-native-kqueue:jar:osx-aarch_64:4.1.87.Final",
        "io.netty:netty-transport-native-kqueue:jar:osx-x86_64:4.1.87.Final",
        "io.netty:netty-transport-native-unix-common:4.1.87.Final",
        "io.netty:netty-transport-native-unix-common:jar:linux-aarch_64:4.1.87.Final",
        "io.netty:netty-transport-native-unix-common:jar:linux-x86_64:4.1.87.Final",
        "io.netty:netty-transport-native-unix-common:jar:osx-aarch_64:4.1.87.Final",
        "io.netty:netty-transport-native-unix-common:jar:osx-x86_64:4.1.87.Final",
        "io.netty:netty-transport-sctp:4.1.87.Final",
        "io.netty:netty-transport:4.1.87.Final",
        "io.reactivex.rxjava3:rxjava:3.1.2",
        "javax.activation:javax.activation-api:1.2.0",
        "javax.annotation:javax.annotation-api:1.3.2",
        "javax.inject:javax.inject:1",
        "net.bytebuddy:byte-buddy-agent:1.11.13",
        "net.bytebuddy:byte-buddy:1.11.13",
        "org.apache.commons:commons-compress:1.19",
        "org.apache.commons:commons-pool2:2.8.0",
        "org.apache.tomcat:tomcat-annotations-api:8.0.5",
        "org.apache.velocity:velocity:1.7",
        "org.checkerframework:checker-qual:3.19.0",
        "org.ow2.asm:asm-analysis:9.2",
        "org.ow2.asm:asm-commons:9.2",
        "org.ow2.asm:asm-tree:9.2",
        "org.ow2.asm:asm-util:9.2",
        "org.ow2.asm:asm:9.2",
        "org.pcollections:pcollections:3.1.4",
        "org.threeten:threeten-extra:1.5.0",
        "org.tukaani:xz:1.9",
        "tools.profiler:async-profiler:2.9",
    ],
    fail_if_repin_required = True,
    maven_install_json = "//:maven_install.json",
    repositories = [
        "https://repo1.maven.org/maven2",
    ],
    strict_visibility = True,
)

load("@maven//:defs.bzl", "pinned_maven_install")

pinned_maven_install()

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
