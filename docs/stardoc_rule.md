<!-- Generated with Stardoc: http://skydoc.bazel.build -->

Starlark rule for stardoc: a documentation generator tool written in Java.

<a id="stardoc"></a>

## stardoc

<pre>
stardoc(<a href="#stardoc-name">name</a>, <a href="#stardoc-input">input</a>, <a href="#stardoc-out">out</a>, <a href="#stardoc-deps">deps</a>, <a href="#stardoc-format">format</a>, <a href="#stardoc-symbol_names">symbol_names</a>, <a href="#stardoc-semantic_flags">semantic_flags</a>, <a href="#stardoc-stardoc">stardoc</a>, <a href="#stardoc-renderer">renderer</a>,
        <a href="#stardoc-aspect_template">aspect_template</a>, <a href="#stardoc-func_template">func_template</a>, <a href="#stardoc-header_template">header_template</a>, <a href="#stardoc-provider_template">provider_template</a>, <a href="#stardoc-rule_template">rule_template</a>, <a href="#stardoc-kwargs">kwargs</a>)
</pre>

Generates documentation for exported skylark rule definitions in a target starlark file.

This rule is an experimental replacement for the existing skylark_doc rule.


**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="stardoc-name"></a>name |  <p align="center"> - </p>   |  none |
| <a id="stardoc-input"></a>input |  The starlark file to generate documentation for (mandatory).   |  none |
| <a id="stardoc-out"></a>out |  The file to which documentation will be output (mandatory).   |  none |
| <a id="stardoc-deps"></a>deps |  A list of bzl_library dependencies which the input depends on.   |  <code>[]</code> |
| <a id="stardoc-format"></a>format |  The format of the output file. Valid values: 'markdown' or 'proto'.   |  <code>"markdown"</code> |
| <a id="stardoc-symbol_names"></a>symbol_names |  A list of symbol names to generate documentation for. These should correspond to the names of rule definitions in the input file. If this list is empty, then documentation for all exported rule definitions will be generated.   |  <code>[]</code> |
| <a id="stardoc-semantic_flags"></a>semantic_flags |  A list of canonical flags to affect Starlark semantics for the Starlark interpreter during documentation generation. This should only be used to maintain compatibility with non-default semantic flags required to use the given Starlark symbols.<br><br>For example, if <code>//foo:bar.bzl</code> does not build except when a user would specify <code>--incompatible_foo_semantic=false</code>, then this attribute should contain "--incompatible_foo_semantic=false".   |  <code>[]</code> |
| <a id="stardoc-stardoc"></a>stardoc |  The location of the stardoc tool.   |  <code>Label("//stardoc:prebuilt_stardoc_binary")</code> |
| <a id="stardoc-renderer"></a>renderer |  The location of the renderer tool.   |  <code>Label("//stardoc:renderer")</code> |
| <a id="stardoc-aspect_template"></a>aspect_template |  The input file template for generating documentation of aspects   |  <code>Label("//stardoc:templates/markdown_tables/aspect.vm")</code> |
| <a id="stardoc-func_template"></a>func_template |  The input file template for generating documentation of functions.   |  <code>Label("//stardoc:templates/markdown_tables/func.vm")</code> |
| <a id="stardoc-header_template"></a>header_template |  The input file template for the header of the output documentation.   |  <code>Label("//stardoc:templates/markdown_tables/header.vm")</code> |
| <a id="stardoc-provider_template"></a>provider_template |  The input file template for generating documentation of providers.   |  <code>Label("//stardoc:templates/markdown_tables/provider.vm")</code> |
| <a id="stardoc-rule_template"></a>rule_template |  The input file template for generating documentation of rules.   |  <code>Label("//stardoc:templates/markdown_tables/rule.vm")</code> |
| <a id="stardoc-kwargs"></a>kwargs |  <p align="center"> - </p>   |  none |


