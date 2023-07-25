<!-- Generated with Stardoc: http://skydoc.bazel.build -->

Input file to test angle bracket bug (https://github.com/bazelbuild/skydoc/issues/186)

See https://github.com/bazelbuild/skydoc/issues/186,
https://github.com/bazelbuild/stardoc/issues/132,
and https://github.com/bazelbuild/stardoc/issues/137.

<b>HTML formatting</b> can be used in docstrings, just as in regular Markdown.
Literal angle brackets can be obtained by escaping them with a backslash, where
the backslash itself must be escaped for use in a Starlark docstring
(`\\<` becomes \<), or by using HTML entities (`&lt;` becomes &lt;).
Angle brackets are also preserved in inline code blocks (`#include <vector>`).


<a id="my_anglebrac"></a>

## my_anglebrac

<pre>
my_anglebrac(<a href="#my_anglebrac-name">name</a>, <a href="#my_anglebrac-also_useless">also_useless</a>, <a href="#my_anglebrac-useless">useless</a>)
</pre>

Rule with \<brackets>

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="my_anglebrac-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="my_anglebrac-also_useless"></a>also_useless |  Args with some formatted tags: `<tag>`   | String | optional |  `"1<<5"`  |
| <a id="my_anglebrac-useless"></a>useless |  Args with some tags: <tag1>, <tag2>   | String | optional |  `"Find \\<brackets>"`  |


<a id="bracketuse"></a>

## bracketuse

<pre>
bracketuse(<a href="#bracketuse-foo">foo</a>, <a href="#bracketuse-bar">bar</a>, <a href="#bracketuse-baz">baz</a>)
</pre>

Information with \<brackets>

**FIELDS**


| Name  | Description |
| :------------- | :------------- |
| <a id="bracketuse-foo"></a>foo |  A string representing <foo>    |
| <a id="bracketuse-bar"></a>bar |  A string representing bar    |
| <a id="bracketuse-baz"></a>baz |  A string representing baz    |


<a id="bracket_function"></a>

## bracket_function

<pre>
bracket_function(<a href="#bracket_function-param">param</a>, <a href="#bracket_function-md_string">md_string</a>)
</pre>

Dummy docstring with \<brackets>.

This rule runs checks on `<angle brackets>`.

Sometimes, we have such things on their own, but they may
also appear in code blocks, like

```starlark
foo = "<thing>"
```


**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="bracket_function-param"></a>param |  an arg with **formatted** docstring, `<default>` by default.   |  `"<default>"` |
| <a id="bracket_function-md_string"></a>md_string |  A markdown string.   |  ``"foo `1<<10` bar"`` |

**RETURNS**

some \<angled> brackets

**DEPRECATED**

deprecated for \<reasons> as well as `<reasons>`.


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
| <a id="bracket_aspect-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="bracket_aspect-brackets"></a>brackets |  Attribute with \<brackets>   | String | optional |  `"<default>"`  |


