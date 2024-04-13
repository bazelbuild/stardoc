// Copyright 2019 The Bazel Authors. All rights reserved.
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

package com.google.devtools.build.skydoc.renderer;

import static com.google.common.collect.ImmutableList.toImmutableList;
import static java.nio.charset.StandardCharsets.UTF_8;
import static java.util.Comparator.comparing;

import com.beust.jcommander.JCommander;
import com.google.common.collect.ImmutableList;
import com.google.common.collect.ImmutableMap;
import com.google.devtools.build.skydoc.rendering.MarkdownRenderer;
import com.google.devtools.build.skydoc.rendering.MarkdownRenderer.Renderer;
import com.google.devtools.build.skydoc.rendering.Stamping;
import com.google.devtools.build.skydoc.rendering.proto.StardocOutputProtos.AspectInfo;
import com.google.devtools.build.skydoc.rendering.proto.StardocOutputProtos.AttributeInfo;
import com.google.devtools.build.skydoc.rendering.proto.StardocOutputProtos.ModuleExtensionInfo;
import com.google.devtools.build.skydoc.rendering.proto.StardocOutputProtos.ModuleExtensionTagClassInfo;
import com.google.devtools.build.skydoc.rendering.proto.StardocOutputProtos.ModuleInfo;
import com.google.devtools.build.skydoc.rendering.proto.StardocOutputProtos.ProviderInfo;
import com.google.devtools.build.skydoc.rendering.proto.StardocOutputProtos.RepositoryRuleInfo;
import com.google.devtools.build.skydoc.rendering.proto.StardocOutputProtos.RuleInfo;
import com.google.devtools.build.skydoc.rendering.proto.StardocOutputProtos.StarlarkFunctionInfo;
import com.google.protobuf.ExtensionRegistry;
import com.google.protobuf.InvalidProtocolBufferException;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Comparator;
import java.util.List;

/**
 * Main entry point for Renderer binary.
 *
 * <p>This Renderer takes in raw stardoc_proto protos as input and produces rich markdown output.
 */
public final class RendererMain {

