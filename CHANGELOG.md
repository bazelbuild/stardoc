## Release 0.6.1

Bugfix release: fix `rules_jvm_external` pin warnings.

This release temporarily restores compatibility with Bazel 5 (manually tested).
Note that normally we only test Stardoc with the current stable Bazel and with
Bazel at HEAD - not with older releases. We make no promises about maintaining
compatibility with Bazel 5.

**Contributors**

Alexandre Rostovtsev

## Release 0.6.0

**New Features**

-   Stardoc no longer escapes HTML tags in documentation. Feel free to
    use HTML formatting in your docs! We now also have much-improved
    rendering for fenced code blocks in attribute docs, and render attribute
    default values using Markdown instead of HTML markup. (#161, #167)
-   Stardoc now dedents and trims all doc strings - not only in macros (#170).
    This means you can have

    ```bzl
    my_rule = rule(
        doc = """
        This is my rule.

        Here is more info about it.

        ...
        """,
        ...
    )
    ```

    and Stardoc will dedent and trim the doc to

    ```
    This is my rule.

    Here is more info about it.

    ...
    ```
-   When using Bazel 7 or newer (or current Bazel HEAD), Stardoc will by
    default use the native `starlark_doc_extract` rule internally (#166).

    This means, in particular:
    *   correct default values for rule attributes in all cases
    *   documentation for module extensions
    *   more complete documentation for repository rules
    *   by default (this can be turned off via `render_main_repo_name = False`),
        we will render labels in your main repo with a repo component: your
        main module name (when using bzlmod) or WORKSPACE name (#168).

    You may temporarily disable the new extractor by calling Stardoc with
    `use_starlark_doc_extract = False`. However, after Bazel 7 is released,
    we plan to remove this argument and always use the new extractor.

**Incompatible Changes**

-   The Markdown renderer now uses Google EscapeVelocity instead of Apache
    Velocity for templating. The templating engines are _almost_ compatible,
    with the exception of escapes in string literals: if in your template you
    had a string literal with a character escape, you would need to expand it.

    For example, instead of

    ```velocity
    ${funcInfo.docString.replaceAll("\n", " ")}
    ```

    you would need

    ```velocity
    ${funcInfo.docString.replaceAll("
    ", " ")}
    ```
-   When using the native `starlark_doc_extract` extractor, Stardoc requires
    two additional templates: `repository_rule_template` and
    `module_extension_template`. If you are using custom templates, you will
    probably want to define these, following the examples in
    `stardoc/templates/markdown_tables`.
-   When using the native `starlark_doc_extract` extractor, Stardoc cannot
    document generated .bzl files any more - because Bazel cannot `load()`
    generated .bzl files.

**Other Notable Changes**

-   The Markdown renderer's source now lives in the Stardoc repo; we build the
    renderer from source instead of using a bundled jar. Unfortunately, if you
    are not using bzlmod, this requires a rather complicated WORKSPACE setup;
    see https://github.com/bazelbuild/stardoc/releases/tag/0.6.0

**Contributors**

Alexandre Rostovtsev, Fabian Meumertzheim

## Release 0.5.6 (initially tagged as 0.5.5)

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

