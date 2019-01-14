## Implement a "mygetenv" function

This `mygetenv`-function should take a null-terminated Fortran string
as an input and return a Fortran string. It should call the `getenv`
function from C library directly.  This can be accomplished by use of
assignment operator that maps `type(c_ptr)` i.e., `char *` in
C-language, to Fortran character strings. You will need to provide the
interface definition to enable `getenv` calls from Fortran.
