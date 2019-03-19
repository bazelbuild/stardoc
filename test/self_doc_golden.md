<!-- Generated with Stardoc: http://skydoc.bazel.build -->

<a name="#stardoc"></a>

## stardoc

<pre>
stardoc(<a href="#stardoc-name">name</a>, <a href="#stardoc-deps">deps</a>, <a href="#stardoc-input">input</a>, <a href="#stardoc-out">out</a>, <a href="#stardoc-semantic_flags">semantic_flags</a>, <a href="#stardoc-stardoc">stardoc</a>, <a href="#stardoc-symbol_names">symbol_names</a>)
</pre>


Generates documentation for exported skylark rule definitions in a target starlark file.

This rule is an experimental replacement for the existing skylark_doc rule.


### Attributes

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="stardoc-name">
      <td><code>name</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#name">Name</a>; required
        <p>
          A unique name for this target.
        </p>
      </td>
    </tr>
    <tr id="stardoc-deps">
      <td><code>deps</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a>; optional
        <p>
          A list of skylark_library dependencies which the input depends on.
        </p>
      </td>
    </tr>
    <tr id="stardoc-input">
      <td><code>input</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">Label</a>; optional
        <p>
          The starlark file to generate documentation for.
        </p>
      </td>
    </tr>
    <tr id="stardoc-out">
      <td><code>out</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">Label</a>; required
        <p>
          The (markdown) file to which documentation will be output.
        </p>
      </td>
    </tr>
    <tr id="stardoc-semantic_flags">
      <td><code>semantic_flags</code></td>
      <td>
        List of strings; optional
        <p>
          A list of canonical flags to affect Starlark semantics for the Starlark interpretter
during documentation generation. This should only be used to maintain compatibility with
non-default semantic flags required to use the given Starlark symbols.
<br><br>For example, if <code>//foo:bar.bzl</code> does not build except when a user would specify
<code>--incompatible_foo_semantic=false</code>, then this attribute should contain
"--incompatible_foo_semantic=false".
        </p>
      </td>
    </tr>
    <tr id="stardoc-stardoc">
      <td><code>stardoc</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">Label</a>; optional
        <p>
          The location of the stardoc tool.
        </p>
      </td>
    </tr>
    <tr id="stardoc-symbol_names">
      <td><code>symbol_names</code></td>
      <td>
        List of strings; optional
        <p>
          A list of symbol names to generate documentation for. These should correspond to
the names of rule definitions in the input file. If this list is empty, then
documentation for all exported rule definitions will be generated.
        </p>
      </td>
    </tr>
  </tbody>
</table>


<a name="#_stardoc_impl"></a>

## _stardoc_impl

<pre>
_stardoc_impl(<a href="#_stardoc_impl-ctx">ctx</a>)
</pre>

Implementation of the stardoc rule.

### Parameters

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="_stardoc_impl-ctx">
      <td><code>ctx</code></td>
      <td>
        required.
      </td>
    </tr>
  </tbody>
</table>


