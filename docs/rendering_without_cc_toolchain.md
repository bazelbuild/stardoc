<nav class="toc">
  <h2>Contents</h2>
  <ul>
    <li><a href="#why">Why Stardoc normally drags in a C++ toolchain</a></li>
    <li><a href="#setup">The setup</a></li>
    <li><a href="#verifying">Verifying that no C++ is compiled</a></li>
    <li><a href="#caveats">Caveats</a></li>
  </ul>
</nav>

# Rendering documentation without a C++ toolchain

Building documentation with Stardoc normally requires a C/C++ compiler on the
host machine, even though the documentation is not C++ code. This slows down
doc builds (compiling protobuf takes minutes on a cache miss) and breaks them
entirely on machines without a compiler, a common pain point on Windows CI (see
[#305]).

This doc explains *why* the C++ toolchain gets pulled in and how to set up a
module that renders and diff-tests docs with **no CC toolchain at all**. A
complete, tested setup lives in [`test/no_cc_toolchain`].

The configuration lives entirely in the module *running* the doc build
(typically a dedicated `docs/` sub-module); Stardoc itself cannot ship it,
because it must not force a particular protoc on everyone that depends on it.

<a name="why"></a>
## Why Stardoc normally drags in a C++ toolchain

Stardoc has two halves:

1. **Extraction**: the native [`starlark_doc_extract`] rule, built into Bazel.
   No protoc involved.
2. **Rendering**: a Java binary. Building it from source pulls in
   `java_proto_library → proto_library → protoc`, and `protoc` is normally
   **compiled from C++ source**, which is what forces a CC toolchain.

Two things have to be addressed:

1. **`protoc` is built from C++ source.** Proto actions invoke protobuf's
   `//:protoc`, a `cc_binary`. [**protobuf >= 33.4**][protobuf-33.4] ships a
   *precompiled* `protoc` and the proto-toolchain wiring to use it instead of
   building it ([protocolbuffers/protobuf#24888][protobuf-prebuilt-pr]). Two
   flags select that path:
   - `--@protobuf//bazel/toolchains:prefer_prebuilt_protoc` picks protobuf's
     bundled prebuilt `protoc`.
   - `--incompatible_enable_proto_toolchain_resolution` routes proto codegen
     through toolchain resolution to reach it. It exists from Bazel 7 on and
     is the default from Bazel 9, so set it explicitly on Bazel 7 and 8.

   **33.4 is a hard floor.** On protobuf 33.0–33.2 the renderer's proto
   compile still builds `protoc` (and its `upb` C sources) from source, which
   fails under a compiler-less toolchain (verified). Both the renderer's own
   protos and protobuf's bundled well-known-types route through the prebuilt
   `protoc` only at 33.4+. Before 33.4 the way to supply a prebuilt `protoc`
   was Aspect's [`toolchains_protoc`], but in this from-source-renderer setup
   it does not avoid the source build either; the bundled prebuilt `protoc`
   and the `prefer_prebuilt_protoc` flag arrived together in 33.4, which is
   exactly why `toolchains_protoc` (now archived) is unnecessary here.
2. **`java_binary` needs CC toolchain *resolution* to succeed.** Even with
   nothing C++ left to compile, `java_binary` pulls in the C++ toolchain type
   (`@bazel_tools//tools/cpp:toolchain_type`) for its *optional* native
   launcher: rules_java adds
   [`use_cc_toolchain(mandatory = False)`][rules-java-cc] to the rule's
   `toolchains`, so toolchain *resolution* must still succeed even though
   nothing links the launcher. With `BAZEL_DO_NOT_DETECT_CPP_TOOLCHAIN=1`
   Bazel registers no CC toolchain at all, so the module registers an **empty**
   CC toolchain: a stub with no compiler behind it that satisfies analysis;
   anything that actually tries to compile or link C++ fails loudly.

<a name="setup"></a>
## The setup

In the `MODULE.bazel` that runs the doc build (full version:
[`test/no_cc_toolchain/MODULE.bazel`]):

```starlark
# protobuf >= 33.4 ships a prebuilt protoc; the .bazelrc flags select it.
bazel_dep(name = "protobuf", version = "33.4")

# Empty CC toolchain for java_binary's optional native launcher.
register_toolchains("//toolchains:empty_cc")
```

In its `.bazelrc` (full version: [`test/no_cc_toolchain/.bazelrc`]):

```
# Use protobuf's bundled prebuilt protoc instead of compiling protoc.
# --incompatible_enable_proto_toolchain_resolution is required through Bazel 8
# and is the default from Bazel 9.
common --@protobuf//bazel/toolchains:prefer_prebuilt_protoc
common --incompatible_enable_proto_toolchain_resolution

# Poison pill: fail loudly if anything ever tries to compile protobuf's C++.
common --per_file_copt=external/.*protobuf.*@--PROTOBUF_WAS_NOT_SUPPOSED_TO_BE_BUILT
common --host_per_file_copt=external/.*protobuf.*@--PROTOBUF_WAS_NOT_SUPPOSED_TO_BE_BUILT

# Don't even autodetect a local C++ toolchain.
common --repo_env=BAZEL_DO_NOT_DETECT_CPP_TOOLCHAIN=1
```

And the empty CC toolchain in `toolchains/BUILD.bazel` (full version:
[`test/no_cc_toolchain/toolchains/BUILD.bazel`]), which mirrors what Bazel
generates for `local_config_cc` when `BAZEL_DO_NOT_DETECT_CPP_TOOLCHAIN=1` is
set (`tools/cpp/BUILD.empty.tpl`), plus the `toolchain()` registration needed
for platform-based resolution.

With that in place, `stardoc()` targets (and wrappers like
`aspect_bazel_lib`'s `stardoc_with_diff_test`) build and run as usual.

<a name="verifying"></a>
## Verifying that no C++ is compiled

```sh
# proto codegen runs protobuf's bundled prebuilt protoc, not a compiled one:
bazel aquery 'mnemonic("GenProtoDescriptorSet", deps(//:stardoc_doc))' \
  | grep -m1 'bin/protoc'
#   -> .../protobuf~~protoc~prebuilt_protoc.<os_arch>/bin/protoc
```

The `--per_file_copt` poison pill and `BAZEL_DO_NOT_DETECT_CPP_TOOLCHAIN=1`
guarantee it stays that way: a regression fails the build instead of silently
reaching for a compiler.

<a name="caveats"></a>
## Caveats

- The renderer's **Java** is still compiled (hermetically, via a remote JDK,
  no CC toolchain). Only the C++/protoc compilation is eliminated. Zero
  compilation (not even the renderer's Java) would require a prebuilt renderer
  jar, which Stardoc does not currently publish. [alexeagle/stardoc-prebuilt]
  used to provide exactly that, but the repo is now archived; the setup
  described here keeps mainstream, from-source Stardoc instead, so there is
  nothing to vendor or re-host.
- **protobuf >= 33.4 is required** (see above). The Bazel and protoc versions
  can be old: the example pins Bazel 7.1.0 and uses whatever prebuilt `protoc`
  protobuf 33.4 bundles, with no separate protoc download to manage.

[#305]: https://github.com/bazelbuild/stardoc/issues/305
[`starlark_doc_extract`]: https://bazel.build/reference/be/general#starlark_doc_extract
[protobuf-33.4]: https://github.com/protocolbuffers/protobuf/releases/tag/v33.4
[protobuf-prebuilt-pr]: https://github.com/protocolbuffers/protobuf/pull/24888
[rules-java-cc]: https://github.com/bazelbuild/rules_java/blob/02f488de/java/bazel/rules/bazel_java_binary.bzl#L320
[`test/no_cc_toolchain`]: ../test/no_cc_toolchain
[`test/no_cc_toolchain/.bazelrc`]: ../test/no_cc_toolchain/.bazelrc
[`test/no_cc_toolchain/MODULE.bazel`]: ../test/no_cc_toolchain/MODULE.bazel
[`test/no_cc_toolchain/toolchains/BUILD.bazel`]: ../test/no_cc_toolchain/toolchains/BUILD.bazel
[`toolchains_protoc`]: https://github.com/aspect-build/toolchains_protoc
[alexeagle/stardoc-prebuilt]: https://github.com/alexeagle/stardoc-prebuilt
