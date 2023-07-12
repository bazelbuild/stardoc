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

import com.google.common.collect.ImmutableList;
import com.google.common.collect.ImmutableMap;
import com.google.devtools.build.lib.cmdline.Label;
import com.google.devtools.build.lib.cmdline.LabelSyntaxException;
import com.google.devtools.build.lib.starlarkbuildapi.ExecGroupApi;
import com.google.devtools.build.lib.starlarkbuildapi.StarlarkAspectApi;
import com.google.devtools.build.lib.starlarkbuildapi.StarlarkRuleFunctionsApi;
import com.google.devtools.build.skydoc.rendering.AspectInfoWrapper;
import com.google.devtools.build.skydoc.rendering.ProviderInfoWrapper;
import com.google.devtools.build.skydoc.rendering.RuleInfoWrapper;
import com.google.devtools.build.skydoc.rendering.proto.StardocOutputProtos.AspectInfo;
import com.google.devtools.build.skydoc.rendering.proto.StardocOutputProtos.AttributeInfo;
import com.google.devtools.build.skydoc.rendering.proto.StardocOutputProtos.AttributeType;
import com.google.devtools.build.skydoc.rendering.proto.StardocOutputProtos.ProviderFieldInfo;
import com.google.devtools.build.skydoc.rendering.proto.StardocOutputProtos.ProviderInfo;
import com.google.devtools.build.skydoc.rendering.proto.StardocOutputProtos.RuleInfo;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;
import net.starlark.java.eval.Dict;
import net.starlark.java.eval.EvalException;
import net.starlark.java.eval.Sequence;
import net.starlark.java.eval.Starlark;
import net.starlark.java.eval.StarlarkCallable;
import net.starlark.java.eval.StarlarkFunction;
import net.starlark.java.eval.StarlarkThread;
import net.starlark.java.eval.Tuple;
import net.starlark.java.syntax.Location;

/**
 * Fake implementation of {@link StarlarkRuleFunctionsApi}.
 *
 * <p>This fake hooks into the global {@code rule()} function, adding descriptors of calls of that
 * function to a {@link List} given in the class constructor.
 */
public class FakeStarlarkRuleFunctionsApi implements StarlarkRuleFunctionsApi {

  private static final FakeDescriptor IMPLICIT_NAME_ATTRIBUTE_DESCRIPTOR =
      new FakeDescriptor(
          AttributeType.NAME,
          Optional.of("A unique name for this target."),
          true,
          ImmutableList.of(),
          "");
  private final List<RuleInfoWrapper> ruleInfoList;

  private final List<ProviderInfoWrapper> providerInfoList;

  private final List<AspectInfoWrapper> aspectInfoList;

  /**
   * Constructor.
   *
   * @param ruleInfoList the list of {@link RuleInfo} objects to which rule() invocation information
   *     will be added
   * @param providerInfoList the list of {@link ProviderInfo} objects to which provider() invocation
   *     information will be added
   * @param aspectInfoList the list of {@link AspectInfo} objects to which aspect() invocation
   *     information will be added
   */
  public FakeStarlarkRuleFunctionsApi(
      List<RuleInfoWrapper> ruleInfoList,
      List<ProviderInfoWrapper> providerInfoList,
      List<AspectInfoWrapper> aspectInfoList) {
    this.ruleInfoList = ruleInfoList;
    this.providerInfoList = providerInfoList;
    this.aspectInfoList = aspectInfoList;
  }

  @Override
  public Object provider(Object doc, Object fields, Object init, StarlarkThread thread)
      throws EvalException {
    FakeProviderApi fakeProvider = new FakeProviderApi(null);
    // Field documentation will be output preserving the order in which the fields are listed.
    ImmutableList.Builder<ProviderFieldInfo> providerFieldInfos = ImmutableList.builder();
    if (fields instanceof Sequence) {
      for (String name : Sequence.cast(fields, String.class, "fields")) {
        providerFieldInfos.add(asProviderFieldInfo(name, "(Undocumented)"));
      }
    } else if (fields instanceof Dict) {
      for (Map.Entry<String, String> e :
          Dict.cast(fields, String.class, String.class, "fields").entrySet()) {
        providerFieldInfos.add(asProviderFieldInfo(e.getKey(), e.getValue()));
      }
    } else {
      // fields is NONE, so there is no field information to add.
    }
    providerInfoList.add(
        forProviderInfo(
            fakeProvider, Starlark.toJavaOptional(doc, String.class), providerFieldInfos.build()));
    if (init == Starlark.NONE) {
      return fakeProvider;
    } else {
      return Tuple.of(fakeProvider, FakeDeepStructure.create("<raw constructor>"));
    }
  }

  /** Constructor for ProviderFieldInfo. */
  public ProviderFieldInfo asProviderFieldInfo(String name, String docString) {
    return ProviderFieldInfo.newBuilder().setName(name).setDocString(docString).build();
  }

  /** Constructor for ProviderInfoWrapper. */
  public ProviderInfoWrapper forProviderInfo(
      StarlarkCallable identifier,
      Optional<String> docString,
      Collection<ProviderFieldInfo> fieldInfos) {
    return new ProviderInfoWrapper(identifier, docString, fieldInfos);
  }

