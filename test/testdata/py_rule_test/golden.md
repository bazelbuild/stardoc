<!-- Generated with Stardoc: http://skydoc.bazel.build -->

The input file for the python rule test

<a id="py_related_rule"></a>

## py_related_rule

<pre>
load("@stardoc//test:testdata/py_rule_test/input.bzl", "py_related_rule")

py_related_rule(<a href="#py_related_rule-name">name</a>, <a href="#py_related_rule-fifth">fifth</a>, <a href="#py_related_rule-first">first</a>, <a href="#py_related_rule-fourth">fourth</a>, <a href="#py_related_rule-second">second</a>, <a href="#py_related_rule-sixth">sixth</a>, <a href="#py_related_rule-third">third</a>)
</pre>

This rule does python-related things.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="py_related_rule-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="py_related_rule-fifth"></a>fifth |  Hey look, its the fifth thing!   | Boolean | optional |  `True`  |
| <a id="py_related_rule-first"></a>first |  this is the first doc string!   | <a href="https://bazel.build/concepts/labels">Label</a> | required |  |
| <a id="py_related_rule-fourth"></a>fourth |  the fourth doc string.   | Boolean | optional |  `False`  |
| <a id="py_related_rule-second"></a>second |  -   | <a href="https://bazel.build/rules/lib/core/dict">Dictionary: String -> String</a> | required |  |
| <a id="py_related_rule-sixth"></a>sixth |  it's the sixth thing.   | List of integers | optional |  `[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]`  |
| <a id="py_related_rule-third"></a>third |  -   | <a href="https://bazel.build/concepts/labels">Label</a>; <a href="https://bazel.build/reference/be/common-definitions#configurable-attributes">nonconfigurable</a> | required |  |


