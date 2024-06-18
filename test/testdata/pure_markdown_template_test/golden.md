<!-- Generated with Stardoc: http://skydoc.bazel.build -->

Input file for markdown template test

<a id="example_rule"></a>

## example_rule

<pre>
load("@stardoc//test:testdata/pure_markdown_template_test/input.bzl", "example_rule")

example_rule(<a href="#example_rule-name">name</a>, <a href="#example_rule-first">first</a>, <a href="#example_rule-second">second</a>)
</pre>

Small example of rule using a markdown template.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="example_rule-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="example_rule-first"></a>first |  This is the first attribute   | String | optional |  `""`  |
| <a id="example_rule-second"></a>second |  -   | Integer | optional |  `2`  |


<a id="ExampleProviderInfo"></a>

## ExampleProviderInfo

<pre>
load("@stardoc//test:testdata/pure_markdown_template_test/input.bzl", "ExampleProviderInfo")

ExampleProviderInfo(<a href="#ExampleProviderInfo-foo">foo</a>, <a href="#ExampleProviderInfo-bar">bar</a>, <a href="#ExampleProviderInfo-baz">baz</a>)
</pre>

Small example of provider using a markdown template.

**FIELDS**

| Name  | Description |
| :------------- | :------------- |
| <a id="ExampleProviderInfo-foo"></a>foo |  A string representing foo    |
| <a id="ExampleProviderInfo-bar"></a>bar |  A string representing bar    |
| <a id="ExampleProviderInfo-baz"></a>baz |  A string representing baz    |


<a id="example_function"></a>

## example_function

<pre>
load("@stardoc//test:testdata/pure_markdown_template_test/input.bzl", "example_function")

example_function(<a href="#example_function-foo">foo</a>, <a href="#example_function-bar">bar</a>)
</pre>

Small example of function using a markdown template.

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="example_function-foo"></a>foo |  This parameter does foo related things.   |  none |
| <a id="example_function-bar"></a>bar |  This parameter does bar related things.<br><br>For example, it does things that require **multiple paragraphs** to explain.<br><br>Note: we should preserve the nested indent in the following code:<br><br><pre><code class="language-json">{&#10;    "key": "value"&#10;}</code></pre>   |  `"bar"` |


<a id="example_aspect"></a>

## example_aspect

<pre>
load("@stardoc//test:testdata/pure_markdown_template_test/input.bzl", "example_aspect")

example_aspect(<a href="#example_aspect-name">name</a>, <a href="#example_aspect-first">first</a>, <a href="#example_aspect-second">second</a>)
</pre>

Small example of aspect using a markdown template.

**ASPECT ATTRIBUTES**


| Name | Type |
| :------------- | :------------- |
| deps| String |
| attr_aspect| String |


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="example_aspect-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="example_aspect-first"></a>first |  -   | String | required |  |
| <a id="example_aspect-second"></a>second |  This is the second attribute.   | String | optional |  `""`  |


