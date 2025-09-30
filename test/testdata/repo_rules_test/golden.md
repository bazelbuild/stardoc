<!-- Generated with Stardoc: http://skydoc.bazel.build -->



<a id="my_repo"></a>

## my_repo

<pre>
load("@stardoc//test:testdata/repo_rules_test/input.bzl", "my_repo")

my_repo(<a href="#my_repo-name">name</a>, <a href="#my_repo-useless">useless</a>)
</pre>

Minimal example of a repository rule.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="my_repo-name"></a>name |  A unique name for this repository.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="my_repo-useless"></a>useless |  This argument will be ignored.<br><br>You don't have to specify it, but you may.   | String | optional |  `"ignoreme"`  |

**ENVIRONMENT VARIABLES**

This repository rule depends on the following environment variables:

* `FOO_CC`
* `BAR_PATH`


