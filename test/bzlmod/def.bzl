"""A simple macro used to test stardoc."""

load("@my_skylib//rules:write_file.bzl", "write_file")
load("@local_config_platform//:constraints.bzl", "HOST_CONSTRAINTS")

def write_host_constraints(name):
    """Emits the constraints of the host platform to a file.

    Args:
      name: The name of the target. The output file will be named
        `<name>.txt`.
    """
    write_file(
        name = name,
        content = HOST_CONSTRAINTS,
        out = name + ".txt",
    )
