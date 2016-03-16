require "c-verifier.k"

module DELETE-SPEC
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
  <mem>... MEM:Map ctree(TP)(T:CTree) ...</mem>
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
            tv(loc(1 /* color */ @ static("rbt.c"), 0),
               t(.Set, pointerType(t(.Set, functionType(t(.Set, int), ListItem(t(.Set, pointerType(t(.Set, structType(global(Identifier("node"), "rbt.c"))))))))))),
            rvlist(
                ListItem(tv(TP:CanonicalSymLoc, t(.Set, pointerType(t(.Set, structType(global(Identifier("node"), "rbt.c")))))))))
      =>
        tv(ctree_color(T), t(.Set, int))
      ...</k>
    ...</thread>
  </threads>
  <files>
    <file-commands> .K </file-commands>
  </files>
  <error-cell-wrapper> .Bag </error-cell-wrapper>
ensures ctree_color(T) ==K 1 orBool ctree_color(T) ==K 0
  [trusted]



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
  <mem>... MEM:Map ctree(TP)(T:CTree) ...</mem>
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
            tv(loc(2 /* find_min */ @ static("rbt.c"), 0),
               t(.Set, pointerType(t(.Set, functionType(t(.Set, int), ListItem(t(.Set, pointerType(t(.Set, structType(global(Identifier("node"), "rbt.c"))))))))))),
            rvlist(
                ListItem(tv(TP:CanonicalSymLoc, t(.Set, pointerType(t(.Set, structType(global(Identifier("node"), "rbt.c")))))))))
      =>
        tv(?M:Int, t(.Set, int))
      ...</k>
    ...</thread>
  </threads>
  <files>
    <file-commands> .K </file-commands>
  </files>
  <error-cell-wrapper> .Bag </error-cell-wrapper>
requires TP =/=K NullPointer andBool rbt(T)
ensures (?M inIntSet ctree_keys(T)) andBool ({ ?M } <=IntSet ctree_keys(T))
  [trusted]



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
    FP:Int @ alloc |-> object(t(.Set, no-type), 4,
       0 |-> piece(F10:Int => ?F20:Int, 8)
       1 |-> piece(F11:Int => ?F21:Int, 8) 
       2 |-> piece(F12:Int => ?F22:Int, 8) 
       3 |-> piece(F13:Int => ?F23:Int, 8),
       0 |-> t(.Set, int))
  (
    ctree( TP1)(cnode( I1:Int, C1:Int, L1:CTree,cnode(RI1:Int,RC1:Int,RL1:CTree,RR1:CTree)))
  =>
    ctree(?TP2)(cnode(?I2:Int,?C2:Int,?L2:CTree,?R2:CTree))
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
            tv(loc(8 /* left_delete_fixup */ @ static("rbt.c"), 0),
                t(.Set, pointerType(t(.Set, functionType(t(.Set, pointerType(t(.Set, structType(global(Identifier("node"), "rbt.c"))))), ListItem(t(.Set, pointerType(t(.Set, int)))) ListItem(t(.Set, pointerType(t(.Set, structType(global(Identifier("node"), "rbt.c"))))))))))),
            rvlist(
                ListItem(tv(loc(FP:Int @ alloc, 0, SetItem(align(16)) SetItem(fromArray(0, 4))), t(.Set, pointerType(t(.Set, int)))))
                ListItem(tv(TP1:CanonicalSymLoc, t(.Set, pointerType(t(.Set, structType(global(Identifier("node"), "rbt.c")))))))))
      =>
        tv(?TP2:CanonicalSymLoc, t(.Set, pointerType(t(.Set, structType(global(Identifier("node"), "rbt.c"))))))
      ...</k>
    ...</thread>
  </threads>
  <files>
    <file-commands> .K </file-commands>
  </files>
  <error-cell-wrapper> .Bag </error-cell-wrapper>
requires ((((((F13:Int <<Int 8) |Int F12:Int) <<Int 8) |Int F11:Int) <<Int 8) |Int F10:Int) =/=K 1
  andBool rbt(L1) andBool rbt(cnode(RI1,RC1,RL1,RR1))
  andBool ctree_keys(L1) <IntSet { I1 } andBool { I1 } <IntSet ctree_keys(cnode(RI1,RC1,RL1,RR1))
  andBool ctree_height(L1) ==Int ctree_height(cnode(RI1,RC1,RL1,RR1)) -Int 1
  andBool ctree_color(L1) ==K 1 andBool ( C1 ==K 1 orBool RC1 ==K 1 )
  andBool ( C1 ==K 1 orBool C1 ==K 0 )
  andBool TP1 =/=K NullPointer
