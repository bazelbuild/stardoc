load("//test:testdata/aspect_test/input.bzl", _my_aspect = "my_aspect", _other_aspect = "other_aspect")
load("//test:testdata/function_basic_test/input.bzl", _check_sources = "check_sources", _returns_a_thing = "returns_a_thing")
load("//test:testdata/module_extension_test/input.bzl", _my_ext = "my_ext")
load("//test:testdata/provider_basic_test/input.bzl", _MyFooInfo = "MyFooInfo", _MyVeryDocumentedInfo = "MyVeryDocumentedInfo")
load("//test:testdata/repo_rules_test/input.bzl", _my_repo = "my_repo")
load("//test:testdata/simple_test/input.bzl", _my_rule = "my_rule")

my_rule = _my_rule

MyFooInfo = _MyFooInfo

MyVeryDocumentedInfo = _MyVeryDocumentedInfo

check_sources = _check_sources

returns_a_thing = _returns_a_thing

my_aspect = _my_aspect

other_aspect = _other_aspect

my_repo = _my_repo

my_ext = _my_ext
