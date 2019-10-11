<nav class="toc">
  <h2>Contents</h2>
  <ul>
    <li><a href="#docstring-formatting">Docstring Formatting</a></li>
    <li><a href="#custom-output">Custom Output</a></li>
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


