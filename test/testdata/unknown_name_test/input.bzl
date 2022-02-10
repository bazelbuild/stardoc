# buildifier: disable=module-docstring
def my_rule_impl(ctx):
    _ignore = [ctx]  # @unused
    return []

# buildifier: disable=unsorted-dict-items
rule(
    implementation = my_rule_impl,
    attrs = {
        "first": attr.label(mandatory = True, allow_single_file = True),
        "second": attr.string_dict(mandatory = True),
        "third": attr.output(mandatory = True),
        "fourth": attr.bool(default = False, mandatory = False),
    },
)