ensures rbt(cnode(?I2,?C2,?L2,?R2))
  andBool ctree_keys(cnode(?I2,?C2,?L2,?R2)) ==K ctree_keys(cnode(I1,C1,L1,cnode(RI1,RC1,RL1,RR1)))
  andBool (
            ?C2 ==K 1
          orBool
            ?C2 ==K C1
          )
  andBool (
            (
              ((((((?F23:Int <<Int 8) |Int ?F22:Int) <<Int 8) |Int ?F21:Int) <<Int 8) |Int ?F20:Int) ==K 1
            andBool ctree_height(cnode(?I2,?C2,?L2,?R2)) ==Int ctree_height(L1) +Int C1 +Int 1
            )
          orBool
            (
              ((((((?F23:Int <<Int 8) |Int ?F22:Int) <<Int 8) |Int ?F21:Int) <<Int 8) |Int ?F20:Int) =/=K 1
            andBool C1 ==K 1
            andBool ?C2 ==K 1
            andBool ctree_height(cnode(?I2,?C2,?L2,?R2)) ==Int ctree_height(L1) +Int C1
            )
          )
  andBool ( C1 =/=K 1 impliesBool ((((((?F23:Int <<Int 8) |Int ?F22:Int) <<Int 8) |Int ?F21:Int) <<Int 8) |Int ?F20:Int) ==K 1 )
  andBool ?TP2 =/=K NullPointer

// rule
//   <struct>... STRUCT:Map ...</struct>
//   <fun>... FUN:Map ...</fun>
//   <k>
//     right_delete_fixup(tv(int *, object(FP:Int)), tv(struct node *, object(TP1:Int)))
//   =>
//     tv(struct node *, object(?TP2:Int))
//   ...</k>
//   <heap>...
//      object(FP) |-> tv(int, F1:Int => ?F2:Int)
//    ( ctree(object( TP1))(cnode( I1:Int, C1:Int,cnode(LI1:Int,LC1:Int,LL1:CTree,LR1:CTree), R1:CTree))
//   => ctree(object(?TP2))(cnode(?I2:Int,?C2:Int,?L2:CTree,                               ?R2:CTree)) )
//   ...</heap>
// requires F1 =/=K 1
//   andBool rbt(cnode(LI1,LC1,LL1,LR1)) andBool rbt(R1)
//   andBool ctree_keys(cnode(LI1,LC1,LL1,LR1)) <IntSet { I1 } andBool { I1 } <IntSet ctree_keys(R1)
//   andBool ctree_height(R1) ==Int ctree_height(cnode(LI1,LC1,LL1,LR1)) -Int 1
//   andBool ctree_color(R1) ==K 1 andBool ( C1 ==K 1 orBool LC1 ==K 1 )
//   andBool ( C1 ==K 1 orBool C1 ==K 0 )
// ensures rbt(cnode(?I2,?C2,?L2,?R2))
//   andBool ctree_keys(cnode(?I2,?C2,?L2,?R2)) ==K ctree_keys(cnode(I1,C1,cnode(LI1,LC1,LL1,LR1),R1))
//   andBool (
//             ?C2 ==K 1
//           orBool
//             ?C2 ==K C1
//           )
//   andBool (
//             (
//               ?F2 ==K 1
//             andBool ctree_height(cnode(?I2,?C2,?L2,?R2)) ==Int ctree_height(R1) +Int C1 +Int 1
//             )
//           orBool
//             (
//               ?F2 =/=K 1
//             andBool C1 ==K 1
//             andBool ?C2 ==K 1
//             andBool ctree_height(cnode(?I2,?C2,?L2,?R2)) ==Int ctree_height(R1) +Int C1
//             )
//           )
//   andBool ( C1 =/=K 1 impliesBool ?F2 ==K 1 )
// 
// rule
//   <struct>... STRUCT:Map ...</struct>
//   <fun>... FUN:Map ...</fun>
//   <k>
//     delete_aux(tv(int *, object(FP:Int)), tv(struct node *, TP1:Pointer), tv(int, V:Int))
//   =>
//     tv(struct node *, ?TP2:Pointer)
//   ...</k>
//   <heap>...
//      object(FP) |-> tv(int, F1:Int => ?F2:Int)
//    ( ctree( TP1)( T1:CTree)
//   => ctree(?TP2)(?T2:CTree) )
//    ( .Map => ?_:Map )
//   ...</heap>
// requires rbt(T1)
// ensures rbt(?T2)
//   andBool ctree_keys(?T2) ==K (ctree_keys(T1) -IntSet { V })
//   andBool (
//             ctree_color(?T2) ==K 1
//           orBool
//             ctree_color(?T2) ==K ctree_color(T1)
//           )
//   andBool (
//             (
//               ?F2 ==K 1
//             andBool ctree_height(?T2) ==Int ctree_height(T1)
//             )
//           orBool
//             (
//               ?F2 =/=K 1
//             andBool ctree_height(?T2) ==Int ctree_height(T1) -Int 1
//             andBool ctree_color(?T2) ==K 1
//             )
//           )
// 
// rule
//   <struct>... STRUCT:Map ...</struct>
//   <fun>... FUN:Map ...</fun>
//   <k>
//     delete(tv(int, V:Int), tv(struct node *, TP1:Pointer))
//   =>
//     tv(struct node *, ?TP2:Pointer)
//   ...</k>
//   <heap>...
//    ( ctree( TP1)( T1:CTree)
//   => ctree(?TP2)(?T2:CTree) )
//    ( .Map => ?_:Map )
//   ...</heap>
// requires rbt(T1)
// ensures rbt(?T2)
//   andBool ctree_keys(?T2) ==K (ctree_keys(T1) -IntSet { V })
//   andBool ctree_height(T1) -Int 1 <=Int ctree_height(?T2)
//   andBool ctree_height(?T2) <=Int ctree_height(T1)

endmodule
