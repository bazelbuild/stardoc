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

"""Detector for the --stamp flag"""

StampDetectorInfo = provider(
    doc = "Result of detecting the --stamp flag",
    fields = {
        "enabled": "True if --stamp is enabled",
    },
)

def _stamp_detector_impl(ctx):
    return [StampDetectorInfo(enabled = ctx.attr.enabled)]

stamp_detector = rule(
    _stamp_detector_impl,
    doc = """Detects if the --stamp flag is enabled""",
    attrs = {
        "enabled": attr.bool(mandatory = True, doc = "True if --stamp flag is enabled"),
    },
)
