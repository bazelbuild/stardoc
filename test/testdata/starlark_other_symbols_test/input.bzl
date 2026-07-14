"""A golden test for documented Starlark global symbols."""

#: A documented string constant.
A_STRING = "a string"

#: A documented struct constant.
STRUCT_CONSTANT = struct(foo = 1)

#: The first line of documentation for a list.
#: The second line of documentation for a list.
Z_LIST = ["one", "two"]

#: Private symbols are not included in generated documentation.
_PRIVATE_CONSTANT = 42

# Undocumented constant
UNDOCUMENTED_CONSTANT = _PRIVATE_CONSTANT == 42
