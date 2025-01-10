"""The input file for the providers for attributes test"""

load(":testdata/providers_for_attributes_test/dep.bzl", "DepProviderInfo")

def my_rule_impl(ctx):
    _ignore = [ctx]  # @unused
    return []

# buildifier: disable=provider-params
# buildifier: disable=unsorted-dict-items
MyProviderInfo = provider(
    fields = {
        "foo": "Something foo-related.",
        "bar": "Something bar-related.",
    },
)

# buildifier: disable=provider-params
OtherProviderInfo = provider()
other_provider_info = OtherProviderInfo(fields = ["foo"])

# buildifier: disable=unsorted-dict-items
my_rule = rule(
    implementation = my_rule_impl,
    doc = "This rule does things.",
    attrs = {
        "first": attr.label_keyed_string_dict(
            providers = [MyProviderInfo, cc_common.CcToolchainInfo],
            doc = "this is the first attribute.",
        ),
        "second": attr.label_list(
            providers = [[CcInfo], [OtherProviderInfo, DepProviderInfo]],
        ),
        "third": attr.label(
            providers = [OtherProviderInfo],
        ),
        "fourth": attr.label(
            providers = [DefaultInfo],
        ),
        "fifth": attr.label(
            providers = [["LegacyProvider", "ObjectProvider"], [DefaultInfo]],
        ),
        "sixth": attr.label(
            providers = ["LegacyProvider"],
        ),
    },
)
