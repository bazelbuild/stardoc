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

package com.google.devtools.build.stardoc.renderer;

import static com.google.common.base.Strings.isNullOrEmpty;
import static com.google.common.collect.ImmutableList.toImmutableList;
import static com.google.common.collect.ImmutableSet.toImmutableSet;
import static java.nio.charset.StandardCharsets.UTF_8;
import static java.util.Comparator.comparing;

import com.beust.jcommander.JCommander;
import com.google.common.collect.ImmutableList;
import com.google.common.collect.ImmutableMap;
import com.google.common.collect.ImmutableSet;
import com.google.devtools.build.lib.starlarkdocextract.StardocOutputProtos.AspectInfo;
import com.google.devtools.build.lib.starlarkdocextract.StardocOutputProtos.AttributeInfo;
import com.google.devtools.build.lib.starlarkdocextract.StardocOutputProtos.MacroInfo;
import com.google.devtools.build.lib.starlarkdocextract.StardocOutputProtos.ModuleExtensionInfo;
import com.google.devtools.build.lib.starlarkdocextract.StardocOutputProtos.ModuleExtensionTagClassInfo;
import com.google.devtools.build.lib.starlarkdocextract.StardocOutputProtos.ModuleInfo;
import com.google.devtools.build.lib.starlarkdocextract.StardocOutputProtos.ProviderInfo;
import com.google.devtools.build.lib.starlarkdocextract.StardocOutputProtos.RepositoryRuleInfo;
import com.google.devtools.build.lib.starlarkdocextract.StardocOutputProtos.RuleInfo;
import com.google.devtools.build.lib.starlarkdocextract.StardocOutputProtos.StarlarkFunctionInfo;
import com.google.devtools.build.stardoc.rendering.MarkdownRenderer;
import com.google.devtools.build.stardoc.rendering.MarkdownRenderer.Renderer;
import com.google.devtools.build.stardoc.rendering.Stamping;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;

/**
 * Main entry point for Renderer binary.
 *
 * <p>This Renderer takes in raw stardoc_proto protos as input and produces rich markdown output.
 */
public final class RendererMain {