  @Override
  public StarlarkCallable rule(
      StarlarkFunction implementation,
      Boolean test,
      Object attrs,
      Object implicitOutputs,
      Boolean executable,
      Boolean outputToGenfiles,
      Sequence<?> fragments,
      Sequence<?> hostFragments,
      Boolean starlarkTestable,
      Sequence<?> toolchains,
      boolean useToolchainTransition,
      Object doc,
      Sequence<?> providesArg,
      Sequence<?> execCompatibleWith,
      Object analysisTest,
      Object buildSetting,
      Object cfg,
      Object execGroups,
      StarlarkThread thread)
      throws EvalException {
    ImmutableMap.Builder<String, FakeDescriptor> attrsMapBuilder = ImmutableMap.builder();
    if (attrs != null && attrs != Starlark.NONE) {
      attrsMapBuilder.putAll(Dict.cast(attrs, String.class, FakeDescriptor.class, "attrs"));
    }

    attrsMapBuilder.put("name", IMPLICIT_NAME_ATTRIBUTE_DESCRIPTOR);
    List<AttributeInfo> attrInfos =
        attrsMapBuilder.build().entrySet().stream()
            .filter(entry -> !entry.getKey().startsWith("_"))
            .map(entry -> entry.getValue().asAttributeInfo(entry.getKey()))
            .collect(Collectors.toList());
    attrInfos.sort(new AttributeNameComparator());

    RuleDefinitionIdentifier functionIdentifier = new RuleDefinitionIdentifier();

    // Only the Builder is passed to RuleInfoWrapper as the rule name is not yet available.
    RuleInfo.Builder ruleInfo = RuleInfo.newBuilder().addAllAttribute(attrInfos);
    Starlark.toJavaOptional(doc, String.class).ifPresent(ruleInfo::setDocString);

    Location loc = thread.getCallerLocation();
    ruleInfoList.add(new RuleInfoWrapper(functionIdentifier, loc, ruleInfo));

    return functionIdentifier;
  }

  @Override
  public Label label(Object input, StarlarkThread thread) throws EvalException {
    if (input instanceof Label) {
      return (Label) input;
    }
    try {
      return Label.parseCanonical((String) input);
    } catch (LabelSyntaxException e) {
      throw Starlark.errorf("Illegal absolute label syntax: %s", input);
    }
  }

  @Override
  public StarlarkAspectApi aspect(
      StarlarkFunction implementation,
      Sequence<?> attributeAspects,
      Object attrs,
      Sequence<?> requiredProvidersArg,
      Sequence<?> requiredAspectProvidersArg,
      Sequence<?> providesArg,
      Sequence<?> requiredAspects,
      Sequence<?> fragments,
      Sequence<?> hostFragments,
      Sequence<?> toolchains,
      boolean useToolchainTransition,
      Object doc,
      Boolean applyToFiles,
      Sequence<?> execCompatibleWith,
      Object execGroups,
      StarlarkThread thread)
      throws EvalException {
    FakeStarlarkAspect fakeAspect = new FakeStarlarkAspect();
    ImmutableMap.Builder<String, FakeDescriptor> attrsMapBuilder = ImmutableMap.builder();
    if (attrs != null && attrs != Starlark.NONE) {
      attrsMapBuilder.putAll(Dict.cast(attrs, String.class, FakeDescriptor.class, "attrs"));
    }

    attrsMapBuilder.put("name", IMPLICIT_NAME_ATTRIBUTE_DESCRIPTOR);
    List<AttributeInfo> attrInfos =
        attrsMapBuilder.build().entrySet().stream()
            .filter(entry -> !entry.getKey().startsWith("_"))
            .map(entry -> entry.getValue().asAttributeInfo(entry.getKey()))
            .collect(Collectors.toList());
    attrInfos.sort(new AttributeNameComparator());

    List<String> aspectAttrs =
        attributeAspects != null
            ? Sequence.cast(attributeAspects, String.class, "aspectAttrs")
            : new ArrayList<>();

    aspectAttrs =
        aspectAttrs.stream().filter(entry -> !entry.startsWith("_")).collect(Collectors.toList());

    // Only the Builder is passed to AspectInfoWrapper as the aspect name is not yet available.
    AspectInfo.Builder aspectInfo =
        AspectInfo.newBuilder().addAllAttribute(attrInfos).addAllAspectAttribute(aspectAttrs);
    Starlark.toJavaOptional(doc, String.class).ifPresent(aspectInfo::setDocString);

    aspectInfoList.add(new AspectInfoWrapper(fakeAspect, thread.getCallerLocation(), aspectInfo));

    return fakeAspect;
  }

  @Override
  public ExecGroupApi execGroup(
      Sequence<?> execCompatibleWith, Sequence<?> toolchains, StarlarkThread thread) {
    return new FakeExecGroup();
  }

  /**
   * A fake {@link StarlarkCallable} implementation which serves as an identifier for a rule
   * definition. A Starlark invocation of 'rule()' should spawn a unique instance of this class and
   * return it. Thus, Starlark code such as 'foo = rule()' will result in 'foo' being assigned to a
   * unique identifier, which can later be matched to a registered rule() invocation saved by the
   * fake build API implementation.
   */
  private static class RuleDefinitionIdentifier implements StarlarkCallable {

    private static int idCounter = 0;
    private final String name = "RuleDefinitionIdentifier" + idCounter++;

    @Override
    public String getName() {
      return name;
    }
  }

  /**
   * A comparator for {@link AttributeInfo} objects which sorts by attribute name alphabetically,
   * except that any attribute named "name" is placed first.
   */
  public static class AttributeNameComparator implements Comparator<AttributeInfo> {

    @Override
    public int compare(AttributeInfo o1, AttributeInfo o2) {
      if (o1.getName().equals("name")) {
        return o2.getName().equals("name") ? 0 : -1;
      } else if (o2.getName().equals("name")) {
        return 1;
      } else {
        return o1.getName().compareTo(o2.getName());
      }
    }
  }
}
