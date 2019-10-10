<!-- Generated with Stardoc: http://skydoc.bazel.build -->

<a name="#my_aspect_impl"></a>

## my_aspect_impl

<pre>
my_aspect_impl(<a href="#my_aspect_impl-ctx">ctx</a>)
</pre>



**PARAMETERS**


| Name  | Description | Default Value |
| :-------------: | :-------------: | :-------------: |
| ctx |  <p align="center"> - </p>   |  none |


<a name="#my_aspect"></a>

## my_aspect

<pre>
my_aspect(<a href="#my_aspect-name">name</a>, <a href="#my_aspect-first">first</a>, <a href="#my_aspect-second">second</a>)
</pre>

This is my aspect. It does stuff.

**ASPECT ATTRIBUTES**


| Name | Type |
| :-------------: | :-------------: |
| deps| String |
| attr_aspect| String |


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :-------------: | :-------------: | :-------------: | :-------------: | :-------------: |
| name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |   |
| first |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | required |   |
| second |  -   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: String -> String</a> | required |   |


<a name="#other_aspect"></a>

## other_aspect

<pre>
other_aspect(<a href="#other_aspect-name">name</a>, <a href="#other_aspect-third">third</a>)
</pre>

This is another aspect.

**ASPECT ATTRIBUTES**


| Name | Type |
| :-------------: | :-------------: |
| *| String |


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :-------------: | :-------------: | :-------------: | :-------------: | :-------------: |
| name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |   |
| third |  -   | Integer | required |   |


