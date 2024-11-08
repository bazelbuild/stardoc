# buildifier: disable=module-docstring
# buildifier: disable=function-docstring
def exercise_the_api():
    var1 = apple_common.platform_type  # @unused
    var2 = apple_common.XcodeVersionConfig  # @unused

exercise_the_api()

# buildifier: disable=rule-impl-return
def my_rule_impl(ctx):
    _ignore = [ctx]  # @unused
    return struct()

# buildifier: disable=unsorted-dict-items
apple_related_rule = rule(
    implementation = my_rule_impl,
    doc = "This rule does apple-related things.",
    attrs = {
        "first": attr.label(mandatory = True, allow_single_file = True),
        "second": attr.string_dict(mandatory = True),
        "third": attr.output(mandatory = True),
        "fourth": attr.bool(default = False, mandatory = False),
    },
)
