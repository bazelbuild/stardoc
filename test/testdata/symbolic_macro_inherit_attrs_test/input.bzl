"""Symbolic macro attribute inheritance tests"""

# buildifier: disable=unused-variable
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
    doc = """Src Macro docs""",
    implementation = _impl,
)

# buildifier: disable=unused-variable
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
    doc = """Src Rule docs""",
    implementation = _rule_impl,
)

inherit_from_common = macro(
    doc = """InheritFromCommon: Initializes some targets.""",
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
    doc = """InheritFromMacro: Initializes some targets.""",
    attrs = {
        "srcs": attr.label_list(
            doc = "Source files",
            allow_files = True,
        ),
    },
    inherit_attrs = _inherit_src_macro,
    implementation = _impl,
)

inherit_from_macro_no_doc = macro(
    # No `doc` value passed.
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
    doc = """InheritFromRule: Initializes some targets.""",
    attrs = {
        "srcs": attr.label_list(
            doc = "Source files",
            allow_files = True,
        ),
    },
    inherit_attrs = _inherit_src_rule,
    implementation = _impl,
)

inherit_from_rule_with_overrides = macro(
    doc = """InheritFromRuleWithOverrides: Initializes some targets.""",
    attrs = {
        "srcs": attr.label_list(
            doc = "Source files",
            allow_files = True,
        ),
        # Should get custom documentation
        "args": attr.string_list(
            doc = "Override docs for Arguments",
            mandatory = True,
        ),
        # Should cause it to be hidden.
        "deps": None,
    },
    inherit_attrs = _inherit_src_rule,
    implementation = _impl,
)

inherit_from_rule_no_doc = macro(
    # No `doc` value passed.
    attrs = {
        "srcs": attr.label_list(
            doc = "Source files",
            allow_files = True,
        ),
    },
    inherit_attrs = _inherit_src_rule,
    implementation = _impl,
)
