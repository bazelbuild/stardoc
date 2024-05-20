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

def _init_MyCustomInitInfo(foo, bar = 42):
    """
    Validate stuff.

    Technical details; the user probably doesn't want to see this part.

    Args:
        foo: Foo data; must be non-negative
    """
    if foo < 0:
        fail("foo must be non-negative")

    return {"foo": foo, "bar": bar, "validated": True}

MyCustomInitInfo, _new_MyCustomInitInfo = provider(
    doc = "A provider with a custom constructor.",
    init = _init_MyCustomInitInfo,
    fields = {
        "foo": "Foo data",
        "bar": "Bar data. Note that we didn't document `bar` parameter for the init callback - we want this docstring to be propagated to the constructor param table.",
    },
)

def _MyCustomInitWithExtraFieldInfo_init(foo, bar = 42):
    """
    Validate stuff.

    Technical details; the user probably doesn't want to see this part.

    Args:
        foo: Foo data; must be non-negative
    """
    if foo < 0:
        fail("foo must be non-negative")

    return {"foo": foo, "bar": bar}

MyCustomInitWithExtraFieldInfo, _new_MyCustomInitWithExtraFieldInfo = provider(
    doc = "A provider with a custom constructor.",
    init = _MyCustomInitWithExtraFieldInfo_init,
    fields = {
        "foo": "Foo data",
        "bar": "Bar data. Note that we didn't document `bar` parameter for the init callback - we want this docstring to be propagated to the constructor param table.",
        "validated": "Whether the data has been validated",
    },
)

def _init_MyDeprecatedInfo():
    """
    MyDeprecatedInfo constructor.

    Deprecated:
        Do not construct!
    """
    return {}

MyDeprecatedInfo, _new_MyDeprecatedInfo = provider(
    doc = """
    You can read this info.

    But should you really construct it?
    """,
    init = _init_MyDeprecatedInfo,
    fields = {
        "foo": "Foo",
    },
)

named_providers_are_hashable = {
    MyFooInfo: "MyFooInfo is hashable",
    MyVeryDocumentedInfo: "So is MyVeryDocumentedInfo",
}
