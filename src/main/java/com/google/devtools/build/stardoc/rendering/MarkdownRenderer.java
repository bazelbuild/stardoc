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

package com.google.devtools.build.stardoc.rendering;

import static com.google.common.collect.ImmutableList.toImmutableList;
import static com.google.common.collect.ImmutableSet.toImmutableSet;
import static java.nio.charset.StandardCharsets.UTF_8;

import com.google.common.collect.ImmutableList;
import com.google.common.collect.ImmutableMap;
import com.google.devtools.build.lib.starlarkdocextract.StardocOutputProtos.AspectInfo;
import com.google.devtools.build.lib.starlarkdocextract.StardocOutputProtos.FunctionParamInfo;
import com.google.devtools.build.lib.starlarkdocextract.StardocOutputProtos.ModuleExtensionInfo;
import com.google.devtools.build.lib.starlarkdocextract.StardocOutputProtos.ModuleInfo;
import com.google.devtools.build.lib.starlarkdocextract.StardocOutputProtos.ProviderFieldInfo;
import com.google.devtools.build.lib.starlarkdocextract.StardocOutputProtos.ProviderInfo;
import com.google.devtools.build.lib.starlarkdocextract.StardocOutputProtos.RepositoryRuleInfo;
import com.google.devtools.build.lib.starlarkdocextract.StardocOutputProtos.RuleInfo;
import com.google.devtools.build.lib.starlarkdocextract.StardocOutputProtos.StarlarkFunctionInfo;
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
import java.util.List;

/** Produces stardoc output in markdown form. */
public class MarkdownRenderer {

  public interface Renderer<T> {
    String render(T info) throws IOException;
  }

  // TODO(kendalllane): Refactor MarkdownRenderer to take in something other than filepaths.
  private final String headerTemplateFilename;
  private final String tableOfContentsTemplateFilename;
  private final String ruleTemplateFilename;
  private final String providerTemplateFilename;
  private final String functionTemplateFilename;
  private final String aspectTemplateFilename;
  private final String repositoryRuleTemplateFilename;
  private final String moduleExtensionTemplateFilename;
  private final String extensionBzlFile;
  private final String footerTemplateFilename;
  private final Stamping stamping;

  public MarkdownRenderer(
      String headerTemplate,
      String tableOfContentsTemplateFilename,
      String ruleTemplate,
      String providerTemplate,
      String functionTemplate,
      String aspectTemplate,
      String repositoryRuleTemplate,
      String moduleExtensionTemplate,
      String extensionBzlFile,
      String footerTemplate,
      Stamping stamping) {
    this.headerTemplateFilename = headerTemplate;
    this.tableOfContentsTemplateFilename = tableOfContentsTemplateFilename;
    this.ruleTemplateFilename = ruleTemplate;
    this.providerTemplateFilename = providerTemplate;
    this.functionTemplateFilename = functionTemplate;
    this.aspectTemplateFilename = aspectTemplate;
    this.repositoryRuleTemplateFilename = repositoryRuleTemplate;
    this.moduleExtensionTemplateFilename = moduleExtensionTemplate;
    this.extensionBzlFile = extensionBzlFile;
    this.footerTemplateFilename = footerTemplate;
    this.stamping = stamping;
  }

  /**
   * Returns a markdown header string that should appear at the top of Stardoc's output, providing a
   * summary for the input Starlark module.
   */
  public String renderMarkdownHeader(ModuleInfo moduleInfo) throws IOException {
    ImmutableMap<String, Object> vars =
        ImmutableMap.of(
            "util",
            new MarkdownUtil(extensionBzlFile),
            "moduleDocstring",
            moduleInfo.getModuleDocstring(),
            "stamping",
            stamping);
    Reader reader = readerFromPath(headerTemplateFilename);
    try {
      return Template.parseFrom(reader).evaluate(vars);
    } catch (ParseException | EvaluationException e) {
      throw new IOException(e);
    }
  }

