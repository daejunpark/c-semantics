#!/bin/bash

#kompile c-verifier.k

#rm -f bst bst.o; ../dist/kcc bst.c -o bst; DUMPALL=1 ./bst; mv tmp-kcc-in-*.bin bst.o; rm tmp-kcc-out-*.txt
#rm -f avl avl.o; ../dist/kcc avl.c -o avl; DUMPALL=1 ./avl; mv tmp-kcc-in-*.bin avl.o; rm tmp-kcc-out-*.txt

 krun -v --debug --z3-executable --prove bst_find_spec.k   --smt_prelude ../../k/k-distribution/include/z3/search_tree.smt2 --parser "kast --parser binary" bst.o -cOPTIONS="(.Set)" -cARGV="(ListItem(\"./avl\") .List)" -cARGC=1
 krun -v --debug --z3-executable --prove bst_insert_spec.k --smt_prelude ../../k/k-distribution/include/z3/search_tree.smt2 --parser "kast --parser binary" bst.o -cOPTIONS="(.Set)" -cARGV="(ListItem(\"./avl\") .List)" -cARGC=1
 krun -v --debug --z3-executable --prove bst_delete_spec.k --smt_prelude ../../k/k-distribution/include/z3/search_tree.smt2 --parser "kast --parser binary" bst.o -cOPTIONS="(.Set)" -cARGV="(ListItem(\"./avl\") .List)" -cARGC=1

 krun -v --debug --z3-executable --prove avl_find_spec.k   --smt_prelude ../../k/k-distribution/include/z3/search_tree.smt2 --parser "kast --parser binary" avl.o -cOPTIONS="(.Set)" -cARGV="(ListItem(\"./avl\") .List)" -cARGC=1
 krun -v --debug --z3-executable --prove avl_insert_spec.k --smt_prelude ../../k/k-distribution/include/z3/search_tree.smt2 --parser "kast --parser binary" avl.o -cOPTIONS="(.Set)" -cARGV="(ListItem(\"./avl\") .List)" -cARGC=1
#krun -v --debug --z3-executable --prove avl_delete_spec.k --smt_prelude ../../k/k-distribution/include/z3/search_tree.smt2 --parser "kast --parser binary" avl.o -cOPTIONS="(.Set)" -cARGV="(ListItem(\"./avl\") .List)" -cARGC=1
