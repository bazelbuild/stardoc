<!-- Generated with Stardoc: http://skydoc.bazel.build -->



<a id="MyCustomInitInfo"></a>

## MyCustomInitInfo

<pre>
MyCustomInitInfo(<a href="#MyCustomInitInfo-_init-foo">foo</a>, <a href="#MyCustomInitInfo-_init-bar">bar</a>)
</pre>

A provider with a custom constructor.

**CONSTRUCTOR PARAMETERS**

| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="MyCustomInitInfo-_init-foo"></a>foo |  Foo data; must be non-negative   |  none |
| <a id="MyCustomInitInfo-_init-bar"></a>bar |  <p align="center"> - </p>   |  `42` |

**FIELDS**


| Name  | Description |
| :------------- | :------------- |
| <a id="MyCustomInitInfo-foo"></a>foo |  Foo data    |
| <a id="MyCustomInitInfo-bar"></a>bar |  Bar data. Note that we didn't document `bar` parameter for the init callback - we want this docstring to be propagated to the constructor param table.    |


<a id="MyCustomInitWithExtraFieldInfo"></a>

## MyCustomInitWithExtraFieldInfo

<pre>
MyCustomInitWithExtraFieldInfo(<a href="#MyCustomInitWithExtraFieldInfo-_init-foo">foo</a>, <a href="#MyCustomInitWithExtraFieldInfo-_init-bar">bar</a>)
</pre>

A provider with a custom constructor.

**CONSTRUCTOR PARAMETERS**

| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="MyCustomInitWithExtraFieldInfo-_init-foo"></a>foo |  Foo data; must be non-negative   |  none |
| <a id="MyCustomInitWithExtraFieldInfo-_init-bar"></a>bar |  <p align="center"> - </p>   |  `42` |

**FIELDS**


| Name  | Description |
| :------------- | :------------- |
| <a id="MyCustomInitWithExtraFieldInfo-foo"></a>foo |  Foo data    |
| <a id="MyCustomInitWithExtraFieldInfo-bar"></a>bar |  Bar data. Note that we didn't document `bar` parameter for the init callback - we want this docstring to be propagated to the constructor param table.    |
| <a id="MyCustomInitWithExtraFieldInfo-validated"></a>validated |  Whether the data has been validated    |


<a id="MyDeprecatedInfo"></a>

## MyDeprecatedInfo

<pre>
MyDeprecatedInfo()
</pre>

You can read this info.

But should you really construct it?

**DEPRECATED**

Do not construct!

**FIELDS**


| Name  | Description |
| :------------- | :------------- |
| <a id="MyDeprecatedInfo-foo"></a>foo |  Foo    |


<a id="MyFooInfo"></a>

## MyFooInfo

<pre>
MyFooInfo(<a href="#MyFooInfo-bar">bar</a>, <a href="#MyFooInfo-baz">baz</a>)
</pre>

Stores information about a foo.

**FIELDS**


| Name  | Description |
| :------------- | :------------- |
| <a id="MyFooInfo-bar"></a>bar |  -    |
| <a id="MyFooInfo-baz"></a>baz |  -    |


<a id="MyPoorlyDocumentedInfo"></a>

## MyPoorlyDocumentedInfo

<pre>
MyPoorlyDocumentedInfo()
</pre>

**FIELDS**



<a id="MyVeryDocumentedInfo"></a>

## MyVeryDocumentedInfo

<pre>
MyVeryDocumentedInfo(<a href="#MyVeryDocumentedInfo-favorite_food">favorite_food</a>, <a href="#MyVeryDocumentedInfo-favorite_color">favorite_color</a>)
</pre>

A provider with some really neat documentation.

Look on my works, ye mighty, and despair!

**FIELDS**


| Name  | Description |
| :------------- | :------------- |
| <a id="MyVeryDocumentedInfo-favorite_food"></a>favorite_food |  A string representing my favorite food<br><br>Expected to be delicious.    |
| <a id="MyVeryDocumentedInfo-favorite_color"></a>favorite_color |  A string representing my favorite color    |


