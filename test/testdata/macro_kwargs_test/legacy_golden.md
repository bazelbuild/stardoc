<!-- Generated with Stardoc: http://skydoc.bazel.build -->

Tests for functions which use *args or **kwargs

<a id="macro_with_args"></a>

## macro_with_args

<pre>
macro_with_args(<a href="#macro_with_args-name">name</a>, <a href="#macro_with_args-args">args</a>)
</pre>

My args macro is OK.

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="macro_with_args-name"></a>name |  The name of the test rule.   |  none |
| <a id="macro_with_args-args"></a>args |  Other arguments to include   |  none |

**RETURNS**

An empty list.


<a id="macro_with_args_and_kwonly"></a>

## macro_with_args_and_kwonly

<pre>
macro_with_args_and_kwonly(<a href="#macro_with_args_and_kwonly-name">name</a>, <a href="#macro_with_args_and_kwonly-args">args</a>)
</pre>

*args and a keyword-only param

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="macro_with_args_and_kwonly-name"></a>name |  The name   |  none |
| <a id="macro_with_args_and_kwonly-args"></a>args |  Positional arguments   |  none |


<a id="macro_with_args_and_kwonlys"></a>

## macro_with_args_and_kwonlys

<pre>
macro_with_args_and_kwonlys(<a href="#macro_with_args_and_kwonlys-name">name</a>, <a href="#macro_with_args_and_kwonlys-number">number</a>, <a href="#macro_with_args_and_kwonlys-args">args</a>)
</pre>

*args and several keyword-only params

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="macro_with_args_and_kwonlys-name"></a>name |  The name   |  none |
| <a id="macro_with_args_and_kwonlys-number"></a>number |  The number   |  `3` |
| <a id="macro_with_args_and_kwonlys-args"></a>args |  Positional arguments   |  none |


<a id="macro_with_args_kwonly_and_kwargs"></a>

## macro_with_args_kwonly_and_kwargs

<pre>
macro_with_args_kwonly_and_kwargs(<a href="#macro_with_args_kwonly_and_kwargs-name">name</a>, <a href="#macro_with_args_kwonly_and_kwargs-args">args</a>, <a href="#macro_with_args_kwonly_and_kwargs-kwargs">kwargs</a>)
</pre>

*args, a keyword-only param, and **kwargs

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="macro_with_args_kwonly_and_kwargs-name"></a>name |  The name   |  none |
| <a id="macro_with_args_kwonly_and_kwargs-args"></a>args |  Positional arguments   |  none |
| <a id="macro_with_args_kwonly_and_kwargs-kwargs"></a>kwargs |  Other named arguments   |  none |


<a id="macro_with_args_kwonlys_and_kwargs"></a>

## macro_with_args_kwonlys_and_kwargs

<pre>
macro_with_args_kwonlys_and_kwargs(<a href="#macro_with_args_kwonlys_and_kwargs-name">name</a>, <a href="#macro_with_args_kwonlys_and_kwargs-number">number</a>, <a href="#macro_with_args_kwonlys_and_kwargs-args">args</a>, <a href="#macro_with_args_kwonlys_and_kwargs-kwargs">kwargs</a>)
</pre>

*args, several keyword-only params, and **kwargs

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="macro_with_args_kwonlys_and_kwargs-name"></a>name |  The name   |  none |
| <a id="macro_with_args_kwonlys_and_kwargs-number"></a>number |  The number   |  `3` |
| <a id="macro_with_args_kwonlys_and_kwargs-args"></a>args |  Positional arguments   |  none |
| <a id="macro_with_args_kwonlys_and_kwargs-kwargs"></a>kwargs |  Other named arguments   |  none |


<a id="macro_with_both"></a>

## macro_with_both

<pre>
macro_with_both(<a href="#macro_with_both-name">name</a>, <a href="#macro_with_both-number">number</a>, <a href="#macro_with_both-args">args</a>, <a href="#macro_with_both-kwargs">kwargs</a>)
</pre>

Oh wow this macro has both.

Not much else to say.


**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="macro_with_both-name"></a>name |  The name of the test rule.   |  none |
| <a id="macro_with_both-number"></a>number |  Some number used for important things   |  `3` |
| <a id="macro_with_both-args"></a>args |  Other arguments to include   |  none |
| <a id="macro_with_both-kwargs"></a>kwargs |  Other attributes to include   |  none |

**RETURNS**

An empty list.


