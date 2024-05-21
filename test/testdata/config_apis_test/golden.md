<!-- Generated with Stardoc: http://skydoc.bazel.build -->



<a id="int_setting"></a>

## int_setting

<pre>
load("@stardoc//test:testdata/config_apis_test/input.bzl", "int_setting")

int_setting(<a href="#int_setting-name">name</a>)
</pre>

An integer flag.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="int_setting-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |


<a id="string_flag"></a>

## string_flag

<pre>
load("@stardoc//test:testdata/config_apis_test/input.bzl", "string_flag")

string_flag(<a href="#string_flag-name">name</a>)
</pre>

A string flag.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="string_flag-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |


<a id="exercise_the_api"></a>

## exercise_the_api

<pre>
load("@stardoc//test:testdata/config_apis_test/input.bzl", "exercise_the_api")

exercise_the_api()
</pre>





<a id="transition_func"></a>

## transition_func

<pre>
load("@stardoc//test:testdata/config_apis_test/input.bzl", "transition_func")

transition_func(<a href="#transition_func-settings">settings</a>)
</pre>

A no-op transition function.

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="transition_func-settings"></a>settings |  <p align="center"> - </p>   |  none |


