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

load("@bazel_skylib//:skylark_library.bzl", "SkylarkLibraryInfo")

def _stardoc_impl(ctx):
    """Implementation of the stardoc rule."""
    out_file = ctx.outputs.out
    input_files = depset(direct = [ctx.file.input], transitive = [
        dep[SkylarkLibraryInfo].transitive_srcs
        for dep in ctx.attr.deps
    ])
    args = [
        str(ctx.file.input.owner),
        ctx.outputs.out.path,
    ] + ctx.attr.symbol_names
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
            providers = [SkylarkLibraryInfo],
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
        "stardoc": attr.label(
            doc = "The location of the stardoc tool.",
            allow_files = True,
            default = Label("@io_bazel//src/main/java/com/google/devtools/build/skydoc"),
            cfg = "host",
            executable = True,
        ),
    },
)
