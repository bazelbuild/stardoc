<!-- Generated with Stardoc: http://skydoc.bazel.build -->

A test that verifies basic user function documentation.

<a id="check_sources"></a>

## check_sources

<pre>
check_sources(<a href="#check_sources-name">name</a>, <a href="#check_sources-required_param">required_param</a>, <a href="#check_sources-bool_param">bool_param</a>, <a href="#check_sources-srcs">srcs</a>, <a href="#check_sources-string_param">string_param</a>, <a href="#check_sources-int_param">int_param</a>, <a href="#check_sources-dict_param">dict_param</a>,
              <a href="#check_sources-struct_param">struct_param</a>)
</pre>

Runs some checks on the given source files.

This rule runs checks on a given set of source files.
Use `bazel build` to run the check.


**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="check_sources-name"></a>name |  A unique name for this rule.   |  none |
| <a id="check_sources-required_param"></a>required_param |  Use your imagination.   |  none |
| <a id="check_sources-bool_param"></a>bool_param |  <p align="center"> - </p>   |  `True` |
| <a id="check_sources-srcs"></a>srcs |  Source files to run the checks against.   |  `[]` |
| <a id="check_sources-string_param"></a>string_param |  <p align="center"> - </p>   |  `""` |
| <a id="check_sources-int_param"></a>int_param |  Your favorite number.   |  `2` |
| <a id="check_sources-dict_param"></a>dict_param |  <p align="center"> - </p>   |  `{}` |
| <a id="check_sources-struct_param"></a>struct_param |  <p align="center"> - </p>   |  `struct(foo = "bar")` |


<a id="deprecated_do_not_use"></a>

## deprecated_do_not_use

<pre>
deprecated_do_not_use()
</pre>

This function is deprecated.


**DEPRECATED**

Use literally anything but this function.


<a id="param_doc_multiline"></a>

## param_doc_multiline

<pre>
param_doc_multiline(<a href="#param_doc_multiline-complex">complex</a>)
</pre>

Has a complex parameter.

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="param_doc_multiline-complex"></a>complex |  A parameter with some non-obvious behavior.<br><br> For example, it does things that require **multiple paragraphs** to explain.<br><br>Note: we should preserve the nested indent in the following code:<br><br><pre><code>json {     "key": "value" } </code></pre>   |  none |


<a id="returns_a_thing"></a>

## returns_a_thing

<pre>
returns_a_thing(<a href="#returns_a_thing-name">name</a>)
</pre>

Returns a suffixed name.

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="returns_a_thing-name"></a>name |  A unique name for this rule.   |  none |

**RETURNS**

A suffixed version of the name.


<a id="undocumented_function"></a>

## undocumented_function

<pre>
undocumented_function(<a href="#undocumented_function-a">a</a>, <a href="#undocumented_function-b">b</a>, <a href="#undocumented_function-c">c</a>)
</pre>



**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="undocumented_function-a"></a>a |  <p align="center"> - </p>   |  none |
| <a id="undocumented_function-b"></a>b |  <p align="center"> - </p>   |  none |
| <a id="undocumented_function-c"></a>c |  <p align="center"> - </p>   |  none |


