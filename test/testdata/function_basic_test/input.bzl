"""A test that verifies basic user function documentation."""

def check_sources(
        name,
        required_param,
        bool_param = True,
        srcs = [],
        string_param = "",
        int_param = 2,
        dict_param = {},
        struct_param = struct(foo = "bar")):
    # buildifier: disable=function-docstring-args
    """Runs some checks on the given source files.

    This rule runs checks on a given set of source files.
    Use `bazel build` to run the check.

    Args:
        name: A unique name for this rule.
        required_param: Use your imagination.
        srcs: Source files to run the checks against.
        doesnt_exist: A param that doesn't exist (lets hope we still get *some* documentation)
        int_param: Your favorite number.
    """
    _ignore = [
        name,
        required_param,
        bool_param,
        srcs,
        string_param,
        int_param,
        dict_param,
        struct_param,
    ]  # @unused
    x = ("Hah. All that documentation but nothing really to see here")  # @unused

def returns_a_thing(name):
    """Returns a suffixed name.

    Args:
        name: A unique name for this rule.

    Returns:
        A suffixed version of the name.
    """
    _ignore = name  # @unused
    pass

def deprecated_do_not_use():
    """This function is deprecated.

    Deprecated:
        Use literally anything but this function.
    """
    pass

def undocumented_function(a, b, c):
    _ignore = [a, b, c]  # @unused
    pass
