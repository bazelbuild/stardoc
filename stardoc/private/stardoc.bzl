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

def _renderer_action_run(ctx, out_file, proto_file):
    """Helper for declaring the markdown renderer action"""
    renderer_args = ctx.actions.args()
    renderer_args.add("--input=" + str(proto_file.path))
    renderer_args.add("--output=" + str(ctx.outputs.out.path))
    renderer_args.add("--aspect_template=" + str(ctx.file.aspect_template.path))
    renderer_args.add("--header_template=" + str(ctx.file.header_template.path))
    renderer_args.add("--table_of_contents_template=" + str(ctx.file.table_of_contents_template.path))
    renderer_args.add("--func_template=" + str(ctx.file.func_template.path))
    renderer_args.add("--provider_template=" + str(ctx.file.provider_template.path))
    renderer_args.add("--rule_template=" + str(ctx.file.rule_template.path))
    renderer_args.add("--repository_rule_template=" + str(ctx.file.repository_rule_template.path))
    renderer_args.add("--module_extension_template=" + str(ctx.file.module_extension_template.path))
    renderer = ctx.executable.renderer
    ctx.actions.run(
        outputs = [out_file],
        inputs = [
            proto_file,
            ctx.file.aspect_template,
            ctx.file.header_template,
            ctx.file.table_of_contents_template,
            ctx.file.func_template,
            ctx.file.provider_template,
            ctx.file.rule_template,
            ctx.file.repository_rule_template,
            ctx.file.module_extension_template,
        ],
        executable = renderer,
        arguments = [renderer_args],
        mnemonic = "Renderer",
        progress_message = ("Converting proto format of %s to markdown format" %
                            (ctx.label.name)),
    )

def _stardoc_impl(ctx):
    """Implementation of the stardoc rule."""
    for semantic_flag in ctx.attr.semantic_flags:
        if not semantic_flag.startswith("--"):
            fail("semantic_flags entry '%s' must start with '--'" % semantic_flag)
    out_file = ctx.outputs.out
    stardoc_args = ctx.actions.args()
    stardoc_args.add("--input=" + str(ctx.file.input.owner))
    stardoc_args.add("--workspace_name=" + ctx.workspace_name)
    stardoc_args.add_all(
        ctx.attr.symbol_names,
        format_each = "--symbols=%s",
        omit_if_empty = True,
    )
    stardoc_args.add_all(ctx.attr.semantic_flags)
    stardoc = ctx.executable.stardoc

    if ctx.attr.format == "proto":
        stardoc_args.add("--output=" + out_file.path)
        ctx.actions.run(
            outputs = [out_file],
            executable = stardoc,
            arguments = [stardoc_args],
            mnemonic = "Stardoc",
            progress_message = ("Generating proto for Starlark doc for %s" %
                                (ctx.label.name)),
        )
    elif ctx.attr.format == "markdown":
        proto_file = ctx.actions.declare_file(ctx.label.name + ".raw", sibling = out_file)
        stardoc_args.add("--output=" + proto_file.path)
        ctx.actions.run(
            outputs = [proto_file],
            executable = stardoc,
            arguments = [stardoc_args],
            mnemonic = "Stardoc",
            progress_message = ("Generating proto for Starlark doc for %s" %
                                (ctx.label.name)),
        )
        _renderer_action_run(ctx, out_file = out_file, proto_file = proto_file)

    # Work around default outputs not getting captured by sh_binary:
    # https://github.com/bazelbuild/bazel/issues/15043.
    # See discussion in https://github.com/bazelbuild/stardoc/pull/139.
    outputs = [out_file]
    return [DefaultInfo(files = depset(outputs), runfiles = ctx.runfiles(files = outputs))]

