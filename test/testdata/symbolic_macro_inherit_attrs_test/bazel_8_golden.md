<!-- Generated with Stardoc: http://skydoc.bazel.build -->

Symbolic macro attribute inheritance tests

<a id="inherit_from_common"></a>

## inherit_from_common

<pre>
load("@stardoc//test:testdata/symbolic_macro_inherit_attrs_test/input.bzl", "inherit_from_common")

inherit_from_common(*, <a href="#inherit_from_common-name">name</a>, <a href="#inherit_from_common-srcs">srcs</a>, <a href="#inherit_from_common-compatible_with">compatible_with</a>, <a href="#inherit_from_common-deprecation">deprecation</a>, <a href="#inherit_from_common-exec_compatible_with">exec_compatible_with</a>,
                    <a href="#inherit_from_common-exec_properties">exec_properties</a>, <a href="#inherit_from_common-features">features</a>, <a href="#inherit_from_common-package_metadata">package_metadata</a>, <a href="#inherit_from_common-restricted_to">restricted_to</a>, <a href="#inherit_from_common-tags">tags</a>,
                    <a href="#inherit_from_common-target_compatible_with">target_compatible_with</a>, <a href="#inherit_from_common-testonly">testonly</a>, <a href="#inherit_from_common-toolchains">toolchains</a>, <a href="#inherit_from_common-visibility">visibility</a>)
</pre>

InheritFromCommon: Initializes some targets.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="inherit_from_common-name"></a>name |  A unique name for this macro instance. Normally, this is also the name for the macro's main or only target. The names of any other targets that this macro might create will be this name with a string suffix.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="inherit_from_common-srcs"></a>srcs |  Source files   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `[]`  |
| <a id="inherit_from_common-compatible_with"></a>compatible_with |  <a href="https://bazel.build/reference/be/common-definitions#common.compatible_with">Inherited rule attribute</a>   | <a href="https://bazel.build/concepts/labels">List of labels</a>; <a href="https://bazel.build/reference/be/common-definitions#configurable-attributes">nonconfigurable</a> | optional |  `None`  |
| <a id="inherit_from_common-deprecation"></a>deprecation |  <a href="https://bazel.build/reference/be/common-definitions#common.deprecation">Inherited rule attribute</a>   | String; <a href="https://bazel.build/reference/be/common-definitions#configurable-attributes">nonconfigurable</a> | optional |  `None`  |
| <a id="inherit_from_common-exec_compatible_with"></a>exec_compatible_with |  <a href="https://bazel.build/reference/be/common-definitions#common.exec_compatible_with">Inherited rule attribute</a>   | <a href="https://bazel.build/concepts/labels">List of labels</a>; <a href="https://bazel.build/reference/be/common-definitions#configurable-attributes">nonconfigurable</a> | optional |  `None`  |
| <a id="inherit_from_common-exec_properties"></a>exec_properties |  <a href="https://bazel.build/reference/be/common-definitions#common.exec_properties">Inherited rule attribute</a>   | <a href="https://bazel.build/rules/lib/core/dict">Dictionary: String -> String</a> | optional |  `None`  |
| <a id="inherit_from_common-features"></a>features |  <a href="https://bazel.build/reference/be/common-definitions#common.features">Inherited rule attribute</a>   | List of strings | optional |  `None`  |
| <a id="inherit_from_common-package_metadata"></a>package_metadata |  <a href="https://bazel.build/reference/be/common-definitions#common.package_metadata">Inherited rule attribute</a>   | <a href="https://bazel.build/concepts/labels">List of labels</a>; <a href="https://bazel.build/reference/be/common-definitions#configurable-attributes">nonconfigurable</a> | optional |  `None`  |
| <a id="inherit_from_common-restricted_to"></a>restricted_to |  <a href="https://bazel.build/reference/be/common-definitions#common.restricted_to">Inherited rule attribute</a>   | <a href="https://bazel.build/concepts/labels">List of labels</a>; <a href="https://bazel.build/reference/be/common-definitions#configurable-attributes">nonconfigurable</a> | optional |  `None`  |
| <a id="inherit_from_common-tags"></a>tags |  <a href="https://bazel.build/reference/be/common-definitions#common.tags">Inherited rule attribute</a>   | List of strings; <a href="https://bazel.build/reference/be/common-definitions#configurable-attributes">nonconfigurable</a> | optional |  `None`  |
| <a id="inherit_from_common-target_compatible_with"></a>target_compatible_with |  <a href="https://bazel.build/reference/be/common-definitions#common.target_compatible_with">Inherited rule attribute</a>   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `None`  |
| <a id="inherit_from_common-testonly"></a>testonly |  <a href="https://bazel.build/reference/be/common-definitions#common.testonly">Inherited rule attribute</a>   | Boolean; <a href="https://bazel.build/reference/be/common-definitions#configurable-attributes">nonconfigurable</a> | optional |  `None`  |
| <a id="inherit_from_common-toolchains"></a>toolchains |  <a href="https://bazel.build/reference/be/common-definitions#common.toolchains">Inherited rule attribute</a>   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `None`  |
| <a id="inherit_from_common-visibility"></a>visibility |  The visibility to be passed to this macro's exported targets. It always implicitly includes the location where this macro is instantiated, so this attribute only needs to be explicitly set if you want the macro's targets to be additionally visible somewhere else.   | <a href="https://bazel.build/concepts/labels">List of labels</a>; <a href="https://bazel.build/reference/be/common-definitions#configurable-attributes">nonconfigurable</a> | optional |  |


