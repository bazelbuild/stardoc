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

import static com.google.common.collect.ImmutableList.toImmutableList;
import static java.util.Comparator.naturalOrder;
import static java.util.stream.Collectors.joining;

import com.google.common.base.Joiner;
import com.google.common.collect.ImmutableList;
import com.google.devtools.build.skydoc.rendering.proto.StardocOutputProtos.AspectInfo;
import com.google.devtools.build.skydoc.rendering.proto.StardocOutputProtos.AttributeInfo;
import com.google.devtools.build.skydoc.rendering.proto.StardocOutputProtos.AttributeType;
import com.google.devtools.build.skydoc.rendering.proto.StardocOutputProtos.FunctionParamInfo;
import com.google.devtools.build.skydoc.rendering.proto.StardocOutputProtos.ModuleExtensionInfo;
import com.google.devtools.build.skydoc.rendering.proto.StardocOutputProtos.ModuleExtensionTagClassInfo;
import com.google.devtools.build.skydoc.rendering.proto.StardocOutputProtos.ProviderInfo;
import com.google.devtools.build.skydoc.rendering.proto.StardocOutputProtos.ProviderNameGroup;
import com.google.devtools.build.skydoc.rendering.proto.StardocOutputProtos.RepositoryRuleInfo;
import com.google.devtools.build.skydoc.rendering.proto.StardocOutputProtos.RuleInfo;
import com.google.devtools.build.skydoc.rendering.proto.StardocOutputProtos.StarlarkFunctionInfo;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/** Contains a number of utility methods for markdown rendering. */
public final class MarkdownUtil {
  private final String extensionBzlFile;

  private static final int MAX_LINE_LENGTH = 100;

  public MarkdownUtil(String extensionBzlFile) {
    this.extensionBzlFile = extensionBzlFile;
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
   */
  public static String markdownCellFormat(String docString) {
    String resultString = docString.trim().replace("|", "\\|");
    resultString = markdownFencedCodeBlockToHtml(resultString);
    return resultString.replaceAll("\r?\n(\\s*\n)+", "<br><br>").replaceAll("\r?\n", " ");
  }

  // Start of input or a newline, followed by 0-3 spaces, followed by 3 or more backticks or tildes,
  // optionally followed by a language name (optionally preceded by spaces and followed by arbitrary
  // text), followed by a newline.
  private static Pattern MARKDOWN_CODE_BLOCK_OPENING_FENCE =
      Pattern.compile(
          "(?<openingNewline>^|\r?\n) {0,3}(?<fence>```+|~~~+) *(?<lang>\\w*)[^`~\r\n]*\r?\n");

  // See https://github.github.com/gfm/#fenced-code-blocks
  private static String markdownFencedCodeBlockToHtml(String input) {
    Matcher codeBlockOpeningFenceMatcher = MARKDOWN_CODE_BLOCK_OPENING_FENCE.matcher(input);
    StringBuilder result = new StringBuilder();
    int position = 0;
    while (position < input.length()) {
      if (!codeBlockOpeningFenceMatcher.find(position)) {
        break;
      }
      String language = codeBlockOpeningFenceMatcher.group("lang");
      int fenceStart = codeBlockOpeningFenceMatcher.start();
      int contentStart = codeBlockOpeningFenceMatcher.end();

      // Newline, followed by 0-3 spaces, followed by same number of backticks or tildes as for the
      // opening fence, followed by optional spaces, and finally a newline or end of input.
      Pattern codeBlockClosingFence =
          Pattern.compile(
              "\r?\n {0,3}"
                  + codeBlockOpeningFenceMatcher.group("fence")
                  + " *(?<closingNewline>$|\r?\n)");
      Matcher codeBlockClosingFenceMatcher = codeBlockClosingFence.matcher(input);
      if (!codeBlockClosingFenceMatcher.find(contentStart)) {
        break;
      }
      int contentEnd = codeBlockClosingFenceMatcher.start();
      int fenceEnd = codeBlockClosingFenceMatcher.end();

      result.append(input.substring(position, fenceStart));
      result.append(codeBlockOpeningFenceMatcher.group("openingNewline"));
      if (language != null && !language.isEmpty()) {
        result.append("<pre><code class=\"language-").append(language).append("\">");
      } else {
        result.append("<pre><code>");
      }
      result.append(newlineEscape(htmlEscape(input.substring(contentStart, contentEnd))));
      result.append("</code></pre>");
      result.append(codeBlockClosingFenceMatcher.group("closingNewline"));
      position = fenceEnd;
    }
    result.append(input.substring(position, input.length()));
    return result.toString();
  }

  /**
   * Return a string that escapes angle brackets for HTML.
   *
   * <p>For example: 'Information with <brackets>.' becomes 'Information with &lt;brackets&gt;'.
   */
  public static String htmlEscape(String docString) {
    return docString.replace("<", "&lt;").replace(">", "&gt;");
  }

  /** Returns a string that escapes newlines and carriage returns with HTML entities. */
  private static String newlineEscape(String docString) {
    return docString.replace("\n", "&#10;").replace("\r", "&#13;");
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
    return summary(ruleName, attributeNames);
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
            .map(field -> field.getName())
            .collect(toImmutableList());
    return summary(providerName, fieldNames);
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
    return summary(aspectName, attributeNames);
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
    return summary(ruleName, attributeNames);
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
            "%s = use_extension(\"%s\", \"%s\")", extensionName, extensionBzlFile, extensionName));
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
    return summary(funcInfo.getFunctionName(), paramNames);
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
}
