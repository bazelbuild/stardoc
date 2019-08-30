# buildifier: disable=module-docstring
def my_rule_impl(ctx):
    return []

rule(
    implementation = my_rule_impl,
    attrs = {
        "first": attr.label(mandatory = True, allow_single_file = True),
        "second": attr.string_dict(mandatory = True),
        "third": attr.output(mandatory = True),
        "fourth": attr.bool(default = False, mandatory = False),
    },
)
