<!-- Generated with Stardoc: http://skydoc.bazel.build -->

Input file to test &lt;angle bracket bugs&gt;

See https://github.com/bazelbuild/skydoc/issues/186,
https://github.com/bazelbuild/stardoc/issues/132,
and https://github.com/bazelbuild/stardoc/issues/137.

&lt;Angle brackets&gt; need to be escaped in some contexts.
They also need to _not_ be escaped when they're enclosed
in a `<code block>`.


<a id="my_anglebrac"></a>

## my_anglebrac

<pre>
my_anglebrac(<a href="#my_anglebrac-name">name</a>, <a href="#my_anglebrac-also_useless">also_useless</a>, <a href="#my_anglebrac-useless">useless</a>)
</pre>

Rule with &lt;brackets&gt;

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="my_anglebrac-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="my_anglebrac-also_useless"></a>also_useless |  Args with some formatted tags: <code>&lt;tag&gt;</code>   | String | optional | <code>"1&lt;&lt;5"</code> |
| <a id="my_anglebrac-useless"></a>useless |  Args with some tags: &lt;tag1&gt;, &lt;tag2&gt;   | String | optional | <code>"Find &lt;brackets&gt;"</code> |


<a id="bracketuse"></a>

## bracketuse

<pre>
bracketuse(<a href="#bracketuse-foo">foo</a>, <a href="#bracketuse-bar">bar</a>, <a href="#bracketuse-baz">baz</a>)
</pre>

Information with &lt;brackets&gt;

**FIELDS**


| Name  | Description |
| :------------- | :------------- |
| <a id="bracketuse-foo"></a>foo |  A string representing &lt;foo&gt;    |
| <a id="bracketuse-bar"></a>bar |  A string representing bar    |
| <a id="bracketuse-baz"></a>baz |  A string representing baz    |


<a id="bracket_function"></a>

## bracket_function

<pre>
bracket_function(<a href="#bracket_function-param">param</a>, <a href="#bracket_function-md_string">md_string</a>)
</pre>

Dummy docstring with &lt;brackets&gt;.

This rule runs checks on &lt;angle brackets&gt;.

Sometimes, we have such things on their own, but they may
also appear in code blocks, like

```starlark
foo = "<thing>"
```


**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="bracket_function-param"></a>param |  an arg with **formatted** docstring, &lt;default&gt; by default.   |  <code>"&lt;default&gt;"</code> |
| <a id="bracket_function-md_string"></a>md_string |  A markdown string.   |  <code>"&#96;1&lt;&lt;10&#96;"</code> |

**RETURNS**

some &lt;angled&gt; brackets

**DEPRECATED**

deprecated for &lt;reasons&gt; as well as `<reasons>`.


<a id="bracket_aspect"></a>

## bracket_aspect

<pre>
bracket_aspect(<a href="#bracket_aspect-name">name</a>, <a href="#bracket_aspect-brackets">brackets</a>)
</pre>

Aspect.

Sometimes, we want a code block like
```starlark
foo = "<brackets>"
```
which includes angle brackets.


**ASPECT ATTRIBUTES**


| Name | Type |
| :------------- | :------------- |
| deps| String |


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="bracket_aspect-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |   |
| <a id="bracket_aspect-brackets"></a>brackets |  Attribute with &lt;brackets&gt;   | String | optional |  <code>"&lt;default&gt;"</code>   |


