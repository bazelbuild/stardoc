<!-- Generated with Stardoc: http://skydoc.bazel.build -->



<a id="allowlisted_dep_rule"></a>

## allowlisted_dep_rule

<pre>
load("@stardoc//test:testdata/filter_rules_test/input.bzl", "allowlisted_dep_rule")

allowlisted_dep_rule(<a href="#allowlisted_dep_rule-name">name</a>, <a href="#allowlisted_dep_rule-first">first</a>, <a href="#allowlisted_dep_rule-second">second</a>)
</pre>

This is the dep rule. It does stuff.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="allowlisted_dep_rule-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="allowlisted_dep_rule-first"></a>first |  dep's my_rule doc string   | <a href="https://bazel.build/concepts/labels">Label</a> | required |  |
| <a id="allowlisted_dep_rule-second"></a>second |  -   | <a href="https://bazel.build/rules/lib/core/dict">Dictionary: String -> String</a> | required |  |


<a id="my_rule"></a>

## my_rule

<pre>
load("@stardoc//test:testdata/filter_rules_test/input.bzl", "my_rule")

my_rule(<a href="#my_rule-name">name</a>, <a href="#my_rule-first">first</a>, <a href="#my_rule-second">second</a>)
</pre>

This is my rule. It does stuff.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="my_rule-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="my_rule-first"></a>first |  first my_rule doc string   | <a href="https://bazel.build/concepts/labels">Label</a> | required |  |
| <a id="my_rule-second"></a>second |  -   | <a href="https://bazel.build/rules/lib/core/dict">Dictionary: String -> String</a> | required |  |


