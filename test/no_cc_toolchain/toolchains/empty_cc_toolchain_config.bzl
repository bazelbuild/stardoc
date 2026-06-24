"""An empty cc_toolchain_config rule.

Replicates what Bazel generates for local_config_cc when
BAZEL_DO_NOT_DETECT_CPP_TOOLCHAIN=1 is set (Bazel 7 shipped it as
@bazel_tools//tools/cpp:empty_cc_toolchain_config.bzl; Bazel 8 no longer
exposes it, so the example carries its own copy). It provides a
CcToolchainConfigInfo with no tools behind it: enough for CC toolchain
*resolution* to succeed, while anything that actually tries to compile or
link C++ fails loudly.
"""

load("@rules_cc//cc/common:cc_common.bzl", "cc_common")
load("@rules_cc//cc/toolchains:cc_toolchain_config_info.bzl", "CcToolchainConfigInfo")

def _impl(ctx):
    # target_system_name/target_cpu/target_libc are required on Bazel 7
    # (optional from Bazel 8 on).
    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        toolchain_identifier = "empty",
        target_system_name = "empty",
        target_cpu = "empty",
        target_libc = "empty",
        compiler = "empty",
    )

cc_toolchain_config = rule(
    implementation = _impl,
    attrs = {},
    provides = [CcToolchainConfigInfo],
)
