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
        "@my_skylib//rules:write_file",
        "@platforms//host:constraints_lib",
    ],
)

diff_test(
    name = "docs_test",
    file1 = "docs.md",
    file2 = "docs.md.golden",
)
