<!-- Generated with Stardoc: http://skydoc.bazel.build -->

Finalizer tests

<a id="my_finalizer"></a>

## my_finalizer

<pre>
load("@stardoc//test:testdata/symbolic_macro_finalizer_test/input.bzl", "my_finalizer")

my_finalizer(*, <a href="#my_finalizer-name">name</a>, <a href="#my_finalizer-ignore_targets">ignore_targets</a>, <a href="#my_finalizer-visibility">visibility</a>)
</pre>

This macro is a <a href="https://bazel.build/extending/macros#finalizers">rule finalizer</a>.

Finalizes a package.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="my_finalizer-name"></a>name |  A unique name for this macro instance. Normally, this is also the name for the macro's main or only target. The names of any other targets that this macro might create will be this name with a string suffix.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="my_finalizer-ignore_targets"></a>ignore_targets |  Targets to ignore   | <a href="https://bazel.build/concepts/labels">List of labels</a>; <a href="https://bazel.build/reference/be/common-definitions#configurable-attributes">nonconfigurable</a> | optional |  `[]`  |
| <a id="my_finalizer-visibility"></a>visibility |  The visibility to be passed to this macro's exported targets. It always implicitly includes the location where this macro is instantiated, so this attribute only needs to be explicitly set if you want the macro's targets to be additionally visible somewhere else.   | <a href="https://bazel.build/concepts/labels">List of labels</a>; <a href="https://bazel.build/reference/be/common-definitions#configurable-attributes">nonconfigurable</a> | optional |  |


