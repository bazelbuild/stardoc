load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def _include_if_not_defined(repo_rule, name, **kwargs):
    if name not in native.existing_rules():
        repo_rule(name = name, **kwargs)

JINJA2_BUILD_FILE = """
py_library(
    name = "jinja2",
    srcs = glob(["jinja2/*.py"]),
    srcs_version = "PY2AND3",
    deps = [
        "@markupsafe_archive//:markupsafe",
    ],
    visibility = ["//visibility:public"],
)
"""

MARKUPSAFE_BUILD_FILE = """
py_library(
    name = "markupsafe",
    srcs = glob(["markupsafe/*.py"]),
    srcs_version = "PY2AND3",
    visibility = ["//visibility:public"],
)
"""

MISTUNE_BUILD_FILE = """
py_library(
    name = "mistune",
    srcs = ["mistune.py"],
    srcs_version = "PY2AND3",
    visibility = ["//visibility:public"],
)
"""

SIX_BUILD_FILE = """
py_library(
    name = "six",
    srcs = ["six.py"],
    srcs_version = "PY2AND3",
    visibility = ["//visibility:public"],
)
"""

def skydoc_repositories():
    """Adds the external repositories used by the skylark rules."""
    _include_if_not_defined(
        git_repository,
        name = "bazel_skylib",
        remote = "https://github.com/bazelbuild/bazel-skylib.git",
        tag = "0.6.0",
    )
    _include_if_not_defined(
        git_repository,
        name = "io_bazel_rules_sass",
        remote = "https://github.com/bazelbuild/rules_sass.git",
        tag = "1.15.1",
    )
    _include_if_not_defined(
        git_repository,
        name = "io_bazel_rules_sass",
        remote = "https://github.com/bazelbuild/rules_sass.git",
        tag = "1.15.1",
    )
    _include_if_not_defined(
        git_repository,
        name = "io_bazel",
        remote = "https://github.com/bazelbuild/bazel.git",
        # TODO: Update to a newer tagged version when available.
        commit = "e7ebb7e68d35ae090d91fe6b4c92c1c831421faa",  # 2018-11-26
    )
    _include_if_not_defined(
        git_repository,
        name = "com_google_protobuf",
        remote = "https://github.com/protocolbuffers/protobuf.git",
        # Latest tagged version at time of writing is v3.6.1, which doesn't
        # include fixes for --incompatible_package_name_is_a_function,
        # --incompatible_new_actions_api, and possibly others.
        # TODO: Update to a newer tagged version when available.
        commit = "7b28271a61a3da0a37f6fda399b0c4c86464e5b3",  # 2018-11-16
    )
    _include_if_not_defined(
        git_repository,
        name = "io_bazel_rules_sass",
        remote = "https://github.com/bazelbuild/rules_sass.git",
        tag = "1.15.1",
    )

    _include_if_not_defined(
        http_archive,
        name = "markupsafe_archive",
        urls = ["https://pypi.python.org/packages/source/M/MarkupSafe/MarkupSafe-0.23.tar.gz#md5=f5ab3deee4c37cd6a922fb81e730da6e"],
        sha256 = "a4ec1aff59b95a14b45eb2e23761a0179e98319da5a7eb76b56ea8cdc7b871c3",
        build_file_content = MARKUPSAFE_BUILD_FILE,
        strip_prefix = "MarkupSafe-0.23",
    )
    native.bind(
        name = "markupsafe",
        actual = "@markupsafe_archive//:markupsafe",
    )

    _include_if_not_defined(
        http_archive,
        name = "jinja2_archive",
        urls = ["https://pypi.python.org/packages/source/J/Jinja2/Jinja2-2.8.tar.gz#md5=edb51693fe22c53cee5403775c71a99e"],
        sha256 = "bc1ff2ff88dbfacefde4ddde471d1417d3b304e8df103a7a9437d47269201bf4",
        build_file_content = JINJA2_BUILD_FILE,
        strip_prefix = "Jinja2-2.8",
    )
    native.bind(
        name = "jinja2",
        actual = "@jinja2_archive//:jinja2",
    )

    _include_if_not_defined(
        http_archive,
        name = "mistune_archive",
        urls = ["https://pypi.python.org/packages/source/m/mistune/mistune-0.7.1.tar.gz#md5=057bc28bf629d6a1283d680a34ed9d0f"],
        sha256 = "6076dedf768348927d991f4371e5a799c6a0158b16091df08ee85ee231d929a7",
        build_file_content = MISTUNE_BUILD_FILE,
        strip_prefix = "mistune-0.7.1",
    )
    native.bind(
        name = "mistune",
        actual = "@mistune_archive//:mistune",
    )

    _include_if_not_defined(
        http_archive,
        name = "six_archive",
        urls = ["https://pypi.python.org/packages/source/s/six/six-1.10.0.tar.gz#md5=34eed507548117b2ab523ab14b2f8b55"],
        sha256 = "105f8d68616f8248e24bf0e9372ef04d3cc10104f1980f54d57b2ce73a5ad56a",
        build_file_content = SIX_BUILD_FILE,
        strip_prefix = "six-1.10.0",
    )
    native.bind(
        name = "six",
        actual = "@six_archive//:six",
    )
