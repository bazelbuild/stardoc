"""Symbolic macro tests"""

# buildifier: disable=unused-variable
def _impl(name, visibility, **kwargs):
    pass

basic_macro = macro(
    doc = """Initializes some targets.""",
    attrs = {
        "srcs": attr.label_list(
            doc = "Source files",
            allow_files = True,
        ),
        "operation": attr.string(
            doc = "Operation to perform",
            configurable = False,
            default = "FROBNICATE",
        ),
    },
    implementation = _impl,
)
