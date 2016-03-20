// Copyright (c) 2014-2015 K Team. All Rights Reserved.

module TREAP-PATTERN
  imports C-COMMON
  imports INT-SET

  syntax PTree ::= "pnode" "(" Int /* Key */ "," Int /* Priority */ "," PTree "," PTree ")"
                 | "pleaf"

  syntax IntSet ::= "ptree_keys" "(" PTree ")"    [function, smtlib(smt_ptree_keys)]
  rule ptree_keys(pnode(I:Int, _, TL:PTree, TR:PTree)) => { I } U (ptree_keys(TL) U ptree_keys(TR))
  rule ptree_keys(pleaf) => .IntSet

  syntax Int ::= "ptree_max_priority" "(" PTree ")"    [function, smtlib(smt_ptree_max_priority)]
  rule ptree_max_priority(pnode(_, Z:Int, TL:PTree, TR:PTree)) => maxInt(Z, maxInt(ptree_max_priority(TL), ptree_max_priority(TR)))
  rule ptree_max_priority(pleaf) => 0
  //
  rule ptree_max_priority(_:PTree) >=Int 0 => true    [smt-lemma]

  syntax Int ::= "ptree_priority" "(" PTree ")"    [function, smtlib(smt_ptree_priority)]
  rule ptree_priority(pnode(_, Z:Int, _, _)) => Z
  rule ptree_priority(pleaf) => 0
  //
  rule ptree_priority(_:PTree) >=Int 0 => true    [smt-lemma]

  syntax Bool ::= "treap" "(" PTree ")"   [function, smtlib(smt_treap)]
  rule treap(pnode(I:Int, Z:Int, TL:PTree, TR:PTree))
    => treap(TL) andBool treap(TR)
       andBool ptree_keys(TL) <IntSet { I } andBool { I } <IntSet ptree_keys(TR)
       andBool Z >=Int ptree_max_priority(TL) andBool Z >=Int ptree_max_priority(TR)
       andBool Z >=Int 0
  rule treap(pleaf) => true
  //
  rule treap(T:PTree) impliesBool ptree_max_priority(T) ==K ptree_priority(T) => true    [smt-lemma]

  syntax Map ::= "ptree" "(" CanonicalSymLoc ")" "(" PTree ")"   [pattern(1)]
  rule
      ptree(loc(BP:Int @ alloc, 0, SetItem(align(16)) SetItem(fromArray(0, 16))))(pnode(I:Int, Z:Int, LT:PTree, RT:PTree))
    =>
      BP:Int @ alloc |-> object(t(.Set, no-type), 16,
         0 |-> piece(?I0:Int, 8) 
         1 |-> piece(?I1:Int, 8) 
         2 |-> piece(?I2:Int, 8) 
         3 |-> piece(?I3:Int, 8) 
         4 |-> piece(?Z0:Int, 8) 
         5 |-> piece(?Z1:Int, 8) 
         6 |-> piece(?Z2:Int, 8) 
         7 |-> piece(?Z3:Int, 8) 
         8 |-> piece(subObject(?LP, 0, 0), 8)
         9 |-> piece(subObject(?LP, 1, 1), 8)
        10 |-> piece(subObject(?LP, 2, 2), 8)
        11 |-> piece(subObject(?LP, 3, 3), 8)
        12 |-> piece(subObject(?RP, 0, 0), 8)
        13 |-> piece(subObject(?RP, 1, 1), 8)
        14 |-> piece(subObject(?RP, 2, 2), 8)
        15 |-> piece(subObject(?RP, 3, 3), 8),
         0 |-> t(.Set, int) // value
         4 |-> t(.Set, int) // priority
         8 |-> t(.Set, pointerType(t(.Set, structType(global(Identifier("node"), "treap.c")))))
        12 |-> t(.Set, pointerType(t(.Set, structType(global(Identifier("node"), "treap.c")))))
      )
      ptree(?LP:CanonicalSymLoc)(LT)
      ptree(?RP:CanonicalSymLoc)(RT)
  ensures I ==K (((((?I3:Int <<Int 8) |Int ?I2:Int) <<Int 8) |Int ?I1:Int) <<Int 8) |Int ?I0:Int
  andBool Z ==K (((((?Z3:Int <<Int 8) |Int ?Z2:Int) <<Int 8) |Int ?Z1:Int) <<Int 8) |Int ?Z0:Int
  andBool min(t(.Set, int)) <=Int I:Int andBool I:Int <=Int max(t(.Set, int))
  andBool min(t(.Set, int)) <=Int Z:Int andBool Z:Int <=Int max(t(.Set, int))
  andBool Z >=Int 0
    [pattern]
  rule ptree(NullPointer)(pleaf) => .Map
    [pattern]

endmodule
