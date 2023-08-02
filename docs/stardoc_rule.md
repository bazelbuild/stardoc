<!-- Generated with Stardoc: http://skydoc.bazel.build -->

Starlark rule for stardoc: a documentation generator tool written in Java.

<a id="stardoc"></a>

## stardoc

<pre>
stardoc(<a href="#stardoc-name">name</a>, <a href="#stardoc-input">input</a>, <a href="#stardoc-out">out</a>, <a href="#stardoc-deps">deps</a>, <a href="#stardoc-format">format</a>, <a href="#stardoc-symbol_names">symbol_names</a>, <a href="#stardoc-semantic_flags">semantic_flags</a>, <a href="#stardoc-stardoc">stardoc</a>, <a href="#stardoc-renderer">renderer</a>,
        <a href="#stardoc-aspect_template">aspect_template</a>, <a href="#stardoc-func_template">func_template</a>, <a href="#stardoc-header_template">header_template</a>, <a href="#stardoc-provider_template">provider_template</a>, <a href="#stardoc-rule_template">rule_template</a>,
        <a href="#stardoc-repository_rule_template">repository_rule_template</a>, <a href="#stardoc-module_extension_template">module_extension_template</a>, <a href="#stardoc-use_starlark_doc_extract">use_starlark_doc_extract</a>,
        <a href="#stardoc-render_main_repo_name">render_main_repo_name</a>, <a href="#stardoc-kwargs">kwargs</a>)
</pre>

Generates documentation for exported starlark rule definitions in a target starlark file.

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="stardoc-name"></a>name |  The name of the stardoc target.   |  none |
| <a id="stardoc-input"></a>input |  The starlark file to generate documentation for (mandatory).   |  none |
| <a id="stardoc-out"></a>out |  The file to which documentation will be output (mandatory).   |  none |
| <a id="stardoc-deps"></a>deps |  A list of bzl_library dependencies which the input depends on.   |  `[]` |
| <a id="stardoc-format"></a>format |  The format of the output file. Valid values: 'markdown' or 'proto'.   |  `"markdown"` |
| <a id="stardoc-symbol_names"></a>symbol_names |  A list of symbol names to generate documentation for. These should correspond to the names of rule definitions in the input file. If this list is empty, then documentation for all exported rule definitions will be generated.   |  `[]` |
| <a id="stardoc-semantic_flags"></a>semantic_flags |  A list of canonical flags to affect Starlark semantics for the Starlark interpreter during documentation generation. This should only be used to maintain compatibility with non-default semantic flags required to use the given Starlark symbols.<br><br>For example, if `//foo:bar.bzl` does not build except when a user would specify `--incompatible_foo_semantic=false`, then this attribute should contain "--incompatible_foo_semantic=false".   |  `[]` |
| <a id="stardoc-stardoc"></a>stardoc |  The location of the legacy Stardoc extractor. Ignored when using the native `starlark_doc_extract` rule.   |  `Label("@io_bazel_stardoc//stardoc:prebuilt_stardoc_binary")` |
| <a id="stardoc-renderer"></a>renderer |  The location of the renderer tool.   |  `Label("@io_bazel_stardoc//stardoc:renderer")` |
| <a id="stardoc-aspect_template"></a>aspect_template |  The input file template for generating documentation of aspects   |  `Label("@io_bazel_stardoc//stardoc:templates/markdown_tables/aspect.vm")` |
| <a id="stardoc-func_template"></a>func_template |  The input file template for generating documentation of functions.   |  `Label("@io_bazel_stardoc//stardoc:templates/markdown_tables/func.vm")` |
| <a id="stardoc-header_template"></a>header_template |  The input file template for the header of the output documentation.   |  `Label("@io_bazel_stardoc//stardoc:templates/markdown_tables/header.vm")` |
| <a id="stardoc-provider_template"></a>provider_template |  The input file template for generating documentation of providers.   |  `Label("@io_bazel_stardoc//stardoc:templates/markdown_tables/provider.vm")` |
| <a id="stardoc-rule_template"></a>rule_template |  The input file template for generating documentation of rules.   |  `Label("@io_bazel_stardoc//stardoc:templates/markdown_tables/rule.vm")` |
| <a id="stardoc-repository_rule_template"></a>repository_rule_template |  The input file template for generating documentation of repository rules. This template is used only when using the native `starlark_doc_extract` rule.   |  `Label("@io_bazel_stardoc//stardoc:templates/markdown_tables/repository_rule.vm")` |
| <a id="stardoc-module_extension_template"></a>module_extension_template |  The input file template for generating documentation of module extensions. This template is used only when using the native `starlark_doc_extract` rule.   |  `Label("@io_bazel_stardoc//stardoc:templates/markdown_tables/module_extension.vm")` |
| <a id="stardoc-use_starlark_doc_extract"></a>use_starlark_doc_extract |  Use the native `starlark_doc_extract` rule if available.   |  `True` |
| <a id="stardoc-render_main_repo_name"></a>render_main_repo_name |  Render labels in the main repository with a repo component (either the module name or workspace name). This parameter is used only when using the native `starlark_doc_extract` rule.   |  `True` |
| <a id="stardoc-kwargs"></a>kwargs |  Further arguments to pass to stardoc.   |  none |


