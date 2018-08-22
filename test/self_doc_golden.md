<a name="#stardoc"></a>
## stardoc

<pre>
stardoc(name, deps, input, out, stardoc, symbol_names)
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
    <tr id="#stardoc_name">
      <td><code>name</code></td>
      <td>
        String; required
        <p>
          A unique name for this rule.
        </p>
      </td>
    </tr>
    <tr id="#stardoc_deps">
      <td><code>deps</code></td>
      <td>
        List of labels; optional
        <p>
          A list of skylark_library dependencies which the input depends on.
        </p>
      </td>
    </tr>
    <tr id="#stardoc_input">
      <td><code>input</code></td>
      <td>
        Label; optional
        <p>
          The starlark file to generate documentation for.
        </p>
      </td>
    </tr>
    <tr id="#stardoc_out">
      <td><code>out</code></td>
      <td>
        Label; required
        <p>
          The (markdown) file to which documentation will be output.
        </p>
      </td>
    </tr>
    <tr id="#stardoc_stardoc">
      <td><code>stardoc</code></td>
      <td>
        Label; optional
        <p>
          The location of the stardoc tool.
        </p>
      </td>
    </tr>
    <tr id="#stardoc_symbol_names">
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


