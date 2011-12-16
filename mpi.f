! Fortran MPI example
      program main
      include 'mpif.h'          ! MPI declarations
      integer ierror
      call mpi_init(ierror)     ! start MPI
      call ga_initialize()      ! start global arrays
      status = ma_init()        ! start memory allocator**
!     ...                       ! do work
      call ga_terminate()       ! tidy up global arrays call
      call mpi_finalize(ierror) ! tidy up MPI
      end program               ! exit program
