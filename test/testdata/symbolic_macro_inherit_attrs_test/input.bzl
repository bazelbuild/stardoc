"""Symbolic macro attribute inheritance tests"""

def _impl(name, visibility, **kwargs):
    pass

_inherit_src_macro = macro(
    attrs = {
        "args": attr.string_list(
            doc = "Arguments",
            mandatory = True,
        ),
        "deps": attr.label_list(
            doc = "Dependencies",
        ),
    },
    implementation = _impl,
)

def _rule_impl(ctx):
    pass

_inherit_src_rule = rule(
    attrs = {
        "args": attr.string_list(
            doc = "Arguments",
            mandatory = True,
        ),
        "deps": attr.label_list(
            doc = "Dependencies",
        ),
    },
    implementation = _rule_impl,
)

inherit_from_common = macro(
    doc = """Initializes some targets.""",
    attrs = {
        "srcs": attr.label_list(
            doc = "Source files",
            allow_files = True,
        ),
    },
    inherit_attrs = "common",
    implementation = _impl,
)

inherit_from_macro = macro(
    doc = """Initializes some targets.""",
    attrs = {
        "srcs": attr.label_list(
            doc = "Source files",
            allow_files = True,
        ),
    },
    inherit_attrs = _inherit_src_macro,
    implementation = _impl,
)

inherit_from_rule = macro(
    doc = """Initializes some targets.""",
    attrs = {
        "srcs": attr.label_list(
            doc = "Source files",
            allow_files = True,
        ),
    },
    inherit_attrs = _inherit_src_rule,
    implementation = _impl,
)
