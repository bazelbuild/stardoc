<!-- Generated with Stardoc: http://skydoc.bazel.build -->

Test rules / providers / etc for the table of contents generation test.


## Rules

- [my_rule](#my_rule)

## Providers

- [MyFooInfo](#MyFooInfo)
- [MyVeryDocumentedInfo](#MyVeryDocumentedInfo)

## Functions

- [check_sources](#check_sources)
- [returns_a_thing](#returns_a_thing)

## Aspects

- [my_aspect](#my_aspect)
- [other_aspect](#other_aspect)

## Repository Rules

- [my_repo](#my_repo)

## Module Extensions

- [my_ext](#my_ext)


<a id="my_rule"></a>

## my_rule

<pre>
load("@stardoc//test:testdata/table_of_contents_test/input.bzl", "my_rule")

my_rule(<a href="#my_rule-name">name</a>, <a href="#my_rule-first">first</a>, <a href="#my_rule-fourth">fourth</a>, <a href="#my_rule-second">second</a>, <a href="#my_rule-third">third</a>)
</pre>

This is my rule. It does stuff.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="my_rule-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="my_rule-first"></a>first |  first doc string   | <a href="https://bazel.build/concepts/labels">Label</a> | required |  |
| <a id="my_rule-fourth"></a>fourth |  fourth doc string   | Boolean | optional |  `False`  |
| <a id="my_rule-second"></a>second |  -   | <a href="https://bazel.build/rules/lib/dict">Dictionary: String -> String</a> | required |  |
| <a id="my_rule-third"></a>third |  -   | <a href="https://bazel.build/concepts/labels">Label</a> | required |  |


<a id="MyFooInfo"></a>

## MyFooInfo

<pre>
load("@stardoc//test:testdata/table_of_contents_test/input.bzl", "MyFooInfo")

MyFooInfo(<a href="#MyFooInfo-bar">bar</a>, <a href="#MyFooInfo-baz">baz</a>)
</pre>

Stores information about a foo.

**FIELDS**

| Name  | Description |
| :------------- | :------------- |
| <a id="MyFooInfo-bar"></a>bar |  -    |
| <a id="MyFooInfo-baz"></a>baz |  -    |


<a id="MyVeryDocumentedInfo"></a>

## MyVeryDocumentedInfo

<pre>
load("@stardoc//test:testdata/table_of_contents_test/input.bzl", "MyVeryDocumentedInfo")

MyVeryDocumentedInfo(<a href="#MyVeryDocumentedInfo-favorite_food">favorite_food</a>, <a href="#MyVeryDocumentedInfo-favorite_color">favorite_color</a>)
</pre>

A provider with some really neat documentation.

Look on my works, ye mighty, and despair!

**FIELDS**

| Name  | Description |
| :------------- | :------------- |
| <a id="MyVeryDocumentedInfo-favorite_food"></a>favorite_food |  A string representing my favorite food<br><br>Expected to be delicious.    |
| <a id="MyVeryDocumentedInfo-favorite_color"></a>favorite_color |  A string representing my favorite color    |


<a id="check_sources"></a>

## check_sources

<pre>
load("@stardoc//test:testdata/table_of_contents_test/input.bzl", "check_sources")

check_sources(<a href="#check_sources-name">name</a>, <a href="#check_sources-required_param">required_param</a>, <a href="#check_sources-bool_param">bool_param</a>, <a href="#check_sources-srcs">srcs</a>, <a href="#check_sources-string_param">string_param</a>, <a href="#check_sources-int_param">int_param</a>, <a href="#check_sources-dict_param">dict_param</a>,
              <a href="#check_sources-struct_param">struct_param</a>)
</pre>

Runs some checks on the given source files.

This rule runs checks on a given set of source files.
Use `bazel build` to run the check.


**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="check_sources-name"></a>name |  A unique name for this rule.   |  none |
| <a id="check_sources-required_param"></a>required_param |  Use your imagination.   |  none |
| <a id="check_sources-bool_param"></a>bool_param |  <p align="center"> - </p>   |  `True` |
| <a id="check_sources-srcs"></a>srcs |  Source files to run the checks against.   |  `[]` |
| <a id="check_sources-string_param"></a>string_param |  <p align="center"> - </p>   |  `""` |
| <a id="check_sources-int_param"></a>int_param |  Your favorite number.   |  `2` |
| <a id="check_sources-dict_param"></a>dict_param |  <p align="center"> - </p>   |  `{}` |
| <a id="check_sources-struct_param"></a>struct_param |  <p align="center"> - </p>   |  `struct(foo = "bar")` |


<a id="returns_a_thing"></a>

## returns_a_thing

<pre>
load("@stardoc//test:testdata/table_of_contents_test/input.bzl", "returns_a_thing")

returns_a_thing(<a href="#returns_a_thing-name">name</a>)
</pre>

Returns a suffixed name.

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="returns_a_thing-name"></a>name |  A unique name for this rule.   |  none |

**RETURNS**

A suffixed version of the name.


<a id="my_aspect"></a>

## my_aspect

<pre>
load("@stardoc//test:testdata/table_of_contents_test/input.bzl", "my_aspect")

my_aspect(<a href="#my_aspect-first">first</a>, <a href="#my_aspect-second">second</a>)
</pre>

This is my aspect.

It does stuff.

**ASPECT ATTRIBUTES**


| Name | Type |
| :------------- | :------------- |
| deps| String |
| attr_aspect| String |


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="my_aspect-first"></a>first |  -   | Boolean | required |  |
| <a id="my_aspect-second"></a>second |  -   | String | required |  |


<a id="other_aspect"></a>

## other_aspect

<pre>
load("@stardoc//test:testdata/table_of_contents_test/input.bzl", "other_aspect")

other_aspect(<a href="#other_aspect-third">third</a>)
</pre>

This is another aspect.

**ASPECT ATTRIBUTES**



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="other_aspect-third"></a>third |  -   | Integer | required |  |


<a id="my_repo"></a>

## my_repo

<pre>
load("@stardoc//test:testdata/table_of_contents_test/input.bzl", "my_repo")

my_repo(<a href="#my_repo-name">name</a>, <a href="#my_repo-repo_mapping">repo_mapping</a>, <a href="#my_repo-useless">useless</a>)
</pre>

Minimal example of a repository rule.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="my_repo-name"></a>name |  A unique name for this repository.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="my_repo-repo_mapping"></a>repo_mapping |  In `WORKSPACE` context only: a dictionary from local repository name to global repository name. This allows controls over workspace dependency resolution for dependencies of this repository.<br><br>For example, an entry `"@foo": "@bar"` declares that, for any time this repository depends on `@foo` (such as a dependency on `@foo//some:target`, it should actually resolve that dependency within globally-declared `@bar` (`@bar//some:target`).<br><br>This attribute is _not_ supported in `MODULE.bazel` context (when invoking a repository rule inside a module extension's implementation function).   | <a href="https://bazel.build/rules/lib/dict">Dictionary: String -> String</a> | optional |  |
| <a id="my_repo-useless"></a>useless |  This argument will be ignored.<br><br>You don't have to specify it, but you may.   | String | optional |  `"ignoreme"`  |

**ENVIRONMENT VARIABLES**

This repository rule depends on the following environment variables:

* `FOO_CC`
* `BAR_PATH`


<a id="my_ext"></a>

## my_ext

<pre>
my_ext = use_extension("@stardoc//test:testdata/table_of_contents_test/input.bzl", "my_ext")
my_ext.install(<a href="#my_ext.install-artifacts">artifacts</a>)
my_ext.artifact(<a href="#my_ext.artifact-artifact">artifact</a>, <a href="#my_ext.artifact-group">group</a>)
</pre>

Minimal example of a module extension.


**TAG CLASSES**

<a id="my_ext.install"></a>

### install

Install tag

**Attributes**

| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="my_ext.install-artifacts"></a>artifacts |  Install artifacts   | List of strings | optional |  `[]`  |

<a id="my_ext.artifact"></a>

### artifact

Artifact tag

**Attributes**

| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="my_ext.artifact-artifact"></a>artifact |  Artifact   | String | required |  |
| <a id="my_ext.artifact-group"></a>group |  Group name   | String | optional |  `"my_group"`  |


