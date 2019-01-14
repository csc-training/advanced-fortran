## Abstract interfaces and procedure pointers

The skeleton for this exercise is provided in `absif.F90` file. Do
the following modifications:
1. Create two abstract interfaces. One for a function that takes two
   vectors as an input arguments and returns a vector and another for
   a function that takes same arguments, but returns a scalar.
1. Create actual implementations for functions computing the sum,
   elementwise product and dot product of two vectors.
1. Initialize two vectors v1=(1,2,3,4,5) and v2=(5,4,3,2,1) and
   compute v3=v1+v2, v3=v1.*v2 (elementwise product) and v3=v1*v2 (dot
   product). Do the type constructors work as expected?
1. Create functions `vecfun(fun,v1,v2)` and `scalfun(fun,v1,v2)` which
   take as their first argument scalar or vector functions with the
   interface created in the part 1. of this exercise. Is it possible
   to compute the results of part 3. of this exercise by using the
   functions vecfun and scalfun?