<a id="macro_with_kwargs"></a>

## macro_with_kwargs

<pre>
macro_with_kwargs(<a href="#macro_with_kwargs-name">name</a>, <a href="#macro_with_kwargs-config">config</a>, <a href="#macro_with_kwargs-deps">deps</a>, <a href="#macro_with_kwargs-kwargs">kwargs</a>)
</pre>

My kwargs macro is the best.

This is a long multi-line doc string.
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer
elementum, diam vitae tincidunt pulvinar, nunc tortor volutpat dui,
vitae facilisis odio ligula a tortor. Donec ullamcorper odio eget ipsum tincidunt,
vel mollis eros pellentesque.


**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="macro_with_kwargs-name"></a>name |  The name of the test rule.   |  none |
| <a id="macro_with_kwargs-config"></a>config |  Config to use for my macro   |  none |
| <a id="macro_with_kwargs-deps"></a>deps |  List of my macro's dependencies   |  `[]` |
| <a id="macro_with_kwargs-kwargs"></a>kwargs |  Other attributes to include   |  none |

**RETURNS**

An empty list.


<a id="macro_with_kwonly"></a>

## macro_with_kwonly

<pre>
macro_with_kwonly(<a href="#macro_with_kwonly-name">name</a>)
</pre>

One keyword-only param

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="macro_with_kwonly-name"></a>name |  The name   |  none |


<a id="macro_with_kwonly_and_kwargs"></a>

## macro_with_kwonly_and_kwargs

<pre>
macro_with_kwonly_and_kwargs(<a href="#macro_with_kwonly_and_kwargs-name">name</a>, <a href="#macro_with_kwonly_and_kwargs-kwargs">kwargs</a>)
</pre>

One keyword-only param and **kwargs

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="macro_with_kwonly_and_kwargs-name"></a>name |  The name   |  none |
| <a id="macro_with_kwonly_and_kwargs-kwargs"></a>kwargs |  Other named arguments   |  none |


<a id="macro_with_kwonlys"></a>

## macro_with_kwonlys

<pre>
macro_with_kwonlys(<a href="#macro_with_kwonlys-name">name</a>, <a href="#macro_with_kwonlys-number">number</a>)
</pre>

Several keyword-only params

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="macro_with_kwonlys-name"></a>name |  The name   |  none |
| <a id="macro_with_kwonlys-number"></a>number |  The number   |  `3` |


<a id="macro_with_kwonlys_and_kwargs"></a>

## macro_with_kwonlys_and_kwargs

<pre>
macro_with_kwonlys_and_kwargs(<a href="#macro_with_kwonlys_and_kwargs-name">name</a>, <a href="#macro_with_kwonlys_and_kwargs-number">number</a>, <a href="#macro_with_kwonlys_and_kwargs-kwargs">kwargs</a>)
</pre>

Several keyword-only params and **kwargs

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="macro_with_kwonlys_and_kwargs-name"></a>name |  The name   |  none |
| <a id="macro_with_kwonlys_and_kwargs-number"></a>number |  The number   |  `3` |
| <a id="macro_with_kwonlys_and_kwargs-kwargs"></a>kwargs |  Other named arguments   |  none |


<a id="macro_with_only_args"></a>

## macro_with_only_args

<pre>
macro_with_only_args(<a href="#macro_with_only_args-args">args</a>)
</pre>

Macro only taking *args

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="macro_with_only_args-args"></a>args |  Positional arguments   |  none |


<a id="macro_with_only_args_and_kwargs"></a>

## macro_with_only_args_and_kwargs

<pre>
macro_with_only_args_and_kwargs(<a href="#macro_with_only_args_and_kwargs-args">args</a>, <a href="#macro_with_only_args_and_kwargs-kwargs">kwargs</a>)
</pre>

Macro only taking *args and **kwargs

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="macro_with_only_args_and_kwargs-args"></a>args |  Positional arguments   |  none |
| <a id="macro_with_only_args_and_kwargs-kwargs"></a>kwargs |  Named arguments   |  none |


<a id="macro_with_only_kwargs"></a>

## macro_with_only_kwargs

<pre>
macro_with_only_kwargs(<a href="#macro_with_only_kwargs-kwargs">kwargs</a>)
</pre>

Macro only taking **kwargs

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="macro_with_only_kwargs-kwargs"></a>kwargs |  Named arguments   |  none |


<a id="macro_with_ordinary_param_and_kwonlys"></a>

