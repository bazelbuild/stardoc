licenses(["notice"])

package(default_visibility = ["//visibility:public"])

proto_library(
    name = "stardoc_output_proto",
    srcs = ["stardoc_output.proto"],
)

exports_files(["stardoc_output.proto"])

# Sources needed for release tarball.
filegroup(
    name = "distro_srcs",
    srcs = [
        "BUILD",
    ] + glob(["*.proto"]),
    visibility = ["//:__pkg__"],
)
