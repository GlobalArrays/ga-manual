#include <mpi.h>    /* in this case we are using MPI */
#include <ga.h>     /* the global arrays declarations */
#include <stdlib.h> /* for malloc, free */

void* replace_malloc(size_t bytes, int align, char *name)
{
    return malloc(bytes);
}

void replace_free(void *ptr)
{
    free(ptr);
}

int main(int argc, char **agrv)
{
    MPI_Init(&argc,&argv);
    GA_Initialize();
    GA_Register_stack_memory(replace_malloc, replace_free);
    /* do work */
    GA_Terminate();
    MPI_Finalize();
}
