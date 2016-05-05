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

"""Documentation generator for Skylark"""


import gflags
import jinja2
import os
import re
import shutil
import sys
import tempfile
import zipfile

from skydoc import macro_extractor
from skydoc import rule
from skydoc import rule_extractor

gflags.DEFINE_string('output_dir', '',
    'The directory to write the output generated documentation to if '
    '--zip=false')
gflags.DEFINE_string('output_file', '',
    'The output zip archive file to write if --zip=true.')
gflags.DEFINE_string('format', 'markdown',
    'The output format. Possible values are markdown and html')
gflags.DEFINE_bool('zip', True,
    'Whether to generate a ZIP arhive containing the output files. If '
    '--zip is true, then skydoc will generate a zip file, skydoc.zip by '
    'default or as specified by --output_file. If --zip is false, then '
    'skydoc will generate documentation, either in Markdown or HTML as '
    'specifed by --format, in the current directory or --output_dir if set.')

FLAGS = gflags.FLAGS

DEFAULT_OUTPUT_DIR = '.'
DEFAULT_OUTPUT_FILE = 'skydoc.zip'

WORKSPACE_DIR = 'io_bazel_skydoc'
TEMPLATE_PATH = 'skydoc/templates'
CSS_PATH = 'skydoc/sass'

CSS_FILE = 'main.css'
CSS_DIR = 'css'


# TODO(dzc): Remove this workaround once we switch to a self-contained Python
# binary format such as PEX.
def _runfile_path(path):
  """Prepends the given path with the path to the root of the runfiles tree.

  The files that skydoc depend on are generated in the Bazel runfiles tree.
  There is no built-in way to get the root of the runfiles tree but it is
  possible to generate it from sys.argv[0]. The code here is adapted from the
  Bazel Python launcher stub.

  Args:
    path: The relative path from the root of the runfiles tree.

  Returns:
    Returns path prepended with the absolute path to the root of the runfiles
    tree.
  """
  script_filename = os.path.abspath(sys.argv[0])
  while True:
    runfiles_dir = script_filename + '.runfiles'
    if os.path.isdir(runfiles_dir):
      break

    # Follow a symlink and try again.
    if os.path.islink(script_filename):
      link = os.readlink(script_filename)
      script_filename = os.path.join(os.path.dirname(script_filename), link)
      continue

    matchobj = re.match("(.*\.runfiles)/.*", os.path.abspath(sys.argv[0]))
    if matchobj:
      runfiles_dir = matchobj.group(1)
      break

    raise AssertionError('Cannot find .runfiles directory.')
  return os.path.join(runfiles_dir, WORKSPACE_DIR, path)

def merge_languages(macro_language, rule_language):
  for rule in rule_language.rule:
    new_rule = macro_language.rule.add()
    new_rule.CopyFrom(rule)
  return macro_language

class MarkdownWriter(object):
  """Writer for generating documentation in Markdown."""

  def __init__(self, output_dir, output_file, output_zip):
    self.__output_dir = output_dir
    self.__output_file = output_file
    self.__output_zip = output_zip

  def write(self, rulesets):
    """Write the documentation for the rules contained in rulesets."""
    try:
      temp_dir = tempfile.mkdtemp()
      output_files = []
      for ruleset in rulesets:
        output_files.append(self._write_ruleset(temp_dir, ruleset))

      if self.__output_zip:
        # We are generating a zip archive containing all the documentation.
        # Write each documentation file generated in the temp directory to the
        # zip file.
        with zipfile.ZipFile(self.__output_file, 'w') as zf:
          for output_file in output_files:
            zf.write(output_file, os.path.basename(output_file))
      else:
        # We are generating documentation in the output_dir directory. Copy each
        # documentation file to output_dir.
        for output_file in output_files:
          shutil.copyfile(
              output_file,
              os.path.join(self.__output_dir, os.path.basename(output_file)))

    finally:
      # Delete temporary directory.
      shutil.rmtree(temp_dir)

  def _write_ruleset(self, output_dir, ruleset):
    # Load template and render Markdown.
    env = jinja2.Environment(
        loader=jinja2.FileSystemLoader(_runfile_path(TEMPLATE_PATH)),
        line_statement_prefix='%')
    template = env.get_template('markdown.jinja')
    out = template.render(ruleset=ruleset)

    # Write output to file.
    output_file = "%s/%s.md" % (output_dir, ruleset.name)
    with open(output_file, "w") as f:
      f.write(out)
    return output_file

