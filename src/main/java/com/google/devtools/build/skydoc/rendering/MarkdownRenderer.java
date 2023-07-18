// Copyright 2018 The Bazel Authors. All rights reserved.
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

package com.google.devtools.build.skydoc.rendering;

import static java.nio.charset.StandardCharsets.UTF_8;

import com.google.common.collect.ImmutableMap;
import com.google.devtools.build.skydoc.rendering.proto.StardocOutputProtos.AspectInfo;
import com.google.devtools.build.skydoc.rendering.proto.StardocOutputProtos.ModuleInfo;
import com.google.devtools.build.skydoc.rendering.proto.StardocOutputProtos.ProviderInfo;
import com.google.devtools.build.skydoc.rendering.proto.StardocOutputProtos.RuleInfo;
import com.google.devtools.build.skydoc.rendering.proto.StardocOutputProtos.StarlarkFunctionInfo;
import com.google.escapevelocity.EvaluationException;
import com.google.escapevelocity.ParseException;
import com.google.escapevelocity.Template;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

/** Produces skydoc output in markdown form. */
public class MarkdownRenderer {
  // TODO(kendalllane): Refactor MarkdownRenderer to take in something other than filepaths.
  private final String headerTemplateFilename;
  private final String ruleTemplateFilename;
  private final String providerTemplateFilename;
  private final String functionTemplateFilename;
  private final String aspectTemplateFilename;

  public MarkdownRenderer(
      String headerTemplate,
      String ruleTemplate,
      String providerTemplate,
      String functionTemplate,
      String aspectTemplate) {
    this.headerTemplateFilename = headerTemplate;
    this.ruleTemplateFilename = ruleTemplate;
    this.providerTemplateFilename = providerTemplate;
    this.functionTemplateFilename = functionTemplate;
    this.aspectTemplateFilename = aspectTemplate;
  }

  /**
   * Returns a markdown header string that should appear at the top of Stardoc's output, providing a
   * summary for the input Starlark module.
   */
  public String renderMarkdownHeader(ModuleInfo moduleInfo) throws IOException {
    ImmutableMap<String, Object> vars =
        ImmutableMap.of(
            "util", new MarkdownUtil(), "moduleDocstring", moduleInfo.getModuleDocstring());
    Reader reader = readerFromPath(headerTemplateFilename);
    try {
      return Template.parseFrom(reader).evaluate(vars);
    } catch (ParseException | EvaluationException e) {
      throw new IOException(e);
    }
  }

  /**
   * Returns a markdown rendering of rule documentation for the given rule information object with
   * the given rule name.
   */
  public String render(String ruleName, RuleInfo ruleInfo) throws IOException {
    ImmutableMap<String, Object> vars =
        ImmutableMap.of("util", new MarkdownUtil(), "ruleName", ruleName, "ruleInfo", ruleInfo);
    Reader reader = readerFromPath(ruleTemplateFilename);
    try {
      return Template.parseFrom(reader).evaluate(vars);
    } catch (ParseException | EvaluationException e) {
      throw new IOException(e);
    }
  }

  /**
   * Returns a markdown rendering of provider documentation for the given provider information
   * object with the given name.
   */
  public String render(String providerName, ProviderInfo providerInfo) throws IOException {
    ImmutableMap<String, Object> vars =
        ImmutableMap.of(
            "util", new MarkdownUtil(), "providerName", providerName, "providerInfo", providerInfo);
    Reader reader = readerFromPath(providerTemplateFilename);
    try {
      return Template.parseFrom(reader).evaluate(vars);
    } catch (ParseException | EvaluationException e) {
      throw new IOException(e);
    }
  }

  /**
   * Returns a markdown rendering of a user-defined function's documentation for the function info
   * object.
   */
  public String render(StarlarkFunctionInfo functionInfo) throws IOException {
    ImmutableMap<String, Object> vars =
        ImmutableMap.of("util", new MarkdownUtil(), "funcInfo", functionInfo);
    Reader reader = readerFromPath(functionTemplateFilename);
    try {
      return Template.parseFrom(reader).evaluate(vars);
    } catch (ParseException | EvaluationException e) {
      throw new IOException(e);
    }
  }

  /**
   * Returns a markdown rendering of aspect documentation for the given aspect information object
   * with the given aspect name.
   */
  public String render(String aspectName, AspectInfo aspectInfo) throws IOException {
    ImmutableMap<String, Object> vars =
        ImmutableMap.of(
            "util", new MarkdownUtil(), "aspectName", aspectName, "aspectInfo", aspectInfo);
    Reader reader = readerFromPath(aspectTemplateFilename);
    try {
      return Template.parseFrom(reader).evaluate(vars);
    } catch (ParseException | EvaluationException e) {
      throw new IOException(e);
    }
  }

  /**
   * Returns a reader from the given path.
   *
   * @param filePath The given path, either a filesystem path or a java Resource
   */
  private static Reader readerFromPath(String filePath) throws IOException {
    if (Files.exists(Paths.get(filePath))) {
      Path path = Paths.get(filePath);
      return Files.newBufferedReader(path, UTF_8);
    }

    InputStream inputStream = MarkdownRenderer.class.getClassLoader().getResourceAsStream(filePath);
    if (inputStream == null) {
      throw new FileNotFoundException(filePath + " was not found as a resource.");
    }
    return new InputStreamReader(inputStream, UTF_8);
  }
}
