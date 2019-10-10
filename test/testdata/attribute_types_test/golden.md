<!-- Generated with Stardoc: http://skydoc.bazel.build -->

<a name="#my_rule"></a>

## my_rule

<pre>
my_rule(<a href="#my_rule-name">name</a>, <a href="#my_rule-a">a</a>, <a href="#my_rule-b">b</a>, <a href="#my_rule-c">c</a>, <a href="#my_rule-d">d</a>, <a href="#my_rule-e">e</a>, <a href="#my_rule-f">f</a>, <a href="#my_rule-g">g</a>, <a href="#my_rule-h">h</a>, <a href="#my_rule-i">i</a>, <a href="#my_rule-j">j</a>, <a href="#my_rule-k">k</a>, <a href="#my_rule-l">l</a>)
</pre>

This is my rule. It does stuff.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :-------------: | :-------------: | :-------------: | :-------------: | :-------------: |
| name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| a |  Some bool   | Boolean | required |  |
| b |  Some int   | Integer | required |  |
| c |  Some int_list   | List of integers | required |  |
| d |  Some label   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | required |  |
| e |  Some label_keyed_string_dict   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: Label -> String</a> | required |  |
| f |  Some label_list   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | required |  |
| g |  Some output   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| h |  Some output_list   | List of labels | optional | None |
| i |  Some string   | String | required |  |
| j |  Some string_dict   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: String -> String</a> | required |  |
| k |  Some string_list   | List of strings | required |  |
| l |  Some string_list_dict   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: String -> List of strings</a> | optional | {} |


