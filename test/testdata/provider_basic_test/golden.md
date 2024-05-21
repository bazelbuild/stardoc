<!-- Generated with Stardoc: http://skydoc.bazel.build -->



<a id="MyCustomInitInfo"></a>

## MyCustomInitInfo

<pre>
MyCustomInitInfo(<a href="#MyCustomInitInfo-foo">foo</a>, <a href="#MyCustomInitInfo-bar">bar</a>)
</pre>

A provider with a custom constructor.

Since the custom constructor parameters match the provider's fields,
we don't need to render a separate table of constructor parameters.

**FIELDS**

| Name  | Description |
| :------------- | :------------- |
| <a id="MyCustomInitInfo-foo></a>foo |  Foo data  |
| <a id="MyCustomInitInfo-bar></a>bar |  Bar data.  |


<a id="MyCustomInitWithDefaultParamValueInfo"></a>

## MyCustomInitWithDefaultParamValueInfo

<pre>
MyCustomInitWithDefaultParamValueInfo(<a href="#MyCustomInitWithDefaultParamValueInfo-foo">foo</a>, <a href="#MyCustomInitWithDefaultParamValueInfo-bar">bar</a>)
</pre>

A provider with a custom constructor with a parameter with a default value.

Since the custom constructor parameters match the provider's fields,
we don't need to render a separate table of constructor parameters - but
we do need to render the default value.

**FIELDS**

| Name  | Description | Default Value |
| :------------- | :------------- | :------------- ||
| <a id="MyCustomInitWithDefaultParamValueInfo-foo></a>foo |  Foo data  |  none  |
| <a id="MyCustomInitWithDefaultParamValueInfo-bar></a>bar |  Bar data.  |  `42`  |


<a id="MyCustomInitWithDocumentedParamInfo"></a>

## MyCustomInitWithDocumentedParamInfo

<pre>
MyCustomInitWithDocumentedParamInfo(<a href="#MyCustomInitWithDocumentedParamInfo-_init-foo">foo</a>, <a href="#MyCustomInitWithDocumentedParamInfo-_init-bar">bar</a>)
</pre>

A provider with a custom constructor with documented constructor parameters.

Docs for constructor parameters differ from docs for fields, so we need to render
constructor parameters as a separate table.

**CONSTRUCTOR PARAMETERS**

| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="MyCustomInitWithDocumentedParamInfo-_init-foo"></a>foo |  Foo data; must be non-negative   |  none |
| <a id="MyCustomInitWithDocumentedParamInfo-_init-bar"></a>bar |  Bar data. Note that we didn't document `bar` parameter for the init callback - we want this docstring to be propagated to the constructor param table.   |  `42` |

**FIELDS**

| Name  | Description |
| :------------- | :------------- |
| <a id="MyCustomInitWithDocumentedParamInfo-foo"></a>foo |  Foo data    |
| <a id="MyCustomInitWithDocumentedParamInfo-bar"></a>bar |  Bar data. Note that we didn't document `bar` parameter for the init callback - we want this docstring to be propagated to the constructor param table.    |


<a id="MyCustomInitWithMismatchingConstructorParamsAndFieldsInfo"></a>

## MyCustomInitWithMismatchingConstructorParamsAndFieldsInfo

<pre>
MyCustomInitWithMismatchingConstructorParamsAndFieldsInfo(<a href="#MyCustomInitWithMismatchingConstructorParamsAndFieldsInfo-_init-foo">foo</a>, <a href="#MyCustomInitWithMismatchingConstructorParamsAndFieldsInfo-_init-bar">bar</a>)
</pre>

A provider with a custom constructor whose set of constructor parameters does not equal the provider's set of fields.

We have no choice - we need to render constructor parameters as a separate table.

**CONSTRUCTOR PARAMETERS**

| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="MyCustomInitWithMismatchingConstructorParamsAndFieldsInfo-_init-foo"></a>foo |  Foo data   |  none |
| <a id="MyCustomInitWithMismatchingConstructorParamsAndFieldsInfo-_init-bar"></a>bar |  Bar data.   |  none |

**FIELDS**

| Name  | Description |
| :------------- | :------------- |
| <a id="MyCustomInitWithMismatchingConstructorParamsAndFieldsInfo-foo"></a>foo |  Foo data    |
| <a id="MyCustomInitWithMismatchingConstructorParamsAndFieldsInfo-bar"></a>bar |  Bar data.    |
| <a id="MyCustomInitWithMismatchingConstructorParamsAndFieldsInfo-validated"></a>validated |  True, hopefully    |


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


