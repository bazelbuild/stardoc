"""Finalizer tests"""

# buildifier: disable=unused-variable
def _impl(name, visibility, **kwargs):
    pass

my_finalizer = macro(
    doc = """Finalizes a package.""",
    attrs = {
        "ignore_targets": attr.label_list(
            doc = "Targets to ignore",
            configurable = False,
        ),
    },
    finalizer = True,
    implementation = _impl,
)
