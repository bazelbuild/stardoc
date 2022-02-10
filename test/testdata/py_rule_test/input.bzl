"""The input file for the python rule test"""

def exercise_the_api():
    var1 = PyRuntimeInfo  # @unused
    var2 = PyInfo  # @unused

exercise_the_api()

def my_rule_impl(ctx):
    _unused = ctx  # @unused
    return []

# buildifier: disable=unsorted-dict-items
py_related_rule = rule(
    implementation = my_rule_impl,
    doc = "This rule does python-related things.",
    attrs = {
        "first": attr.label(
            mandatory = True,
            doc = "this is the first doc string!",
            allow_single_file = True,
        ),
        "second": attr.string_dict(mandatory = True),
        "third": attr.output(mandatory = True),
        "fourth": attr.bool(default = False, doc = "the fourth doc string.", mandatory = False),
        "fifth": attr.bool(default = True, doc = "Hey look, its the fifth thing!"),
        "sixth": attr.int_list(
            default = range(10),
            doc = "it's the sixth thing.",
            mandatory = False,
        ),
        "_hidden": attr.string(),
    },
)