  public static void main(String[] args) throws IOException {

    RendererOptions rendererOptions = new RendererOptions();
    JCommander jcommander = JCommander.newBuilder().addObject(rendererOptions).build();
    jcommander.setProgramName("renderer");
    jcommander.parse(args);
    if (rendererOptions.printHelp) {
      jcommander.usage();
      return;
    }

    String inputPath = rendererOptions.inputPath;
    String outputPath = rendererOptions.outputFilePath;

    Stamping stamping;
    if (rendererOptions.stampingStableStatusFilePath != null &&
        rendererOptions.stampingVolatileStatusFilePath != null) {
      stamping = Stamping.read(
          rendererOptions.stampingStableStatusFilePath,
          rendererOptions.stampingVolatileStatusFilePath);
    } else {
      stamping = Stamping.empty();
    }

    try (PrintWriter printWriter =
        new PrintWriter(outputPath, UTF_8) {
          // Use consistent line endings on all platforms.
          @Override
          public void println() {
            write("\n");
          }
        }) {
      ModuleInfo moduleInfo =
          ModuleInfo.parseFrom(
              new FileInputStream(inputPath), ExtensionRegistry.getEmptyRegistry());

      MarkdownRenderer renderer =
          new MarkdownRenderer(
              rendererOptions.headerTemplateFilePath,
              rendererOptions.tableOfContentsTemplateFilePath,
              rendererOptions.ruleTemplateFilePath,
              rendererOptions.providerTemplateFilePath,
              rendererOptions.funcTemplateFilePath,
              rendererOptions.aspectTemplateFilePath,
              rendererOptions.repositoryRuleTemplateFilePath,
              rendererOptions.moduleExtensionTemplateFilePath,
              !moduleInfo.getFile().isEmpty() ? moduleInfo.getFile() : "...",
              stamping);

      // rules are printed sorted by their qualified name, and their attributes are sorted by name,
      // with ATTRIBUTE_ORDERING specifying a fixed sort order for some standard attributes.
      ImmutableList<RuleInfo> sortedRuleInfos =
          moduleInfo.getRuleInfoList().stream()
              .map(RendererMain::withSortedRuleAttributes)
              .sorted(comparing(RuleInfo::getRuleName))
              .collect(toImmutableList());

      // providers are printed sorted by their qualified name.
      ImmutableList<ProviderInfo> sortedProviderInfos =
          ImmutableList.sortedCopyOf(comparing(ProviderInfo::getProviderName), moduleInfo.getProviderInfoList());

      // functions are printed sorted by their qualified name.
      ImmutableList<StarlarkFunctionInfo> sortedStarlarkFunctions =
          ImmutableList.sortedCopyOf(
              comparing(StarlarkFunctionInfo::getFunctionName), moduleInfo.getFuncInfoList());

      // aspects are printed sorted by their qualified name.
      ImmutableList<AspectInfo> sortedAspectInfos =
          ImmutableList.sortedCopyOf(comparing(AspectInfo::getAspectName), moduleInfo.getAspectInfoList());

      // Repository rules are printed sorted by their qualified name, and their attributes are sorted
      // by name, with ATTRIBUTE_ORDERING specifying a fixed sort order for some standard attributes.
      ImmutableList<RepositoryRuleInfo> sortedRepositoryRuleInfos =
          moduleInfo.getRepositoryRuleInfoList().stream()
              .map(RendererMain::withSortedRuleAttributes)
              .sorted(comparing(RepositoryRuleInfo::getRuleName))
              .collect(toImmutableList());

      // Module extension are printed sorted by their qualified name, and their tag classes'
      // attributes are sorted by name, with ATTRIBUTE_ORDERING specifying a fixed sort order for some
      // standard attributes.
      ImmutableList<ModuleExtensionInfo> sortedModuleExtensionInfos =
          moduleInfo.getModuleExtensionInfoList().stream()
              .map(RendererMain::withSortedTagAttributes)
              .sorted(comparing(ModuleExtensionInfo::getExtensionName))
              .collect(toImmutableList());

      // rules are printed sorted by their qualified name, and their attributes are sorted by name,
      // with ATTRIBUTE_ORDERING specifying a fixed sort order for some standard attributes.
      ImmutableList<RuleInfo> sortedRuleInfos =
          moduleInfo.getRuleInfoList().stream()
              .map(RendererMain::withSortedRuleAttributes)
              .sorted(comparing(RuleInfo::getRuleName))
              .collect(toImmutableList());

      // providers are printed sorted by their qualified name.
      ImmutableList<ProviderInfo> sortedProviderInfos =
          ImmutableList.sortedCopyOf(
              comparing(ProviderInfo::getProviderName), moduleInfo.getProviderInfoList());

      // functions are printed sorted by their qualified name.
      ImmutableList<StarlarkFunctionInfo> sortedStarlarkFunctions =
          ImmutableList.sortedCopyOf(
              comparing(StarlarkFunctionInfo::getFunctionName), moduleInfo.getFuncInfoList());

      // aspects are printed sorted by their qualified name.
      ImmutableList<AspectInfo> sortedAspectInfos =
          ImmutableList.sortedCopyOf(
              comparing(AspectInfo::getAspectName), moduleInfo.getAspectInfoList());

      // Repository rules are printed sorted by their qualified name, and their attributes are
      // sorted by name, with ATTRIBUTE_ORDERING specifying a fixed sort order for some standard
      // attributes.
      ImmutableList<RepositoryRuleInfo> sortedRepositoryRuleInfos =
          moduleInfo.getRepositoryRuleInfoList().stream()
              .map(RendererMain::withSortedRuleAttributes)
              .sorted(comparing(RepositoryRuleInfo::getRuleName))
              .collect(toImmutableList());

      // Module extension are printed sorted by their qualified name, and their tag classes'
      // attributes are sorted by name, with ATTRIBUTE_ORDERING specifying a fixed sort order for
      // some standard attributes.
      ImmutableList<ModuleExtensionInfo> sortedModuleExtensionInfos =
          moduleInfo.getModuleExtensionInfoList().stream()
              .map(RendererMain::withSortedTagAttributes)
              .sorted(comparing(ModuleExtensionInfo::getExtensionName))
              .collect(toImmutableList());

      printWriter.println(renderer.renderMarkdownHeader(moduleInfo));
      if (rendererOptions.tableOfContentsTemplateFilePath != null) {
        printWriter.println(
            renderer.renderTableOfContents(
                sortedRuleInfos,
                sortedProviderInfos,
                sortedStarlarkFunctions,
                sortedAspectInfos,
                sortedRepositoryRuleInfos,
                sortedModuleExtensionInfos));
      }
      print(printWriter, renderer::render, sortedRuleInfos);
      print(printWriter, renderer::render, sortedProviderInfos);
      print(printWriter, renderer::render, sortedStarlarkFunctions);
      print(printWriter, renderer::render, sortedAspectInfos);
      print(printWriter, renderer::render, sortedRepositoryRuleInfos);
      print(printWriter, renderer::render, sortedModuleExtensionInfos);

    } catch (InvalidProtocolBufferException e) {
      throw new IllegalArgumentException("Input file is not a valid ModuleInfo proto.", e);
    }
  }

