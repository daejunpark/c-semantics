/* Generated by CIL v. 1.3.7 */
/* print_CIL_Input is true */

typedef unsigned long size_t;
extern  __attribute__((__nothrow__, __noreturn__)) void abort(void)  __attribute__((__leaf__)) ;
extern void *memcpy(void *dest , void const   *src , size_t n ) ;
extern size_t strlen(char const   *s ) ;
extern int strcmp(char const   *s1 , char const   *s2 )  __attribute__((__pure__)) ;
char buf[50]  ;
static void foo(void) 
{ void *tmp ;
  int tmp___0 ;
  size_t tmp___1 ;

  {
  tmp = memcpy((void *)(buf), (void const   *)"abc", 4UL);
  if ((unsigned long )tmp != (unsigned long )(buf)) {
    abort();
  }
  tmp___0 = strcmp((char const   *)(buf), "abc");
  if (tmp___0) {
    abort();
  }
  tmp___1 = strlen("abcdefgh");
  memcpy((void *)(buf), (void const   *)"abcdefgh", tmp___1 + 1UL);
  return;
}
}
int main(void) 
{ 

  {
  foo();
  return (0);
}
}