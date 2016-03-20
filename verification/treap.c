#include <stdlib.h>

struct node {
  int value;
  int priority;
  struct node *left;
  struct node *right;
};

struct node *new_node(int v, int p) {
  struct node *n;
  n = (struct node *) malloc(sizeof(struct node));
  n->value = v;
  n->priority = p;
  n->left = NULL;
  n->right = NULL;
  return n;
}

struct node *left_rotate(struct node *x) {
  struct node *y;
  y = x->right;
  x->right = y->left;
  y->left = x;
  return y;
}

struct node *right_rotate(struct node *x) {
  struct node *y;
  y = x->left;
  x->left = y->right;
  y->right = x;
  return y;
}

int find(int v, struct node *t) {
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

struct node *insert(int v, int p, struct node *t) {
  if (t == NULL) {
    return new_node(v, p);
  }
  if (v < t->value) {
    t->left = insert(v, p, t->left);
    if (t->left->priority > t->priority) {
      t = right_rotate(t);
    }
  } else if (v > t->value) {
    t->right = insert(v, p, t->right);
    if (t->right->priority > t->priority) {
      t = left_rotate(t);
    }
  }
  return t;
}

struct node *delete_root(struct node *t) {
  if (t->left == NULL) {
    struct node *tmp;
    tmp = t;
    t = t->right;
    free(tmp);
  } else if (t->right == NULL) {
    struct node *tmp;
    tmp = t;
    t = t->left;
    free(tmp);
  } else {
    if (t->left->priority < t->right->priority) {
      t = left_rotate(t);
      t->left = delete_root(t->left);
    } else {
      t = right_rotate(t);
      t->right = delete_root(t->right);
    }
  }
  return t;
}

struct node *delete(int v, struct node *t) {
  if (t == NULL) {
    return NULL;
  }
  if (v == t->value) {
    t = delete_root(t);
  } else if (v < t->value) {
    t->left = delete(v, t->left);
  } else {
    t->right = delete(v, t->right);
  }
  return t;
}

int main() {
//struct node *t = NULL;
//t = insert(1,10,t);
//t = insert(2,30,t);
//t = insert(3,20,t);
//t = delete(2,t);
  return 0;
}
