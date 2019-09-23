<nav class="toc">
  <h2>Contents</h2>
  <ul>
    <li><a href="#single-file">Single File</a></li>
    <li><a href="#files-with-deps">Files with Dependencies</a></li>
    <li><a href="#multiple-files">Multiple Files</a></li>
  </ul>
</nav>

The following are some examples of how to use Stardoc.

<a name="single-file"></a>
## Single File

Suppose you have a project containing Stardoc rules you want to document:

```
[workspace]/
    WORKSPACE
    checkstyle/
        BUILD
        checkstyle.bzl
```

To generate documentation for the rules in `checkstyle.bzl`, add the
following target to `rules/BUILD`:

```python
load("@io_bazel_stardoc//stardoc:stardoc.bzl", "stardoc")

stardoc(
    name = "checkstyle-docs",
    input = "checkstyle.bzl",
    out = "checkstyle_doc.md",
)
```

Running `bazel build //checkstyle:checkstyle-docs` will generate a markdown file
containing documentation for all Starlark rules defined in `checkstyle.bzl`.

To generate a subset of rules defined in `checkstyle.bzl`, you may specify which
rule names you specifically want documentation for using the `symbol_names` attribute
of the `stardoc` rule. If `symbol_names` is specified, only rules matching a name
in `symbol_names` will be documented:

```python
load("@io_bazel_stardoc//stardoc:stardoc.bzl", "stardoc")

stardoc(
    name = "checkstyle-docs",
    input = "checkstyle.bzl",
    out = "checkstyle_doc.md",
    symbol_names = ["checkstyle_rule", "other_rule"],
)
```

<a name="files-with-deps"></a>
## Files with Dependencies

If you would like to generate documentation for a `.bzl` with dependencies on
other `.bzl` files, use the `bzl_library` rule to create logical collections of
Starlark sources and depend on these libraries via the `deps` attribute of your
`stardoc` target.

Suppose your project has the following structure:

```
[workspace]/
    WORKSPACE
    BUILD
    checkstyle/
        BUILD
        checkstyle.bzl
    lua/
        BUILD
        lua.bzl
        luarocks.bzl
```

...and suppose your target `.bzl` file depends on other `.bzl` files in your workspace:

`checkstyle/checkstyle.bzl`:

```python
load("//lua:lua.bzl", "lua_utility")

lua_utility()

checkstyle_rule = rule(
    ...
)
```

In this case, you can have a `bzl_library` target in `lua/BUILD`:

`lua/BUILD`:

```python
load("@bazel_skylib//:bzl_library.bzl", "bzl_library")

bzl_library(
    name = "lua-rules",
    srcs = [
        "lua.bzl",
        "luarocks.bzl",
    ],
)
```

To build documentation for `checkstyle.bzl`, specify the `bzl_library` target
as a dependency of the `stardoc` target:

`checkstyle/BUILD`:

```python
load("@io_bazel_stardoc//stardoc:stardoc.bzl", "stardoc")

stardoc(
    name = "checkstyle-docs",
    input = "checkstyle.bzl",
    out = "checkstyle_doc.md",
    deps = ["//lua:lua-rules"],
)
```

<a name="multiple-files"></a>
## Multiple Files

If you would like to generate documentation for multiple .bzl files in various
packages in your workspace, you will need to create a single `.bzl` file that depends
on all those `.bzl` files. You can then explicitly whitelist rules for which you would
like documentation to be generated.

For example, you may want to generate documentation for `foo_rule`, `bar_rule`, and
`baz_rule`, all in different `.bzl` files. First, you would create a single `.bzl` file
which loads these files:

`doc_hub.bzl`:

```python
load("//foo:foo.bzl", "foo_rule")
load("//bar:bar.bzl", "bar_rule")
load("//baz:baz.bzl", "baz_rule")

# No need for any implementation here. The rules need only be loaded.
```

A single `stardoc` target can then be used to generate their documentation:

`BUILD`:

```python
load("@io_bazel_stardoc//stardoc:stardoc.bzl", "stardoc")

stardoc(
    name = "my-docs",
    input = "doc_hub.bzl",
    out = "docs.md",
    symbol_names = ["foo_rule", "bar_rule", "baz_rule"],
)
```


