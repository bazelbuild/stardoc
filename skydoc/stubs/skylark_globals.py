# Copyright 2016 The Bazel Authors. All rights reserved.
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

"""Stubs for Skylark globals"""


def FileType(filetypes=[]):
  return filetypes

HOST_CFG = 'HOST_CFG'
DATA_CFG = 'DATA_CFG'
PACKAGE_NAME = 'PACKAGE_NAME'
REPOSITORY_NAME = 'REPOSITORY_NAME'

def aspect(implementation, attr_aspects=[], attrs=None, fragments=[],
           host_fragments=[]):
  return None

def provider(target, type):
  return None

def select(x):
  return None

def struct(**kwargs):
  return None

class Label(object):
  def __init__(self, label_string):
    self.label_string = label_string

class RuleDescriptor(object):
  def __init__(self, implementation, test=False, attrs={}, outputs={},
               executable=False, output_to_genfiles=False, fragments=[],
               host_fragments=[], local=False, doc='', type='rule'):
    """Constructor for RuleDescriptor

    Args:
      self: The current instance.
      implementation: The implementation function for the rule (not used).
      test: Whether this is a test rule
      attrs: Dictionary mapping attribute name to attribute descriptor
      outputs: Outputs for this rule as a mapping from string to template name.
          The dictionary keys are used to refer to the output in the docstring
          documentation.
      executable: Whether this rule produces an executable.
      output_to_genfiles: Whether the rule generates files in the genfiles
          directory rather than the bin directory (not used).
      fragments: List of names of configuration fragments the rule requires in
          the target configuration (not used).
      host_fragments: List of names of configuration fragments that the rule
          requires in the host configuration (not used).
      local: Indicates that the rule fetches everything from the local system.
          (Only used if type='repository').
      doc: Documentation for this rule. This parameter is used internally by
          skydoc and is not set by any Skylark code in .bzl files.
      example_doc: Example documentation for this rule. This parameter is used
          internally by skydoc and is not set by any Skylark code in .bzl files.
      type: The type of rule (rule, repository_rule). This parameter is used
          by skydoc and is not set by any Skylark code in .bzl files.
    """
    self.is_rule = True
    self.implementation = implementation
    self.test = test
    self.attrs = attrs
    self.outputs = outputs
    self.executable = executable
    self.output_to_genfiles = output_to_genfiles
    self.fragments = fragments
    self.host_fragments = host_fragments
    self.local = local
    self.doc = doc
    self.example_doc = ''
    self.outputs = outputs
    self.output_docs = {}
    self.type = type
    for name, attr in self.attrs.iteritems():
      attr.name = name

def rule(implementation, test=False, attrs={}, outputs=None,
         executable=False, output_to_genfiles=False, fragments=[],
         host_fragments=[]):
  return RuleDescriptor(implementation, test, attrs, outputs, executable,
                        output_to_genfiles, fragments, host_fragments)

def repository_rule(implementation, attrs={}, local=False):
  return RuleDescriptor(implementation, attrs=attrs, local=local,
                        type='repository')
