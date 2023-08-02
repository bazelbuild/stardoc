"""The input file for the aspect test"""

def my_aspect_impl(ctx):
    _ignore = [ctx]  # @unused
    return []

my_aspect = aspect(
    implementation = my_aspect_impl,
    doc = """
    This is my aspect.

    It does stuff.
    """,
    attr_aspects = ["deps", "attr_aspect"],
    attrs = {
        "first": attr.bool(mandatory = True),
        "second": attr.string(mandatory = True),
    },
)

# buildifier: disable=unsorted-dict-items
other_aspect = aspect(
    implementation = my_aspect_impl,
    doc = "This is another aspect.",
    attr_aspects = ["*"],
    attrs = {
        "_hidden": attr.string(),
        "third": attr.int(mandatory = True),
    },
)
