## Release 0.5.5

Bugfix release: update `@rules_java` dependency to fix breakage with Bazel at HEAD.

**Contributors**

Alexandre Rostovtsev


## Release 0.5.4

**New Features**

-   Stardoc supports bzlmod! (#141, special thanks to Fabian Meumertzheim)
-   Stardoc output files are now exposed in stardoc() target runfiles (#139)

**Contributors**

Alexandre Rostovtsev, Fabian Meumertzheim, Greg Estren, Ivo List, Keith Smiley,
lberki, Philipp Schrader

## Release 0.5.3

Bugfix release: fixes angle bracket escaping and a crash on labels with `@@`

**Contributors**

Alexandre Rostovtsev, Jon Shea

## Release 0.5.2

Bugfix release: fixes crash with `config_common.toolchain_type`.

**Contributors**

Alexandre Rostovtsev, Keith Smiley

## Release 0.5.1

Bugfix release: minor fixes, including a fix for build failure due to missing zlib version.

**Contributors**

aiuto, Alexandre Rostovtsev, Brian Silverman, Casey, Xùdōng Yáng

## Release 0.5.0

This release includes many fixes for Stardoc's markdown output, plus:

**New Features**

-   Raw protobuf output via `format = "proto"` (#20)
-   Stardoc now outputs documentation for macro returns and deprecations (#75)
    as well as module (file) docstrings (#100)

**Contributors**

Alexandre Rostovtsev, Alex Eagle, Andrew Z Allen, Chris Rebert, c-parsons, Ivo
List, Jon Brandvein, Laurent Le Brun, Max Vorobev, pbatg, Philipp Wollermann,
Samuel Giddins, Thomas Van Lenten, Tiago Quelhas, Xùdōng Yáng, Yiting Wang

## Release 0.4.0

First release of **Stardoc** under the new repository location
[bazelbuild/stardoc](https://github.com/bazelbuild/stardoc). Please use this
repository for future Stardoc releases instead of its old location. See
[Getting Started](https://github.com/bazelbuild/stardoc/blob/4378e9b6bb2831de7143580594782f538f461180/docs/getting_started_stardoc.md)
for updated setup information.

There are **many** new features since the last release. A summary of major
features:

-   Changed the default Stardoc output format to use pure-markdown tables
    instead of HTML tables. This output format is fully compatible with markdown
    formatting constructs. For example, use `**bold**` instead of `<b>bold</b>`.
    The `<`. and `>` characters are escaped in this output format.
-   Stardoc now supports custom formatting. See
    [Custom Output documentation](https://github.com/bazelbuild/stardoc/blob/4378e9b6bb2831de7143580594782f538f461180/docs/advanced_stardoc_usage.md#custom-output)
    for details.
-   `aspect()` definitions are now documented by Stardoc.
-   Module definitions (structs which combine series of functions in a
    'namespace') are now documetned by Stardoc.
-   Attribute default-value information is now included in output.

**Huge Thanks to [kendalllaneee](https://github.com/kendalllaneee) and
[blossommojekwu](https://github.com/blossommojekwu) for their work on many of
the features in this release.**

