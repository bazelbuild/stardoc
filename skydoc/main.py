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

from __future__ import print_function
# internal imports
import gflags
import jinja2
import mistune
import os
import posixpath
import re
import shutil
import sys
import tempfile
import zipfile

from bazel_tools.tools.python.runfiles import runfiles as runfiles_lib
from skydoc import common
from skydoc import load_extractor
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
gflags.DEFINE_string('strip_prefix', '',
    'The directory prefix to strip from all generated docs, which are '
    'generated in subdirectories that match the package structure of the '
    'input .bzl files. The prefix to strip must be common to all .bzl files; '
    'otherwise, skydoc will raise an error.')
gflags.DEFINE_bool('overview', False, 'Whether to generate an overview page')
gflags.DEFINE_string('overview_filename', 'index',
    'The file name to use for the overview page.')
gflags.DEFINE_string('link_ext', 'html',
    'The file extension used for links in the generated documentation')
gflags.DEFINE_string('site_root', '',
    'The site root to be prepended to all URLs in the generated documentation')

FLAGS = gflags.FLAGS

DEFAULT_OUTPUT_DIR = '.'
DEFAULT_OUTPUT_FILE = 'skydoc.zip'

WORKSPACE_DIR = 'io_bazel_skydoc'
TEMPLATE_PATH = 'skydoc/templates'
CSS_PATH = 'skydoc/sass'

CSS_FILE = 'main.css'

def _create_jinja_environment(runfiles, site_root, link_ext):
  def _Load(path):
    return runfiles.Rlocation(posixpath.join(WORKSPACE_DIR, TEMPLATE_PATH,
                                             path))

  env = jinja2.Environment(
      loader=jinja2.FunctionLoader(_Load),
      keep_trailing_newline=True,
      line_statement_prefix='%')
  env.filters['markdown'] = lambda text: jinja2.Markup(mistune.markdown(text))
  env.filters['doc_link'] = (
      lambda fname: site_root + '/' + fname + '.' + link_ext)
  env.filters['link'] = lambda fname: site_root + '/' + fname
  return env


# TODO(dzc): Remove this workaround once we switch to a self-contained Python
# binary format such as PEX.
def _runfile_path(runfiles, path):
  return runfiles.Rlocation(posixpath.join(WORKSPACE_DIR, path))

def merge_languages(macro_language, rule_language):
  for rule in rule_language.rule:
    new_rule = macro_language.rule.add()
    new_rule.CopyFrom(rule)
  return macro_language

class WriterOptions(object):
  def __init__(self, output_dir, output_file, output_zip, overview,
               overview_filename, link_ext, site_root):
    self.output_dir = output_dir
    self.output_file = output_file
    self.output_zip = output_zip
    self.overview = overview
    self.overview_filename = overview_filename
    self.link_ext = link_ext

    self.site_root = site_root
    if len(self.site_root) > 0 and self.site_root.endswith('/'):
        self.site_root = self.site_root[:-1]

class MarkdownWriter(object):
  """Writer for generating documentation in Markdown."""

  def __init__(self, writer_options, runfiles):
    self.__options = writer_options
    self.__env = _create_jinja_environment(runfiles,
                                           self.__options.site_root,
                                           self.__options.link_ext)

  def write(self, rulesets):
    """Write the documentation for the rules contained in rulesets."""
    try:
      temp_dir = tempfile.mkdtemp()
      output_files = []
      for ruleset in rulesets:
        if not ruleset.empty():
          output_files.append(self._write_ruleset(temp_dir, ruleset))
      if self.__options.overview:
        output_files.append(self._write_overview(temp_dir, rulesets))

      if self.__options.output_zip:
        # We are generating a zip archive containing all the documentation.
        # Write each documentation file generated in the temp directory to the
        # zip file.
        with zipfile.ZipFile(self.__options.output_file, 'w') as zf:
          for output_file, output_path in output_files:
            zf.write(output_file, output_path)
      else:
        # We are generating documentation in the output_dir directory. Copy each
        # documentation file to output_dir.
        for output_file, output_path in output_files:
          dest_file = os.path.join(self.__options.output_dir, output_path)
          dest_dir = os.path.dirname(dest_file)
          if not os.path.exists(dest_dir):
            os.makedirs(dest_dir)
          shutil.copyfile(output_file, dest_file)

    finally:
      # Delete temporary directory.
      shutil.rmtree(temp_dir)

  def _write_ruleset(self, output_dir, ruleset):
    # Load template and render Markdown.
    template = self.__env.get_template('markdown.jinja')
    out = template.render(ruleset=ruleset)

    # Write output to file. Output files are created in a directory structure
    # that matches that of the input file.
    output_path = ruleset.output_file + '.md'
    output_file = "%s/%s" % (output_dir, output_path)
    file_dirname = os.path.dirname(output_file)
    if not os.path.exists(file_dirname):
      os.makedirs(file_dirname)
    with open(output_file, "w") as f:
      f.write(out)
    return (output_file, output_path)

  def _write_overview(self, output_dir, rulesets):
    template = self.__env.get_template('markdown_overview.jinja')
    out = template.render(rulesets=rulesets)

    output_file = "%s/%s.md" % (output_dir, self.__options.overview_filename)
    with open(output_file, "w") as f:
      f.write(out)
    return (output_file, "%s.md" % self.__options.overview_filename)

