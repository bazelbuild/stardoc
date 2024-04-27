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

import static com.google.common.base.Strings.isNullOrEmpty;
import static com.google.common.collect.ImmutableList.toImmutableList;
import static java.util.Comparator.naturalOrder;
import static java.util.stream.Collectors.joining;

import com.google.common.base.Joiner;
import com.google.common.collect.ImmutableList;
import com.google.devtools.build.lib.starlarkdocextract.StardocOutputProtos;
import com.google.devtools.build.lib.starlarkdocextract.StardocOutputProtos.AspectInfo;
import com.google.devtools.build.lib.starlarkdocextract.StardocOutputProtos.AttributeInfo;
import com.google.devtools.build.lib.starlarkdocextract.StardocOutputProtos.AttributeType;
import com.google.devtools.build.lib.starlarkdocextract.StardocOutputProtos.FunctionParamInfo;
import com.google.devtools.build.lib.starlarkdocextract.StardocOutputProtos.ModuleExtensionInfo;
import com.google.devtools.build.lib.starlarkdocextract.StardocOutputProtos.ModuleExtensionTagClassInfo;
import com.google.devtools.build.lib.starlarkdocextract.StardocOutputProtos.ProviderInfo;
import com.google.devtools.build.lib.starlarkdocextract.StardocOutputProtos.ProviderNameGroup;
import com.google.devtools.build.lib.starlarkdocextract.StardocOutputProtos.RepositoryRuleInfo;
import com.google.devtools.build.lib.starlarkdocextract.StardocOutputProtos.RuleInfo;
import com.google.devtools.build.lib.starlarkdocextract.StardocOutputProtos.StarlarkFunctionInfo;
import java.time.Instant;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/** Contains a number of utility methods for markdown rendering. */
public final class MarkdownUtil {
  private final Optional<String> entrypointBzlFile;

  private static final int MAX_LINE_LENGTH = 100;

  public MarkdownUtil(Optional<String> entrypointBzlFile) {
    this.entrypointBzlFile = entrypointBzlFile;
  }

  /**
   * Formats the input string so that it is displayable in a Markdown table cell. This performs the
   * following operations:
   *
   * <ul>
   *   <li>Trims the string of leading/trailing whitespace.
   *   <li>Escapes pipe characters ({@code |}) as {@code \|}.
   *   <li>Transforms Markdown code blocks ({@code ```}) into HTML preformatted code blocks, and
   *       transforms newlines within those code blocks into character entities
   *   <li>Transforms remaining 'new paragraph' patterns (two or more sequential newline characters)
   *       into line break HTML tags.
   *   <li>Turns remaining newlines into spaces (as they generally indicate intended line wrap).
   * </ul>
   *
   * TODO(https://github.com/bazelbuild/stardoc/issues/118): also format Markdown lists as HTML.
   */
  public static String markdownCellFormat(String docString) {
    return new MarkdownCellFormatter(docString).format();
  }

  // See https://github.github.com/gfm
  private static final class MarkdownCellFormatter {
    // Lines of the input docstring, without newline terminators.
    private final ImmutableList<String> lines;
    // Index of the current line in lines, 0-based.
    int currentLine;
    // Formatted result.
    StringBuilder result;

    private static final Pattern CODE_BLOCK_OPENING_FENCE =
        Pattern.compile("^ {0,3}(?<fence>```+|~~~+) *(?<lang>\\w*)[^`~]*$");

    MarkdownCellFormatter(String docString) {
      lines = docString.trim().replace("|", "\\|").lines().collect(toImmutableList());
      currentLine = 0;
      result = new StringBuilder();
    }

    /** Consumes the input and yields the formatted result. */
    String format() {
      boolean prefixContentWithSpace = false;
      for (; currentLine < lines.size(); currentLine++) {
        if (formatParagraphBreak()) {
          prefixContentWithSpace = false;
          continue;
        }
        if (prefixContentWithSpace) {
          result.append(" ");
        }
        prefixContentWithSpace = true;
        if (formatFencedCodeBlock()) {
          continue;
        }
        result.append(lines.get(currentLine));
      }
      return result.toString();
    }