<a id="inherit_from_macro"></a>

## inherit_from_macro

<pre>
load("@stardoc//test:testdata/symbolic_macro_inherit_attrs_test/input.bzl", "inherit_from_macro")

inherit_from_macro(*, <a href="#inherit_from_macro-name">name</a>, <a href="#inherit_from_macro-deps">deps</a>, <a href="#inherit_from_macro-srcs">srcs</a>, <a href="#inherit_from_macro-args">args</a>, <a href="#inherit_from_macro-visibility">visibility</a>)
</pre>

InheritFromMacro: Initializes some targets.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="inherit_from_macro-name"></a>name |  A unique name for this macro instance. Normally, this is also the name for the macro's main or only target. The names of any other targets that this macro might create will be this name with a string suffix.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="inherit_from_macro-deps"></a>deps |  Dependencies   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `None`  |
| <a id="inherit_from_macro-srcs"></a>srcs |  Source files   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `[]`  |
| <a id="inherit_from_macro-args"></a>args |  Arguments   | List of strings | required |  |
| <a id="inherit_from_macro-visibility"></a>visibility |  The visibility to be passed to this macro's exported targets. It always implicitly includes the location where this macro is instantiated, so this attribute only needs to be explicitly set if you want the macro's targets to be additionally visible somewhere else.   | <a href="https://bazel.build/concepts/labels">List of labels</a>; <a href="https://bazel.build/reference/be/common-definitions#configurable-attributes">nonconfigurable</a> | optional |  |


<a id="inherit_from_macro_no_doc"></a>

## inherit_from_macro_no_doc

<pre>
load("@stardoc//test:testdata/symbolic_macro_inherit_attrs_test/input.bzl", "inherit_from_macro_no_doc")

