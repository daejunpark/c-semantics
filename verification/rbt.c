#include <stdlib.h>

struct node {
  int value;
  int color; // RED=0, BLACK=1
  struct node *left;
  struct node *right;
};

struct node *new_node(int value)
{
  struct node *node;
  node = (struct node *) malloc(sizeof(struct node));
  node->value = value;
  node->color = 0; // RED
  node->left = NULL;
  node->right = NULL;
  return node;
}

int color(struct node *tree)
{
  return tree ? tree->color : 1; // BLACK
}

int find_min(struct node *tree)
{
  if (tree->left == NULL)
    return tree->value;
  else
    return find_min(tree->left);
}

struct node *left_rotate(struct node *x)
{
  struct node *y;
  y = x->right;
  x->right = y->left;
  y->left = x;
  return y;
}

struct node *right_rotate(struct node *x)
{
  struct node *y;
  y = x->left;
  x->left = y->right;
  y->right = x;
  return y;
}

int find(int v, struct node *t)
{
  if (t == NULL) {
    return 0;
  } else if (v == t->value) {
    return 1;
  } else if (v < t->value) {
    return find(v, t->left);
  } else {
    return find(v, t->right);
  }
}

struct node *insert_aux(int value, struct node *tree)
{
  if (tree == NULL) {
    return new_node(value);
  }
  if (value < tree->value) {
    tree->left = insert_aux(value, tree->left);
    if (color(tree->left) != 1 /* RED */) {
      if (color(tree->right) != 1 /* RED */) { // case 3
        if (color(tree->left->left) != 1 /* RED */ || color(tree->left->right) != 1 /* RED */) {
          tree->left->color = 1 /* BLACK */;
          tree->right->color = 1 /* BLACK */;
          tree->color = 0 /* RED */;
        }
      }
      else {
        if (color(tree->left->right) != 1 /* RED */) { // case 4
          tree->left = left_rotate(tree->left);
        }
        if (color(tree->left->left) != 1 /* RED */) { // case 5; case 4 falls through
          tree = right_rotate(tree);
          tree->color = 1 /* BLACK */;
          tree->right->color = 0 /* RED */;
        }
      }
    }
  }
  else if (value > tree->value) {
    tree->right = insert_aux(value, tree->right);
    if (color(tree->right) != 1 /* RED */) {
      if (color(tree->left) != 1 /* RED */) {
        if (color(tree->right->right) != 1 /* RED */ || color(tree->right->left) != 1 /* RED */) { // case 3
          tree->right->color = 1 /* BLACK */;
          tree->left->color = 1 /* BLACK */;
          tree->color = 0 /* RED */;
        }
      }
      else {
        if (color(tree->right->left) != 1 /* RED */) { // case 4
          tree->right = right_rotate(tree->right);
        }
        if (color(tree->right->right) != 1 /* RED */) { // case 5; case 4 falls through
          tree = left_rotate(tree);
          tree->color = 1 /* BLACK */;
          tree->left->color = 0 /* RED */;
        }
      }
    }
  }
  return tree;
}

struct node *insert(int value, struct node *tree)
{
  tree = insert_aux(value, tree);
  if (color(tree) != 1 /* RED */) {
    tree->color = 1 /* BLACK */;
  }
  return tree;
}


struct node *left_delete_fixup(int *fixed, struct node *tree)
{
  if (color(tree->right) != 1 /* RED */) { // case 2
    tree = left_rotate(tree);
    tree->color = 1 /* BLACK */;
    tree->left->color = 0 /* RED */;
    tree->left = left_delete_fixup(fixed, tree->left);
    *fixed = 1;
  }
  else {
    if (color(tree->right->left) == 1 /* BLACK */ &&
        color(tree->right->right) == 1 /* BLACK */) { // case 3 & 4
      if (color(tree) == 1 /* BLACK */) { // case 3
        *fixed = 0; // fixup will be called again later
      } else { // case 4
        *fixed = 1;
      }
      tree->right->color = 0 /* RED */;
      tree->color = 1 /* BLACK */;
    }
    else {
      if (color(tree->right->right) == 1 /* BLACK */) { // case 5
        tree->right = right_rotate(tree->right);
        tree->right->color = 1 /* BLACK */;
        tree->right->right->color = 0 /* RED */;
      }
      // case 6; case 5 falls through
      tree = left_rotate(tree);
      tree->color = color(tree->left);
      tree->left->color = 1 /* BLACK */;
      tree->right->color = 1 /* BLACK */;
      *fixed = 1;
    }
  }
  return tree;
}

struct node *right_delete_fixup(int *fixed, struct node *tree)
{
  if (color(tree->left) != 1 /* RED */) {
    tree = right_rotate(tree);
    tree->color = 1 /* BLACK */;
    tree->right->color = 0 /* RED */;
    tree->right = right_delete_fixup(fixed, tree->right);
    *fixed = 1;
  }
  else {
    if (color(tree->left->right) == 1 /* BLACK */ &&
        color(tree->left->left) == 1 /* BLACK */) {
      if (color(tree) == 1 /* BLACK */) {
        *fixed = 0; // fixup will be called again later
      } else {
        *fixed = 1;
      }
      tree->left->color = 0 /* RED */;
      tree->color = 1 /* BLACK */;
    }
    else {
      if (color(tree->left->left) == 1 /* BLACK */) {
        tree->left = left_rotate(tree->left);
        tree->left->color = 1 /* BLACK */;
        tree->left->left->color = 0 /* RED */;
      }
      tree = right_rotate(tree);
      tree->color = color(tree->right);
      tree->right->color = 1 /* BLACK */;
      tree->left->color = 1 /* BLACK */;
      *fixed = 1;
    }
  }
  return tree;
}

struct node *delete_aux(int *fixed, int value, struct node *tree)
{
  if (tree == NULL) {
    *fixed = 1;
    return NULL;
  }
  if (value == tree->value) {
    if (tree->left == NULL) {
      if (color(tree->right) != 1 /* RED */) {
        tree->right->color = 1 /* BLACK */;
        *fixed = 1;
      }
      else {
        if (color(tree) == 1 /* BLACK */) {
          *fixed = 0; // fixup will be called again later
        } else {
          *fixed = 1;
        }
      }
      return tree->right;
    }
    else if (tree->right == NULL) {
      if (color(tree->left) != 1 /* RED */) {
        tree->left->color = 1 /* BLACK */;
        *fixed = 1;
      }
      else {
        if (color(tree) == 1 /* BLACK */) {
          *fixed = 0; // fixup will be called again later
        } else {
          *fixed = 1;
        }
      }
      return tree->left;
    }
    else {
      tree->value = find_min(tree->right);
      tree->right = delete_aux(fixed, tree->value, tree->right);
      if (*fixed != 1) {
        tree = right_delete_fixup(fixed, tree);
      }
    }
  }
  else if (value < tree->value) {
    tree->left = delete_aux(fixed, value, tree->left);
    if (*fixed != 1) {
      tree = left_delete_fixup(fixed, tree);
    }
  }
  else {
    tree->right = delete_aux(fixed, value, tree->right);
    if (*fixed != 1) {
      tree = right_delete_fixup(fixed, tree);
    }
  }
  return tree;
}

struct node *delete(int value, struct node *tree)
{
  int fixed;
  fixed = 0;
  tree = delete_aux(&fixed, value, tree);
  return tree;
}

int main() {
  return 0;
}
