# buildifier: disable=module-docstring
# buildifier: disable=function-docstring
# buildifier: disable=unused-variable
def exercise_the_api():
    _ignore = android_common.create_device_broker_info("")

exercise_the_api()

def my_rule_impl(ctx):
    _ignore = [ctx]  # @unused
    return []

# buildifier: disable=unsorted-dict-items
android_related_rule = rule(
    implementation = my_rule_impl,
    doc = "This rule does android-related things.",
    attrs = {
        "first": attr.label(mandatory = True, allow_single_file = True),
        "second": attr.string_dict(mandatory = True),
        "third": attr.output(mandatory = True),
        "fourth": attr.bool(default = False, mandatory = False),
    },
)
