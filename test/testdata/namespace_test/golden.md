<!-- Generated with Stardoc: http://skydoc.bazel.build -->

A test that verifies documenting a namespace of functions.

<a id="my_namespace.assert_non_empty"></a>

## my_namespace.assert_non_empty

<pre>
load("@stardoc//test:testdata/namespace_test/input.bzl", "my_namespace")

my_namespace.assert_non_empty(<a href="#my_namespace.assert_non_empty-some_list">some_list</a>, <a href="#my_namespace.assert_non_empty-other_list">other_list</a>)
</pre>

Asserts the two given lists are not empty.

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="my_namespace.assert_non_empty-some_list"></a>some_list |  The first list   |  none |
| <a id="my_namespace.assert_non_empty-other_list"></a>other_list |  The second list   |  none |


<a id="my_namespace.join_strings"></a>

## my_namespace.join_strings

<pre>
load("@stardoc//test:testdata/namespace_test/input.bzl", "my_namespace")

my_namespace.join_strings(<a href="#my_namespace.join_strings-strings">strings</a>, <a href="#my_namespace.join_strings-delimiter">delimiter</a>)
</pre>

Joins the given strings with a delimiter.

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="my_namespace.join_strings-strings"></a>strings |  A list of strings to join.   |  none |
| <a id="my_namespace.join_strings-delimiter"></a>delimiter |  The delimiter to use   |  `", "` |

**RETURNS**

The joined string.


<a id="my_namespace.min"></a>

## my_namespace.min

<pre>
load("@stardoc//test:testdata/namespace_test/input.bzl", "my_namespace")

my_namespace.min(<a href="#my_namespace.min-integers">integers</a>)
</pre>

Returns the minimum of given elements.

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="my_namespace.min-integers"></a>integers |  A list of integers. Must not be empty.   |  none |

**RETURNS**

The minimum integer in the given list.


