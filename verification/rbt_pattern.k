// Copyright (c) 2014-2015 K Team. All Rights Reserved.

module RBT-PATTERN
  imports C-COMMON
  imports INT-SET

  syntax CTree ::= "cnode" "(" Int "," Int /* Color */ "," CTree "," CTree ")" // Red=0, Black=1
                 | "cleaf"

  syntax IntSet ::= "ctree_keys" "(" CTree ")"    [function, smtlib(smt_ctree_keys)]
  rule ctree_keys(cnode(I:Int, _, TL:CTree, TR:CTree)) => { I } U (ctree_keys(TL) U ctree_keys(TR))
  rule ctree_keys(cleaf) => .IntSet

  syntax Int ::= "ctree_height" "(" CTree ")"     [function, smtlib(smt_ctree_height)]
  rule ctree_height(cnode(_, C:Int, TL:CTree, TR:CTree)) => C +Int maxInt(ctree_height(TL), ctree_height(TR))
  rule ctree_height(cleaf) => 0
  //
  rule ctree_height(T:CTree) >=Int 0 => true    [smt-lemma]

  syntax Int ::= "ctree_color" "(" CTree ")"      [function, smtlib(smt_ctree_color)]
  rule ctree_color(cnode(_, C:Int, _, _)) => C
  rule ctree_color(cleaf) => 1
  //
  rule ( ctree_color(T:CTree) ==K 1 orBool ctree_color(T) ==K 0 ) => true  [smt-lemma]

  syntax Bool ::= "rbt" "(" CTree ")"   [function, smtlib(smt_rbt)]
  rule rbt(cnode(I:Int, C:Int, TL:CTree, TR:CTree))
    => rbt(TL) andBool rbt(TR)
       andBool ctree_keys(TL) <IntSet { I } andBool { I } <IntSet ctree_keys(TR)
       andBool ctree_height(TL) ==Int ctree_height(TR)
       andBool ( C ==K 1 orBool C ==K 0 )
       andBool (
                 C ==K 1
               orBool
                 (ctree_color(TL) ==K 1 andBool ctree_color(TR) ==K 1)
               )
  rule rbt(cleaf) => true

  syntax Map ::= "ctree" "(" CanonicalSymLoc ")" "(" CTree ")"   [pattern(1)]
  rule
      ctree(loc(BP:Int @ alloc, 0, SetItem(align(16)) SetItem(fromArray(0, 16))))(cnode(I:Int, C:Int, LT:CTree, RT:CTree))
    =>
      BP:Int @ alloc |-> object(t(.Set, no-type), 16,
         0 |-> piece(?I0:Int, 8) 
         1 |-> piece(?I1:Int, 8) 
         2 |-> piece(?I2:Int, 8) 
         3 |-> piece(?I3:Int, 8) 
         4 |-> piece(?C0:Int, 8) 
         5 |-> piece(?C1:Int, 8) 
         6 |-> piece(?C2:Int, 8) 
         7 |-> piece(?C3:Int, 8) 
         8 |-> piece(subObject(?LP, 0, 0), 8)
         9 |-> piece(subObject(?LP, 1, 1), 8)
        10 |-> piece(subObject(?LP, 2, 2), 8)
        11 |-> piece(subObject(?LP, 3, 3), 8)
        12 |-> piece(subObject(?RP, 0, 0), 8)
        13 |-> piece(subObject(?RP, 1, 1), 8)
        14 |-> piece(subObject(?RP, 2, 2), 8)
        15 |-> piece(subObject(?RP, 3, 3), 8),
         0 |-> t(.Set, int) // value
         4 |-> t(.Set, int) // color
         8 |-> t(.Set, pointerType(t(.Set, structType(global(Identifier("node"), "rbt.c")))))
        12 |-> t(.Set, pointerType(t(.Set, structType(global(Identifier("node"), "rbt.c")))))
      )
      ctree(?LP:CanonicalSymLoc)(LT)
      ctree(?RP:CanonicalSymLoc)(RT)
  ensures I ==K (((((?I3:Int <<Int 8) |Int ?I2:Int) <<Int 8) |Int ?I1:Int) <<Int 8) |Int ?I0:Int
  andBool C ==K (((((?C3:Int <<Int 8) |Int ?C2:Int) <<Int 8) |Int ?C1:Int) <<Int 8) |Int ?C0:Int
  andBool min(t(.Set, int)) <=Int I:Int andBool I:Int <=Int max(t(.Set, int))
  andBool min(t(.Set, int)) <=Int C:Int andBool C:Int <=Int max(t(.Set, int))
    [pattern]
  rule ctree(NullPointer)(cleaf) => .Map
    [pattern]

endmodule
