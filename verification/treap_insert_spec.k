require "c-verifier.k"

module INSERT-SPEC
imports C-VERIFIER

rule
  <functions> FUNCTIONS:Map </functions> // <functions>... FUNCTIONS:Map ...</functions>
  <structs> STRUCTS:Map </structs>       // <structs>... STRUCTS:Map ...</structs>
  <external-types> EXTERNALTYPES:Map </external-types>
  <external-defs> EXTERNALDEFS:Map </external-defs>
  <linkings> LINKINGS:Map </linkings>
  <translation-units> TRANSLATIONUNITS:Bag </translation-units>
  <activeBlocks> .Map </activeBlocks>
  <malloced> _:Map => ?_:Map </malloced>
  <next-malloced> (_:Int => ?_:Int) @ alloc </next-malloced>
  <status> mainCalled </status>
  <mem>...
    MEM:Map
  (
    ptree( TP1)( T1:PTree)
  =>
    ptree(?TP2)(pnode(?I2:Int,?Z2:Int,?L2:PTree,?R2:PTree))
  )
  ...</mem>
  <restrict> .Map </restrict>
  <threads>
    <thread>...
      <thread-id> 0 </thread-id>
        <buffer> .List </buffer>
        <curr-function> _:CId </curr-function>
        <curr-subobject> .List </curr-subobject>
        <locs-written> _:List => .List </locs-written>
      <formatting-wrapper> .Bag </formatting-wrapper>
      <type-wrapper> .Bag </type-wrapper>
      <initializing> 0 /* Initializing:Int */ </initializing>
      <duration> auto(0) </duration>
      <k> 
        Call1(
            tv(loc(4 /* insert */ @ static("treap.c"), 0),
                t(.Set, pointerType(t(.Set, functionType(t(.Set, pointerType(t(.Set, structType(global(Identifier("node"), "treap.c"))))),
                    ListItem(t(.Set, int))
                    ListItem(t(.Set, int))
                    ListItem(t(.Set, pointerType(t(.Set, structType(global(Identifier("node"), "treap.c"))))))))))),
            rvlist(
                ListItem(tv(V:Int, t(.Set, int)))
                ListItem(tv(Z:Int, t(.Set, int)))
                ListItem(tv(TP1:CanonicalSymLoc, t(.Set, pointerType(t(.Set, structType(global(Identifier("node"), "treap.c")))))))))
      =>
        tv(?TP2:CanonicalSymLoc, t(.Set, pointerType(t(.Set, structType(global(Identifier("node"), "treap.c"))))))
      ...</k>
    ...</thread>
  </threads>
  <files>
    <file-commands> .K </file-commands>
  </files>
  <error-cell-wrapper> .Bag </error-cell-wrapper>
requires treap(T1)
  andBool Z >=Int 0
  andBool min(t(.Set, int)) <=Int V:Int andBool V:Int <=Int max(t(.Set, int)) // c-specific
  andBool min(t(.Set, int)) <=Int Z:Int andBool Z:Int <=Int max(t(.Set, int)) // c-specific
ensures treap(pnode(?I2,?Z2,?L2,?R2))
  andBool ptree_keys(pnode(?I2,?Z2,?L2,?R2)) ==K { V } U ptree_keys(T1)
  andBool ?TP2 =/=K NullPointer
  andBool ptree_max_priority(T1) >=Int ptree_max_priority(?L2)
  andBool ptree_max_priority(T1) >=Int ptree_max_priority(?R2)

endmodule
