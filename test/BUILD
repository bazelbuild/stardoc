licenses(["notice"])  # Apache 2.0

sh_test(
    name = "stardoc_self_gen_test",
    srcs = ["diff_test_runner.sh"],
    args = [
        "$(location //stardoc:stardoc_doc.md)",
        "$(location :self_doc_golden.md)",
    ],
    data = [
        "self_doc_golden.md",
        "//stardoc:stardoc_doc.md",
    ],
)
