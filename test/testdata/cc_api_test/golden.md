<!-- Generated with Stardoc: http://skydoc.bazel.build -->

Input file for C++ api test

<a id="cpp_related_rule"></a>

## cpp_related_rule

<pre>
load("@stardoc//test:testdata/cc_api_test/input.bzl", "cpp_related_rule")

cpp_related_rule(<a href="#cpp_related_rule-name">name</a>, <a href="#cpp_related_rule-first">first</a>, <a href="#cpp_related_rule-fourth">fourth</a>, <a href="#cpp_related_rule-second">second</a>, <a href="#cpp_related_rule-third">third</a>)
</pre>

This rule does C++-related things.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="cpp_related_rule-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="cpp_related_rule-first"></a>first |  -   | <a href="https://bazel.build/concepts/labels">Label</a> | required |  |
| <a id="cpp_related_rule-fourth"></a>fourth |  -   | Boolean | optional |  `False`  |
| <a id="cpp_related_rule-second"></a>second |  -   | <a href="https://bazel.build/rules/lib/dict">Dictionary: String -> String</a> | required |  |
| <a id="cpp_related_rule-third"></a>third |  -   | <a href="https://bazel.build/concepts/labels">Label</a> | required |  |


<a id="exercise_the_api"></a>

## exercise_the_api

<pre>
load("@stardoc//test:testdata/cc_api_test/input.bzl", "exercise_the_api")

exercise_the_api()
</pre>





<a id="my_rule_impl"></a>

## my_rule_impl

<pre>
load("@stardoc//test:testdata/cc_api_test/input.bzl", "my_rule_impl")

my_rule_impl(<a href="#my_rule_impl-ctx">ctx</a>)
</pre>



**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="my_rule_impl-ctx"></a>ctx |  <p align="center"> - </p>   |  none |