    /**
     * If a fenced code block begins at {@link #currentLine}, render to {@link #result}, update
     * {@link #currentLine} to point to the closing fence, and return true.
     */
    private boolean formatFencedCodeBlock() {
      // See https://github.github.com/gfm/#fenced-code-blocks
      Matcher opening = CODE_BLOCK_OPENING_FENCE.matcher(lines.get(currentLine));
      if (!opening.matches()) {
        return false;
      }
      Pattern closingFence = Pattern.compile("^ {0,3}" + opening.group("fence") + " *$");
      for (int closingLine = currentLine + 1; closingLine < lines.size(); closingLine++) {
        if (closingFence.matcher(lines.get(closingLine)).matches()) {
          // We found the closing fence: format the block's contents as HTML.
          String language = opening.group("lang");
          if (language != null && !language.isEmpty()) {
            result.append("<pre><code class=\"language-").append(language).append("\">");
          } else {
            result.append("<pre><code>");
          }
          int firstContentLine = currentLine + 1;
          for (int i = firstContentLine; i < closingLine; i++) {
            if (i > firstContentLine) {
              result.append(newlineEscape("\n"));
            }
            result.append(htmlEscape(lines.get(i)));
          }
          result.append("</code></pre>");
          currentLine = closingLine;
          return true;
        }
      }
      // We did not find the closing fence.
      return false;
    }

    /**
     * If blank lines appear at {@link #currentLine}, render to {@link #result}, update {@link
     * #currentLine} to point to the last line of the break, and return true.
     */
    private boolean formatParagraphBreak() {
      int numEmptyLines = 0;
      for (int i = currentLine; i < lines.size(); i++) {
        if (lines.get(i).isEmpty()) {
          numEmptyLines++;
        } else {
          break;
        }
      }
      if (numEmptyLines > 0) {
        result.append("<br><br>");
        currentLine += numEmptyLines - 1;
        return true;
      }
      return false;
    }
  }

  /**
   * Return a string that escapes angle brackets for HTML.
   *
   * <p>For example: 'Information with <brackets>.' becomes 'Information with &lt;brackets&gt;'.
   */
  public static String htmlEscape(String docString) {
    return docString.replace("<", "&lt;").replace(">", "&gt;");
  }

  /** Returns a string that escapes newlines with HTML entities. */
  private static String newlineEscape(String docString) {
    return docString.replace("\n", "&#10;");
  }

  private static final Pattern CONSECUTIVE_BACKTICKS = Pattern.compile("`+");

  /**
   * Returns a Markdown code span (e.g. {@code `return foo;`}) that contains the given literal text,
   * which may itself contain backticks.
   *
   * <p>For example:
   *
   * <ul>
   *   <li>{@code markdownCodeSpan("foo")} returns {@code "`foo`"}
   *   <li>{@code markdownCodeSpan("fo`o")} returns {@code "``fo`o``"}
   *   <li>{@code markdownCodeSpan("`foo`")} returns {@code "`` foo` ``""}
   * </ul>
   */
  public static String markdownCodeSpan(String code) {
    // https://github.github.com/gfm/#code-span
    int numConsecutiveBackticks =
        CONSECUTIVE_BACKTICKS
            .matcher(code)
            .results()
            .map(match -> match.end() - match.start())
            .max(naturalOrder())
            .orElse(0);
    String padding = code.startsWith("`") || code.endsWith("`") ? " " : "";
    return String.format(
        "%1$s%2$s%3$s%2$s%1$s", "`".repeat(numConsecutiveBackticks + 1), padding, code);
  }

  /**
   * Return a string representing the rule summary for the given rule with the given name.
   *
   * <p>For example: 'my_rule(foo, bar)'. The summary will contain hyperlinks for each attribute.
   */
  @SuppressWarnings("unused") // Used by markdown template.
  public String ruleSummary(String ruleName, RuleInfo ruleInfo) {
    ImmutableList<String> attributeNames =
        ruleInfo.getAttributeList().stream().map(AttributeInfo::getName).collect(toImmutableList());
    return maybeLoad(ruleName) + summary(ruleName, attributeNames);
  }

  /**
   * Return a string representing the summary for the given provider with the given name.
   *
   * <p>For example: 'MyInfo(foo, bar)'. The summary will contain hyperlinks for each field.
   */
  @SuppressWarnings("unused") // Used by markdown template.
  public String providerSummary(String providerName, ProviderInfo providerInfo) {
    ImmutableList<String> fieldNames =
        providerInfo.getFieldInfoList().stream()
            .map(StardocOutputProtos.ProviderFieldInfo::getName)
            .collect(toImmutableList());
    return maybeLoad(providerName) + summary(providerName, fieldNames);
  }

