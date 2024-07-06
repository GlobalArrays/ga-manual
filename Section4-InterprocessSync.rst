Interprocess Synchronization
============================

Global Arrays provide three types of synchronization calls to support
different synchronization styles.

+---------------------+------------------------------------------------+
| **Lock with mutex** | is useful for a shared memory model. One can   |
|                     | lock a mutex, to exclusively access a critical |
|                     | section.                                       |
+---------------------+------------------------------------------------+
| **Fence**           | guarantees that the Global Array operations    |
|                     | issued from the calling process are complete.  |
|                     | The fence operation is local.                  |
+---------------------+------------------------------------------------+
| **Sync**            | is a barrier. It synchronizes processes and    |
|                     | ensures that all Global Array operations are   |
|                     | completed. Sync operation is collective.       |
+---------------------+------------------------------------------------+

Lock and Mutex 
--------------

Lock works together with mutex. It is a simple synchronization mechanism
used to protect a critical section. To enter a critical section,
typically, one needs to do:

::

   1. Create mutexes
   2. Lock on a mutex
   3. ...
       Do the exclusive operation in the critical section
      ...
   4. Unlock the mutex
   5. Destroy mutexes

The function

- Fortran logical function: `ga_create_mutexes <https://hpc.pnl.gov/globalarrays/api/f_op_api.html#CREATE_MUTEXES>`__\ (number) 

- C:        int `GA_Create_mutexes <https://hpc.pnl.gov/globalarrays/api/c_op_api.html#CREATE_MUTEXES>`__\ (int number) 

- C++:      int GA::GAServices::createMutexes(int number) 

creates a set
containing the number of mutexes. Only one set of mutexes can exist at a
time. Mutexes can be created and destroyed as many times as needed.
Mutexes are numbered: 0, ..., number-1.

The function

- Fortran logical function: `ga_destroy_mutexes <https://hpc.pnl.gov/globalarrays/api/f_op_api.html#DESTROY_MUTEXES>`__\ () 

- C:        int `GA_Destroy_mutexes <https://hpc.pnl.gov/globalarrays/api/c_op_api.html#DESTROY_MUTEXES>`__\ ()

- C++:      int GA::GAServices::destroyMutexes()  
 
destroys the set of mutexes
created with ga_create_mutexes.

Both ``ga_create_mutexes`` and ``ga_destroy_mutexes`` are collective
operations.

The functions

- Fortran subroutine: `ga_lock <https://hpc.pnl.gov/globalarrays/api/f_op_api.html#LOCK>`__\ (int mutex) 
    - subroutine `ga_unlock <https://hpc.pnl.gov/globalarrays/api/f_op_api.html#UNLOCK>`__\ (int mutex) 

- C:        void `GA_lock <https://hpc.pnl.gov/globalarrays/api/c_op_api.html#LOCK>`__\ (int mutex) 
   - void `GA_unlock <https://hpc.pnl.gov/globalarrays/api/c_op_api.html#UNLOCK>`__\ (int mutex) 

- C++:      void GA::GAServices::lock(int mutex) 
    - void GA::GAServices::unlock(int mutex) 

lock and unlock a mutex
object identified by the mutex number, respectively. It is a fatal error
for a process to attempt to lock a mutex which has already been locked
by this process, or unlock a mutex which has not been locked by this
process.

Use one mutex and the lock mechanism to enter the critical section.

::

       status = ga_create_mutexes(1)
       if(.not.status) then
           call ga_error('ga_create_mutexes failed ',0)
       endif
       call ga_lock(0)
       ... do something in the critical section
       call ga_put(g_a, ...)
       ...
       call ga_unlock(0)
       if(.not.ga_destroy_mutexes()) then
           call ga_error('mutex not destroyed',0)

Fence 
-----

Fence blocks the calling process until all the data transfers
corresponding to the Global Array operations initiated by this process
complete. The typical scenario that it is being used is

::

   1. Initialize the fence

   2. ...

       Global array operations

       ...

   3. Fence

This would guarantee the operations between step 1 and 3 are complete.

The function

- Fortran subroutine: `ga_init_fence <https://hpc.pnl.gov/globalarrays/api/f_op_api.html#ga_init_fence>`__\ () 

- C:        void `GA_Init_fence <https://hpc.pnl.gov/globalarrays/api/c_op_api.html#ga_init_fence>`__\ () 

- C++:      void GA::GAServices::initFence() 
  
Initializes tracing of completion status of data movement operations.

The function

- Fortran subroutine: `ga_fence <https://hpc.pnl.gov/globalarrays/api/f_op_api.html#ga_fence>`__\ () 

- C:       void `GA_Fence <https://hpc.pnl.gov/globalarrays/api/c_op_api.html#ga_fence>`__\ () 

- C++:      void GA::GAServices::fence() 

blocks the calling process until
all the data transfers corresponding to GA operations called after
``ga_init_fence`` complete.

``ga_fence`` must be called after ``ga_init_fence``. A barrier,
``ga_sync``, assures completion of all data transfers and implicitly
cancels outstanding ga_init_fence. ``ga_init_fence`` and ``ga_fence``
must be used in pairs, multiple calls to ``ga_fence`` require the same
number of corresponding ``ga_init_fence`` calls.
``ga_init_fence/ga_fence`` pairs can be nested.

*Example1*: Since ``ga_put`` might return before the data reaches the final
destination ``ga_init_fence`` and ``ga_fence`` allow the process to wait
until the data is actually moved:

::

       call ga_init_fence()
       call ga_put(g_a,...)
       call ga_fence()

*Example2*: ``ga_fence`` works for multiple GA operations.

::

       call ga_init_fence()
       call ga_put(g_a,...)
       call ga_scatter(g_a,...)
       call ga_put(g_b,...)
       call ga_fence()

The calling process will be blocked until data movements initiated by
two calls to ``ga_put`` and one ``ga_scatter`` complete.

Sync 
----

Sync is a collective operation. It acts as a barrier, which synchronizes
all the processes and ensures that all the Global Array operations are
complete at the call.

The function is

- Fortran subroutine: `ga_sync <https://hpc.pnl.gov/globalarrays/api/f_op_api.html#ga_sync>`__\ () 

- C:        void `GA_Sync <https://hpc.pnl.gov/globalarrays/api/c_op_api.html#ga_sync>`__\ () 

- C++:      void GA::GAServices::sync() 
  
Sync should be inserted as necessary. With many sync calls, 
the application performance would suffer.
