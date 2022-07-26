"""Input file to test <angle bracket bugs>

See https://github.com/bazelbuild/skydoc/issues/186
and https://github.com/bazelbuild/stardoc/issues/132"""

def bracket_function(param = "<default>"):
    """Dummy docstring with <brackets>.

    This rule runs checks on <angle brackets>.

    Args:
        param: an arg with **formatted** docstring, <default> by default.

    Returns:
        some <angled> brackets

    Deprecated:
        deprecated for <reasons>
    """
    return param

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
    },
)

def _bracket_aspect_impl(ctx):
    _ignore = [ctx]  # @unused
    return []

bracket_aspect = aspect(
    implementation = _bracket_aspect_impl,
    doc = "Aspect with <brackets>",
    attr_aspects = ["deps"],
    attrs = {
        "brackets": attr.string(
            doc = "Attribute with <brackets>",
            default = "<default>",
        ),
    },
)
