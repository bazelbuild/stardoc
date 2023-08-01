<!-- Generated with Stardoc: http://skydoc.bazel.build -->

A simple .bzl file used to test stardoc.

<a id="copy_host_constraints"></a>

## copy_host_constraints

<pre>
copy_host_constraints(<a href="#copy_host_constraints-name">name</a>, <a href="#copy_host_constraints-src">src</a>)
</pre>

Copies the host constraints file.

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="copy_host_constraints-name"></a>name |  The name of the target. The output file will be named `<name>.txt`.   |  none |
| <a id="copy_host_constraints-src"></a>src |  File to copy.   |  `Label("@test_module//:host_constraints")` |


<a id="write_host_constraints"></a>

## write_host_constraints

<pre>
write_host_constraints(<a href="#write_host_constraints-name">name</a>)
</pre>

Emits the constraints of the host platform to a file.

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="write_host_constraints-name"></a>name |  The name of the target. The output file will be named `<name>.txt`.   |  none |


