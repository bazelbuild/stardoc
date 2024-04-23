"""Macros related to distro tarball packaging"""

def strip_internal_only(name, src, out):
    """Strip an internal-only block from a file

    Removes everything starting with `### INTERNAL ONLY` and ending with `### END INTERNAL ONLY` (or up to the end of the file).

    Args:
        name: Target name
        src: Input file
        out: Output file
    """
    native.genrule(
        name = name,
        srcs = [src],
        outs = [out],
        cmd = "sed -e '/### INTERNAL ONLY/,/### END INTERNAL ONLY/d' $(location %s) >$@" % src,
    )
