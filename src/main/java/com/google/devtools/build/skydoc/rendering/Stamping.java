// Copyright 2024 The Bazel Authors. All rights reserved.
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

import com.google.common.collect.ImmutableMap;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;

/** Reads and stores stamping information. */
public final class Stamping {

  public static Stamping read(String stableStatusFile, String volatileStatusFile)
      throws IOException {
    return new Stamping(parse(stableStatusFile), parse(volatileStatusFile));
  }

  public static Stamping empty() {
    return new Stamping(ImmutableMap.of(), ImmutableMap.of());
  }

  private final ImmutableMap<String, String> stableInfo;
  private final ImmutableMap<String, String> volatileInfo;

  private static ImmutableMap<String, String> parse(String path) throws IOException {
    ImmutableMap.Builder<String, String> builder = ImmutableMap.builder();
    List<String> lines = Files.readAllLines(Path.of(path));
    for (String line : lines) {
      String[] kv = line.split(" ", 2); // split on first space only
      builder.put(kv[0], kv[1]);
    }
    return builder.build();
  }

  private Stamping(
      ImmutableMap<String, String> stableInfo, ImmutableMap<String, String> volatileInfo) {
    this.stableInfo = stableInfo;
    this.volatileInfo = volatileInfo;
  }

  public ImmutableMap<String, String> getStable() {
    return stableInfo;
  }

  public ImmutableMap<String, String> getVolatile() {
    return volatileInfo;
  }
}
