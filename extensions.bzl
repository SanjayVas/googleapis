"""Module extension for generating imports."""

load(
    "@com_google_googleapis//:repository_rules.bzl",
    "switched_rules_by_language",
)

_types_tag = tag_class(
    attrs = {
        "java": attr.bool(),
        "cc": attr.bool(),
    },
)

def _imports_impl(mctx):
    java = False
    cc = False
    for module in mctx.modules:
        for types in module.tags.types:
            java = java or types.java
            cc = cc or types.cc

    switched_rules_by_language(
        name = "com_google_googleapis_imports",
        java = java,
        cc = cc,
    )

imports = module_extension(
    implementation = _imports_impl,
    tag_classes = {
        "types": _types_tag,
    },
)