_common_renderer_attrs = {
    "out": attr.output(
        doc = "The (markdown) file to which documentation will be output.",
        mandatory = True,
    ),
    "renderer": attr.label(
        doc = "The location of the renderer tool.",
        allow_files = True,
        cfg = "exec",
        executable = True,
        mandatory = True,
    ),
    "aspect_template": attr.label(
        doc = "The input file template for generating documentation of aspects.",
        allow_single_file = [".vm"],
        mandatory = True,
    ),
    "header_template": attr.label(
        doc = "The input file template for the header of the output documentation.",
        allow_single_file = [".vm"],
        mandatory = True,
    ),
    "table_of_contents_template": attr.label(
        doc = "The input file template for the table of contents of the output documentation.",
        allow_single_file = [".vm"],
        mandatory = True,
    ),
    "func_template": attr.label(
        doc = "The input file template for generating documentation of functions.",
        allow_single_file = [".vm"],
        mandatory = True,
    ),
    "provider_template": attr.label(
        doc = "The input file template for generating documentation of providers.",
        allow_single_file = [".vm"],
        mandatory = True,
    ),
    "rule_template": attr.label(
        doc = "The input file template for generating documentation of rules.",
        allow_single_file = [".vm"],
        mandatory = True,
    ),
    "repository_rule_template": attr.label(
        doc = "The input file template for generating documentation of repository rules." +
              " This template is not used when rendering the output of the legacy extractor.",
        allow_single_file = [".vm"],
        mandatory = True,
    ),
    "module_extension_template": attr.label(
        doc = "The input file template for generating documentation of module extensions." +
              " This template is not used when rendering the output of the legacy extractor.",
        allow_single_file = [".vm"],
        mandatory = True,
    ),
}

# TODO(arostovtsev): replace with ... attrs = { ... } | _common_renderer_attrs
# in rule definition below after we drop support for Bazel 5.
_stardoc_attrs = {
    "input": attr.label(
        doc = "The starlark file to generate documentation for.",
        allow_single_file = [".bzl"],
        mandatory = True,
    ),
    "format": attr.string(
        doc = "The format of the output file. Valid values: 'markdown' or 'proto'.",
        values = ["markdown", "proto"],
        mandatory = True,
    ),
    "symbol_names": attr.string_list(
        doc = """
A list of symbol names to generate documentation for. These should correspond to
the names of rule definitions in the input file. If this list is empty, then
documentation for all exported rule definitions will be generated.
""",
        mandatory = True,
    ),
    "semantic_flags": attr.string_list(
        doc = """
A list of canonical flags to affect Starlark semantics for the Starlark interpretter
during documentation generation. This should only be used to maintain compatibility with
non-default semantic flags required to use the given Starlark symbols.

For example, if `//foo:bar.bzl` does not build except when a user would specify
`--incompatible_foo_semantic=false`, then this attribute should contain
"--incompatible_foo_semantic=false".
""",
        mandatory = True,
    ),
    "stardoc": attr.label(
        doc = "The location of the stardoc tool.",
        allow_files = True,
        cfg = "exec",
        executable = True,
        mandatory = True,
    ),
}
_stardoc_attrs.update(_common_renderer_attrs.items())

stardoc = rule(
    _stardoc_impl,
    doc = """
Generates documentation for starlark skylark rule definitions in a target starlark file.
""",
    attrs = _stardoc_attrs,
)

def _stardoc_markdown_renderer_impl(ctx):
    out_file = ctx.outputs.out
    _renderer_action_run(ctx, out_file = out_file, proto_file = ctx.file.src)

    # Work around default outputs not getting captured by sh_binary:
    # https://github.com/bazelbuild/bazel/issues/15043.
    # See discussion in https://github.com/bazelbuild/stardoc/pull/139.
    outputs = [out_file]
    return [DefaultInfo(files = depset(outputs), runfiles = ctx.runfiles(files = outputs))]

# TODO(arostovtsev): replace with ... attrs = { ... } | _common_renderer_attrs
# in rule definition below after we drop support for Bazel 5.
_stardoc_markdown_renderer_attrs = {
    "src": attr.label(
        doc = "The .binaryproto file from which to generate documentation.",
        allow_single_file = [".binaryproto"],
        mandatory = True,
    ),
}
_stardoc_markdown_renderer_attrs.update(_common_renderer_attrs.items())

stardoc_markdown_renderer = rule(
    _stardoc_markdown_renderer_impl,
    doc = """
Generates markdown documentation for starlark rule definitions from the corresponding binary proto.
""",
    attrs = _stardoc_markdown_renderer_attrs,
)
