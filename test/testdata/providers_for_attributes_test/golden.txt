<!-- Generated with Stardoc: http://skydoc.bazel.build -->

<a name="#my_rule"></a>

## my_rule

<pre>
my_rule(<a href="#my_rule-name">name</a>, <a href="#my_rule-fifth">fifth</a>, <a href="#my_rule-first">first</a>, <a href="#my_rule-fourth">fourth</a>, <a href="#my_rule-second">second</a>, <a href="#my_rule-sixth">sixth</a>, <a href="#my_rule-third">third</a>)
</pre>

This rule does things.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :-------------: | :-------------: | :-------------: | :-------------: | :-------------: |
| name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| fifth |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| first |  this is the first attribute.   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: Label -> String</a> | optional | {} |
| fourth |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| second |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| sixth |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| third |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |


<a name="#MyProviderInfo"></a>

## MyProviderInfo

<pre>
MyProviderInfo(<a href="#MyProviderInfo-foo">foo</a>, <a href="#MyProviderInfo-bar">bar</a>)
</pre>



**FIELDS**


| Name  | Description |
| :-------------: | :-------------: |
| foo |  Something foo-related.    |
| bar |  Something bar-related.    |


<a name="#OtherProviderInfo"></a>

## OtherProviderInfo

<pre>
OtherProviderInfo()
</pre>



**FIELDS**



<a name="#my_rule_impl"></a>

## my_rule_impl

<pre>
my_rule_impl(<a href="#my_rule_impl-ctx">ctx</a>)
</pre>



**PARAMETERS**


| Name  | Description | Default Value |
| :-------------: | :-------------: | :-------------: |
| ctx |  <p align="center"> - </p>   |  none |


