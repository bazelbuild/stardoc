# Example: [Rendering docs without a C++ toolchain][no-cc-toolchain-doc]

A standalone Bazel module that renders Stardoc's own rule documentation (the
same content as [`docs/stardoc_rule.md`]) with Stardoc's renderer **built from
source** but with **no C++ toolchain** and **no `protoc` compiled from source**:

- [`MODULE.bazel`]: a `protobuf >= 33.4` pin brings a bundled *precompiled*
  `protoc`, so nothing has to build `protoc` (a `cc_binary`) from source.
- [`.bazelrc`]: `--@protobuf//bazel/toolchains:prefer_prebuilt_protoc` (with
  `--incompatible_enable_proto_toolchain_resolution`, the default from Bazel 9)
  routes proto codegen through that prebuilt `protoc`;
  `BAZEL_DO_NOT_DETECT_CPP_TOOLCHAIN=1` disables CC toolchain autodetection
  entirely; a `--per_file_copt` poison pill makes any attempt to compile
  protobuf's C++ fail loudly.
- [`toolchains/BUILD.bazel`]: an *empty* CC toolchain so that `java_binary`'s
  optional native launcher passes toolchain *resolution* with no compiler
  behind it.

## Generate and test the docs

The rendered Markdown is checked in at [`stardoc_rule.md`] and diff tested:

```sh
bazel test //...     # fails if stardoc_rule.md is out of date
bazel run //:update  # re-renders stardoc_rule.md into the source tree
```

The golden is rendered with the Bazel version pinned in [`.bazelversion`]
(7.1.0), to show the setup works on an *older* Bazel; it also builds on Bazel
8.5.1 with the same config (verified), since protobuf bundles a matching
`protoc`, so there is no protoc version to juggle. The one hard requirement is
**protobuf >= 33.4** (earlier versions still compile `protoc` from source; see
the [doc][no-cc-toolchain-doc]). Note that `starlark_doc_extract` output
differs cosmetically across Bazel versions, so the diff test is only expected
to pass with the pinned one.

## Verifying nothing C++/protoc was compiled

```sh
# proto codegen runs protobuf's bundled prebuilt protoc, not a compiled one:
bazel aquery 'mnemonic("GenProtoDescriptorSet", deps(//:stardoc_doc))' \
  | grep -m1 'bin/protoc'
#   -> .../protobuf~~protoc~prebuilt_protoc.<os_arch>/bin/protoc
```

The renderer's **Java** is still compiled (hermetically, via the remote JDK,
no CC). Only the C++/protoc compilation is removed.

A zero-build alternative would be a prebuilt renderer jar, e.g.
[alexeagle/stardoc-prebuilt]. This working example deliberately builds the
renderer from source instead: it stays on mainstream Stardoc and is fully
self-contained, with nothing to vendor, re-host or trust out of band, at the
cost of compiling the renderer's Java once.

[no-cc-toolchain-doc]: ../../docs/rendering_without_cc_toolchain.md
[`docs/stardoc_rule.md`]: ../../docs/stardoc_rule.md
[`MODULE.bazel`]: MODULE.bazel
[`.bazelrc`]: .bazelrc
[`.bazelversion`]: .bazelversion
[`stardoc_rule.md`]: stardoc_rule.md
[`toolchains/BUILD.bazel`]: toolchains/BUILD.bazel
[alexeagle/stardoc-prebuilt]: https://github.com/alexeagle/stardoc-prebuilt
