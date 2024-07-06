GA++: C++ Bindings for Global Arrays
====================================

Overview 
--------

GA++ provides a C++ interface to global arrays (GA) libraries. The
doxygen documentation of GA++ is located here:
https://hpc.pnl.gov/globalarrays/api/cxxapi.shtml. The GA C++ bindings
are a layer built directly on top of the GA C bindings. GA++ provides
new names for the C bindings of GA functions (For example,
GA_Add_patch() is renamed as addPatch()).

GA++ Classes 
------------

All GA classes (GAServices, GlobalArray) are declared within the scope
of GA namespace.

**Namespace issue:**\ Although namespace is part of the ANSI C++
standard, not all C++ compilers support namespaces (A non-instantiable
GA class is provided for implementations using compilers without
namespace). **Note**: define the variable ``_GA_USENAMESPACE_`` as ``0`` in
``ga++.h`` if your compiler does not support namespaces.

.. code-block:: cpp

   namespace GA {
       class GAServices;
       class GlobalArray;
   };

The current implementation has no derived classes (no (virtual)
inheritance), templates, or exception handling. Eventually, more object
oriented functionalities will be added, and standard library facilities
will be used without affecting the performance.

Initialization and Termination
------------------------------

GA namespace has the following static functions for initialization and termination of Global Arrays.

- GA::Initialize(): Initialize Global Arrays, allocates and initializes internal data structures in Global Arrays. This is a collective operation.

- GA::Terminate(): Delete all active arrays and destroy internal data structures. This is a collective operation.

.. code-block:: cpp

   namespace GA { 
       _GA_STATIC_ void Initialize(int argc, char *argv[]}, size_t limit = 0); 
       _GA_STATIC_ void Initialize(int argc, char *argv[], unsigned long heapSize, unsigned long stackSize, int type, size_t limit = 0); 
       _GA_STATIC_ void Terminate();
   };

.. code-block:: cpp

   #include <iostream.h> 
   #include "ga++.h"

   int main(int argc, char *argv[]) { 
       GA::Initialize(argc, argv, 0); 
       cout << "Hello World!\n";
       GA::Terminate(); 
   }

GAServices
----------

GAServices class has member functions that does all the global
operations (non-array operations) like Process Information (number of
processes, process id, ..), Inter-process Synchronization (sync, lock,
broadcast, reduce,..), etc,.

SERVICES Object: GA namespace has a global SERVICES object (of type
GAServices), which can be used to invoke the non-array operations. To
call the functions (for example, sync()), we invoke them on this
SERVICES object (for example, ``GA::SERVICES.sync()``). As this object is in
the global address space, the functions can be invoked from anywhere
inside the program (provided the header ``ga++.h`` is included in that
file/program).

Global Array
------------

GlobalArray class has member functions that perform:

- Array operations
- One-sided (get/put)
- Collective array operations
- Utility operations, etc.
