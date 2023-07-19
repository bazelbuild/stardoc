<!-- Generated with Stardoc: http://skydoc.bazel.build -->



<a id="my_repo"></a>

## my_repo

<pre>
my_repo(<a href="#my_repo-name">name</a>, <a href="#my_repo-repo_mapping">repo_mapping</a>, <a href="#my_repo-useless">useless</a>)
</pre>

Minimal example of a repository rule.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="my_repo-name"></a>name |  A unique name for this repository.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="my_repo-repo_mapping"></a>repo_mapping |  In &lt;code&gt;WORKSPACE&lt;/code&gt; context only: a dictionary from local repository name to global repository name. This allows controls over workspace dependency resolution for dependencies of this repository.&lt;p&gt;For example, an entry <code>"@foo": "@bar"</code> declares that, for any time this repository depends on <code>@foo</code> (such as a dependency on <code>@foo//some:target</code>, it should actually resolve that dependency within globally-declared <code>@bar</code> (<code>@bar//some:target</code>).&lt;p&gt;This attribute is &lt;em&gt;not&lt;/em&gt; supported in &lt;code&gt;MODULE.bazel&lt;/code&gt; context (when invoking a repository rule inside a module extension's implementation function).   | <a href="https://bazel.build/rules/lib/dict">Dictionary: String -> String</a> | optional |  |
| <a id="my_repo-useless"></a>useless |  This argument will be ignored. You don't have to specify it, but you may.   | String | optional |  `"ignoreme"`  |

**ENVIRONMENT VARIABLES**

This repository rule depends on the following environment variables:
* `FOO_CC`
* `BAR_PATH`