## macro_with_ordinary_param_and_kwonlys

<pre>
macro_with_ordinary_param_and_kwonlys(<a href="#macro_with_ordinary_param_and_kwonlys-name">name</a>, <a href="#macro_with_ordinary_param_and_kwonlys-number">number</a>, <a href="#macro_with_ordinary_param_and_kwonlys-config">config</a>)
</pre>

One ordinary param and several keyword-only params

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="macro_with_ordinary_param_and_kwonlys-name"></a>name |  The name   |  none |
| <a id="macro_with_ordinary_param_and_kwonlys-number"></a>number |  The number   |  none |
| <a id="macro_with_ordinary_param_and_kwonlys-config"></a>config |  Configuration   |  none |


<a id="macro_with_ordinary_param_args_and_kwonlys"></a>

## macro_with_ordinary_param_args_and_kwonlys

<pre>
macro_with_ordinary_param_args_and_kwonlys(<a href="#macro_with_ordinary_param_args_and_kwonlys-name">name</a>, <a href="#macro_with_ordinary_param_args_and_kwonlys-number">number</a>, <a href="#macro_with_ordinary_param_args_and_kwonlys-config">config</a>, <a href="#macro_with_ordinary_param_args_and_kwonlys-args">args</a>)
</pre>

One ordinary param, *args, and several keyword-only params

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="macro_with_ordinary_param_args_and_kwonlys-name"></a>name |  The name   |  none |
| <a id="macro_with_ordinary_param_args_and_kwonlys-number"></a>number |  The number   |  none |
| <a id="macro_with_ordinary_param_args_and_kwonlys-config"></a>config |  Configuration   |  none |
| <a id="macro_with_ordinary_param_args_and_kwonlys-args"></a>args |  Positional arguments   |  none |


<a id="macro_with_ordinary_param_args_kwonlys_and_kwargs"></a>

## macro_with_ordinary_param_args_kwonlys_and_kwargs

<pre>
macro_with_ordinary_param_args_kwonlys_and_kwargs(<a href="#macro_with_ordinary_param_args_kwonlys_and_kwargs-name">name</a>, <a href="#macro_with_ordinary_param_args_kwonlys_and_kwargs-number">number</a>, <a href="#macro_with_ordinary_param_args_kwonlys_and_kwargs-config">config</a>, <a href="#macro_with_ordinary_param_args_kwonlys_and_kwargs-args">args</a>, <a href="#macro_with_ordinary_param_args_kwonlys_and_kwargs-kwargs">kwargs</a>)
</pre>

One ordinary param, *args, several keyword-only params, and **kwargs

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="macro_with_ordinary_param_args_kwonlys_and_kwargs-name"></a>name |  The name   |  none |
| <a id="macro_with_ordinary_param_args_kwonlys_and_kwargs-number"></a>number |  The number   |  none |
| <a id="macro_with_ordinary_param_args_kwonlys_and_kwargs-config"></a>config |  Configuration   |  none |
| <a id="macro_with_ordinary_param_args_kwonlys_and_kwargs-args"></a>args |  Other positional arguments   |  none |
| <a id="macro_with_ordinary_param_args_kwonlys_and_kwargs-kwargs"></a>kwargs |  Other named arguments   |  none |


<a id="macro_with_ordinary_param_kwonlys_and_kwargs"></a>

## macro_with_ordinary_param_kwonlys_and_kwargs

<pre>
macro_with_ordinary_param_kwonlys_and_kwargs(<a href="#macro_with_ordinary_param_kwonlys_and_kwargs-name">name</a>, <a href="#macro_with_ordinary_param_kwonlys_and_kwargs-number">number</a>, <a href="#macro_with_ordinary_param_kwonlys_and_kwargs-config">config</a>, <a href="#macro_with_ordinary_param_kwonlys_and_kwargs-kwargs">kwargs</a>)
</pre>

One ordinary param, several keyword-only params, and **kwargs

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="macro_with_ordinary_param_kwonlys_and_kwargs-name"></a>name |  The name   |  none |
| <a id="macro_with_ordinary_param_kwonlys_and_kwargs-number"></a>number |  The number   |  none |
| <a id="macro_with_ordinary_param_kwonlys_and_kwargs-config"></a>config |  Configuration   |  none |
| <a id="macro_with_ordinary_param_kwonlys_and_kwargs-kwargs"></a>kwargs |  Other named arguments   |  none |


