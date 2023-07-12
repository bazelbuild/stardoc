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

package com.google.devtools.build.skydoc.fakebuildapi;

import com.google.devtools.build.lib.starlarkbuildapi.core.ProviderApi;
import javax.annotation.Nullable;
import net.starlark.java.eval.Dict;
import net.starlark.java.eval.Printer;
import net.starlark.java.eval.StarlarkCallable;
import net.starlark.java.eval.StarlarkThread;
import net.starlark.java.eval.Tuple;

/** Fake callable implementation of {@link ProviderApi}. */
public class FakeProviderApi implements StarlarkCallable, ProviderApi {

  private String name;

  public FakeProviderApi(@Nullable String name) {
    this.name = name;
  }

  @Override
  public Object call(StarlarkThread thread, Tuple args, Dict<String, Object> kwargs) {
    return new FakeStructApi();
  }

  @Override
  public String getName() {
    return name != null ? name : "Unexported Provider";
  }

  /** Called when provider is "exported" by a top-level assignment {@code name = provider()}. */
  public void setName(String name) {
    if (this.name == null) {
      this.name = name;
    }
  }

  @Override
  public boolean isImmutable() {
    // Mirroring StarlarkProvider's behavior.
    return name != null;
  }

  @Override
  public void repr(Printer printer) {}
}