  @SuppressWarnings("ProtoParseWithRegistry") // See https://github.com/bazelbuild/stardoc/pull/221
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
    if (rendererOptions.stampingStableStatusFilePath != null
        && rendererOptions.stampingVolatileStatusFilePath != null) {
      stamping =
          Stamping.read(
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
      ModuleInfo moduleInfo = ModuleInfo.parseFrom(new FileInputStream(inputPath));

      MarkdownRenderer renderer =
          new MarkdownRenderer(
              rendererOptions.headerTemplateFilePath,
              rendererOptions.tableOfContentsTemplateFilePath,
              rendererOptions.ruleTemplateFilePath,
              rendererOptions.providerTemplateFilePath,
              rendererOptions.funcTemplateFilePath,
              rendererOptions.macroTemplateFilePath,
              rendererOptions.aspectTemplateFilePath,
              rendererOptions.repositoryRuleTemplateFilePath,
              rendererOptions.moduleExtensionTemplateFilePath,
              !moduleInfo.getFile().isEmpty()
                  ? Optional.of(moduleInfo.getFile())
                  : Optional.empty(),
              rendererOptions.footerTemplateFilePath,
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
          ImmutableList.sortedCopyOf(
              comparing(ProviderInfo::getProviderName), moduleInfo.getProviderInfoList());

      // functions are printed sorted by their qualified name.
      ImmutableList<StarlarkFunctionInfo> sortedStarlarkFunctions =
          ImmutableList.sortedCopyOf(
              comparing(StarlarkFunctionInfo::getFunctionName), moduleInfo.getFuncInfoList());

      // symbolic macros are printed sorted by their qualified name, and their attributes are sorted
      // by name, with ATTRIBUTE_ORDERING specifying a fixed sort order for some standard
      // attributes.
      ImmutableList<MacroInfo> sortedMacroInfos =
          moduleInfo.getMacroInfoList().stream()
              .map(RendererMain::withSortedMacroAttributes)
              .sorted(comparing(MacroInfo::getMacroName))
              .collect(toImmutableList());

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
      print(printWriter, renderer::render, sortedMacroInfos);
      print(printWriter, renderer::render, sortedAspectInfos);
      print(printWriter, renderer::render, sortedRepositoryRuleInfos);
      print(printWriter, renderer::render, sortedModuleExtensionInfos);
      if (rendererOptions.footerTemplateFilePath != null) {
        printWriter.println(renderer.renderMarkdownFooter(moduleInfo));
      }
    } catch (IOException e) {
      // Avoid an explicit dependency on the Java protobuf runtime as it should be injected by the
      // root module via a proto_lang_toolchain.
      if (e.getClass().getName().equals("com.google.protobuf.InvalidProtocolBufferException")) {
        throw new IllegalArgumentException("Input file is not a valid ModuleInfo proto.", e);
      } else {
        throw e;
      }
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

  private static MacroInfo withSortedMacroAttributes(MacroInfo macroInfo) {
    boolean inheritsFromTest = inheritsFromTestRule(macroInfo);
    ArrayList<AttributeInfo> attributes = new ArrayList<>(macroInfo.getAttributeList().size() + 1);
    for (AttributeInfo attributeInfo : macroInfo.getAttributeList()) {
      if (attributeInfo.getNativelyDefined() && isNullOrEmpty(attributeInfo.getDocString())) {
        // inject doc string for undocumented inherited native attributes
        String docString = "Inherited rule attribute";
        if (COMMON_UNDOCUMENTED_ATTR_NAMES.contains(attributeInfo.getName())) {
          continue;
        } else if (COMMON_BASE_ATTR_NAMES.contains(attributeInfo.getName())) {
          docString =
              String.format(
                  "<a href=\"https://bazel.build/reference/be/common-definitions#common.%s\">%s</a>",
                  attributeInfo.getName(), docString);
        } else if (inheritsFromTest && COMMON_TEST_ATTR_NAMES.contains(attributeInfo.getName())) {
          docString =
              String.format(
                  "<a href=\"https://bazel.build/reference/be/common-definitions#test.%s\">%s</a>",
                  attributeInfo.getName(), docString);
        } else if (COMMON_BINARY_ATTR_NAMES.contains(attributeInfo.getName())) {
          docString =
              String.format(
                  "<a href=\"https://bazel.build/reference/be/common-definitions#binary.%s\">%s</a>",
                  attributeInfo.getName(), docString);
        }
        attributes.add(attributeInfo.toBuilder().setDocString(docString).build());
      } else {
        attributes.add(attributeInfo);
      }
    }
    return macroInfo.toBuilder()
        .clearAttribute()
        .addAllAttribute(
            ImmutableList.sortedCopyOf(
                comparing(AttributeInfo::getName, ATTRIBUTE_NAME_COMPARATOR), attributes))
        .build();
  }

  private static final ImmutableSet<String> COMMON_BASE_ATTR_NAMES =
      ImmutableSet.of(
          "compatible_with",
          "deprecation",
          "distribs",
          "exec_compatible_with",
          "exec_properties",
          "features",
          "package_metadata",
          "restricted_to",
          "tags",
          "target_compatible_with",
          "testonly",
          "toolchains",
          "visibility");
  private static final ImmutableSet<String> COMMON_TEST_ATTR_NAMES =
      ImmutableSet.of(
          "args", "env", "env_inherit", "size", "timeout", "flaky", "shard_count", "local");
  private static final ImmutableSet<String> COMMON_BINARY_ATTR_NAMES =
      ImmutableSet.of("args", "env", "output_licenses");
  // TODO(https://github.com/bazelbuild/bazel/issues/24948): Bazel should explicitly mark these as
  // undocumented, so we wouldn't need to filter them out.
  private static final ImmutableSet<String> COMMON_UNDOCUMENTED_ATTR_NAMES =
      ImmutableSet.of("expect_failure", "transitive_configs");

  /**
   * Heuristically guesses whehter the given macro inherits attributes from a test rule (as opposed
   * to, for example, a binary rule).
   */
  private static boolean inheritsFromTestRule(MacroInfo macroInfo) {
    ImmutableSet<String> inheritedAttrs =
        macroInfo.getAttributeList().stream()
            .filter(AttributeInfo::getNativelyDefined)
            .map(AttributeInfo::getName)
            .collect(toImmutableSet());
    for (String testAttrName : COMMON_TEST_ATTR_NAMES) {
      if (!COMMON_BINARY_ATTR_NAMES.contains(testAttrName)
          && inheritedAttrs.contains(testAttrName)) {
        return true;
      }
    }
    return false;
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