<a id="macro_with_ordinary_params_and_kwonly"></a>

## macro_with_ordinary_params_and_kwonly

<pre>
macro_with_ordinary_params_and_kwonly(<a href="#macro_with_ordinary_params_and_kwonly-name">name</a>, <a href="#macro_with_ordinary_params_and_kwonly-number">number</a>, <a href="#macro_with_ordinary_params_and_kwonly-config">config</a>)
</pre>

Several ordinary params and a keyword-only param

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="macro_with_ordinary_params_and_kwonly-name"></a>name |  The name   |  none |
| <a id="macro_with_ordinary_params_and_kwonly-number"></a>number |  The number   |  `3` |
| <a id="macro_with_ordinary_params_and_kwonly-config"></a>config |  Configuration   |  none |


<a id="macro_with_ordinary_params_args_and_kwonly"></a>

## macro_with_ordinary_params_args_and_kwonly

<pre>
macro_with_ordinary_params_args_and_kwonly(<a href="#macro_with_ordinary_params_args_and_kwonly-name">name</a>, <a href="#macro_with_ordinary_params_args_and_kwonly-number">number</a>, <a href="#macro_with_ordinary_params_args_and_kwonly-config">config</a>, <a href="#macro_with_ordinary_params_args_and_kwonly-args">args</a>)
</pre>

Several ordinary params, *args, and a keyword-only param

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="macro_with_ordinary_params_args_and_kwonly-name"></a>name |  The name   |  none |
| <a id="macro_with_ordinary_params_args_and_kwonly-number"></a>number |  The number   |  `3` |
| <a id="macro_with_ordinary_params_args_and_kwonly-config"></a>config |  Configuration   |  none |
| <a id="macro_with_ordinary_params_args_and_kwonly-args"></a>args |  Positional arguments   |  none |


<a id="macro_with_ordinary_params_args_kwonly_and_kwargs"></a>

## macro_with_ordinary_params_args_kwonly_and_kwargs

<pre>
macro_with_ordinary_params_args_kwonly_and_kwargs(<a href="#macro_with_ordinary_params_args_kwonly_and_kwargs-name">name</a>, <a href="#macro_with_ordinary_params_args_kwonly_and_kwargs-number">number</a>, <a href="#macro_with_ordinary_params_args_kwonly_and_kwargs-config">config</a>, <a href="#macro_with_ordinary_params_args_kwonly_and_kwargs-args">args</a>, <a href="#macro_with_ordinary_params_args_kwonly_and_kwargs-kwargs">kwargs</a>)
</pre>

Several ordinary params, *args, one keyword-only param, and **kwargs

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="macro_with_ordinary_params_args_kwonly_and_kwargs-name"></a>name |  The name   |  none |
| <a id="macro_with_ordinary_params_args_kwonly_and_kwargs-number"></a>number |  The number   |  `3` |
| <a id="macro_with_ordinary_params_args_kwonly_and_kwargs-config"></a>config |  Configuration   |  none |
| <a id="macro_with_ordinary_params_args_kwonly_and_kwargs-args"></a>args |  Other positional arguments   |  none |
| <a id="macro_with_ordinary_params_args_kwonly_and_kwargs-kwargs"></a>kwargs |  Other named arguments   |  none |


<a id="macro_with_ordinary_params_kwonly_and_kwargs"></a>

## macro_with_ordinary_params_kwonly_and_kwargs

<pre>
macro_with_ordinary_params_kwonly_and_kwargs(<a href="#macro_with_ordinary_params_kwonly_and_kwargs-name">name</a>, <a href="#macro_with_ordinary_params_kwonly_and_kwargs-number">number</a>, <a href="#macro_with_ordinary_params_kwonly_and_kwargs-config">config</a>, <a href="#macro_with_ordinary_params_kwonly_and_kwargs-kwargs">kwargs</a>)
</pre>

Several ordinary params, a keyword-only param, and **kwargs

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="macro_with_ordinary_params_kwonly_and_kwargs-name"></a>name |  The name   |  none |
| <a id="macro_with_ordinary_params_kwonly_and_kwargs-number"></a>number |  The number   |  `3` |
| <a id="macro_with_ordinary_params_kwonly_and_kwargs-config"></a>config |  Configuration   |  none |
| <a id="macro_with_ordinary_params_kwonly_and_kwargs-kwargs"></a>kwargs |  Other named arguments   |  none |


