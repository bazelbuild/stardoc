<!-- Generated with Stardoc: http://skydoc.bazel.build -->

Starlark rule for stardoc: a documentation generator tool written in Java.

<a id="stardoc"></a>

## stardoc

<pre>
load("@stardoc//stardoc:stardoc.bzl", "stardoc")

stardoc(*, <a href="#stardoc-name">name</a>, <a href="#stardoc-input">input</a>, <a href="#stardoc-out">out</a>, <a href="#stardoc-deps">deps</a>, <a href="#stardoc-format">format</a>, <a href="#stardoc-symbol_names">symbol_names</a>, <a href="#stardoc-renderer">renderer</a>, <a href="#stardoc-aspect_template">aspect_template</a>, <a href="#stardoc-func_template">func_template</a>,
        <a href="#stardoc-macro_template">macro_template</a>, <a href="#stardoc-header_template">header_template</a>, <a href="#stardoc-table_of_contents_template">table_of_contents_template</a>, <a href="#stardoc-provider_template">provider_template</a>, <a href="#stardoc-rule_template">rule_template</a>,
        <a href="#stardoc-repository_rule_template">repository_rule_template</a>, <a href="#stardoc-module_extension_template">module_extension_template</a>, <a href="#stardoc-footer_template">footer_template</a>, <a href="#stardoc-render_main_repo_name">render_main_repo_name</a>,
        <a href="#stardoc-stamp">stamp</a>, <a href="#stardoc-kwargs">**kwargs</a>)
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
| <a id="stardoc-renderer"></a>renderer |  The location of the renderer tool.   |  `Label("@stardoc//stardoc:renderer")` |
| <a id="stardoc-aspect_template"></a>aspect_template |  The input file template for generating documentation of aspects   |  `Label("@stardoc//stardoc:templates/markdown_tables/aspect.vm")` |
| <a id="stardoc-func_template"></a>func_template |  The input file template for generating documentation of functions, including legacy macros.   |  `Label("@stardoc//stardoc:templates/markdown_tables/func.vm")` |
| <a id="stardoc-macro_template"></a>macro_template |  The input file template for generating documentation of symbolic macros.   |  `Label("@stardoc//stardoc:templates/markdown_tables/macro.vm")` |
| <a id="stardoc-header_template"></a>header_template |  The input file template for the header of the output documentation.   |  `Label("@stardoc//stardoc:templates/markdown_tables/header.vm")` |
| <a id="stardoc-table_of_contents_template"></a>table_of_contents_template |  The input file template for the table of contents of the output documentation. This is unset by default for backwards compatibility. Use `Label("@stardoc//stardoc:templates/markdown_tables/table_of_contents.vm")` for the default template.   |  `None` |
| <a id="stardoc-provider_template"></a>provider_template |  The input file template for generating documentation of providers.   |  `Label("@stardoc//stardoc:templates/markdown_tables/provider.vm")` |
| <a id="stardoc-rule_template"></a>rule_template |  The input file template for generating documentation of rules.   |  `Label("@stardoc//stardoc:templates/markdown_tables/rule.vm")` |
| <a id="stardoc-repository_rule_template"></a>repository_rule_template |  The input file template for generating documentation of repository rules.   |  `Label("@stardoc//stardoc:templates/markdown_tables/repository_rule.vm")` |
| <a id="stardoc-module_extension_template"></a>module_extension_template |  The input file template for generating documentation of module extensions.   |  `Label("@stardoc//stardoc:templates/markdown_tables/module_extension.vm")` |
| <a id="stardoc-footer_template"></a>footer_template |  The input file template for generating the footer of the output documentation. Optional.   |  `None` |
| <a id="stardoc-render_main_repo_name"></a>render_main_repo_name |  Render labels in the main repository with a repo component (either the module name or workspace name).   |  `True` |
| <a id="stardoc-stamp"></a>stamp |  Whether to provide stamping information to templates, where it can be accessed via `$util.formatBuildTimestamp()` and`$stamping`. Example: <pre><code class="language-vm">Built on `$util.formatBuildTimestamp($stamping.volatile.BUILD_TIMESTAMP, "UTC", "yyyy-MM-dd HH:mm")`</code></pre> Possible values: <ul> <li>`stamp = 1`: Always provide stamping information, even in     [--nostamp](https://bazel.build/docs/user-manual#stamp) builds.     This setting should be avoided, since it potentially kills remote caching for the target     and any downstream actions that depend on it.</li> <li>`stamp = 0`: Do not provide stamping information.</li> <li>`stamp = -1`: Provide stamping information only if the      [--stamp](https://bazel.build/docs/user-manual#stamp) flag is set.</li> </ul> Stamped targets are not rebuilt unless their dependencies change.   |  `-1` |
| <a id="stardoc-kwargs"></a>kwargs |  Further arguments to pass to stardoc.   |  none |


