<!-- Generated with Stardoc: http://skydoc.bazel.build -->

A direct dependency file of the input file.

<a id="my_rule"></a>

## my_rule

<pre>
load("@stardoc//test:testdata/multiple_files_test/input.bzl", "my_rule")
my_rule(<a href="#my_rule-name">name</a>, <a href="#my_rule-first">first</a>, <a href="#my_rule-second">second</a>)
</pre>

This is my rule. It does stuff.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="my_rule-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="my_rule-first"></a>first |  first my_rule doc string   | <a href="https://bazel.build/concepts/labels">Label</a> | required |  |
| <a id="my_rule-second"></a>second |  -   | <a href="https://bazel.build/rules/lib/dict">Dictionary: String -> String</a> | required |  |


<a id="other_rule"></a>

## other_rule

<pre>
load("@stardoc//test:testdata/multiple_files_test/input.bzl", "other_rule")
other_rule(<a href="#other_rule-name">name</a>, <a href="#other_rule-fourth">fourth</a>, <a href="#other_rule-third">third</a>)
</pre>

This is another rule.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="other_rule-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="other_rule-fourth"></a>fourth |  -   | <a href="https://bazel.build/rules/lib/dict">Dictionary: String -> String</a> | required |  |
| <a id="other_rule-third"></a>third |  third other_rule doc string   | <a href="https://bazel.build/concepts/labels">Label</a> | required |  |


<a id="yet_another_rule"></a>

## yet_another_rule

<pre>
load("@stardoc//test:testdata/multiple_files_test/input.bzl", "yet_another_rule")
yet_another_rule(<a href="#yet_another_rule-name">name</a>, <a href="#yet_another_rule-fifth">fifth</a>)
</pre>

This is yet another rule

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="yet_another_rule-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="yet_another_rule-fifth"></a>fifth |  -   | <a href="https://bazel.build/concepts/labels">Label</a> | required |  |


<a id="top_fun"></a>

## top_fun

<pre>
load("@stardoc//test:testdata/multiple_files_test/input.bzl", "top_fun")
top_fun(<a href="#top_fun-a">a</a>, <a href="#top_fun-b">b</a>, <a href="#top_fun-c">c</a>)
</pre>



**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="top_fun-a"></a>a |  <p align="center"> - </p>   |  none |
| <a id="top_fun-b"></a>b |  <p align="center"> - </p>   |  none |
| <a id="top_fun-c"></a>c |  <p align="center"> - </p>   |  none |


