<nav class="toc">
  <h2>Contents</h2>
  <ul>
    <li><a href="#docstring-formatting">Docstring Formatting</a></li>
    <li><a href="#custom-output">Custom Output</a></li>
    <li><a href="#proto-output">Proto Output</a></li>
  </ul>
</nav>

This document covers a number of advanced topics pertaining to using Stardoc.


<a name="docstring-formatting"></a>
## Docstring Formatting

You may want to inline various kinds of formatting in the docstrings adjacent
to your Starlark code. Use standard markdown formatting constructs instead of
HTML tags.

For example:
```python
def my_function(foo, bar):
  """Does some cool stuff.

  Oh, by the way, have you heard about [Stardoc](https://github.com/bazelbuild/stardoc)?

  Args:
    foo: You don't know what a **foo** is?
    bar: Two variables, `x` and `y`, walk in to a bar...
  """
  ...
```

Markdown formatting constructs are handled appropriately by Stardoc's default
output format ("markdown_tables"), even as part of a table.


<a name="custom-output"></a>
## Custom Output

Stardoc's output format is customizable; while Stardoc's output is markdown
by default, you may define a different output format for your documentation.

Customization is done at the level of "output templates". To customize the
doc output for a particular type of Starlark definition (such as a "rule" or a
"function"), you will need to:

1. Create a new custom output template to describe how this type of object should
   be rendered.
2. In your `stardoc()` target, set the matching `_template` attribute to point to
   your new output template.

For example, you might want to change the way rule documentation is generated.
You might create a new output template file `package/rule.vm` and then define your
`stardoc` target as follows:

```python
stardoc(
    name = "my_docs",
    input = "my_rule.bzl",
    out = "my_rule_doc.md",
    rule_template = "//package:rule.vm",
)
```

The default values for the available templates may be found under
[templates/markdown_tables](../stardoc/templates/markdown_tables). See the
[Stardoc rule documentation](stardoc_rule.md) for a comprehensive list of which
'_template' attributes are available.


### Writing a custom output template

Stardoc's output templates are defined using
[Velocity Template Language (VTL)](https://velocity.apache.org/engine/1.7/user-guide.html)
with utilities and model objects available in the evaluation context.

The full comprehensive list of available utilities top-level objects is available in
[the source for MarkdownRenderer](https://github.com/bazelbuild/bazel/blob/3fcfbe14ddec34889c5e3fe33415af2cf9124e7c/src/main/java/com/google/devtools/build/skydoc/rendering/MarkdownRenderer.java#L100).

Information available for raw model objects (such rule information) is defined by
Stardoc's underlying [proto schema](https://github.com/bazelbuild/bazel/blob/5eeccd8a647df10d154d3b86e9732e7f263c96db/src/main/java/com/google/devtools/build/skydoc/rendering/proto/stardoc_output.proto).

This is a particularly advanced feature of Stardoc, so we would recommend using
one of the existing canonical [templates](../stardoc/templates/markdown_tables) as a
springboard to get started.


<a name="proto-output"></a>
## Proto Output

Stardoc provides the option to output documentation information in raw proto
format. You may find this useful if you need output customization beyond
Stardoc's current custom-output-template capabilities: you might prefer to build
your own custom output renderer binary using the data that Stardoc acquires by
fully evaluating a Starlark file. If your changes could be incorporated into
Stardoc, please first consider [contributing](contributing.md) instead.

The proto schema may be found under
[stardoc/proto/stardoc_output.proto](../stardoc/proto/stardoc_output.proto).
Only the `.proto` file itself is provided (this prevents a transitive dependency on
proto rules to support only a very-advanced usecase). We recommend using rules
defined under
[bazelbuild/rules_proto](https://github.com/bazelbuild/rules_proto), creating
your own proto target using this source file, and adding it as a dependency of
your renderer binary.

To configure stardoc to output raw proto instead of markdown, use the `format`
attribute of the [stardoc rule](stardoc_rule.md#stardoc-format). Specify `"proto"`.
An example:

```python
stardoc(
    name = "docs_proto_output",
    out = "doc_output.raw",
    input = ":my_rule.bzl",
    deps = [":my_lib"],
    format = "proto",
)

# Define a proto_library target to incorporate the stardoc_output_proto
proto_library(
    name = "stardoc_output_proto",
    srcs = ["@io_bazel_stardoc//stardoc/proto:stardoc_output.proto"],
)

# You'll need to define your own rendering target. This might be a
# `genrule` or your own custom rule.
genrule(
    name = "docs_markdown_output",
    tools = ["my_renderer.sh"],
    srcs = ["doc_output.raw"],
    outs = ["doc_output.md"],
    cmd = "$(location :my_renderer.sh) $@ $(SRCS)",
)
```
