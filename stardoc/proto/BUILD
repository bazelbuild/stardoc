licenses(["notice"])

package(
    default_applicable_license = ["//:license"],
    default_visibility = ["//visibility:public"],
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
