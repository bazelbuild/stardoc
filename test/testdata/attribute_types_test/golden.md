<!-- Generated with Stardoc: http://skydoc.bazel.build -->



<a id="my_rule"></a>

## my_rule

<pre>
load("@stardoc//test:testdata/attribute_types_test/input.bzl", "my_rule")
my_rule(<a href="#my_rule-name">name</a>, <a href="#my_rule-a">a</a>, <a href="#my_rule-b">b</a>, <a href="#my_rule-c">c</a>, <a href="#my_rule-d">d</a>, <a href="#my_rule-e">e</a>, <a href="#my_rule-f">f</a>, <a href="#my_rule-g">g</a>, <a href="#my_rule-h">h</a>, <a href="#my_rule-i">i</a>, <a href="#my_rule-j">j</a>, <a href="#my_rule-k">k</a>, <a href="#my_rule-l">l</a>)
</pre>

This is my rule.

It does stuff.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="my_rule-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="my_rule-a"></a>a |  Some bool   | Boolean | required |  |
| <a id="my_rule-b"></a>b |  Some int   | Integer | required |  |
| <a id="my_rule-c"></a>c |  Some int_list   | List of integers | required |  |
| <a id="my_rule-d"></a>d |  Some label   | <a href="https://bazel.build/concepts/labels">Label</a> | required |  |
| <a id="my_rule-e"></a>e |  Some label_keyed_string_dict   | <a href="https://bazel.build/rules/lib/dict">Dictionary: Label -> String</a> | required |  |
| <a id="my_rule-f"></a>f |  Some label_list   | <a href="https://bazel.build/concepts/labels">List of labels</a> | required |  |
| <a id="my_rule-g"></a>g |  Some output   | <a href="https://bazel.build/concepts/labels">Label</a> | optional |  `None`  |
| <a id="my_rule-h"></a>h |  Some output_list   | List of labels | optional |  `[]`  |
| <a id="my_rule-i"></a>i |  Some string   | String | required |  |
| <a id="my_rule-j"></a>j |  Some string_dict   | <a href="https://bazel.build/rules/lib/dict">Dictionary: String -> String</a> | required |  |
| <a id="my_rule-k"></a>k |  Some string_list   | List of strings | required |  |
| <a id="my_rule-l"></a>l |  Some string_list_dict   | <a href="https://bazel.build/rules/lib/dict">Dictionary: String -> List of strings</a> | optional |  `{}`  |