class HtmlWriter(object):
  """Writer for generating documentation in HTML."""

  def __init__(self, options, runfiles):
    self.__runfiles = runfiles
    self.__options = options
    self.__env = _create_jinja_environment(runfiles,
                                           self.__options.site_root,
                                           self.__options.link_ext)

  def write(self, rulesets):
    # Generate navigation used for all rules.
    nav_template = self.__env.get_template('nav.jinja')
    nav = nav_template.render(
        rulesets=rulesets,
        overview=self.__options.overview,
        overview_filename=self.__options.overview_filename)

    try:
      temp_dir = tempfile.mkdtemp()
      output_files = []
      for ruleset in rulesets:
        if not ruleset.empty():
          output_files.append(self._write_ruleset(temp_dir, ruleset, nav))
      if self.__options.overview:
        output_files.append(self._write_overview(temp_dir, rulesets, nav))

      if self.__options.output_zip:
        with zipfile.ZipFile(self.__options.output_file, 'w') as zf:
          for output_file, output_path in output_files:
            zf.write(output_file, output_path)
          zf.write(_runfile_path(self.__runfiles,
                                 posixpath.join(CSS_PATH, CSS_FILE)),
                   CSS_FILE)
      else:
        for output_file, output_path in output_files:
          dest_file = os.path.join(self.__options.output_dir, output_path)
          dest_dir = os.path.dirname(dest_file)
          if not os.path.exists(dest_dir):
            os.makedirs(dest_dir)
          shutil.copyfile(output_file, dest_file)

        # Copy CSS file.
        shutil.copyfile(_runfile_path(self.__runfiles,
                                      posixpath.join(CSS_PATH, CSS_FILE)),
                        os.path.join(self.__options.output_dir, CSS_FILE))
    finally:
      # Delete temporary directory.
      shutil.rmtree(temp_dir)

  def _write_ruleset(self, output_dir, ruleset, nav):
    # Load template and render markdown.
    template = self.__env.get_template('html.jinja')
    out = template.render(title=ruleset.title, ruleset=ruleset, nav=nav)

    # Write output to file. Output files are created in a directory structure
    # that matches that of the input file.
    output_path = ruleset.output_file + '.html'
    output_file = "%s/%s" % (output_dir, output_path)
    file_dirname = os.path.dirname(output_file)
    if not os.path.exists(file_dirname):
      os.makedirs(file_dirname)
    with open(output_file, "w") as f:
      f.write(out)
    return (output_file, output_path)

  def _write_overview(self, output_dir, rulesets, nav):
    template = self.__env.get_template('html_overview.jinja')
    out = template.render(title='Overview', rulesets=rulesets, nav=nav)

    output_file = "%s/%s.html" % (output_dir, self.__options.overview_filename)
    with open(output_file, "w") as f:
      f.write(out)
    return (output_file, "%s.html" % self.__options.overview_filename)

def main(argv):
  if FLAGS.output_dir and FLAGS.output_file:
    sys.stderr.write('Only one of --output_dir or --output_file can be set.')
    sys.exit(1)

  if not FLAGS.output_dir:
    FLAGS.output_dir = DEFAULT_OUTPUT_DIR
  if not FLAGS.output_file:
    FLAGS.output_file = DEFAULT_OUTPUT_FILE

  bzl_files = argv[1:]
  try:
    strip_prefix = common.validate_strip_prefix(FLAGS.strip_prefix, bzl_files)
  except common.InputError as err:
    print(err.message)
    sys.exit(1)

  runfiles = runfiles_lib.Create()
  if not runfiles:
    # TODO(laszlocsomor): fix https://github.com/bazelbuild/bazel/issues/6212
    # and remove this if-block once Bazel is released with that bugfix.
    if (not os.environ.get("RUNFILES_DIR") and
        not os.environ.get("RUNFILES_MANIFEST_FILE")):
      argv0 = sys.argv[0]
      pos = argv0.rfind('%s%s%s' % (os.sep, WORKSPACE_DIR, os.sep))
      if pos > -1:
        dirpath = argv0[0:pos]
        if not os.path.isdir(dirpath):
          print("ERROR: Cannot access runfiles directory (%s)" % dirpath)
          sys.exit(1)
        runfiles = runfiles_lib.CreateDirectoryBased(dirpath)

  if not runfiles:
    print("ERROR: Cannot load runfiles")
    sys.exit(1)

  rulesets = []
  load_sym_extractor = load_extractor.LoadExtractor()
  for bzl_file in bzl_files:
    load_symbols = []
    try:
      load_symbols = load_sym_extractor.extract(bzl_file)
    except load_extractor.LoadExtractorError as e:
      print("ERROR: Error extracting loaded symbols from %s: %s" %
            (bzl_file, str(e)))
      sys.exit(2)

    # TODO(dzc): Make MacroDocExtractor and RuleDocExtractor stateless.
    macro_doc_extractor = macro_extractor.MacroDocExtractor()
    rule_doc_extractor = rule_extractor.RuleDocExtractor()
    macro_doc_extractor.parse_bzl(bzl_file)
    rule_doc_extractor.parse_bzl(bzl_file, load_symbols)
    merged_language = merge_languages(macro_doc_extractor.proto(),
                                      rule_doc_extractor.proto())
    rulesets.append(
        rule.RuleSet(bzl_file, merged_language, macro_doc_extractor.title,
                     macro_doc_extractor.description, strip_prefix,
                     FLAGS.format))
  writer_options = WriterOptions(
      FLAGS.output_dir, FLAGS.output_file, FLAGS.zip, FLAGS.overview,
      FLAGS.overview_filename, FLAGS.link_ext, FLAGS.site_root)
  if FLAGS.format == "markdown":
    markdown_writer = MarkdownWriter(writer_options, runfiles)
    markdown_writer.write(rulesets)
  elif FLAGS.format == "html":
    html_writer = HtmlWriter(writer_options, runfiles)
    html_writer.write(rulesets)
  else:
    sys.stderr.write(
        'Invalid output format: %s. Possible values are markdown and html'
        % FLAGS.format)

if __name__ == '__main__':
  main(FLAGS(sys.argv))
