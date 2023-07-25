"""Minimal example of a .bzl file defining a module extension."""

# buildifier: disable=unused-variable
def _impl(module_ctx):
    """No-op"""
    pass

_artifact = tag_class(
    doc = "Artifact tag",
    attrs = {
        "group": attr.string(
            doc = "Group name",
            default = "my_group",
        ),
        "artifact": attr.string(
            doc = "Artifact",
            mandatory = True,
        ),
    },
)

_install = tag_class(
    doc = "Install tag",
    attrs = {
        "artifacts": attr.string_list(
            doc = "Install artifacts",
        ),
    },
)

my_ext = module_extension(
    implementation = _impl,
    doc = "Minimal example of a module extension.",
    tag_classes = {
        "install": _install,
        "artifact": _artifact,
    },
)
