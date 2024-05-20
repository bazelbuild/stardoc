# buildifier: disable=module-docstring
# buildifier: disable=provider-params
MyPoorlyDocumentedInfo = provider()

MyFooInfo = provider(
    doc = "Stores information about a foo.",
    fields = ["bar", "baz"],
)

# buildifier: disable=unsorted-dict-items
MyVeryDocumentedInfo = provider(
    doc = """
    A provider with some really neat documentation.

    Look on my works, ye mighty, and despair!
    """,
    fields = {
        "favorite_food": """
            A string representing my favorite food

            Expected to be delicious.
        """,
        "favorite_color": "A string representing my favorite color",
    },
)

def _my_custom_info_init(foo, bar = 42):
    """
    MyCustomInfo constructor.

    Args:
        foo: Foo data; must be non-negative
        bar: Bar data
    """
    if foo < 0:
        fail("foo must be non-negative")

    return {"foo": foo, "bar": bar, "validated": True}

MyCustomInitInfo, _new_my_custom_init_info = provider(
    doc = "A provider with a custom constructor.",
    init = _my_custom_info_init,
    fields = {
        "foo": "Foo data",
        "bar": "Bar data",
        "validated": "Whether the data has been validated",
    },
)

def _my_deprecated_info_init():
    """
    MyDeprecatedInfo constructor.

    Deprecated:
        Do not construct!
    """
    return {}

MyDeprecatedInfo, _new_my_deprecated_info = provider(
    doc = """
    You can read this info.

    But should you really construct it?
    """,
    init = _my_deprecated_info_init,
    fields = {
        "foo": "Foo",
    },
)

named_providers_are_hashable = {
    MyFooInfo: "MyFooInfo is hashable",
    MyVeryDocumentedInfo: "So is MyVeryDocumentedInfo",
}
