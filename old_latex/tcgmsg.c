/* C TCGMSG example */
int main(int argc, char **argv) {
  tcg_pbegin(argc,argv);    /* start TCGMSG */
  GA_Initialize();          /* start global arrays */
  MA_Init(...);             /* start memory allocator** */
  /* ... */                 /* do work */
  GA_Terminate();           /* tidy up global arrays call */
  tcg_pend();               /* tidy up TCGMSG */
}
