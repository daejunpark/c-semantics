#!/bin/bash -x

SMT_PRELUDE_DIR=$K_HOME/k-distribution/include/z3

kompile c-verifier.k

rm -f bst  bst.o  && ../dist/kcc bst.c  -o bst  && DUMPALL=1 ./bst  ; mv tmp-kcc-in-*.bin bst.o  && rm -f tmp-kcc-out-*.txt
rm -f avl  avl.o  && ../dist/kcc avl.c  -o avl  && DUMPALL=1 ./avl  ; mv tmp-kcc-in-*.bin avl.o  && rm -f tmp-kcc-out-*.txt
rm -f rbt  rbt.o  && ../dist/kcc rbt.c  -o rbt  && DUMPALL=1 ./rbt  ; mv tmp-kcc-in-*.bin rbt.o  && rm -f tmp-kcc-out-*.txt
rm -f treap treap.o && ../dist/kcc treap.c -o treap && DUMPALL=1 ./treap ; mv tmp-kcc-in-*.bin treap.o && rm -f tmp-kcc-out-*.txt
rm -f list list.o && ../dist/kcc list.c -o list && DUMPALL=1 ./list ; mv tmp-kcc-in-*.bin list.o && rm -f tmp-kcc-out-*.txt

krun -v --debug --prove bst_find_spec.k                   --parser "kast --parser binary" bst.o  --smt_prelude $SMT_PRELUDE_DIR/search_tree.smt2 -cOPTIONS="(.Set)" -cARGV="(ListItem(\"./bst\") .List)" -cARGC=1
krun -v --debug --prove bst_insert_spec.k                 --parser "kast --parser binary" bst.o  --smt_prelude $SMT_PRELUDE_DIR/search_tree.smt2 -cOPTIONS="(.Set)" -cARGV="(ListItem(\"./bst\") .List)" -cARGC=1
krun -v --debug --prove bst_delete_spec.k                 --parser "kast --parser binary" bst.o  --smt_prelude $SMT_PRELUDE_DIR/search_tree.smt2 -cOPTIONS="(.Set)" -cARGV="(ListItem(\"./bst\") .List)" -cARGC=1

krun -v --debug --prove avl_find_spec.k                   --parser "kast --parser binary" avl.o  --smt_prelude $SMT_PRELUDE_DIR/search_tree.smt2 -cOPTIONS="(.Set)" -cARGV="(ListItem(\"./avl\") .List)" -cARGC=1
krun -v --debug --prove avl_insert_spec.k                 --parser "kast --parser binary" avl.o  --smt_prelude $SMT_PRELUDE_DIR/search_tree.smt2 -cOPTIONS="(.Set)" -cARGV="(ListItem(\"./avl\") .List)" -cARGC=1
K_OPTS=-Xmx4g krun -v --debug --prove avl_delete_spec.k   --parser "kast --parser binary" avl.o  --smt_prelude $SMT_PRELUDE_DIR/search_tree.smt2 -cOPTIONS="(.Set)" -cARGV="(ListItem(\"./avl\") .List)" -cARGC=1

K_OPTS=-Xmx6g krun -v --debug --prove rbt_find_spec.k     --parser "kast --parser binary" rbt.o  --smt_prelude $SMT_PRELUDE_DIR/search_tree.smt2 -cOPTIONS="(.Set)" -cARGV="(ListItem(\"./rbt\") .List)" -cARGC=1
K_OPTS=-Xmx6g krun -v --debug --prove rbt_insert_spec.k   --parser "kast --parser binary" rbt.o  --smt_prelude $SMT_PRELUDE_DIR/search_tree.smt2 -cOPTIONS="(.Set)" -cARGV="(ListItem(\"./rbt\") .List)" -cARGC=1
K_OPTS=-Xmx6g krun -v --debug --prove rbt_delete_spec.k   --parser "kast --parser binary" rbt.o  --smt_prelude $SMT_PRELUDE_DIR/search_tree.smt2 -cOPTIONS="(.Set)" -cARGV="(ListItem(\"./rbt\") .List)" -cARGC=1

K_OPTS=-Xmx6g krun -v --debug --prove treap_find_spec.k     --parser "kast --parser binary" treap.o  --smt_prelude ../../k/k-distribution/include/z3/search_tree.smt2 -cOPTIONS="(.Set)" -cARGV="(ListItem(\"./treap\") .List)" -cARGC=1
K_OPTS=-Xmx6g krun -v --debug --prove treap_insert_spec.k   --parser "kast --parser binary" treap.o  --smt_prelude ../../k/k-distribution/include/z3/search_tree.smt2 -cOPTIONS="(.Set)" -cARGV="(ListItem(\"./treap\") .List)" -cARGC=1
K_OPTS=-Xmx6g krun -v --debug --prove treap_delete_spec.k   --parser "kast --parser binary" treap.o  --smt_prelude ../../k/k-distribution/include/z3/search_tree.smt2 -cOPTIONS="(.Set)" -cARGV="(ListItem(\"./treap\") .List)" -cARGC=1

krun -v --debug --prove list_reverse_spec.k               --parser "kast --parser binary" list.o --smt_prelude $SMT_PRELUDE_DIR/sorted_list.smt2 -cOPTIONS="(.Set)" -cARGV="(ListItem(\"./list\") .List)" -cARGC=1
krun -v --debug --prove list_append_spec.k                --parser "kast --parser binary" list.o --smt_prelude $SMT_PRELUDE_DIR/sorted_list.smt2 -cOPTIONS="(.Set)" -cARGV="(ListItem(\"./list\") .List)" -cARGC=1

krun -v --debug --prove list_bubble_sort_spec.k           --parser "kast --parser binary" list.o --smt_prelude $SMT_PRELUDE_DIR/sorted_list.smt2 -cOPTIONS="(.Set)" -cARGV="(ListItem(\"./list\") .List)" -cARGC=1
krun -v --debug --prove list_insertion_sort_spec.k        --parser "kast --parser binary" list.o --smt_prelude $SMT_PRELUDE_DIR/sorted_list.smt2 -cOPTIONS="(.Set)" -cARGV="(ListItem(\"./list\") .List)" -cARGC=1
krun -v --debug --prove list_quick_sort_spec.k            --parser "kast --parser binary" list.o --smt_prelude $SMT_PRELUDE_DIR/sorted_list.smt2 -cOPTIONS="(.Set)" -cARGV="(ListItem(\"./list\") .List)" -cARGC=1
krun -v --debug --prove list_merge_sort_spec.k            --parser "kast --parser binary" list.o --smt_prelude $SMT_PRELUDE_DIR/sorted_list.smt2 -cOPTIONS="(.Set)" -cARGV="(ListItem(\"./list\") .List)" -cARGC=1
