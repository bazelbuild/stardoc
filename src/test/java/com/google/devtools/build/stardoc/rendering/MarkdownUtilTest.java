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

package com.google.devtools.build.stardoc.rendering;

import static com.google.common.truth.Truth.assertThat;

import java.util.Optional;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

/** Tests for MarkdownUtil. */
@RunWith(JUnit4.class)
public class MarkdownUtilTest {

  MarkdownUtil util = new MarkdownUtil(Optional.of("//:test.bzl"));

  @Test
  public void markdownCodeSpan() {
    assertThat(MarkdownUtil.markdownCodeSpan("")).isEqualTo("``");
    assertThat(MarkdownUtil.markdownCodeSpan("foo bar ")).isEqualTo("`foo bar `");
  }

  @Test
  public void markdownCodeSpan_backticks() {
    assertThat(MarkdownUtil.markdownCodeSpan("foo`bar")).isEqualTo("``foo`bar``");
    assertThat(MarkdownUtil.markdownCodeSpan("foo``bar")).isEqualTo("```foo``bar```");
    assertThat(MarkdownUtil.markdownCodeSpan("foo`bar```baz``quz"))
        .isEqualTo("````foo`bar```baz``quz````");
  }

  @Test
  public void markdownCodeSpan_backticksPadding() {
    assertThat(MarkdownUtil.markdownCodeSpan("`foo")).isEqualTo("`` `foo ``");
    assertThat(MarkdownUtil.markdownCodeSpan("``foo")).isEqualTo("``` ``foo ```");
    assertThat(MarkdownUtil.markdownCodeSpan("foo`")).isEqualTo("`` foo` ``");
    assertThat(MarkdownUtil.markdownCodeSpan("foo``")).isEqualTo("``` foo`` ```");
  }

  @Test
  public void markdownCellFormat_pipes() {
    assertThat(MarkdownUtil.markdownCellFormat("foo|bar")).isEqualTo("foo\\|bar");
    assertThat(MarkdownUtil.markdownCellFormat("|\\|foobar||")).isEqualTo("\\|\\\\|foobar\\|\\|");
  }

  @Test
  public void markdownCellFormat_newlines() {
    assertThat(MarkdownUtil.markdownCellFormat("\nfoo\nbar\n\nbaz\r\n\r\n\r\nqux\r\n"))
        .isEqualTo("foo bar<br><br>baz<br><br>qux");
    // Newline escapes are not expanded
    assertThat(MarkdownUtil.markdownCellFormat("hello\\r\\nworld")).isEqualTo("hello\\r\\nworld");
  }

  @Test
  public void markdownCellFormat_codeBlocks() {
    assertThat(MarkdownUtil.markdownCellFormat("```\nhello();\n```"))
        .isEqualTo("<pre><code>hello();</code></pre>");
    assertThat(MarkdownUtil.markdownCellFormat("```\nhello();\n```\nor\n~~~\nbye();\n~~~"))
        .isEqualTo("<pre><code>hello();</code></pre> or <pre><code>bye();</code></pre>");
    assertThat(MarkdownUtil.markdownCellFormat("```bash\ncat foo.txt | cmd > /dev/null\n```"))
        .isEqualTo(
            "<pre><code class=\"language-bash\">cat foo.txt \\| cmd &gt; /dev/null</code></pre>");
    assertThat(MarkdownUtil.markdownCellFormat("````\n```\n```\n````"))
        .isEqualTo("<pre><code>```&#10;```</code></pre>");
  }