class HtmlWriter(object):
  """Writer for generating documentation in HTML."""

  def __init__(self, output_dir, output_file, output_zip):
    self.__output_dir = output_dir
    self.__output_file = output_file
    self.__output_zip = output_zip
    self.__env = jinja2.Environment(
        loader=jinja2.FileSystemLoader(_runfile_path(TEMPLATE_PATH)),
        line_statement_prefix='%')

  def write(self, rulesets):
    # Generate navigation used for all rules.
    nav_template = self.__env.get_template('nav.jinja')
    nav = nav_template.render(rulesets=rulesets)

    try:
      temp_dir = tempfile.mkdtemp()
      output_files = []
      for ruleset in rulesets:
        output_files.append(self._write_ruleset(temp_dir, ruleset, nav))

      if self.__output_zip:
        with zipfile.ZipFile(self.__output_file, 'w') as zf:
          for output_file in output_files:
            zf.write(output_file, os.path.basename(output_file))
          zf.write(os.path.join(_runfile_path(CSS_PATH), CSS_FILE),
                                'css/%s' % CSS_FILE)
      else:
        for output_file in output_files:
          shutil.copyfile(
              output_file,
              os.path.join(self.__output_dir, os.path.basename(output_file)))

        # Copy CSS file.
        css_dir = os.path.join(self.__output_dir, CSS_DIR)
        os.mkdir(css_dir)
        shutil.copyfile(os.path.join(_runfile_path(CSS_PATH), CSS_FILE),
                        os.path.join(css_dir, CSS_FILE))
    finally:
      # Delete temporary directory.
      shutil.rmtree(temp_dir)

  def _write_ruleset(self, output_dir, ruleset, nav):
    # Load template and render markdown.
    template = self.__env.get_template('html.jinja')
    out = template.render(ruleset=ruleset, nav=nav)

    # Write output to file.
    output_file = "%s/%s.html" % (output_dir, ruleset.name)
    with open(output_file, "w") as f:
      f.write(out)
    return output_file

def main(argv):
  if FLAGS.output_dir and FLAGS.output_file:
    sys.stderr.write('Only one of --output_dir or --output_file can be set.')
    sys.exit(1)

  if not FLAGS.output_dir:
    FLAGS.output_dir = DEFAULT_OUTPUT_DIR
  if not FLAGS.output_file:
    FLAGS.output_file = DEFAULT_OUTPUT_FILE

  rulesets = []
  for bzl_file in argv[1:]:
    macro_doc_extractor = macro_extractor.MacroDocExtractor()
    rule_doc_extractor = rule_extractor.RuleDocExtractor()
    macro_doc_extractor.parse_bzl(bzl_file)
    rule_doc_extractor.parse_bzl(bzl_file)
    merged_language = merge_languages(macro_doc_extractor.proto(),
                                      rule_doc_extractor.proto())
    file_basename = os.path.basename(bzl_file)
    rulesets.append(rule.RuleSet(file_basename, merged_language,
                                 macro_doc_extractor.title,
                                 macro_doc_extractor.description))

  if FLAGS.format == "markdown":
    markdown_writer = MarkdownWriter(FLAGS.output_dir, FLAGS.output_file,
                                     FLAGS.zip)
    markdown_writer.write(rulesets)
  elif FLAGS.format == "html":
    html_writer = HtmlWriter(FLAGS.output_dir, FLAGS.output_file, FLAGS.zip)
    html_writer.write(rulesets)
  else:
    sys.stderr.write(
        'Invalid output format: %s. Possible values are markdown and html'
        % FLAGS.format)

if __name__ == '__main__':
  main(FLAGS(sys.argv))
