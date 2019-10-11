<nav class="toc">
  <h2>Contents</h2>
  <ul>
    <li><a href="#rule-documentation">Rule Documentation</a></li>
    <li><a href="#provider-documentation">Provider Documentation</a></li>
    <li><a href="#macro-documentation">Macro / Function Documentation</a></li>
  </ul>
</nav>

When generating documentation, Stardoc parses the `.bzl` file to extract the
inline documentation as well as evaluates the Starlark code to determine the
types for rule attributes. Stardoc will, by default, generate documentation for
all rules, macros, and functions reachable from a target `.bzl` file.
See [Generating Stardoc](generating_stardoc.md) for details on limiting the
symbols for which stardoc generates documentation.

<a name="rule-documentation"></a>
## Rule Documentation

When generating documentation, Stardoc parses the `.bzl` file to extract the
inline documentation as well as evaluates the Starlark code to determine the
types for rule attributes.

Private rule attributes (attributes with names that begin with `_`) will not
appear in generated documentation.

[Starlark Rules](https://bazel.build/docs/skylark/rules.html) are declared using
the `rule()` function as global variables.

General rule documentation should be supplied in the `doc` parameter of the
`rule()` function.

Likewise, supply attribute documentation in the `doc` parameter of attribute
schema-defining functions, such as `attr.label()`.

```python
my_rule = rule(
    implementation = _my_rule_impl,
    doc = """
Example rule documentation.

Example:
  Here is an example of how to use this rule.
""",
    attrs = {
        "srcs" : attr.label_list(
            doc = "Source files used to build this target.",
        ),
        "deps" : attr.label_list(
            doc = "Dependencies for this target.",
        ),
    }
)
```

The `name` attribute that is common to all rules is documented by default.

<a name="provider-documentation"></a>
## Provider Documentation

[Starlark Providers](https://docs.bazel.build/versions/master/skylark/rules.html#providers)
are documented similarly to rules: using docstrings specified as parameters during
creation of the provider.

General provider documentation can be specified using the `doc` parameter
to the `provider()` function.

Field-related documentation can be specified by passing a map to the
`fields` parameter of the `provider()` function. Keys are required field
names, and values are their corresponding docstrings.

```python
MyInfo = provider(
    doc = """
A provider with some really neat documentation.

Contains information about some of my favorite things.
""",
    fields = {'favorite_food' : 'A string representing my favorite food',
              'favorite_color' : 'A string representing my favorite color'}
)
```

<a name="macro-documentation"></a>
## Macro / Function Documentation

Functions and [Starlark Macros](https://bazel.build/docs/skylark/macros.html) are documented
using docstrings similar to Python docstring format:

```python
def rat_check(name, srcs=[], format, visibility):
  """Runs Apache Rat license checks on the given source files.

  This rule runs [Apache Rat](http://creadur.apache.org/rat/) license checks on
  a given set of source files. Use `bazel build` to run the check.

  Args:
    name: A unique name for this rule.
    srcs: Source files to run the Rat license checks against.

      Note that the Bazel glob() function can be used to specify which source
      files to include and which to exclude.
    format: The format to write the Rat check report in.
    visibility: The visibility of this rule.
  """
  if format not in ['text', 'html', 'xml']:
    fail('Invalid format: %s' % format, 'format')

  _rat_check(
      name = name,
      srcs = srcs,
      format = format,
      visibility = visibility,
  )
```

Parameters are documented in a special `Args:` section. Begin the documentation
for each parameter on an indented line with the parameter name followed by a
colon `:`. The documentation for a parameter can span multiple lines as long as
each line is indented from the first line.


