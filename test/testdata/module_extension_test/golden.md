<!-- Generated with Stardoc: http://skydoc.bazel.build -->

Minimal example of a .bzl file defining a module extension.

<a id="my_ext"></a>

## my_ext

<pre>
my_ext = use_extension("@io_bazel_stardoc//test:testdata/module_extension_test/input.bzl", "my_ext")
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