  /**
   * Return a string representing the aspect summary for the given aspect with the given name.
   *
   * <p>For example: 'my_aspect(foo, bar)'. The summary will contain hyperlinks for each attribute.
   */
  @SuppressWarnings("unused") // Used by markdown template.
  public String aspectSummary(String aspectName, AspectInfo aspectInfo) {
    ImmutableList<String> attributeNames =
        aspectInfo.getAttributeList().stream()
            .map(AttributeInfo::getName)
            .collect(toImmutableList());
    String aspectFlag =
        entrypointBzlFile
            // Namespaced aspects can't be referenced on the command line.
            .filter(unused -> !aspectName.contains("."))
            .map(
                file ->
                    String.format(
                        "# or on the command line:\n# --aspects=%s%%%s\n", file, aspectName))
            .orElse("");
    return maybeLoad(aspectName) + aspectFlag + summary(aspectName, attributeNames);
  }

  /**
   * Return a string representing the repository rule summary for the given repository rule with the
   * given name.
   *
   * <p>For example: 'my_repo_rule(foo, bar)'. The summary will contain hyperlinks for each
   * attribute.
   */
  @SuppressWarnings("unused") // Used by markdown template.
  public String repositoryRuleSummary(String ruleName, RepositoryRuleInfo ruleInfo) {
    ImmutableList<String> attributeNames =
        ruleInfo.getAttributeList().stream().map(AttributeInfo::getName).collect(toImmutableList());
    return maybeLoad(ruleName) + summary(ruleName, attributeNames);
  }

  /**
   * Return a string representing the module extension summary for the given module extension with
   * the given name.
   *
   * <p>For example:
   *
   * <pre>
   * my_ext = use_extension("//some:file.bzl", "my_ext")
   * my_ext.tag1(foo, bar)
   * my_ext.tag2(baz)
   * </pre>
   *
   * <p>The summary will contain hyperlinks for each attribute.
   */
  @SuppressWarnings("unused") // Used by markdown template.
  public String moduleExtensionSummary(String extensionName, ModuleExtensionInfo extensionInfo) {
    StringBuilder summaryBuilder = new StringBuilder();
    summaryBuilder.append(
        String.format(
            "%s = use_extension(\"%s\", \"%s\")",
            extensionName, entrypointBzlFile.orElse("..."), extensionName));
    for (ModuleExtensionTagClassInfo tagClass : extensionInfo.getTagClassList()) {
      ImmutableList<String> attributeNames =
          tagClass.getAttributeList().stream()
              .map(AttributeInfo::getName)
              .collect(toImmutableList());
      summaryBuilder
          .append("\n")
          .append(
              summary(
                  String.format("%s.%s", extensionName, tagClass.getTagName()), attributeNames));
    }
    return summaryBuilder.toString();
  }

  /**
   * Return a string representing the summary for the given user-defined function.
   *
   * <p>For example: 'my_func(foo, bar)'. The summary will contain hyperlinks for each parameter.
   */
  @SuppressWarnings("unused") // Used by markdown template.
  public String funcSummary(StarlarkFunctionInfo funcInfo) {
    ImmutableList<String> paramNames =
        funcInfo.getParameterList().stream()
            .map(FunctionParamInfo::getName)
            .collect(toImmutableList());
    return maybeLoad(funcInfo.getFunctionName()) + summary(funcInfo.getFunctionName(), paramNames);
  }

  private String maybeLoad(String name) {
    return entrypointBzlFile
        .map(file -> String.format("load(\"%s\", \"%s\")\n", file, name.split("\\.")[0]))
        .orElse("");
  }

  private static String summary(String functionName, ImmutableList<String> paramNames) {
    ImmutableList<ImmutableList<String>> paramLines =
        wrap(functionName, paramNames, MAX_LINE_LENGTH);
    List<String> paramLinksLines = new ArrayList<>();
    for (List<String> params : paramLines) {
      String paramLinksLine =
          params.stream()
              .map(param -> String.format("<a href=\"#%s-%s\">%s</a>", functionName, param, param))
              .collect(joining(", "));
      paramLinksLines.add(paramLinksLine);
    }
    String paramList =
        Joiner.on(",\n" + " ".repeat(functionName.length() + 1)).join(paramLinksLines);
    return String.format("%s(%s)", functionName, paramList);
  }

  /**
   * Wraps the given function parameter names to be able to construct a function summary that stays
   * within the provided line length limit.
   *
   * @param functionName the function name.
   * @param paramNames the function parameter names.
   * @param maxLineLength the maximal line length.
   * @return the lines with the wrapped parameter names.
   */
  private static ImmutableList<ImmutableList<String>> wrap(
      String functionName, ImmutableList<String> paramNames, int maxLineLength) {
    ImmutableList.Builder<ImmutableList<String>> paramLines = ImmutableList.builder();
    ImmutableList.Builder<String> linesBuilder = new ImmutableList.Builder<>();
    int leading = functionName.length();
    int length = leading;
    int punctuation = 2; // cater for left parenthesis/space before and comma after parameter
    for (String paramName : paramNames) {
      length += paramName.length() + punctuation;
      if (length > maxLineLength) {
        paramLines.add(linesBuilder.build());
        length = leading + paramName.length();
        linesBuilder = new ImmutableList.Builder<>();
      }
      linesBuilder.add(paramName);
    }
    paramLines.add(linesBuilder.build());
    return paramLines.build();
  }

