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

import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

/** Tests for MarkdownUtil. */
@RunWith(JUnit4.class)
public class MarkdownUtilTest {

  MarkdownUtil util = new MarkdownUtil("//:test.bzl");

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
  public void markdownCellFormat_inlineMarkup() {
    assertThat(MarkdownUtil.markdownCellFormat("<b>bold</b> <i>italic</i>"))
        .isEqualTo("<b>bold</b> <i>italic</i>");
    assertThat(MarkdownUtil.markdownCellFormat("**bold** _italic_")).isEqualTo("**bold** _italic_");
  }
}
