/* Generated by CIL v. 1.3.7 */
/* print_CIL_Input is true */

typedef unsigned int u32;
extern  __attribute__((__nothrow__, __noreturn__)) void abort(void)  __attribute__((__leaf__)) ;
static u32 const   cfb_tab8_be[16]  = 
  {      (u32 const   )0,      (u32 const   )255,      (u32 const   )65280,      (u32 const   )65535, 
        (u32 const   )16711680,      (u32 const   )16711935,      (u32 const   )16776960,      (u32 const   )16777215, 
        (u32 const   )4278190080U,      (u32 const   )4278190335U,      (u32 const   )4278255360U,      (u32 const   )4278255615U, 
        (u32 const   )4294901760U,      (u32 const   )4294902015U,      (u32 const   )4294967040U,      (u32 const   )4294967295U};
static u32 const   cfb_tab16_be[4]  = {      (u32 const   )0,      (u32 const   )65535,      (u32 const   )4294901760U,      (u32 const   )4294967295U};
static u32 const   cfb_tab32[2]  = {      (u32 const   )0,      (u32 const   )4294967295U};
u32 const   *xxx(int bpp ) 
{ u32 const   *tab ;

  {
  switch (bpp) {
  case 8: 
  tab = cfb_tab8_be;
  break;
  case 16: 
  tab = cfb_tab16_be;
  break;
  case 32: 
  default: 
  tab = cfb_tab32;
  break;
  }
  return (tab);
}
}
int main(void) 
{ u32 const   *a ;
  u32 const   *tmp ;
  int b ;

  {
  tmp = xxx(8);
  a = tmp;
  b = (int )*(a + 0);
  if ((u32 const   )b != cfb_tab8_be[0]) {
    abort();
  }
  return (0);
}
}