  private static <T> void print(PrintWriter printWriter, Renderer<T> renderer, List<T> infos)
      throws IOException {
    for (T info : infos) {
      printWriter.println(renderer.render(info));
      printWriter.println();
    }
  }

  // A copy of com.google.devtools.build.docgen.DocgenConsts.ATTRIBUTE_ORDERING - we duplicate the
  // ordering here because we intend to move this file from the Bazel tree to the Stardoc repo.
  private static final ImmutableMap<String, Integer> ATTRIBUTE_ORDERING =
      ImmutableMap.<String, Integer>builder()
          .put("name", -99)
          .put("deps", -98)
          .put("src", -97)
          .put("srcs", -96)
          .put("data", -95)
          .put("resource", -94)
          .put("resources", -93)
          .put("out", -92)
          .put("outs", -91)
          .put("hdrs", -90)
          .buildOrThrow();

  private static final Comparator<String> ATTRIBUTE_NAME_COMPARATOR =
      (a, b) -> {
        int aOrdering = ATTRIBUTE_ORDERING.getOrDefault(a, 0);
        int bOrdering = ATTRIBUTE_ORDERING.getOrDefault(b, 0);
        if (aOrdering > bOrdering) {
          return 1;
        } else if (aOrdering < bOrdering) {
          return -1;
        } else {
          return Comparator.<String>naturalOrder().compare(a, b);
        }
      };

  private static RuleInfo withSortedRuleAttributes(RuleInfo ruleInfo) {
    return ruleInfo.toBuilder()
        .clearAttribute()
        .addAllAttribute(
            ImmutableList.sortedCopyOf(
                comparing(AttributeInfo::getName, ATTRIBUTE_NAME_COMPARATOR),
                ruleInfo.getAttributeList()))
        .build();
  }

  private static RepositoryRuleInfo withSortedRuleAttributes(
      RepositoryRuleInfo repositoryRuleInfo) {
    return repositoryRuleInfo.toBuilder()
        .clearAttribute()
        .addAllAttribute(
            ImmutableList.sortedCopyOf(
                comparing(AttributeInfo::getName, ATTRIBUTE_NAME_COMPARATOR),
                repositoryRuleInfo.getAttributeList()))
        .build();
  }

  private static ModuleExtensionTagClassInfo withSortedTagAttributes(
      ModuleExtensionTagClassInfo moduleExtensionTagClassInfo) {
    return moduleExtensionTagClassInfo.toBuilder()
        .clearAttribute()
        .addAllAttribute(
            ImmutableList.sortedCopyOf(
                comparing(AttributeInfo::getName, ATTRIBUTE_NAME_COMPARATOR),
                moduleExtensionTagClassInfo.getAttributeList()))
        .build();
  }

  private static ModuleExtensionInfo withSortedTagAttributes(
      ModuleExtensionInfo moduleExtensionInfo) {
    return moduleExtensionInfo.toBuilder()
        .clearTagClass()
        .addAllTagClass(
            moduleExtensionInfo.getTagClassList().stream()
                .map(RendererMain::withSortedTagAttributes)
                .collect(toImmutableList()))
        .build();
  }

  private RendererMain() {}
}
