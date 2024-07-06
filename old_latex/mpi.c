/* C example */
int main(int argc, char **argv) {
  MPI_Init(&argc,&argv);    /* start MPI */
  GA_Initialize();          /* start global arrays */
  MA_Init(...);             /* start memory allocator** */
  /* ... */                 /* do work */
  GA_Terminate();           /* tidy up global arrays call */
  MPI_Finalize();           /* tidy up MPI */
}
