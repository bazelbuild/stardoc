<!-- Generated with Stardoc: http://skydoc.bazel.build -->

<a name="#stardoc"></a>

## stardoc

<pre>
stardoc(<a href="#stardoc-name">name</a>, <a href="#stardoc-aspect_template">aspect_template</a>, <a href="#stardoc-deps">deps</a>, <a href="#stardoc-format">format</a>, <a href="#stardoc-func_template">func_template</a>, <a href="#stardoc-header_template">header_template</a>, <a href="#stardoc-input">input</a>, <a href="#stardoc-out">out</a>,
        <a href="#stardoc-provider_template">provider_template</a>, <a href="#stardoc-renderer">renderer</a>, <a href="#stardoc-rule_template">rule_template</a>, <a href="#stardoc-semantic_flags">semantic_flags</a>, <a href="#stardoc-stardoc">stardoc</a>, <a href="#stardoc-symbol_names">symbol_names</a>)
</pre>


Generates documentation for exported skylark rule definitions in a target starlark file.

This rule is an experimental replacement for the existing skylark_doc rule.


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :-------------: | :-------------: | :-------------: | :-------------: | :-------------: |
| name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| aspect_template |  The input file template for generating documentation of aspects.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | //stardoc:templates/markdown_tables/aspect.vm |
| deps |  A list of skylark_library dependencies which the input depends on.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| format |  The format of the output file. Valid values: 'markdown' or 'proto'.   | String | optional | "markdown" |
| func_template |  The input file template for generating documentation of functions.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | //stardoc:templates/markdown_tables/func.vm |
| header_template |  The input file template for the header of the output documentation.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | //stardoc:templates/markdown_tables/header.vm |
| input |  The starlark file to generate documentation for.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| out |  The (markdown) file to which documentation will be output.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | required |  |
| provider_template |  The input file template for generating documentation of providers.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | //stardoc:templates/markdown_tables/provider.vm |
| renderer |  The location of the renderer tool.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | //stardoc:renderer |
| rule_template |  The input file template for generating documentation of rules.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | //stardoc:templates/markdown_tables/rule.vm |
| semantic_flags |  A list of canonical flags to affect Starlark semantics for the Starlark interpretter during documentation generation. This should only be used to maintain compatibility with non-default semantic flags required to use the given Starlark symbols.<br><br>For example, if <code>//foo:bar.bzl</code> does not build except when a user would specify <code>--incompatible_foo_semantic=false</code>, then this attribute should contain "--incompatible_foo_semantic=false".   | List of strings | optional | [] |
| stardoc |  The location of the stardoc tool.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | //stardoc:stardoc |
| symbol_names |  A list of symbol names to generate documentation for. These should correspond to the names of rule definitions in the input file. If this list is empty, then documentation for all exported rule definitions will be generated.   | List of strings | optional | [] |


