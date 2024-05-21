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

def _init_my_custom_init_info(foo, bar):
    """
    Validate stuff.

    Technical details; the user probably doesn't want to see this part.
    """
    if foo < 0:
        fail("foo must be non-negative")

    return {"foo": foo, "bar": bar, "validated": True}

MyCustomInitInfo, _new_my_custom_init_info = provider(
    doc = """
    A provider with a custom constructor.

    Since the custom constructor parameters match the provider's fields,
    we don't need to render a separate table of constructor parameters.
    """,
    init = _init_my_custom_init_info,
    fields = {
        "foo": "Foo data",
        "bar": "Bar data.",
    },
)

def _init_my_custom_init_with_default_param_value_info(foo, bar = 42):
    """
    Validate stuff.

    Technical details; the user probably doesn't want to see this part.
    """
    if foo < 0:
        fail("foo must be non-negative")

    return {"foo": foo, "bar": bar, "validated": True}

MyCustomInitWithDefaultParamValueInfo, _new_my_custom_init_with_default_param_value_info = provider(
    doc = """
    A provider with a custom constructor with a parameter with a default value.

    Since the custom constructor parameters match the provider's fields,
    we don't need to render a separate table of constructor parameters - but
    we do need to render the default value.
    """,
    init = _init_my_custom_init_with_default_param_value_info,
    fields = {
        "foo": "Foo data",
        "bar": "Bar data.",
    },
)

def _init_my_custom_init_with_mismatching_constructor_params_and_fields_info(foo, bar):
    """
    Validate stuff.

    Technical details; the user probably doesn't want to see this part.
    """
    if foo < 0:
        fail("foo must be non-negative")

    return {"foo": foo, "bar": bar, "validated": True}

MyCustomInitWithMismatchingConstructorParamsAndFieldsInfo, _new_my_custom_init_with_mismatching_constructor_params_and_fields_info = provider(
    doc = """
    A provider with a custom constructor whose set of constructor parameters does not equal the provider's set of fields.
    
    We have no choice - we need to render constructor parameters as a separate table.
    """,
    init = _init_my_custom_init_with_mismatching_constructor_params_and_fields_info,
    fields = {
        "foo": "Foo data",
        "bar": "Bar data.",
        "validated": "True, hopefully",
    },
)

def _init_my_custom_init_with_documented_param_info(foo, bar = 42):
    """
    Validate stuff.

    Technical details; the user probably doesn't want to see this part.

    Args:
        foo: Foo data; must be non-negative
    """
    if foo < 0:
        fail("foo must be non-negative")

    return {"foo": foo, "bar": bar}

MyCustomInitWithDocumentedParamInfo, _new_my_custom_init_with_documented_param_info = provider(
    doc = """
    A provider with a custom constructor with documented constructor parameters.
    
    Docs for constructor parameters differ from docs for fields, so we need to render
    constructor parameters as a separate table.
    """,
    init = _init_my_custom_init_with_documented_param_info,
    fields = {
        "foo": "Foo data",
        "bar": "Bar data. Note that we didn't document `bar` parameter for the init callback - we want this docstring to be propagated to the constructor param table.",
    },
)

def _init_my_deprecated_info():
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
    init = _init_my_deprecated_info,
    fields = {
        "foo": "Foo",
    },
)

named_providers_are_hashable = {
    MyFooInfo: "MyFooInfo is hashable",
    MyVeryDocumentedInfo: "So is MyVeryDocumentedInfo",
}
