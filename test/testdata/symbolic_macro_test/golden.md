<!-- Generated with Stardoc: http://skydoc.bazel.build -->

Symbolic macro tests

<a id="basic_macro"></a>

## basic_macro

<pre>
load("@stardoc//test:testdata/symbolic_macro_test/input.bzl", "basic_macro")

basic_macro(*, <a href="#basic_macro-name">name</a>, <a href="#basic_macro-srcs">srcs</a>, <a href="#basic_macro-operation">operation</a>, <a href="#basic_macro-visibility">visibility</a>)
</pre>

Initializes some targets.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="basic_macro-name"></a>name |  A unique name for this macro instance. Normally, this is also the name for the macro's main or only target. The names of any other targets that this macro might create will be this name with a string suffix.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="basic_macro-srcs"></a>srcs |  Source files   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `[]`  |
| <a id="basic_macro-operation"></a>operation |  Operation to perform   | String; <a href="https://bazel.build/reference/be/common-definitions#configurable-attributes">nonconfigurable</a> | optional |  `"FROBNICATE"`  |
| <a id="basic_macro-visibility"></a>visibility |  The visibility to be passed to this macro's exported targets. It always implicitly includes the location where this macro is instantiated, so this attribute only needs to be explicitly set if you want the macro's targets to be additionally visible somewhere else.   | <a href="https://bazel.build/concepts/labels">List of labels</a>; <a href="https://bazel.build/reference/be/common-definitions#configurable-attributes">nonconfigurable</a> | optional |  |


