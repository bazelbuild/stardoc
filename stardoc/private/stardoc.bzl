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

load("//stardoc/private:stamp_detector.bzl", "StampDetectorInfo")

def _is_stamp_enabled(ctx):
    if ctx.attr.stamp == 1:
        return True
    elif ctx.attr.stamp == 0:
        return False
    elif ctx.attr.stamp == -1:
        return ctx.attr._stamp_detector[StampDetectorInfo].enabled
    else:
        fail("`stamp` is expected to be one of [-1, 0, 1]")

def _renderer_action_run(ctx, out_file, proto_file):
    """Helper for declaring the markdown renderer action"""
    stamp_enabled = _is_stamp_enabled(ctx)
    renderer_args = ctx.actions.args()
    renderer_args.add("--input=" + str(proto_file.path))
    renderer_args.add("--output=" + str(ctx.outputs.out.path))
    renderer_args.add("--aspect_template=" + str(ctx.file.aspect_template.path))
    renderer_args.add("--header_template=" + str(ctx.file.header_template.path))
    if ctx.attr.table_of_contents_template:
        renderer_args.add("--table_of_contents_template=" + str(ctx.file.table_of_contents_template.path))
    renderer_args.add("--func_template=" + str(ctx.file.func_template.path))
    renderer_args.add("--macro_template=" + str(ctx.file.macro_template.path))
    renderer_args.add("--provider_template=" + str(ctx.file.provider_template.path))
    renderer_args.add("--rule_template=" + str(ctx.file.rule_template.path))
    renderer_args.add("--repository_rule_template=" + str(ctx.file.repository_rule_template.path))
    renderer_args.add("--module_extension_template=" + str(ctx.file.module_extension_template.path))
    if ctx.file.footer_template:
        renderer_args.add("--footer_template=" + str(ctx.file.footer_template.path))
    if stamp_enabled:
        renderer_args.add("--stamping_stable_status_file=" + str(ctx.info_file.path))
        renderer_args.add("--stamping_volatile_status_file=" + str(ctx.version_file.path))

    inputs = [
        proto_file,
        ctx.file.aspect_template,
        ctx.file.header_template,
        ctx.file.func_template,
        ctx.file.macro_template,
        ctx.file.provider_template,
        ctx.file.rule_template,
        ctx.file.repository_rule_template,
        ctx.file.module_extension_template,
    ]
    if ctx.attr.table_of_contents_template:
        inputs.append(ctx.file.table_of_contents_template)
    if ctx.file.footer_template:
        inputs.append(ctx.file.footer_template)
    if stamp_enabled:
        inputs.append(ctx.info_file)
        inputs.append(ctx.version_file)

    renderer = ctx.executable.renderer
    ctx.actions.run(
        arguments = [renderer_args],
        executable = renderer,
        inputs = inputs,
        mnemonic = "Renderer",
        outputs = [out_file],
        progress_message = ("Converting proto format of %s to markdown format" %
                            (ctx.label.name)),
    )

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
        doc = "The input file template for the table of contents of the output documentation. " +
              "This is unset by default for backwards compatibility. Use " +
              "`Label(\"@stardoc//stardoc:templates/markdown_tables/table_of_contents.vm\")` " +
              "for the default template.",
        allow_single_file = [".vm"],
        mandatory = False,  # Not mandatory for backwards compatibility.
    ),
    "func_template": attr.label(
        doc = "The input file template for generating documentation of functions, including legacy macros.",
        allow_single_file = [".vm"],
        mandatory = True,
    ),
    "macro_template": attr.label(
        doc = "The input file template for generating documentation of symbolic macros.",
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
        doc = "The input file template for generating documentation of repository rules.",
        allow_single_file = [".vm"],
        mandatory = True,
    ),
    "module_extension_template": attr.label(
        doc = "The input file template for generating documentation of module extensions.",
        allow_single_file = [".vm"],
        mandatory = True,
    ),
    "footer_template": attr.label(
        doc = "The input file template for generating the footer of the output documentation. Optional.",
        allow_single_file = [".vm"],
    ),
    "stamp": attr.int(
        doc = """
        Whether to provide stamping information to templates, where it can be accessed via
        `$util.formatBuildTimestamp()` and`$stamping`. Example:
        ```vm
        Built on `$util.formatBuildTimestamp($stamping.volatile.BUILD_TIMESTAMP, "UTC", "yyyy-MM-dd HH:mm")`
        ```

        Possible values:
        * `stamp = 1`: Always provide stamping information, even in
          [--nostamp](https://bazel.build/docs/user-manual#stamp) builds.
          This setting should be avoided, since it potentially kills remote caching for the target
          and any downstream actions that depend on it.
        * `stamp = 0`: Do not provide stamping information.
        * `stamp = -1`: Provide stamping information only if the
           [--stamp](https://bazel.build/docs/user-manual#stamp) flag is set.

        Stamped targets are not rebuilt unless their dependencies change.
        """,
        default = -1,
    ),
    "_stamp_detector": attr.label(
        default = "//stardoc/private:stamp_detector",
        providers = [StampDetectorInfo],
    ),
}

def _stardoc_markdown_renderer_impl(ctx):
    out_file = ctx.outputs.out
    _renderer_action_run(ctx, out_file = out_file, proto_file = ctx.file.src)

    # Work around default outputs not getting captured by sh_binary:
    # https://github.com/bazelbuild/bazel/issues/15043.
    # See discussion in https://github.com/bazelbuild/stardoc/pull/139.
    outputs = [out_file]
    return [DefaultInfo(files = depset(outputs), runfiles = ctx.runfiles(files = outputs))]

_stardoc_markdown_renderer_attrs = {
    "src": attr.label(
        doc = "The .binaryproto file from which to generate documentation.",
        allow_single_file = [".binaryproto"],
        mandatory = True,
    ),
} | _common_renderer_attrs

stardoc_markdown_renderer = rule(
    _stardoc_markdown_renderer_impl,
    doc = """
Generates markdown documentation for starlark rule definitions from the corresponding binary proto.
""",
    attrs = _stardoc_markdown_renderer_attrs,
)
