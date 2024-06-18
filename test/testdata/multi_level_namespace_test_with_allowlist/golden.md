<!-- Generated with Stardoc: http://skydoc.bazel.build -->

A test that verifies documenting a multi-leveled namespace of functions with allowlist symbols.
The allowlist symbols should cause everything in my_namespace to to be documented, but only a
specific symbol in other_namespace to be documented.

<a id="my_namespace.math.min"></a>

## my_namespace.math.min

<pre>
load("@stardoc//test:testdata/multi_level_namespace_test_with_allowlist/input.bzl", "my_namespace")

my_namespace.math.min(<a href="#my_namespace.math.min-integers">integers</a>)
</pre>

Returns the minimum of given elements.

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="my_namespace.math.min-integers"></a>integers |  <p align="center"> - </p>   |  none |


<a id="my_namespace.min"></a>

## my_namespace.min

<pre>
load("@stardoc//test:testdata/multi_level_namespace_test_with_allowlist/input.bzl", "my_namespace")

my_namespace.min(<a href="#my_namespace.min-integers">integers</a>)
</pre>

Returns the minimum of given elements.

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="my_namespace.min-integers"></a>integers |  <p align="center"> - </p>   |  none |


<a id="other_namespace.foo.nothing"></a>

## other_namespace.foo.nothing

<pre>
load("@stardoc//test:testdata/multi_level_namespace_test_with_allowlist/input.bzl", "other_namespace")

other_namespace.foo.nothing()
</pre>

This function does nothing.



