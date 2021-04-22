"""A test that verifies documenting functions in an input file under a local_repository."""

load("@io_bazel_skydoc//test/testdata/fakedeps:dep.bzl", "give_me_five")

def min(integers):
    """Returns the minimum of given elements.

    Args:
      integers: A list of integers. Must not be empty.

    Returns:
      The minimum integer in the given list.
    """
    _ignore = [integers]
    return give_me_five()