  /**
   * Returns a markdown string of a Table of Contents, appearing after the header and before the
   * documentation.
   */
  public String renderTableOfContents(
      List<RuleInfo> ruleInfos,
      List<ProviderInfo> providerInfos,
      List<StarlarkFunctionInfo> starlarkFunctions,
      List<AspectInfo> aspectInfos,
      List<RepositoryRuleInfo> repositoryRuleInfos,
      List<ModuleExtensionInfo> moduleExtensionInfos)
      throws IOException {

    ImmutableMap<String, Object> vars =
        ImmutableMap.of(
            "util", new MarkdownUtil(extensionBzlFile),
            "ruleInfos", ruleInfos,
            "providerInfos", providerInfos,
            "functionInfos", starlarkFunctions,
            "aspectInfos", aspectInfos,
            "repositoryRuleInfos", repositoryRuleInfos,
            "moduleExtensionInfos", moduleExtensionInfos);
    Reader reader = readerFromPath(tableOfContentsTemplateFilename);
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
  public String render(RuleInfo ruleInfo) throws IOException {
    ImmutableMap<String, Object> vars =
        ImmutableMap.of(
            "util",
            new MarkdownUtil(extensionBzlFile),
            "ruleName",
            ruleInfo.getRuleName(),
            "ruleInfo",
            ruleInfo);
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
   *
   * <p>For evaluating the provider template, populates the the following constants:
   *
   * <ul>
   *   <li>util - a {@link MarkdownUtil} object
   *   <li>providerName - the provider's name
   *   <li>providerInfo - the {@link ProviderInfo} proto
   *   <li>initParamsWithInferredDocs - the list of the init callback's {@link FunctionParamInfo}
   *       protos, with any undocumented parameters inheriting the doc string of the provider's
   *       field with the same name; or an empty list of the provider doesn't have an init callback
   *   <li>initParamNamesEqualFieldNames - true iff the provider has an init callback and the set of
   *       names of the init callback's parameters equals the set of names of the provider's fields
   *   <li>initParamsHaveDefaultValues - true iff the provider has an init callback and at least one
   *       of the init callback's parameters has a default value specified
   *   <li>initParamsHaveDistinctDocs - true iff the provider has an init callback and at least one
   *       of the init callback's parameters has a docstring which is non-empty and not equal to the
   *       corresponding field's docstring.
   * </ul>
   */
  public String render(ProviderInfo providerInfo) throws IOException {
    ImmutableMap.Builder<String, String> fieldDocsBuilder = ImmutableMap.builder();
    for (ProviderFieldInfo fieldInfo : providerInfo.getFieldInfoList()) {
      fieldDocsBuilder.put(fieldInfo.getName(), fieldInfo.getDocString());
    }
    ImmutableMap<String, String> fieldDocs = fieldDocsBuilder.buildOrThrow();

    ImmutableList<FunctionParamInfo> initParamsWithInferredDocs;
    if (providerInfo.hasInit()) {
      initParamsWithInferredDocs =
          providerInfo.getInit().getParameterList().stream()
              .map(param -> withInferredDoc(param, fieldDocs))
              .collect(toImmutableList());
    } else {
      initParamsWithInferredDocs = ImmutableList.of();
    }
    boolean initParamNamesEqualFieldNames =
        providerInfo.hasInit()
            && providerInfo.getInit().getParameterList().stream()
                .map(FunctionParamInfo::getName)
                .collect(toImmutableSet())
                .equals(
                    providerInfo.getFieldInfoList().stream()
                        .map(ProviderFieldInfo::getName)
                        .collect(toImmutableSet()));
    boolean initParamsHaveDefaultValues =
        providerInfo.hasInit()
            && providerInfo.getInit().getParameterList().stream()
                .filter(param -> !param.getDefaultValue().isEmpty())
                .findFirst()
                .isPresent();
    boolean initParamsHaveDistinctDocs =
        providerInfo.hasInit()
            && providerInfo.getInit().getParameterList().stream()
                .filter(
                    param ->
                        !param.getDocString().isEmpty()
                            && !param.getDocString().equals(fieldDocs.get(param.getName())))
                .findFirst()
                .isPresent();
    ImmutableMap<String, Object> vars =
        ImmutableMap.of(
            "util",
            new MarkdownUtil(extensionBzlFile),
            "providerName",
            providerInfo.getProviderName(),
            "providerInfo",
            providerInfo,
            "initParamsWithInferredDocs",
            initParamsWithInferredDocs,
            "initParamNamesEqualFieldNames",
            initParamNamesEqualFieldNames,
            "initParamsHaveDefaultValues",
            initParamsHaveDefaultValues,
            "initParamsHaveDistinctDocs",
            initParamsHaveDistinctDocs);
    Reader reader = readerFromPath(providerTemplateFilename);
    try {
      return Template.parseFrom(reader).evaluate(vars);
    } catch (ParseException | EvaluationException e) {
      throw new IOException(e);
    }
  }

  private static FunctionParamInfo withInferredDoc(
      FunctionParamInfo paramInfo, ImmutableMap<String, String> fallbackDocs) {
    if (paramInfo.getDocString().isEmpty() && fallbackDocs.containsKey(paramInfo.getName())) {
      return paramInfo.toBuilder()
          .clearDocString()
          .setDocString(fallbackDocs.get(paramInfo.getName()))
          .build();
    } else {
      return paramInfo;
    }
  }

  /**
   * Returns a markdown rendering of a user-defined function's documentation for the function info
   * object.
   */
  public String render(StarlarkFunctionInfo functionInfo) throws IOException {
    ImmutableMap<String, Object> vars =
        ImmutableMap.of("util", new MarkdownUtil(extensionBzlFile), "funcInfo", functionInfo);
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
  public String render(AspectInfo aspectInfo) throws IOException {
    ImmutableMap<String, Object> vars =
        ImmutableMap.of(
            "util",
            new MarkdownUtil(extensionBzlFile),
            "aspectName",
            aspectInfo.getAspectName(),
            "aspectInfo",
            aspectInfo);
    Reader reader = readerFromPath(aspectTemplateFilename);
    try {
      return Template.parseFrom(reader).evaluate(vars);
    } catch (ParseException | EvaluationException e) {
      throw new IOException(e);
    }
  }

  /**
   * Returns a markdown rendering of repository rule documentation for the given repository rule
   * information object with the given name.
   */
  public String render(RepositoryRuleInfo repositoryRuleInfo) throws IOException {
    ImmutableMap<String, Object> vars =
        ImmutableMap.of(
            "util",
            new MarkdownUtil(extensionBzlFile),
            "ruleName",
            repositoryRuleInfo.getRuleName(),
            "ruleInfo",
            repositoryRuleInfo);
    Reader reader = readerFromPath(repositoryRuleTemplateFilename);
    try {
      return Template.parseFrom(reader).evaluate(vars);
    } catch (ParseException | EvaluationException e) {
      throw new IOException(e);
    }
  }

  /**
   * Returns a markdown rendering of module extension documentation for the given module extension
   * information object with the given name.
   */
  public String render(ModuleExtensionInfo moduleExtensionInfo) throws IOException {
    ImmutableMap<String, Object> vars =
        ImmutableMap.of(
            "util",
            new MarkdownUtil(extensionBzlFile),
            "extensionName",
            moduleExtensionInfo.getExtensionName(),
            "extensionInfo",
            moduleExtensionInfo);
    Reader reader = readerFromPath(moduleExtensionTemplateFilename);
    try {
      return Template.parseFrom(reader).evaluate(vars);
    } catch (ParseException | EvaluationException e) {
      throw new IOException(e);
    }
  }

  /** Returns a markdown header string that should appear at the end of Stardoc's output. */
  public String renderMarkdownFooter(ModuleInfo moduleInfo) throws IOException {
    ImmutableMap<String, Object> vars =
        ImmutableMap.of("util", new MarkdownUtil(extensionBzlFile), "stamping", stamping);
    Reader reader = readerFromPath(footerTemplateFilename);
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
