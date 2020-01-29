<!-- Generated with Stardoc: http://skydoc.bazel.build -->

<a name="#my_rule"></a>

## my_rule

<pre>
my_rule(<a href="#my_rule-name">name</a>, <a href="#my_rule-deps">deps</a>, <a href="#my_rule-extra_arguments">extra_arguments</a>, <a href="#my_rule-out">out</a>, <a href="#my_rule-src">src</a>, <a href="#my_rule-tool">tool</a>)
</pre>

This rule exercises some of the build API.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a name="my_rule-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a name="my_rule-deps"></a>deps |  A list of dependencies.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a name="my_rule-extra_arguments"></a>extra_arguments |  -   | List of strings | optional | [] |
| <a name="my_rule-out"></a>out |  The output file.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | required |  |
| <a name="my_rule-src"></a>src |  The source file.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a name="my_rule-tool"></a>tool |  The location of the tool to use.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | //foo/bar/baz:target |


<a name="#MyInfo"></a>

## MyInfo

<pre>
MyInfo(<a href="#MyInfo-foo">foo</a>, <a href="#MyInfo-bar">bar</a>)
</pre>



**FIELDS**


| Name  | Description |
| :------------- | :------------- |
| <a name="MyInfo-foo"></a>foo |  Something foo-related.    |
| <a name="MyInfo-bar"></a>bar |  Something bar-related.    |


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
| :------------- | :------------- | :------------- |
| <a name="my_rule_impl-ctx"></a>ctx |  <p align="center"> - </p>   |  none |


