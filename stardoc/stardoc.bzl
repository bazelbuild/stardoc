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

load("@bazel_skylib//rules:copy_file.bzl", "copy_file")
load("//stardoc/private:stardoc.bzl", "stardoc_markdown_renderer")

def stardoc(
        *,
        name,
        input,
        out,
        deps = [],
        format = "markdown",
        symbol_names = [],
        renderer = Label("//stardoc:renderer"),
        aspect_template = Label("//stardoc:templates/markdown_tables/aspect.vm"),
        func_template = Label("//stardoc:templates/markdown_tables/func.vm"),
        header_template = Label("//stardoc:templates/markdown_tables/header.vm"),
        table_of_contents_template = None,
        provider_template = Label("//stardoc:templates/markdown_tables/provider.vm"),
        rule_template = Label("//stardoc:templates/markdown_tables/rule.vm"),
        repository_rule_template = Label("//stardoc:templates/markdown_tables/repository_rule.vm"),
        module_extension_template = Label("//stardoc:templates/markdown_tables/module_extension.vm"),
        footer_template = None,
        render_main_repo_name = True,
        stamp = -1,
        **kwargs):
    """Generates documentation for exported starlark rule definitions in a target starlark file.

    Args:
      name: The name of the stardoc target.
      input: The starlark file to generate documentation for (mandatory).
      out: The file to which documentation will be output (mandatory).
      deps: A list of bzl_library dependencies which the input depends on.
      format: The format of the output file. Valid values: 'markdown' or 'proto'.
      symbol_names: A list of symbol names to generate documentation for. These should correspond to the names of rule
        definitions in the input file. If this list is empty, then documentation for all exported rule definitions will
        be generated.
      renderer: The location of the renderer tool.
      aspect_template: The input file template for generating documentation of aspects
      header_template: The input file template for the header of the output documentation.
      table_of_contents_template: The input file template for the table of contents of the output documentation.
        This is unset by default for backwards compatibility. Use
        `Label("@stardoc//stardoc:templates/markdown_tables/table_of_contents.vm")` for the default template.
      func_template: The input file template for generating documentation of functions.
      provider_template: The input file template for generating documentation of providers.
      rule_template: The input file template for generating documentation of rules.
      repository_rule_template: The input file template for generating documentation of repository rules.
      module_extension_template: The input file template for generating documentation of module extensions.
      footer_template: The input file template for generating the footer of the output documentation. Optional.
      render_main_repo_name: Render labels in the main repository with a repo component (either
        the module name or workspace name).
      stamp: Whether to provide stamping information to templates, where it can be accessed via
        `$util.formatBuildTimestamp()` and`$stamping`. Example:
        ```vm
        #if ($stamping)
        Built on `$util.formatBuildTimestamp($stamping.volatile.BUILD_TIMESTAMP, "UTC", "yyyy-MM-dd HH:mm")`
        #else
        Build timestamp not available
        #end
        ```
        Possible values:
        <ul>
        <li>`stamp = 1`: Always provide stamping information, even in
            [--nostamp](https://bazel.build/docs/user-manual#flag--stamp) builds.
            This setting should be avoided, since it potentially kills remote caching for the target
            and any downstream actions that depend on it.</li>
        <li>`stamp = 0`: Do not provide stamping information.</li>
        <li>`stamp = -1`: Provide stamping information only if the
             [--stamp](https://bazel.build/docs/user-manual#flag--stamp) flag is set.</li>
        </ul>
        Stamped targets are not rebuilt unless their dependencies change.
      **kwargs: Further arguments to pass to stardoc.
    """

    if format not in ["markdown", "proto"]:
        fail("`format` must be \"markdown\" or \"proto\"")

    auxiliary_target_kwargs = {
        "tags": ["manual"],
        "visibility": ["//visibility:private"],
    }
    if "testonly" in kwargs:
        auxiliary_target_kwargs["testonly"] = kwargs["testonly"]

    if format == "proto" and Label(name + ".binaryproto") == Label(out):
        extractor_is_main_target = True
        extractor_name = name
    else:
        extractor_is_main_target = False
        extractor_name = name + ".extract"

    proto_name = extractor_name + ".binaryproto"

    native.starlark_doc_extract(
        name = extractor_name,
        src = input,
        deps = deps,
        render_main_repo_name = render_main_repo_name,
        symbol_names = symbol_names,
        **(kwargs if extractor_is_main_target else auxiliary_target_kwargs)
    )

    if format == "markdown":
        stardoc_markdown_renderer(
            name = name,
            src = proto_name,
            out = out,
            renderer = renderer,
            aspect_template = aspect_template,
            func_template = func_template,
            header_template = header_template,
            table_of_contents_template = table_of_contents_template,
            provider_template = provider_template,
            rule_template = rule_template,
            repository_rule_template = repository_rule_template,
            module_extension_template = module_extension_template,
            footer_template = footer_template,
            stamp = stamp,
            **kwargs
        )
    elif format == "proto" and not extractor_is_main_target:
        copy_file(
            name = name,
            src = proto_name,
            out = out,
            **kwargs
        )
