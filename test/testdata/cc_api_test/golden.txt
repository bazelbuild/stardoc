<!-- Generated with Stardoc: http://skydoc.bazel.build -->

<a name="#cpp_related_rule"></a>

## cpp_related_rule

<pre>
cpp_related_rule(<a href="#cpp_related_rule-name">name</a>, <a href="#cpp_related_rule-first">first</a>, <a href="#cpp_related_rule-fourth">fourth</a>, <a href="#cpp_related_rule-second">second</a>, <a href="#cpp_related_rule-third">third</a>)
</pre>

This rule does C++-related things.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :-------------: | :-------------: | :-------------: | :-------------: | :-------------: |
| name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| first |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | required |  |
| fourth |  -   | Boolean | optional | False |
| second |  -   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: String -> String</a> | required |  |
| third |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | required |  |


<a name="#exercise_the_api"></a>

## exercise_the_api

<pre>
exercise_the_api()
</pre>



**PARAMETERS**



<a name="#my_rule_impl"></a>

## my_rule_impl

<pre>
my_rule_impl(<a href="#my_rule_impl-ctx">ctx</a>)
</pre>



**PARAMETERS**


| Name  | Description | Default Value |
| :-------------: | :-------------: | :-------------: |
| ctx |  <p align="center"> - </p>   |  none |


