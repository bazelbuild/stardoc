<!-- Generated with Stardoc: http://skydoc.bazel.build -->

<a id="#my_rule"></a>

## my_rule

<pre>
my_rule(<a href="#my_rule-name">name</a>, <a href="#my_rule-first">first</a>, <a href="#my_rule-second">second</a>)
</pre>

This is my rule. It does stuff.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="my_rule-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="my_rule-first"></a>first |  first my_rule doc string   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | required |  |
| <a id="my_rule-second"></a>second |  -   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: String -> String</a> | required |  |


<a id="#whitelisted_dep_rule"></a>

## whitelisted_dep_rule

<pre>
whitelisted_dep_rule(<a href="#whitelisted_dep_rule-name">name</a>, <a href="#whitelisted_dep_rule-first">first</a>, <a href="#whitelisted_dep_rule-second">second</a>)
</pre>

This is the dep rule. It does stuff.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="whitelisted_dep_rule-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="whitelisted_dep_rule-first"></a>first |  dep's my_rule doc string   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | required |  |
| <a id="whitelisted_dep_rule-second"></a>second |  -   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: String -> String</a> | required |  |


