<!-- Generated with Stardoc: http://skydoc.bazel.build -->

Input file for C++ api test

<a id="#cpp_related_rule"></a>

## cpp_related_rule

<pre>
cpp_related_rule(<a href="#cpp_related_rule-name">name</a>, <a href="#cpp_related_rule-first">first</a>, <a href="#cpp_related_rule-fourth">fourth</a>, <a href="#cpp_related_rule-second">second</a>, <a href="#cpp_related_rule-third">third</a>)
</pre>

This rule does C++-related things.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="cpp_related_rule-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="cpp_related_rule-first"></a>first |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | required |  |
| <a id="cpp_related_rule-fourth"></a>fourth |  -   | Boolean | optional | False |
| <a id="cpp_related_rule-second"></a>second |  -   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: String -> String</a> | required |  |
| <a id="cpp_related_rule-third"></a>third |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | required |  |


<a id="#exercise_the_api"></a>

## exercise_the_api

<pre>
exercise_the_api()
</pre>





<a id="#my_rule_impl"></a>

## my_rule_impl

<pre>
my_rule_impl(<a href="#my_rule_impl-ctx">ctx</a>)
</pre>



**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="my_rule_impl-ctx"></a>ctx |  <p align="center"> - </p>   |  none |


