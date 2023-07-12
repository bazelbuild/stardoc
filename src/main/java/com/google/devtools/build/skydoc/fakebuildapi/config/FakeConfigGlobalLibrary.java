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

package com.google.devtools.build.skydoc.fakebuildapi.config;

import com.google.devtools.build.lib.starlarkbuildapi.config.ConfigGlobalLibraryApi;
import com.google.devtools.build.lib.starlarkbuildapi.config.ConfigurationTransitionApi;
import net.starlark.java.eval.Dict;
import net.starlark.java.eval.Sequence;
import net.starlark.java.eval.StarlarkCallable;
import net.starlark.java.eval.StarlarkThread;

/**
 * Fake implementation of {@link ConfigGlobalLibraryApi}.
 */
public class FakeConfigGlobalLibrary implements ConfigGlobalLibraryApi {

  @Override
  public ConfigurationTransitionApi transition(
      StarlarkCallable implementation,
      Sequence<?> inputs,
      Sequence<?> outputs,
      StarlarkThread thread) {
    return new FakeConfigurationTransition();
  }

  @Override
  public ConfigurationTransitionApi analysisTestTransition(
      Dict<?, ?> changedSettings, StarlarkThread thread) {
    return new FakeConfigurationTransition();
  }
}
