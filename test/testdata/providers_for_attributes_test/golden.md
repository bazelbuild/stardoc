<!-- Generated with Stardoc: http://skydoc.bazel.build -->

The input file for the providers for attributes test

<a id="my_rule"></a>

## my_rule

<pre>
load("@stardoc//test:testdata/providers_for_attributes_test/input.bzl", "my_rule")

my_rule(<a href="#my_rule-name">name</a>, <a href="#my_rule-first">first</a>, <a href="#my_rule-fourth">fourth</a>, <a href="#my_rule-second">second</a>, <a href="#my_rule-third">third</a>)
</pre>

This rule does things.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="my_rule-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="my_rule-first"></a>first |  this is the first attribute.   | <a href="https://bazel.build/rules/lib/core/dict">Dictionary: Label -> String</a> | optional |  `{}`  |
| <a id="my_rule-fourth"></a>fourth |  -   | <a href="https://bazel.build/concepts/labels">Label</a> | optional |  `None`  |
| <a id="my_rule-second"></a>second |  -   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `[]`  |
| <a id="my_rule-third"></a>third |  -   | <a href="https://bazel.build/concepts/labels">Label</a> | optional |  `None`  |


<a id="MyProviderInfo"></a>

## MyProviderInfo

<pre>
load("@stardoc//test:testdata/providers_for_attributes_test/input.bzl", "MyProviderInfo")

MyProviderInfo(<a href="#MyProviderInfo-foo">foo</a>, <a href="#MyProviderInfo-bar">bar</a>)
</pre>

**FIELDS**

| Name  | Description |
| :------------- | :------------- |
| <a id="MyProviderInfo-foo"></a>foo |  Something foo-related.    |
| <a id="MyProviderInfo-bar"></a>bar |  Something bar-related.    |


<a id="OtherProviderInfo"></a>

## OtherProviderInfo

<pre>
load("@stardoc//test:testdata/providers_for_attributes_test/input.bzl", "OtherProviderInfo")

OtherProviderInfo()
</pre>


<a id="my_rule_impl"></a>

## my_rule_impl

<pre>
load("@stardoc//test:testdata/providers_for_attributes_test/input.bzl", "my_rule_impl")

my_rule_impl(<a href="#my_rule_impl-ctx">ctx</a>)
</pre>



**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="my_rule_impl-ctx"></a>ctx |  <p align="center"> - </p>   |  none |


