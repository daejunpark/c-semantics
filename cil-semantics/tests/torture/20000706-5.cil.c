/* Generated by CIL v. 1.3.7 */
/* print_CIL_Input is true */

struct baz {
   int a ;
   int b ;
   int c ;
};
extern void abort(void) ;
extern void exit(int  ) ;
struct baz *c  ;
void bar(int b ) 
{ 

  {
  if (c->a != 1) {
    abort();
  } else {
    if (c->b != 2) {
      abort();
    } else {
      if (c->c != 3) {
        abort();
      } else {
        if (b != 4) {
          abort();
        }
      }
    }
  }
  return;
}
}
void foo(struct baz a , int b ) 
{ 

  {
  c = & a;
  bar(b);
  return;
}
}
int main(void) 
{ struct baz a ;

  {
  a.a = 1;
  a.b = 2;
  a.c = 3;
  foo(a, 4);
  exit(0);
}
}