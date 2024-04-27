<!-- Generated with Stardoc: http://skydoc.bazel.build -->



<a id="my_rule"></a>

## my_rule

<pre>
load("@stardoc//test:testdata/simple_test/input.bzl", "my_rule")
my_rule(<a href="#my_rule-name">name</a>, <a href="#my_rule-first">first</a>, <a href="#my_rule-fourth">fourth</a>, <a href="#my_rule-second">second</a>, <a href="#my_rule-third">third</a>)
</pre>

This is my rule. It does stuff.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="my_rule-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="my_rule-first"></a>first |  first doc string   | <a href="https://bazel.build/concepts/labels">Label</a> | required |  |
| <a id="my_rule-fourth"></a>fourth |  fourth doc string   | Boolean | optional |  `False`  |
| <a id="my_rule-second"></a>second |  -   | <a href="https://bazel.build/rules/lib/dict">Dictionary: String -> String</a> | required |  |
| <a id="my_rule-third"></a>third |  -   | <a href="https://bazel.build/concepts/labels">Label</a> | required |  |


