<!-- Generated with Stardoc: http://skydoc.bazel.build -->

<a name="#my_rule"></a>

## my_rule

<pre>
my_rule(<a href="#my_rule-name">name</a>, <a href="#my_rule-first">first</a>, <a href="#my_rule-second">second</a>)
</pre>

This is my rule. It does stuff.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :-------------: | :-------------: | :-------------: | :-------------: | :-------------: |
| name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| first |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | required |  |
| second |  -   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: String -> String</a> | required |  |


<a name="#other_rule"></a>

## other_rule

<pre>
other_rule(<a href="#other_rule-name">name</a>, <a href="#other_rule-fourth">fourth</a>, <a href="#other_rule-third">third</a>)
</pre>

This is another rule.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :-------------: | :-------------: | :-------------: | :-------------: | :-------------: |
| name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| fourth |  -   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: String -> String</a> | required |  |
| third |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | required |  |


<a name="#yet_another_rule"></a>

## yet_another_rule

<pre>
yet_another_rule(<a href="#yet_another_rule-name">name</a>, <a href="#yet_another_rule-fifth">fifth</a>)
</pre>

This is yet another rule

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :-------------: | :-------------: | :-------------: | :-------------: | :-------------: |
| name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| fifth |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | required |  |


<a name="#my_rule_impl"></a>

## my_rule_impl

<pre>
my_rule_impl(<a href="#my_rule_impl-ctx">ctx</a>)
</pre>



**PARAMETERS**


| Name  | Description | Default Value |
| :-------------: | :-------------: | :-------------: |
| ctx |  <p align="center"> - </p>   |  none |


