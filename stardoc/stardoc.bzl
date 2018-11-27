# Copyright 2018 The Bazel Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""Starlark rule for stardoc: a documentation generator tool written in Java."""

load("@bazel_skylib//:bzl_library.bzl", "StarlarkLibraryInfo")

def _stardoc_impl(ctx):
    """Implementation of the stardoc rule."""
    for semantic_flag in ctx.attr.semantic_flags:
        if not semantic_flag.startswith("--"):
            fail("semantic_flags entry '%s' must start with '--'" % semantic_flag)
    out_file = ctx.outputs.out
    input_files = depset(direct = [ctx.file.input], transitive = [
        dep[StarlarkLibraryInfo].transitive_srcs
        for dep in ctx.attr.deps
    ])
    args = [
        "--input=" + str(ctx.file.input.owner),
        "--output=" + ctx.outputs.out.path,
    ] + [
        ("--symbols=" + symbol)
        for symbol in ctx.attr.symbol_names
    ] + ctx.attr.semantic_flags
    stardoc = ctx.executable.stardoc
    ctx.actions.run(
        outputs = [out_file],
        inputs = input_files,
        executable = stardoc,
        arguments = args,
        mnemonic = "Stardoc",
        progress_message = ("Generating Starlark doc for %s" %
                            (ctx.label.name)),
    )

stardoc = rule(
    _stardoc_impl,
    doc = """
Generates documentation for exported skylark rule definitions in a target starlark file.

This rule is an experimental replacement for the existing skylark_doc rule.
""",
    attrs = {
        "input": attr.label(
            doc = "The starlark file to generate documentation for.",
            allow_single_file = [".bzl"],
        ),
        "deps": attr.label_list(
            doc = "A list of skylark_library dependencies which the input depends on.",
            providers = [StarlarkLibraryInfo],
        ),
        "out": attr.output(
            doc = "The (markdown) file to which documentation will be output.",
            mandatory = True,
        ),
        "symbol_names": attr.string_list(
            doc = """
A list of symbol names to generate documentation for. These should correspond to
the names of rule definitions in the input file. If this list is empty, then
documentation for all exported rule definitions will be generated.
""",
            default = [],
        ),
        "semantic_flags": attr.string_list(
            doc = """
A list of canonical flags to affect Starlark semantics for the Starlark interpretter
during documentation generation. This should only be used to maintain compatibility with
non-default semantic flags required to use the given Starlark symbols.
<br><br>For example, if <code>//foo:bar.bzl</code> does not build except when a user would specify
<code>--incompatible_foo_semantic=false</code>, then this attribute should contain
"--incompatible_foo_semantic=false".
""",
            default = [],
        ),
        "stardoc": attr.label(
            doc = "The location of the stardoc tool.",
            allow_files = True,
            default = Label("@io_bazel//src/main/java/com/google/devtools/build/skydoc"),
            cfg = "host",
            executable = True,
        ),
    },
)
