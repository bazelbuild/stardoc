<!-- Generated with Stardoc: http://skydoc.bazel.build -->



<a id="my_rule"></a>

## my_rule

<pre>
my_rule(<a href="#my_rule-name">name</a>, <a href="#my_rule-deps">deps</a>, <a href="#my_rule-extra_arguments">extra_arguments</a>, <a href="#my_rule-out">out</a>, <a href="#my_rule-src">src</a>, <a href="#my_rule-tool">tool</a>)
</pre>

This rule exercises some of the build API.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="my_rule-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="my_rule-deps"></a>deps |  A list of dependencies.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional | <code>[]</code> |
| <a id="my_rule-extra_arguments"></a>extra_arguments |  -   | List of strings | optional | <code>[]</code> |
| <a id="my_rule-out"></a>out |  The output file.   | <a href="https://bazel.build/concepts/labels">Label</a> | required |  |
| <a id="my_rule-src"></a>src |  The source file.   | <a href="https://bazel.build/concepts/labels">Label</a> | optional | <code>None</code> |
| <a id="my_rule-tool"></a>tool |  The location of the tool to use.   | <a href="https://bazel.build/concepts/labels">Label</a> | optional | <code>//foo/bar/baz:target</code> |


<a id="MyInfo"></a>

## MyInfo

<pre>
MyInfo(<a href="#MyInfo-foo">foo</a>, <a href="#MyInfo-bar">bar</a>)
</pre>



**FIELDS**


| Name  | Description |
| :------------- | :------------- |
| <a id="MyInfo-foo"></a>foo |  Something foo-related.    |
| <a id="MyInfo-bar"></a>bar |  Something bar-related.    |


<a id="exercise_the_api"></a>

## exercise_the_api

<pre>
exercise_the_api()
</pre>





<a id="my_rule_impl"></a>

## my_rule_impl

<pre>
my_rule_impl(<a href="#my_rule_impl-ctx">ctx</a>)
</pre>



**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="my_rule_impl-ctx"></a>ctx |  <p align="center"> - </p>   |  none |


