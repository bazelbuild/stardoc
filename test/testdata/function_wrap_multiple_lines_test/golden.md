<!-- Generated with Stardoc: http://skydoc.bazel.build -->

Rules for ANTLR 3.

<a id="antlr"></a>

## antlr

<pre>
antlr(<a href="#antlr-name">name</a>, <a href="#antlr-deps">deps</a>, <a href="#antlr-srcs">srcs</a>, <a href="#antlr-Xconversiontimeout">Xconversiontimeout</a>, <a href="#antlr-Xdbgconversion">Xdbgconversion</a>, <a href="#antlr-Xdbgst">Xdbgst</a>, <a href="#antlr-Xdfa">Xdfa</a>, <a href="#antlr-Xdfaverbose">Xdfaverbose</a>, <a href="#antlr-Xgrtree">Xgrtree</a>, <a href="#antlr-Xm">Xm</a>,
      <a href="#antlr-Xmaxdfaedges">Xmaxdfaedges</a>, <a href="#antlr-Xmaxinlinedfastates">Xmaxinlinedfastates</a>, <a href="#antlr-Xminswitchalts">Xminswitchalts</a>, <a href="#antlr-Xmultithreaded">Xmultithreaded</a>, <a href="#antlr-Xnfastates">Xnfastates</a>, <a href="#antlr-Xnocollapse">Xnocollapse</a>,
      <a href="#antlr-Xnomergestopstates">Xnomergestopstates</a>, <a href="#antlr-Xnoprune">Xnoprune</a>, <a href="#antlr-XsaveLexer">XsaveLexer</a>, <a href="#antlr-Xwatchconversion">Xwatchconversion</a>, <a href="#antlr-debug">debug</a>, <a href="#antlr-depend">depend</a>, <a href="#antlr-dfa">dfa</a>, <a href="#antlr-dump">dump</a>, <a href="#antlr-imports">imports</a>,
      <a href="#antlr-language">language</a>, <a href="#antlr-message_format">message_format</a>, <a href="#antlr-nfa">nfa</a>, <a href="#antlr-package">package</a>, <a href="#antlr-profile">profile</a>, <a href="#antlr-report">report</a>, <a href="#antlr-trace">trace</a>)
</pre>

Runs [ANTLR 3](https://www.antlr3.org//) on a set of grammars.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="antlr-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="antlr-deps"></a>deps |  The dependencies to use. Defaults to the most recent ANTLR 3 release, but if you need to use a different version, you can specify the dependencies here.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `["@@[unknown repo 'antlr3_runtimes' requested from @@]//:tool"]`  |
| <a id="antlr-srcs"></a>srcs |  The grammar files to process.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | required |  |
| <a id="antlr-Xconversiontimeout"></a>Xconversiontimeout |  Set NFA conversion timeout for each decision.   | Integer | optional |  `0`  |
| <a id="antlr-Xdbgconversion"></a>Xdbgconversion |  Dump lots of info during NFA conversion.   | Boolean | optional |  `False`  |
| <a id="antlr-Xdbgst"></a>Xdbgst |  Put tags at start/stop of all templates in output.   | Boolean | optional |  `False`  |
| <a id="antlr-Xdfa"></a>Xdfa |  Print DFA as text.   | Boolean | optional |  `False`  |
| <a id="antlr-Xdfaverbose"></a>Xdfaverbose |  Generate DFA states in DOT with NFA configs.   | Boolean | optional |  `False`  |
| <a id="antlr-Xgrtree"></a>Xgrtree |  Print the grammar AST.   | Boolean | optional |  `False`  |
| <a id="antlr-Xm"></a>Xm |  Max number of rule invocations during conversion.   | Integer | optional |  `0`  |
| <a id="antlr-Xmaxdfaedges"></a>Xmaxdfaedges |  Max &quot;comfortable&quot; number of edges for single DFA state.   | Integer | optional |  `0`  |
| <a id="antlr-Xmaxinlinedfastates"></a>Xmaxinlinedfastates |  Max DFA states before table used rather than inlining.   | Integer | optional |  `0`  |
| <a id="antlr-Xminswitchalts"></a>Xminswitchalts |  Don't generate switch() statements for dfas smaller than given number.   | Integer | optional |  `0`  |
| <a id="antlr-Xmultithreaded"></a>Xmultithreaded |  Run the analysis in 2 threads.   | Boolean | optional |  `False`  |
| <a id="antlr-Xnfastates"></a>Xnfastates |  For nondeterminisms, list NFA states for each path.   | Boolean | optional |  `False`  |
| <a id="antlr-Xnocollapse"></a>Xnocollapse |  Collapse incident edges into DFA states.   | Boolean | optional |  `False`  |
| <a id="antlr-Xnomergestopstates"></a>Xnomergestopstates |  Max DFA states before table used rather than inlining.   | Boolean | optional |  `False`  |
| <a id="antlr-Xnoprune"></a>Xnoprune |  Do not test EBNF block exit branches.   | Boolean | optional |  `False`  |
| <a id="antlr-XsaveLexer"></a>XsaveLexer |  For nondeterminisms, list NFA states for each path.   | Boolean | optional |  `False`  |
| <a id="antlr-Xwatchconversion"></a>Xwatchconversion |  Don't delete temporary lexers generated from combined grammars.   | Boolean | optional |  `False`  |
| <a id="antlr-debug"></a>debug |  Generate a parser that emits debugging events.   | Boolean | optional |  `False`  |
| <a id="antlr-depend"></a>depend |  Generate file dependencies; don't actually run antlr.   | Boolean | optional |  `False`  |
| <a id="antlr-dfa"></a>dfa |  Generate a DFA for each decision point.   | Boolean | optional |  `False`  |
| <a id="antlr-dump"></a>dump |  Print out the grammar without actions.   | Boolean | optional |  `False`  |
| <a id="antlr-imports"></a>imports |  The grammar and .tokens files to import. Must be all in the same directory.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `[]`  |
| <a id="antlr-language"></a>language |  The code generation target language. Either C, Cpp, CSharp2, CSharp3, JavaScript, Java, ObjC, Python, Python3 or Ruby (case-sensitive).   | String | optional |  `""`  |
| <a id="antlr-message_format"></a>message_format |  Specify output style for messages.   | String | optional |  `""`  |
| <a id="antlr-nfa"></a>nfa |  Generate an NFA for each rule.   | Boolean | optional |  `False`  |
| <a id="antlr-package"></a>package |  The package/namespace for the generated code.   | String | optional |  `""`  |
| <a id="antlr-profile"></a>profile |  Generate a parser that computes profiling information.   | Boolean | optional |  `False`  |
| <a id="antlr-report"></a>report |  Print out a report about the grammar(s) processed.   | Boolean | optional |  `False`  |
| <a id="antlr-trace"></a>trace |  Generate a parser with trace output. If the default output is not enough, you can override the traceIn and traceOut methods.   | Boolean | optional |  `False`  |


