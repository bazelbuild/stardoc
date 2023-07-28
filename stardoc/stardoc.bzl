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

load("@rules_java//java:defs.bzl", "java_binary")
load("@bazel_skylib//rules:copy_file.bzl", "copy_file")
load("//stardoc/private:stardoc.bzl", "stardoc_markdown_renderer", _stardoc = "stardoc")

def stardoc(
        *,
        name,
        input,
        out,
        deps = [],
        format = "markdown",
        symbol_names = [],
        semantic_flags = [],
        stardoc = Label("//stardoc:prebuilt_stardoc_binary"),
        renderer = Label("//stardoc:renderer"),
        aspect_template = Label("//stardoc:templates/markdown_tables/aspect.vm"),
        func_template = Label("//stardoc:templates/markdown_tables/func.vm"),
        header_template = Label("//stardoc:templates/markdown_tables/header.vm"),
        provider_template = Label("//stardoc:templates/markdown_tables/provider.vm"),
        rule_template = Label("//stardoc:templates/markdown_tables/rule.vm"),
        repository_rule_template = Label("//stardoc:templates/markdown_tables/repository_rule.vm"),
        module_extension_template = Label("//stardoc:templates/markdown_tables/module_extension.vm"),
        use_starlark_doc_extract = True,
        render_main_repo_name = True,
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
      semantic_flags: A list of canonical flags to affect Starlark semantics for the Starlark interpreter during
        documentation generation. This should only be used to maintain compatibility with non-default semantic flags
        required to use the given Starlark symbols.

        For example, if `//foo:bar.bzl` does not build except when a user would specify
        `--incompatible_foo_semantic=false`, then this attribute should contain
        "--incompatible_foo_semantic=false".
      stardoc: The location of the legacy Stardoc extractor. Ignored when using the native `starlark_doc_extract` rule.
      renderer: The location of the renderer tool.
      aspect_template: The input file template for generating documentation of aspects
      header_template: The input file template for the header of the output documentation.
      func_template: The input file template for generating documentation of functions.
      provider_template: The input file template for generating documentation of providers.
      rule_template: The input file template for generating documentation of rules.
      repository_rule_template: The input file template for generating documentation of repository rules.
        This template is used only when using the native `starlark_doc_extract` rule.
      module_extension_template: The input file template for generating documentation of module extensions.
        This template is used only when using the native `starlark_doc_extract` rule.
      render_main_repo_name: Render labels in the main repository with a repo component (either
        the module name or workspace name). This parameter is used only when using the native
        `starlark_doc_extract` rule.
      use_starlark_doc_extract: Use the native `starlark_doc_extract` rule if available.
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

    if use_starlark_doc_extract and hasattr(native, "starlark_doc_extract"):
        # Use native.starlark_doc_extract as extractor
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
                provider_template = provider_template,
                rule_template = rule_template,
                repository_rule_template = repository_rule_template,
                module_extension_template = module_extension_template,
                **kwargs
            )
        elif format == "proto" and not extractor_is_main_target:
            copy_file(
                name = name,
                src = proto_name,
                out = out,
                **kwargs
            )

    else:
        # Use legacy extractor
        stardoc_with_runfiles_name = name + "_stardoc"

        java_binary(
            name = stardoc_with_runfiles_name,
            main_class = "com.google.devtools.build.skydoc.SkydocMain",
            runtime_deps = [stardoc],
            data = [input] + deps,
            **auxiliary_target_kwargs
        )

        _stardoc(
            name = name,
            input = input,
            out = out,
            format = format,
            symbol_names = symbol_names,
            semantic_flags = semantic_flags,
            stardoc = stardoc_with_runfiles_name,
            renderer = renderer,
            aspect_template = aspect_template,
            func_template = func_template,
            header_template = header_template,
            provider_template = provider_template,
            rule_template = rule_template,
            repository_rule_template = repository_rule_template,
            module_extension_template = module_extension_template,
            **kwargs
        )
