require "c-verifier.k"

module DELETE-SPEC
imports C-VERIFIER

rule [func-delete-root]:
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
    ptree( TP1)(pnode(I1:Int,Z1:Int,L1:PTree,R1:PTree))
  =>
    ptree(?TP2)(?T2:PTree)
  )
//  (.Map => ?_:Map)
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
            tv(loc(5 /* delete_root */ @ static("treap.c"), 0),
                t(.Set, pointerType(t(.Set, functionType(t(.Set, pointerType(t(.Set, structType(global(Identifier("node"), "treap.c"))))),
                    ListItem(t(.Set, pointerType(t(.Set, structType(global(Identifier("node"), "treap.c"))))))))))),
            rvlist(
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
requires treap(pnode(I1:Int,Z1:Int,L1:PTree,R1:PTree))
  andBool TP1 =/=K NullPointer
  andBool min(t(.Set, int)) <=Int I1 andBool I1 <=Int max(t(.Set, int)) // c-specific
  andBool min(t(.Set, int)) <=Int Z1 andBool Z1 <=Int max(t(.Set, int)) // c-specific
ensures treap(?T2)
  andBool ptree_keys(?T2) ==K ptree_keys(L1) U ptree_keys(R1)
  andBool ptree_max_priority(?T2) ==Int maxInt(ptree_max_priority(L1), ptree_max_priority(R1))

rule [func-delete]:
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
    ptree(?TP2)(?T2:PTree)
  )
//  (.Map => ?_:Map)
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
            tv(loc(6 /* delete */ @ static("treap.c"), 0),
                t(.Set, pointerType(t(.Set, functionType(t(.Set, pointerType(t(.Set, structType(global(Identifier("node"), "treap.c"))))), ListItem(t(.Set, int)) ListItem(t(.Set, pointerType(t(.Set, structType(global(Identifier("node"), "treap.c"))))))))))),
            rvlist(
                ListItem(tv(V:Int, t(.Set, int)))
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
  andBool min(t(.Set, int)) <=Int V:Int andBool V:Int <=Int max(t(.Set, int)) // c-specific
ensures treap(?T2)
  andBool ptree_keys(?T2) ==K (ptree_keys(T1) -IntSet { V })
  andBool ptree_max_priority(?T2) <=Int ptree_max_priority(T1)

endmodule
