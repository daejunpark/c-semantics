#!/bin/bash

#krun -v --debug --prove avl_find_spec.k   --smt_prelude ../../k/k-distribution/include/z3/search_tree.smt2 --parser "kast --parser binary" avl.o -cOPTIONS="(.Set)" -cARGV="(ListItem(\"./avl\") .List)" -cARGC=1
#krun -v --debug --prove avl_insert_spec.k --smt_prelude ../../k/k-distribution/include/z3/search_tree.smt2 --parser "kast --parser binary" avl.o -cOPTIONS="(.Set)" -cARGV="(ListItem(\"./avl\") .List)" -cARGC=1
 krun -v --debug --prove avl_delete_spec.k --smt_prelude ../../k/k-distribution/include/z3/search_tree.smt2 --parser "kast --parser binary" avl.o -cOPTIONS="(.Set)" -cARGV="(ListItem(\"./avl\") .List)" -cARGC=1
