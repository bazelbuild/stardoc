<!-- Generated with Stardoc: http://skydoc.bazel.build -->

<a id="#check_struct_default_values"></a>

## check_struct_default_values

<pre>
check_struct_default_values(<a href="#check_struct_default_values-struct_no_args">struct_no_args</a>, <a href="#check_struct_default_values-struct_arg">struct_arg</a>, <a href="#check_struct_default_values-struct_args">struct_args</a>, <a href="#check_struct_default_values-struct_int_args">struct_int_args</a>,
                            <a href="#check_struct_default_values-struct_struct_args">struct_struct_args</a>)
</pre>

Checks the default values of structs.

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="check_struct_default_values-struct_no_args"></a>struct_no_args |  struct with no arguments   |  <code>struct()</code> |
| <a id="check_struct_default_values-struct_arg"></a>struct_arg |  struct with one argument   |  <code>struct(foo = "bar")</code> |
| <a id="check_struct_default_values-struct_args"></a>struct_args |  struct with multiple arguments   |  <code>struct(bar = "foo", foo = "bar")</code> |
| <a id="check_struct_default_values-struct_int_args"></a>struct_int_args |  struct with int arguments   |  <code>struct(one = 1, three = 3, two = 2)</code> |
| <a id="check_struct_default_values-struct_struct_args"></a>struct_struct_args |  struct with struct arguments   |  <code>struct(multiple = struct(one = 1, three = 3, two = 2), none = struct(), one = struct(foo = "bar"))</code> |


