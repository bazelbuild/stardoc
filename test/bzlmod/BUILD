load("@my_skylib//rules:diff_test.bzl", "diff_test")
load("@stardoc//stardoc:stardoc.bzl", "stardoc")
load(":def.bzl", "write_host_constraints")

write_host_constraints(
    name = "host_constraints",
)

stardoc(
    name = "docs",
    out = "docs.md",
    input = "def.bzl",
    deps = [
        "@local_config_platform//:constraints.bzl",
        "@my_skylib//rules:write_file",
    ],
)

diff_test(
    name = "docs_test",
    file1 = "docs.md",
    file2 = "docs.md.golden",
)
