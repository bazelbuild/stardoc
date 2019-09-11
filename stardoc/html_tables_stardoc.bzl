# Copyright 2019 The Bazel Authors. All rights reserved.
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

"""Macro for Pure Markdown Stardoc Output Format"""

load(":stardoc.bzl", "stardoc")

def html_tables_stardoc(name, **kwargs):
    """Outputs documentation using html_tables templates.

    Args:
      name: A unique name for this target.
      **kwargs: Attributes to be passed along to the stardoc() rule. (May not include the attributes
          for the stardoc and renderer binaries, format, or templates.)
    """

    stardoc(
        name = name,
        format = "markdown",
        aspect_template = Label("//stardoc:templates/html_tables/aspect.vm"),
        func_template = Label("//stardoc:templates/html_tables/func.vm"),
        header_template = Label("//stardoc:templates/html_tables/header.vm"),
        provider_template = Label("//stardoc:templates/html_tables/provider.vm"),
        rule_template = Label("//stardoc:templates/html_tables/rule.vm"),
        **kwargs
    )
