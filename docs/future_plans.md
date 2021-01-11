**Last updated:** January 2021.

**Summary:** We'll be redesigning how Stardoc works, and deprioritizing feature
requests and minor bugs until that work is complete (targeting 2021 Q2).

## Technical motivation

Stardoc is currently the recommended tool for generating documentation of
Starlark rules. It [replaces](skydoc_deprecation.md) *Sky*doc, the previous
tool, which worked by evaluating .bzl files in a Python interpreter, using
fake versions of functions from Bazel's Build Language.

Mocking is an inherently problematic approach for two reasons:

1. It creates a maintenance burden for the tool maintainer (us). We have to
ensure that the mocked definitions stay up-to-date as Bazel changes. These
include not just `rule()` and `provider()`, but also a number of other symbols
that don't directly affect documentation but still require stubs.

2. It puts a constraint on the user: All of their documented .bzl files, as
well as all of the .bzl dependencies they transitively load, must be
compatible with the mock evaluation. This means users must be vigilant about
writing Starlark code that lies in the intersection of what is understood as
valid by Bazel and by Stardoc.

The Python-based Skydoc experienced an extreme version of this problem because
it didn't even treat .bzl files as being written in the Starlark language.
However, the Java-based Stardoc still uses mocking -- not of the Starlark
language, but of Bazel's Build Language functions.

In addition, Stardoc's mocking approach tightly integrates it with Bazel.
Indeed much of its source code lives inside the bazelbuild/bazel repository.
This makes refactoring and evolving the Bazel source code more difficult.

While the Starlark language has a specification and several implementations,
the Build Language is more complicated and has only one accurate
implementation: Bazel. Any tooling that operates on BUILD and .bzl files must
carefully consider whether it is feasible to ask Bazel for the authoritative
information, only falling back on simulation if absolutely necessary.

## Our plans

We will rewrite the part of Stardoc that extracts documentation information from
.bzl files, so that instead of using mocking to pseudo-evaluate individual .bzl
files, it performs a real Bazel evaluation of the workspace. Think of how `bazel
query` is used to dump out information from Bazel's loading phase about the
target dependency graph. Now imagine that it's extended to also dump out the
rules and providers declared in the .bzl files used by a build, and that this
dump also includes their docstrings.

This approach intersects other work we are doing to simplify and better specify
Bazel's loading phase, so that users have access to all sorts of information
that was previously not readily available.

Note that this new internal approach does not necessarily have to mean the
user's workflow changes. You could still write a target in your BUILD file to
say exactly what content you want documented and how you'd like it formatted.
The rendering logic may very well continue to live outside of Bazel, in the
bazelbuild/stardoc repository.

## Prioritization

We're aiming to explore this design in more concrete detail in 2021 Q1, and
implement it in Q2.

In the meantime, *we will not be focusing on improvements to the current
implementation of Stardoc*, even the formatting parts which might remain the
same. We still commit to keeping Stardoc working for its existing essential use
cases.
