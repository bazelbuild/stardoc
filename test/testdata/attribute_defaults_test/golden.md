<!-- Generated with Stardoc: http://skydoc.bazel.build -->

A golden test to verify attribute default values.

<a id="my_rule"></a>

## my_rule

<pre>
load("@stardoc//test:testdata/attribute_defaults_test/input.bzl", "my_rule")

my_rule(<a href="#my_rule-name">name</a>, <a href="#my_rule-a">a</a>, <a href="#my_rule-b">b</a>, <a href="#my_rule-c">c</a>, <a href="#my_rule-d">d</a>, <a href="#my_rule-e">e</a>, <a href="#my_rule-f">f</a>, <a href="#my_rule-g">g</a>, <a href="#my_rule-h">h</a>, <a href="#my_rule-i">i</a>, <a href="#my_rule-j">j</a>, <a href="#my_rule-k">k</a>, <a href="#my_rule-l">l</a>, <a href="#my_rule-m">m</a>, <a href="#my_rule-n">n</a>, <a href="#my_rule-o">o</a>, <a href="#my_rule-p">p</a>, <a href="#my_rule-q">q</a>, <a href="#my_rule-r">r</a>, <a href="#my_rule-s">s</a>, <a href="#my_rule-t">t</a>, <a href="#my_rule-u">u</a>, <a href="#my_rule-v">v</a>, <a href="#my_rule-w">w</a>)
</pre>

This is my rule. It does stuff.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="my_rule-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="my_rule-a"></a>a |  Some bool   | Boolean | optional |  `False`  |
| <a id="my_rule-b"></a>b |  Some int   | Integer | optional |  `2`  |
| <a id="my_rule-c"></a>c |  Some int_list   | List of integers | optional |  `[0, 1]`  |
| <a id="my_rule-d"></a>d |  Some label   | <a href="https://bazel.build/concepts/labels">Label</a> | optional |  `"@stardoc//foo:bar"`  |
| <a id="my_rule-e"></a>e |  Some label_keyed_string_dict   | <a href="https://bazel.build/rules/lib/core/dict">Dictionary: Label -> String</a> | optional |  `{"@stardoc//foo:bar": "hello", "@stardoc//bar:baz": "goodbye"}`  |
| <a id="my_rule-f"></a>f |  Some label_list   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `["@stardoc//foo:bar", "@stardoc//bar:baz"]`  |
| <a id="my_rule-g"></a>g |  Some string   | String | optional |  `""`  |
| <a id="my_rule-h"></a>h |  Some string_dict   | <a href="https://bazel.build/rules/lib/core/dict">Dictionary: String -> String</a> | optional |  `{"animal": "bunny", "color": "orange"}`  |
| <a id="my_rule-i"></a>i |  Some string_list   | List of strings | optional |  `["cat", "dog"]`  |
| <a id="my_rule-j"></a>j |  Some string_list_dict   | <a href="https://bazel.build/rules/lib/core/dict">Dictionary: String -> List of strings</a> | optional |  `{"animal": ["cat", "bunny"], "color": ["blue", "orange"]}`  |
| <a id="my_rule-k"></a>k |  Some bool   | Boolean | required |  |
| <a id="my_rule-l"></a>l |  Some int   | Integer | required |  |
| <a id="my_rule-m"></a>m |  Some int_list   | List of integers | required |  |
| <a id="my_rule-n"></a>n |  Some label   | <a href="https://bazel.build/concepts/labels">Label</a> | required |  |
| <a id="my_rule-o"></a>o |  Some label_keyed_string_dict   | <a href="https://bazel.build/rules/lib/core/dict">Dictionary: Label -> String</a> | required |  |
| <a id="my_rule-p"></a>p |  Some label_list   | <a href="https://bazel.build/concepts/labels">List of labels</a> | required |  |
| <a id="my_rule-q"></a>q |  Some string   | String | required |  |
| <a id="my_rule-r"></a>r |  Some string_dict   | <a href="https://bazel.build/rules/lib/core/dict">Dictionary: String -> String</a> | required |  |
| <a id="my_rule-s"></a>s |  Some string_list   | List of strings | required |  |
| <a id="my_rule-t"></a>t |  Some string_list_dict   | <a href="https://bazel.build/rules/lib/core/dict">Dictionary: String -> List of strings</a> | required |  |
| <a id="my_rule-u"></a>u |  -   | String | optional |  `""`  |
| <a id="my_rule-v"></a>v |  -   | <a href="https://bazel.build/concepts/labels">Label</a> | optional |  `None`  |
| <a id="my_rule-w"></a>w |  -   | Integer | optional |  `0`  |


<a id="my_aspect"></a>

## my_aspect

<pre>
load("@stardoc//test:testdata/attribute_defaults_test/input.bzl", "my_aspect")

my_aspect(<a href="#my_aspect-y">y</a>, <a href="#my_aspect-z">z</a>)
</pre>

This is my aspect. It does stuff.

**ASPECT ATTRIBUTES**


| Name | Type |
| :------------- | :------------- |
| deps| String |
| attr_aspect| String |


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="my_aspect-y"></a>y |  some string   | String | optional |  `"why"`  |
| <a id="my_aspect-z"></a>z |  -   | String | required |  |


