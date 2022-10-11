"""Input file to test <angle bracket bugs>

See https://github.com/bazelbuild/skydoc/issues/186,
https://github.com/bazelbuild/stardoc/issues/132,
and https://github.com/bazelbuild/stardoc/issues/137.

<Angle brackets> need to be escaped in some contexts.
They also need to _not_ be escaped when they're enclosed
in a `<code block>`.
"""

def bracket_function(param = "<default>", md_string = "`1<<10`"):
    """Dummy docstring with <brackets>.

    This rule runs checks on <angle brackets>.

    Sometimes, we have such things on their own, but they may
    also appear in code blocks, like

    ```starlark
    foo = "<thing>"
    ```

    Args:
        param: an arg with **formatted** docstring, <default> by default.
        md_string: A markdown string.

    Returns:
        some <angled> brackets

    Deprecated:
        deprecated for <reasons> as well as `<reasons>`.
    """
    return param or md_string

# buildifier: disable=unsorted-dict-items
bracketuse = provider(
    doc = "Information with <brackets>",
    fields = {
        "foo": "A string representing <foo>",
        "bar": "A string representing bar",
        "baz": "A string representing baz",
    },
)

def _rule_impl(ctx):
    _ignore = [ctx]  # @unused
    return []

my_anglebrac = rule(
    implementation = _rule_impl,
    doc = "Rule with <brackets>",
    attrs = {
        "useless": attr.string(
            doc = "Args with some tags: <tag1>, <tag2>",
            default = "Find <brackets>",
        ),
        "also_useless": attr.string(
            doc = "Args with some formatted tags: `<tag>`",
            default = "1<<5",
        ),
    },
)

def _bracket_aspect_impl(ctx):
    _ignore = [ctx]  # @unused
    return []

bracket_aspect = aspect(
    implementation = _bracket_aspect_impl,
    doc = """Aspect.

Sometimes, we want a code block like
```starlark
foo = "<brackets>"
```
which includes angle brackets.
""",
    attr_aspects = ["deps"],
    attrs = {
        "brackets": attr.string(
            doc = "Attribute with <brackets>",
            default = "<default>",
        ),
    },
)