  @Test
  public void markdownCellFormat_lists() {
    assertThat(
            MarkdownUtil.markdownCellFormat(
                "Blah blah blah\n\nPossible values:\n* `\"x\"` - sets foo to x\n"
                    + "* `\"y\"` - sets foo to y\n"))
        .isEqualTo(
            "Blah blah blah<br><br>Possible values: <ul><li>`\"x\"` - sets foo to x</li>"
                + " <li>`\"y\"` - sets foo to y</li></ul>");
    assertThat(
            MarkdownUtil.markdownCellFormat(
                "Options are:\n\n*   `ios`: architectures gathered\n    from `--ios_multi_cpus`.\n"
                    + "*   `macos`: architectures gathered\n    from `--macos_cpus`."))
        .isEqualTo(
            "Options are:<br><br><ul><li>`ios`: architectures gathered from"
                + " `--ios_multi_cpus`.</li> <li>`macos`: architectures gathered from"
                + " `--macos_cpus`.</li></ul>");
    assertThat(MarkdownUtil.markdownCellFormat("Options:\n\n- a\n\n- b\n\nMore text."))
        .isEqualTo("Options:<br><br><ul><li>a</li> <li>b</li></ul><br><br>More text.");
    assertThat(MarkdownUtil.markdownCellFormat("+ a | b\n+ c"))
        .isEqualTo("<ul><li>a \\| b</li> <li>c</li></ul>");
    assertThat(MarkdownUtil.markdownCellFormat("1. one\n2. two"))
        .isEqualTo("<ol><li>one</li> <li>two</li></ol>");
    assertThat(MarkdownUtil.markdownCellFormat("Steps:\n\n3) three\n4) four"))
        .isEqualTo("Steps:<br><br><ol start=\"3\"><li>three</li> <li>four</li></ol>");
    // A different bullet character or delimiter starts a new list.
    assertThat(MarkdownUtil.markdownCellFormat("- a\n* b"))
        .isEqualTo("<ul><li>a</li></ul> <ul><li>b</li></ul>");
    assertThat(MarkdownUtil.markdownCellFormat("1. a\n1) b"))
        .isEqualTo("<ol><li>a</li></ol> <ol><li>b</li></ol>");
  }

  @Test
  public void markdownCellFormat_listItemContent() {
    assertThat(MarkdownUtil.markdownCellFormat("- a\n  - b\n  - c\n- d"))
        .isEqualTo("<ul><li>a <ul><li>b</li> <li>c</li></ul></li> <li>d</li></ul>");
    assertThat(MarkdownUtil.markdownCellFormat("- a\n\n  more about a\n- b"))
        .isEqualTo("<ul><li>a<br><br>more about a</li> <li>b</li></ul>");
    assertThat(MarkdownUtil.markdownCellFormat("- example:\n  ```\n  foo()\n  ```\n- b"))
        .isEqualTo("<ul><li>example: <pre><code>foo()</code></pre></li> <li>b</li></ul>");
    // Lazy continuation line
    assertThat(MarkdownUtil.markdownCellFormat("- a\nstill a\n- b"))
        .isEqualTo("<ul><li>a still a</li> <li>b</li></ul>");
    // A code block ends the list
    assertThat(MarkdownUtil.markdownCellFormat("- a\n```\n- b\n```"))
        .isEqualTo("<ul><li>a</li></ul> <pre><code>- b</code></pre>");
  }

  @Test
  public void markdownCellFormat_notLists() {
    // An ordered list can only interrupt a paragraph if it starts with 1.
    assertThat(MarkdownUtil.markdownCellFormat("Released in\n2019. The end."))
        .isEqualTo("Released in 2019. The end.");
    assertThat(MarkdownUtil.markdownCellFormat("**bold**\n*emphasis*\n-flag\n---\n* * *\n-"))
        .isEqualTo("**bold** *emphasis* -flag --- * * * -");
  }

  @Test
  public void markdownCellFormat_inlineMarkup() {
    assertThat(MarkdownUtil.markdownCellFormat("<b>bold</b> <i>italic</i>"))
        .isEqualTo("<b>bold</b> <i>italic</i>");
    assertThat(MarkdownUtil.markdownCellFormat("**bold** _italic_")).isEqualTo("**bold** _italic_");
  }
}
