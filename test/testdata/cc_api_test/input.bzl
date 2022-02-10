"""Input file for C++ api test"""

def exercise_the_api():
    var1 = CcInfo  # @unused

exercise_the_api()

def my_rule_impl(ctx):
    _ignore = [ctx]  # @unused
    return []

# buildifier: disable=unsorted-dict-items
cpp_related_rule = rule(
    implementation = my_rule_impl,
    doc = "This rule does C++-related things.",
    attrs = {
        "first": attr.label(mandatory = True, allow_single_file = True),
        "second": attr.string_dict(mandatory = True),
        "third": attr.output(mandatory = True),
        "fourth": attr.bool(default = False, mandatory = False),
    },
)
