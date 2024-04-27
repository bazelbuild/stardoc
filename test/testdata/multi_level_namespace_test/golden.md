<!-- Generated with Stardoc: http://skydoc.bazel.build -->

A test that verifies documenting a multi-leveled namespace of functions.

<a id="my_namespace.foo.bar.baz"></a>

## my_namespace.foo.bar.baz

<pre>
load("@stardoc//test:testdata/multi_level_namespace_test/input.bzl", "my_namespace")
my_namespace.foo.bar.baz()
</pre>

This function does nothing.



<a id="my_namespace.math.min"></a>

## my_namespace.math.min

<pre>
load("@stardoc//test:testdata/multi_level_namespace_test/input.bzl", "my_namespace")
my_namespace.math.min(<a href="#my_namespace.math.min-integers">integers</a>)
</pre>

Returns the minimum of given elements.

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="my_namespace.math.min-integers"></a>integers |  A list of integers. Must not be empty.   |  none |

**RETURNS**

The minimum integer in the given list.


<a id="my_namespace.min"></a>

## my_namespace.min

<pre>
load("@stardoc//test:testdata/multi_level_namespace_test/input.bzl", "my_namespace")
my_namespace.min(<a href="#my_namespace.min-integers">integers</a>)
</pre>

Returns the minimum of given elements.

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="my_namespace.min-integers"></a>integers |  A list of integers. Must not be empty.   |  none |

**RETURNS**

The minimum integer in the given list.


<a id="my_namespace.one.three.does_nothing"></a>

## my_namespace.one.three.does_nothing

<pre>
load("@stardoc//test:testdata/multi_level_namespace_test/input.bzl", "my_namespace")
my_namespace.one.three.does_nothing()
</pre>

This function does nothing.



<a id="my_namespace.one.two.min"></a>

## my_namespace.one.two.min

<pre>
load("@stardoc//test:testdata/multi_level_namespace_test/input.bzl", "my_namespace")
my_namespace.one.two.min(<a href="#my_namespace.one.two.min-integers">integers</a>)
</pre>

Returns the minimum of given elements.

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="my_namespace.one.two.min-integers"></a>integers |  A list of integers. Must not be empty.   |  none |

**RETURNS**

The minimum integer in the given list.


