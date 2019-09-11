<!-- Generated with Stardoc: http://skydoc.bazel.build -->

<a name="#stardoc"></a>

## stardoc

<pre>
stardoc(<a href="#stardoc-name">name</a>, <a href="#stardoc-aspect_template">aspect_template</a>, <a href="#stardoc-deps">deps</a>, <a href="#stardoc-format">format</a>, <a href="#stardoc-func_template">func_template</a>, <a href="#stardoc-header_template">header_template</a>, <a href="#stardoc-input">input</a>, <a href="#stardoc-out">out</a>, <a href="#stardoc-provider_template">provider_template</a>, <a href="#stardoc-renderer">renderer</a>, <a href="#stardoc-rule_template">rule_template</a>, <a href="#stardoc-semantic_flags">semantic_flags</a>, <a href="#stardoc-stardoc">stardoc</a>, <a href="#stardoc-symbol_names">symbol_names</a>)
</pre>


Generates documentation for exported skylark rule definitions in a target starlark file.

This rule is an experimental replacement for the existing skylark_doc rule.


**ATTRIBUTES**


| Name  | Description | Type | Mandatory |
| :-------------: | :-------------: | :-------------: | :-------------: |
| name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |
| aspect_template |  The input file template for generating documentation of aspects.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional |
| deps |  A list of skylark_library dependencies which the input depends on.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional |
| format |  The format of the output file.   | String | optional |
| func_template |  The input file template for generating documentation of functions.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional |
| header_template |  The input file template for the header of the output documentation.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional |
| input |  The starlark file to generate documentation for.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional |
| out |  The (markdown) file to which documentation will be output.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | required |
| provider_template |  The input file template for generating documentation of providers.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional |
| renderer |  The location of the renderer tool.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional |
| rule_template |  The input file template for generating documentation of rules.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional |
| semantic_flags |  A list of canonical flags to affect Starlark semantics for the Starlark interpretter<br>during documentation generation. This should only be used to maintain compatibility with<br>non-default semantic flags required to use the given Starlark symbols.<br>&lt;br&gt;&lt;br&gt;For example, if &lt;code&gt;//foo:bar.bzl&lt;/code&gt; does not build except when a user would specify<br>&lt;code&gt;--incompatible_foo_semantic=false&lt;/code&gt;, then this attribute should contain<br>"--incompatible_foo_semantic=false".   | List of strings | optional |
| stardoc |  The location of the stardoc tool.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional |
| symbol_names |  A list of symbol names to generate documentation for. These should correspond to<br>the names of rule definitions in the input file. If this list is empty, then<br>documentation for all exported rule definitions will be generated.   | List of strings | optional |


<a name="#_stardoc_impl"></a>

## _stardoc_impl

<pre>
_stardoc_impl(<a href="#_stardoc_impl-ctx">ctx</a>)
</pre>

Implementation of the stardoc rule.

**PARAMETERS**


| Name  | Description | Default Value |
| :-------------: | :-------------: | :-------------: |
| ctx |  <p align="center"> - </p>   |  none |


