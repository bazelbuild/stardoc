"""Input file to test angle bracket bug (https://github.com/bazelbuild/skydoc/issues/186)"""

def bracket_function(name):
    """Dummy docstring with <brackets>.

    This rule runs checks on <angle brackets>.

    Args:
        name: an arg with **formatted** docstring.

    Returns:
        some <angled> brackets

    """
    _ignore = name  # @unused
    pass

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
