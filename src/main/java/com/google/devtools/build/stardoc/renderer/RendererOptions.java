// Copyright 2023 The Bazel Authors. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package com.google.devtools.build.stardoc.renderer;

import com.beust.jcommander.Parameter;
import com.beust.jcommander.Parameters;

/** Contains options for running {@link RendererMain}. */
@Parameters(separators = "=")
class RendererOptions {

  @Parameter(
      names = "--input",
      required = true,
      description = "The path of the proto file that will be converted to markdown")
  String inputPath;

  @Parameter(
      names = "--output",
      required = true,
      description = "The path of the file to output documentation into")
  String outputFilePath;

  @Parameter(
      names = "--header_template",
      required = true,
      description = "The template for the header string")
  String headerTemplateFilePath;

  @Parameter(
      names = "--table_of_contents_template",
      description = "The template for the table of contents string")
  String tableOfContentsTemplateFilePath;

  @Parameter(
      names = "--rule_template",
      required = true,
      description = "The template for the documentation of a rule")
  String ruleTemplateFilePath;

  @Parameter(
      names = "--provider_template",
      required = true,
      description = "The template for the documentation of a provider")
  String providerTemplateFilePath;

  @Parameter(
      names = "--func_template",
      required = true,
      description = "The template for the documentation of a function")
  String funcTemplateFilePath;

  @Parameter(
      names = "--aspect_template",
      required = true,
      description = "The template for the documentation of an aspect")
  String aspectTemplateFilePath;

  @Parameter(
      names = "--repository_rule_template",
      required = true,
      description = "The template for the documentation of a repository rule")
  String repositoryRuleTemplateFilePath;

  @Parameter(
      names = "--module_extension_template",
      required = true,
      description = "The template for the documentation of a module extension")
  String moduleExtensionTemplateFilePath;

  @Parameter(names = "--footer_template", description = "The template for the footer string")
  String footerTemplateFilePath;

  @Parameter(
      names = "--stamping_stable_status_file",
      description = "The file path to the stable status file for stamping")
  String stampingStableStatusFilePath;

  @Parameter(
      names = "--stamping_volatile_status_file",
      description = "The file path to the volatile status file for stamping")
  String stampingVolatileStatusFilePath;

  @Parameter(
      names = {"--help", "-h"},
      description = "Print help and exit",
      help = true)
  boolean printHelp;
}
