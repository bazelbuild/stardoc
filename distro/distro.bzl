# Copyright 2024 The Bazel Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

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
