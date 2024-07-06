! Fortran TCGMSG example
      program main
      include 'tcgmsg.fh'       ! TCGMSG declarations
      call pbeginf()            ! start TCGMSG
      call ga_initialize()      ! start global arrays
      status = ma_init()        ! start memory allocator**
!     ...                       ! do work
      call ga_terminate()       ! tidy up global arrays call
      call pend()               ! tidy up TCGMSG
      end program               ! exit program
