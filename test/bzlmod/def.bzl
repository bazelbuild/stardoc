# Copyright 2023 The Bazel Authors. All rights reserved.
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

"""A simple macro used to test stardoc."""

load("@my_skylib//rules:write_file.bzl", "write_file")
load("@platforms//host:constraints.bzl", "HOST_CONSTRAINTS")

def write_host_constraints(name):
    """Emits the constraints of the host platform to a file.

    Args:
      name: The name of the target. The output file will be named
        `<name>.txt`.
    """
    write_file(
        name = name,
        content = HOST_CONSTRAINTS,
        out = name + ".txt",
    )