inherit_from_macro_no_doc(*, <a href="#inherit_from_macro_no_doc-name">name</a>, <a href="#inherit_from_macro_no_doc-deps">deps</a>, <a href="#inherit_from_macro_no_doc-srcs">srcs</a>, <a href="#inherit_from_macro_no_doc-args">args</a>, <a href="#inherit_from_macro_no_doc-visibility">visibility</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="inherit_from_macro_no_doc-name"></a>name |  A unique name for this macro instance. Normally, this is also the name for the macro's main or only target. The names of any other targets that this macro might create will be this name with a string suffix.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="inherit_from_macro_no_doc-deps"></a>deps |  Dependencies   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `None`  |
| <a id="inherit_from_macro_no_doc-srcs"></a>srcs |  Source files   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `[]`  |
| <a id="inherit_from_macro_no_doc-args"></a>args |  Arguments   | List of strings | required |  |
| <a id="inherit_from_macro_no_doc-visibility"></a>visibility |  The visibility to be passed to this macro's exported targets. It always implicitly includes the location where this macro is instantiated, so this attribute only needs to be explicitly set if you want the macro's targets to be additionally visible somewhere else.   | <a href="https://bazel.build/concepts/labels">List of labels</a>; <a href="https://bazel.build/reference/be/common-definitions#configurable-attributes">nonconfigurable</a> | optional |  |


<a id="inherit_from_rule"></a>

## inherit_from_rule

<pre>
load("@stardoc//test:testdata/symbolic_macro_inherit_attrs_test/input.bzl", "inherit_from_rule")

inherit_from_rule(*, <a href="#inherit_from_rule-name">name</a>, <a href="#inherit_from_rule-deps">deps</a>, <a href="#inherit_from_rule-srcs">srcs</a>, <a href="#inherit_from_rule-args">args</a>, <a href="#inherit_from_rule-compatible_with">compatible_with</a>, <a href="#inherit_from_rule-deprecation">deprecation</a>, <a href="#inherit_from_rule-exec_compatible_with">exec_compatible_with</a>,
                  <a href="#inherit_from_rule-exec_properties">exec_properties</a>, <a href="#inherit_from_rule-features">features</a>, <a href="#inherit_from_rule-package_metadata">package_metadata</a>, <a href="#inherit_from_rule-restricted_to">restricted_to</a>, <a href="#inherit_from_rule-tags">tags</a>,
                  <a href="#inherit_from_rule-target_compatible_with">target_compatible_with</a>, <a href="#inherit_from_rule-testonly">testonly</a>, <a href="#inherit_from_rule-toolchains">toolchains</a>, <a href="#inherit_from_rule-visibility">visibility</a>)
</pre>

InheritFromRule: Initializes some targets.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="inherit_from_rule-name"></a>name |  A unique name for this macro instance. Normally, this is also the name for the macro's main or only target. The names of any other targets that this macro might create will be this name with a string suffix.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="inherit_from_rule-deps"></a>deps |  Dependencies   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `None`  |
| <a id="inherit_from_rule-srcs"></a>srcs |  Source files   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `[]`  |
| <a id="inherit_from_rule-args"></a>args |  Arguments   | List of strings | required |  |
| <a id="inherit_from_rule-compatible_with"></a>compatible_with |  <a href="https://bazel.build/reference/be/common-definitions#common.compatible_with">Inherited rule attribute</a>   | <a href="https://bazel.build/concepts/labels">List of labels</a>; <a href="https://bazel.build/reference/be/common-definitions#configurable-attributes">nonconfigurable</a> | optional |  `None`  |
| <a id="inherit_from_rule-deprecation"></a>deprecation |  <a href="https://bazel.build/reference/be/common-definitions#common.deprecation">Inherited rule attribute</a>   | String; <a href="https://bazel.build/reference/be/common-definitions#configurable-attributes">nonconfigurable</a> | optional |  `None`  |
| <a id="inherit_from_rule-exec_compatible_with"></a>exec_compatible_with |  <a href="https://bazel.build/reference/be/common-definitions#common.exec_compatible_with">Inherited rule attribute</a>   | <a href="https://bazel.build/concepts/labels">List of labels</a>; <a href="https://bazel.build/reference/be/common-definitions#configurable-attributes">nonconfigurable</a> | optional |  `None`  |
| <a id="inherit_from_rule-exec_properties"></a>exec_properties |  <a href="https://bazel.build/reference/be/common-definitions#common.exec_properties">Inherited rule attribute</a>   | <a href="https://bazel.build/rules/lib/core/dict">Dictionary: String -> String</a> | optional |  `None`  |
| <a id="inherit_from_rule-features"></a>features |  <a href="https://bazel.build/reference/be/common-definitions#common.features">Inherited rule attribute</a>   | List of strings | optional |  `None`  |
| <a id="inherit_from_rule-package_metadata"></a>package_metadata |  <a href="https://bazel.build/reference/be/common-definitions#common.package_metadata">Inherited rule attribute</a>   | <a href="https://bazel.build/concepts/labels">List of labels</a>; <a href="https://bazel.build/reference/be/common-definitions#configurable-attributes">nonconfigurable</a> | optional |  `None`  |
| <a id="inherit_from_rule-restricted_to"></a>restricted_to |  <a href="https://bazel.build/reference/be/common-definitions#common.restricted_to">Inherited rule attribute</a>   | <a href="https://bazel.build/concepts/labels">List of labels</a>; <a href="https://bazel.build/reference/be/common-definitions#configurable-attributes">nonconfigurable</a> | optional |  `None`  |
| <a id="inherit_from_rule-tags"></a>tags |  <a href="https://bazel.build/reference/be/common-definitions#common.tags">Inherited rule attribute</a>   | List of strings; <a href="https://bazel.build/reference/be/common-definitions#configurable-attributes">nonconfigurable</a> | optional |  `None`  |
| <a id="inherit_from_rule-target_compatible_with"></a>target_compatible_with |  <a href="https://bazel.build/reference/be/common-definitions#common.target_compatible_with">Inherited rule attribute</a>   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `None`  |
| <a id="inherit_from_rule-testonly"></a>testonly |  <a href="https://bazel.build/reference/be/common-definitions#common.testonly">Inherited rule attribute</a>   | Boolean; <a href="https://bazel.build/reference/be/common-definitions#configurable-attributes">nonconfigurable</a> | optional |  `None`  |
| <a id="inherit_from_rule-toolchains"></a>toolchains |  <a href="https://bazel.build/reference/be/common-definitions#common.toolchains">Inherited rule attribute</a>   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `None`  |
| <a id="inherit_from_rule-visibility"></a>visibility |  The visibility to be passed to this macro's exported targets. It always implicitly includes the location where this macro is instantiated, so this attribute only needs to be explicitly set if you want the macro's targets to be additionally visible somewhere else.   | <a href="https://bazel.build/concepts/labels">List of labels</a>; <a href="https://bazel.build/reference/be/common-definitions#configurable-attributes">nonconfigurable</a> | optional |  |


<a id="inherit_from_rule_no_doc"></a>

## inherit_from_rule_no_doc

<pre>
load("@stardoc//test:testdata/symbolic_macro_inherit_attrs_test/input.bzl", "inherit_from_rule_no_doc")

inherit_from_rule_no_doc(*, <a href="#inherit_from_rule_no_doc-name">name</a>, <a href="#inherit_from_rule_no_doc-deps">deps</a>, <a href="#inherit_from_rule_no_doc-srcs">srcs</a>, <a href="#inherit_from_rule_no_doc-args">args</a>, <a href="#inherit_from_rule_no_doc-compatible_with">compatible_with</a>, <a href="#inherit_from_rule_no_doc-deprecation">deprecation</a>,
                         <a href="#inherit_from_rule_no_doc-exec_compatible_with">exec_compatible_with</a>, <a href="#inherit_from_rule_no_doc-exec_properties">exec_properties</a>, <a href="#inherit_from_rule_no_doc-features">features</a>, <a href="#inherit_from_rule_no_doc-package_metadata">package_metadata</a>,
                         <a href="#inherit_from_rule_no_doc-restricted_to">restricted_to</a>, <a href="#inherit_from_rule_no_doc-tags">tags</a>, <a href="#inherit_from_rule_no_doc-target_compatible_with">target_compatible_with</a>, <a href="#inherit_from_rule_no_doc-testonly">testonly</a>, <a href="#inherit_from_rule_no_doc-toolchains">toolchains</a>,
                         <a href="#inherit_from_rule_no_doc-visibility">visibility</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="inherit_from_rule_no_doc-name"></a>name |  A unique name for this macro instance. Normally, this is also the name for the macro's main or only target. The names of any other targets that this macro might create will be this name with a string suffix.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="inherit_from_rule_no_doc-deps"></a>deps |  Dependencies   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `None`  |
| <a id="inherit_from_rule_no_doc-srcs"></a>srcs |  Source files   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `[]`  |
| <a id="inherit_from_rule_no_doc-args"></a>args |  Arguments   | List of strings | required |  |
| <a id="inherit_from_rule_no_doc-compatible_with"></a>compatible_with |  <a href="https://bazel.build/reference/be/common-definitions#common.compatible_with">Inherited rule attribute</a>   | <a href="https://bazel.build/concepts/labels">List of labels</a>; <a href="https://bazel.build/reference/be/common-definitions#configurable-attributes">nonconfigurable</a> | optional |  `None`  |
| <a id="inherit_from_rule_no_doc-deprecation"></a>deprecation |  <a href="https://bazel.build/reference/be/common-definitions#common.deprecation">Inherited rule attribute</a>   | String; <a href="https://bazel.build/reference/be/common-definitions#configurable-attributes">nonconfigurable</a> | optional |  `None`  |
| <a id="inherit_from_rule_no_doc-exec_compatible_with"></a>exec_compatible_with |  <a href="https://bazel.build/reference/be/common-definitions#common.exec_compatible_with">Inherited rule attribute</a>   | <a href="https://bazel.build/concepts/labels">List of labels</a>; <a href="https://bazel.build/reference/be/common-definitions#configurable-attributes">nonconfigurable</a> | optional |  `None`  |
| <a id="inherit_from_rule_no_doc-exec_properties"></a>exec_properties |  <a href="https://bazel.build/reference/be/common-definitions#common.exec_properties">Inherited rule attribute</a>   | <a href="https://bazel.build/rules/lib/dict">Dictionary: String -> String</a> | optional |  `None`  |
| <a id="inherit_from_rule_no_doc-features"></a>features |  <a href="https://bazel.build/reference/be/common-definitions#common.features">Inherited rule attribute</a>   | List of strings | optional |  `None`  |
| <a id="inherit_from_rule_no_doc-package_metadata"></a>package_metadata |  <a href="https://bazel.build/reference/be/common-definitions#common.package_metadata">Inherited rule attribute</a>   | <a href="https://bazel.build/concepts/labels">List of labels</a>; <a href="https://bazel.build/reference/be/common-definitions#configurable-attributes">nonconfigurable</a> | optional |  `None`  |
| <a id="inherit_from_rule_no_doc-restricted_to"></a>restricted_to |  <a href="https://bazel.build/reference/be/common-definitions#common.restricted_to">Inherited rule attribute</a>   | <a href="https://bazel.build/concepts/labels">List of labels</a>; <a href="https://bazel.build/reference/be/common-definitions#configurable-attributes">nonconfigurable</a> | optional |  `None`  |
| <a id="inherit_from_rule_no_doc-tags"></a>tags |  <a href="https://bazel.build/reference/be/common-definitions#common.tags">Inherited rule attribute</a>   | List of strings; <a href="https://bazel.build/reference/be/common-definitions#configurable-attributes">nonconfigurable</a> | optional |  `None`  |
| <a id="inherit_from_rule_no_doc-target_compatible_with"></a>target_compatible_with |  <a href="https://bazel.build/reference/be/common-definitions#common.target_compatible_with">Inherited rule attribute</a>   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `None`  |
| <a id="inherit_from_rule_no_doc-testonly"></a>testonly |  <a href="https://bazel.build/reference/be/common-definitions#common.testonly">Inherited rule attribute</a>   | Boolean; <a href="https://bazel.build/reference/be/common-definitions#configurable-attributes">nonconfigurable</a> | optional |  `None`  |
| <a id="inherit_from_rule_no_doc-toolchains"></a>toolchains |  <a href="https://bazel.build/reference/be/common-definitions#common.toolchains">Inherited rule attribute</a>   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `None`  |
| <a id="inherit_from_rule_no_doc-visibility"></a>visibility |  The visibility to be passed to this macro's exported targets. It always implicitly includes the location where this macro is instantiated, so this attribute only needs to be explicitly set if you want the macro's targets to be additionally visible somewhere else.   | <a href="https://bazel.build/concepts/labels">List of labels</a>; <a href="https://bazel.build/reference/be/common-definitions#configurable-attributes">nonconfigurable</a> | optional |  |


<a id="inherit_from_rule_with_overrides"></a>

## inherit_from_rule_with_overrides

<pre>
load("@stardoc//test:testdata/symbolic_macro_inherit_attrs_test/input.bzl", "inherit_from_rule_with_overrides")

inherit_from_rule_with_overrides(*, <a href="#inherit_from_rule_with_overrides-name">name</a>, <a href="#inherit_from_rule_with_overrides-srcs">srcs</a>, <a href="#inherit_from_rule_with_overrides-args">args</a>, <a href="#inherit_from_rule_with_overrides-compatible_with">compatible_with</a>, <a href="#inherit_from_rule_with_overrides-deprecation">deprecation</a>,
                                 <a href="#inherit_from_rule_with_overrides-exec_compatible_with">exec_compatible_with</a>, <a href="#inherit_from_rule_with_overrides-exec_properties">exec_properties</a>, <a href="#inherit_from_rule_with_overrides-features">features</a>, <a href="#inherit_from_rule_with_overrides-package_metadata">package_metadata</a>,
                                 <a href="#inherit_from_rule_with_overrides-restricted_to">restricted_to</a>, <a href="#inherit_from_rule_with_overrides-tags">tags</a>, <a href="#inherit_from_rule_with_overrides-target_compatible_with">target_compatible_with</a>, <a href="#inherit_from_rule_with_overrides-testonly">testonly</a>, <a href="#inherit_from_rule_with_overrides-toolchains">toolchains</a>,
                                 <a href="#inherit_from_rule_with_overrides-visibility">visibility</a>)
</pre>

InheritFromRuleWithOverrides: Initializes some targets.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="inherit_from_rule_with_overrides-name"></a>name |  A unique name for this macro instance. Normally, this is also the name for the macro's main or only target. The names of any other targets that this macro might create will be this name with a string suffix.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="inherit_from_rule_with_overrides-srcs"></a>srcs |  Source files   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `[]`  |
| <a id="inherit_from_rule_with_overrides-args"></a>args |  Override docs for Arguments   | List of strings | required |  |
| <a id="inherit_from_rule_with_overrides-compatible_with"></a>compatible_with |  <a href="https://bazel.build/reference/be/common-definitions#common.compatible_with">Inherited rule attribute</a>   | <a href="https://bazel.build/concepts/labels">List of labels</a>; <a href="https://bazel.build/reference/be/common-definitions#configurable-attributes">nonconfigurable</a> | optional |  `None`  |
| <a id="inherit_from_rule_with_overrides-deprecation"></a>deprecation |  <a href="https://bazel.build/reference/be/common-definitions#common.deprecation">Inherited rule attribute</a>   | String; <a href="https://bazel.build/reference/be/common-definitions#configurable-attributes">nonconfigurable</a> | optional |  `None`  |
| <a id="inherit_from_rule_with_overrides-exec_compatible_with"></a>exec_compatible_with |  <a href="https://bazel.build/reference/be/common-definitions#common.exec_compatible_with">Inherited rule attribute</a>   | <a href="https://bazel.build/concepts/labels">List of labels</a>; <a href="https://bazel.build/reference/be/common-definitions#configurable-attributes">nonconfigurable</a> | optional |  `None`  |
| <a id="inherit_from_rule_with_overrides-exec_properties"></a>exec_properties |  <a href="https://bazel.build/reference/be/common-definitions#common.exec_properties">Inherited rule attribute</a>   | <a href="https://bazel.build/rules/lib/dict">Dictionary: String -> String</a> | optional |  `None`  |
| <a id="inherit_from_rule_with_overrides-features"></a>features |  <a href="https://bazel.build/reference/be/common-definitions#common.features">Inherited rule attribute</a>   | List of strings | optional |  `None`  |
| <a id="inherit_from_rule_with_overrides-package_metadata"></a>package_metadata |  <a href="https://bazel.build/reference/be/common-definitions#common.package_metadata">Inherited rule attribute</a>   | <a href="https://bazel.build/concepts/labels">List of labels</a>; <a href="https://bazel.build/reference/be/common-definitions#configurable-attributes">nonconfigurable</a> | optional |  `None`  |
| <a id="inherit_from_rule_with_overrides-restricted_to"></a>restricted_to |  <a href="https://bazel.build/reference/be/common-definitions#common.restricted_to">Inherited rule attribute</a>   | <a href="https://bazel.build/concepts/labels">List of labels</a>; <a href="https://bazel.build/reference/be/common-definitions#configurable-attributes">nonconfigurable</a> | optional |  `None`  |
| <a id="inherit_from_rule_with_overrides-tags"></a>tags |  <a href="https://bazel.build/reference/be/common-definitions#common.tags">Inherited rule attribute</a>   | List of strings; <a href="https://bazel.build/reference/be/common-definitions#configurable-attributes">nonconfigurable</a> | optional |  `None`  |
| <a id="inherit_from_rule_with_overrides-target_compatible_with"></a>target_compatible_with |  <a href="https://bazel.build/reference/be/common-definitions#common.target_compatible_with">Inherited rule attribute</a>   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `None`  |
| <a id="inherit_from_rule_with_overrides-testonly"></a>testonly |  <a href="https://bazel.build/reference/be/common-definitions#common.testonly">Inherited rule attribute</a>   | Boolean; <a href="https://bazel.build/reference/be/common-definitions#configurable-attributes">nonconfigurable</a> | optional |  `None`  |
| <a id="inherit_from_rule_with_overrides-toolchains"></a>toolchains |  <a href="https://bazel.build/reference/be/common-definitions#common.toolchains">Inherited rule attribute</a>   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `None`  |
| <a id="inherit_from_rule_with_overrides-visibility"></a>visibility |  The visibility to be passed to this macro's exported targets. It always implicitly includes the location where this macro is instantiated, so this attribute only needs to be explicitly set if you want the macro's targets to be additionally visible somewhere else.   | <a href="https://bazel.build/concepts/labels">List of labels</a>; <a href="https://bazel.build/reference/be/common-definitions#configurable-attributes">nonconfigurable</a> | optional |  |