  /**
   * Returns a string describing the given attribute's type. The description consists of a hyperlink
   * if there is a relevant hyperlink to Bazel documentation available.
   */
  public String attributeTypeString(AttributeInfo attrInfo) {
    String typeLink;
    switch (attrInfo.getType()) {
      case LABEL:
      case LABEL_LIST:
      case OUTPUT:
        typeLink = "https://bazel.build/concepts/labels";
        break;
      case NAME:
        typeLink = "https://bazel.build/concepts/labels#target-names";
        break;
      case STRING_DICT:
      case STRING_LIST_DICT:
      case LABEL_STRING_DICT:
        typeLink = "https://bazel.build/rules/lib/dict";
        break;
      default:
        typeLink = null;
        break;
    }
    if (typeLink == null) {
      return attributeTypeDescription(attrInfo.getType());
    } else {
      return String.format(
          "<a href=\"%s\">%s</a>", typeLink, attributeTypeDescription(attrInfo.getType()));
    }
  }

  public String mandatoryString(AttributeInfo attrInfo) {
    return attrInfo.getMandatory() ? "required" : "optional";
  }

  /**
   * Returns "required" if providing a value for this parameter is mandatory. Otherwise, returns
   * "optional".
   */
  public String mandatoryString(FunctionParamInfo paramInfo) {
    return paramInfo.getMandatory() ? "required" : "optional";
  }

  /**
   * Return a string explaining what providers an attribute requires. Adds hyperlinks to providers.
   */
  public String attributeProviders(AttributeInfo attributeInfo) {
    List<ProviderNameGroup> providerNames = attributeInfo.getProviderNameGroupList();
    List<String> finalProviderNames = new ArrayList<>();
    for (ProviderNameGroup providerNameList : providerNames) {
      List<String> providers = providerNameList.getProviderNameList();
      finalProviderNames.add(Joiner.on(", ").join(providers));
    }
    return Joiner.on("; or ").join(finalProviderNames);
  }

  private static String attributeTypeDescription(AttributeType attributeType) {
    switch (attributeType) {
      case NAME:
        return "Name";
      case INT:
        return "Integer";
      case STRING:
        return "String";
      case STRING_LIST:
        return "List of strings";
      case INT_LIST:
        return "List of integers";
      case BOOLEAN:
        return "Boolean";
      case LABEL_STRING_DICT:
        return "Dictionary: Label -> String";
      case STRING_DICT:
        return "Dictionary: String -> String";
      case STRING_LIST_DICT:
        return "Dictionary: String -> List of strings";
      case LABEL:
      case OUTPUT:
        return "Label";
      case LABEL_LIST:
      case OUTPUT_LIST:
        return "List of labels";
      case UNKNOWN:
      case UNRECOGNIZED:
        throw new IllegalArgumentException("Unhandled type " + attributeType);
    }
    throw new IllegalArgumentException("Unhandled type " + attributeType);
  }

  /**
   * Formats a build timestamp from stamping with the given format. For example:
   *
   * <p>`$util.formatBuildTimestamp($stamping.volatile.BUILD_TIMESTAMP, "UTC", "yyyy MMM dd, HH:mm")
   * UTC`
   */
  public String formatBuildTimestamp(String buildTimestampSeconds, String zoneId, String format) {
    // If stamp is not set to True in the stardoc() rule, then $stamping.volatile.BUILD_TIMESTAMP
    // will be null, so return the empty string rather than crash. Alternatively, if this function
    // is called as:
    //
    //   $util.formatBuildTimestamp("$!stamping.volatile.BUILD_TIMESTAMP", "UTC", "yyyy MMM dd,
    // HH:mm")
    //
    // then buildTimestampSeconds will be the empty string, so return the empty string too.
    if (isNullOrEmpty(buildTimestampSeconds)) {
      return "";
    }
    return Instant.ofEpochSecond(Long.parseLong(buildTimestampSeconds))
        .atZone(ZoneId.of(zoneId))
        .format(DateTimeFormatter.ofPattern(format));
  }
}
