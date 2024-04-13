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
| <a id="my_repo-repo_mapping"></a>repo_mapping |  In `WORKSPACE` context only: a dictionary from local repository name to global repository name. This allows controls over workspace dependency resolution for dependencies of this repository.<br><br>For example, an entry `"@foo": "@bar"` declares that, for any time this repository depends on `@foo` (such as a dependency on `@foo//some:target`, it should actually resolve that dependency within globally-declared `@bar` (`@bar//some:target`).<br><br>This attribute is _not_ supported in `MODULE.bazel` context (when invoking a repository rule inside a module extension's implementation function).   | <a href="https://bazel.build/rules/lib/dict">Dictionary: String -> String</a> | optional |  |
| <a id="my_repo-useless"></a>useless |  This argument will be ignored.<br><br>You don't have to specify it, but you may.   | String | optional |  `"ignoreme"`  |

**ENVIRONMENT VARIABLES**

This repository rule depends on the following environment variables:

* `FOO_CC`
* `BAR_PATH`


