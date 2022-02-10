# buildifier: disable=module-docstring
def my_rule_impl(ctx):
    _unused = ctx  # @unused
    return []

my_rule = rule(
    implementation = my_rule_impl,
    doc = "This is my rule. It does stuff.",
    attrs = {
        "first": attr.label(mandatory = True, allow_single_file = True),
        "second": attr.string_dict(mandatory = True),
    },
)

# buildifier: disable=unsorted-dict-items
other_rule = rule(
    implementation = my_rule_impl,
    doc = "This is another rule.",
    attrs = {
        "third": attr.label(mandatory = True, allow_single_file = True),
        "_hidden": attr.string(),
        "fourth": attr.string_dict(mandatory = True),
    },
)

# buildifier: disable=unsorted-dict-items
yet_another_rule = rule(
    implementation = my_rule_impl,
    doc = "This is yet another rule",
    attrs = {
        "_hidden": attr.string(),
        "fifth": attr.label(mandatory = True, allow_single_file = True),
    },
)
