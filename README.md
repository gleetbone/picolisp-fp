Floating Point Math Library for 64 bit PicoLisp
===============================================

PicoLisp has gotten along quite well for its entire history without floating point number support. Perhaps this floating point library is a solution looking for a problem, but it seems to me that floating point support might occasionally be useful - if only to shut up PicoLisp newcomers who demand floating point support!
 
PicoLisp does not have a floating point number type, only an infinite-precision integer type that can also be used as a fixed-point numeric type. However, it is possible to write a set of functions that treat PicoLisp integers as floating point numbers and perform floating point arithmetic.

The IEEE-754 standard specifies the bit encoding for single and double precision floating point numbers. Single precision numbers are encoded into 32 bit signed integers, and double precision numbers are encoded into 64 bit signed integers. The fp.l library uses native functions written in C in the fp.c file or inline to interpret PicoLisp integers as floating point numbers to perform floating point arithmetic and to call the functions in the C header file <math.h>. These functions include trigonometric and logarithmic/exponential operations.

The library fp.l provides several conversion functions to get to and from floating point numbers in PicoLisp. The function names in fp.l use a code to indicate which type of number is expected as an input or produced as an output. 32 bit single precision floating numbers are designated by the letter "r" (for "real" - the letter "f" that might be used for "float" is already used in the PicoLisp frac.l library to designate fractions or rational numbers). 64 bit double precision floating point numbers are designated by the letter "d", PicoLisp fixed point numbers are designated with "fix", integers are designated with "l" (long), and strings are designated with "s". 

The string to number conversion functions are

s2r - converts a string representation of a number to a single precision float. 

(s2r "1.0" ) gives 1065353216 - just a jumble of decimal digits, but

(hex 1065353216) gives 3F800000 

This shows the IEEE 754 format in hexadecimal. The most significant bit of the 32 bit word is the sign bit - zero in this case. The next eight bits (the 3F8 part) forms the exponent, and the 24 bit mantissa is represented by an implicit leading one and 23 bits of zeros. 

(hex (s2r "2.0") ) gives 4000000

In this case the sign bit is zero, the exponent is 400, and the mantissa is again an implicit leading one bit followed by 23 zero bits.

Going the other way,

(r2s 1065353216) gives "1.000000"

The default string format has six digits after the decimal point. An optional extra parameter can be supplied to format the string result using the standard C language printf formatting fields.

(r2s 1065353216 "%5.2f") gives "1.00"
(r2s 1065353216 "%5.2e") gives "1.00e+00"

Double precision works the same way:

(s2d "1.0") gives 4607182418800017408, and

(hex 4607182418800017408) gives 3FF0000000000000

Here, the most significant bit is the sign bit (zero), the 3FF0 is the exponent, and the mantissa is an implicit leading one followed by 52 zero bits.

(s2d "2.0") gives 4611686018427387904, and
(hex (s2d "2.0") ) gives 4000000000000000

(d2s 4607182418800017408) gives "1.000000", and
(d2s 4607182418800017408 "%5.2f") gives "1.00", and
(d2s 4607182418800017408 "%5.2e") gives "1.00e+00"

A zero integer has the floating point value 0.0 in both single and double precision IEEE formats.

Using the string conversion functions is the easiest way to specify and view floating point numbers:

(setq A (s2d "1.0") )
(d2s A)

The following functions convert between the various numeric types: r2d, d2r, l2d, d2l, l2r, r2l, fix2d, d2fix, fix2r, r2fix.

Single precision floating point arithmetic is supported for addition, subtraction (including negation), multiplication, and division:

(r2s (r+ (s2r "1.0") (s2r "2.0") ) ) gives "3.000000"
(r2s (r- (s2r "1.0") (s2r "2.0") ) ) gives "-1.000000"
(r2s (r* (s2r "1.0") (s2r "2.0") ) ) gives "2.000000"
(r2s (r/ (s2r "1.0") (s2r "2.0") ) ) gives "0.500000"

(r2s (r- (s2r "1.0") ) ) gives "-1.000000"
(r2s (r+ (s2r "1.0") (s2r "2.0") (s2r "3.0") ) ) gives "6.000000"

Double precision floating point arithmetic works the same way:

(d2s (d+ (s2d "1.0") (s2d "2.0") ) ) gives "3.000000"
(d2s (d- (s2d "1.0") (s2d "2.0") ) ) gives "-1.000000"
(d2s (d* (s2d "1.0") (s2d "2.0") ) ) gives "2.000000"
(d2s (d/ (s2d "1.0") (s2d "2.0") ) ) gives "0.500000"

(d2s (d- (s2d "1.0") ) ) gives "-1.000000"
(d2s (d+ (s2d "1.0") (s2d "2.0") (s2d "3.0") ) ) gives "6.000000"

The existing integer comparison functions (<, <=, >, >=) can be used directly on floating point numbers (of the same type, single or double precision).

(> (s2d "1.0") (s2d "2.0") ) gives NIL
(< (s2d "1.0") (s2d "2.0") ) gives T

The rest of fp.l implements the functions provided in <math.h> for trigonometric functions, hyperbolic functions, square root, logarithm functions, and exponential functions. Floating point constants are also provided from <math.h> for Pi and several common roots and logarithmic values.

(d2s (dasin (s2d "1.0") ) ) gives "1.570796", or Pi/2 = 90 degrees

(d2s (dexp (s2d "1.0") ) ) gives "2.718282", or the constant "e"

(d2s (dpi)) gives "3.141593"


Inline and Separately Compiled Versions
=======================================

The floating point library is provided in two different forms - one with inline C compilation via the "gcc" function, and the other with a separate "fp.c" file. Using the inline version is the most convenient, since PicoLisp handles all of the compilation and linking details. The separate version would be useful if one needs to avoid the (short) startup time required for inline C compilation, or if the platform environment being used does not provide a C compiler (such as an embedded system). The user API for both versions is identical. The "inline" folder provides the single "fp.l" file, and the "separate" folder provides the "fp.l" and "fp.c" files along with a simple build script for gcc and Linux operating systems, which should be adaptable to other operating systems and C compilers. Note that the "separate" "fp.l" version will need to be modified if the location of the "libfp.so" shared object is not placed in the "lib" folder of the PicoLisp installation.


Testing
=======

A test file "fptest.l" is provided in the "test" folder that exercises all of the functions in "fp.l". It can be used with both the "inline" and "separate" versions. Because floating point values are inherently approximations and the unit tests use exact values for results, the tests for trigonometric and trancendental functions may fail on some machines for some floating point libraries due to differences in the least significant bit(s) of computed values. The tests pass for x86_64 Linux using the gcc compiler.

To call the tests -

(load "fptest.l") # adjust for the location of "fptest.l"


Installation
============

To install:

1) (Both inline and separate versions) Copy the fp.l file to the lib subdirectory in the PicoLisp installation directory.

2) (Separate version only) Compile the fp.c file and create the shared library libfp.so. Use the supplied build script for Linux or its equivalent for your operating system. 

3) (Separate version only) Copy the libfp.so file (or its equivalent) to the lib subdirectory of the PicoLisp installation directory.

4) (Both inline and separate version) Use fp.l as any other PicoLisp library.


Examples
========

There are two examples provided. The first is a wrapper for the fftw library as described in the PicoLisp documentation file "Native C Calls". The C wrapper for the fft call is the same as in the documentation file, but picolisp-fp calls are made to manage the input and output data arrays. Several supporting functions are provided to translate between lists of integers, lists of formatted strings, and raw C buffers.

To run the fft example -

(load "@lib/fp.l")
(load "X.l")     # loads a list of complex numbers into "X", adjust for location of "X.l"
(list2s X)       # show "X" in a more human readable form
(load "fft.l")   # adjust this line for the location of the "fft.l" file
(fft X)          # perform the fft
(list2s (fft X)) # output the fft result in a more human readable form

The other examples show how to build both an inline and a separately compiled wrapper for a call to a Bessel function from the GNU Scientific Library (GSL).

To run the bessel function example (both the inline and separately compiled versions are called the same way) - 

(load "@lib/fp.l")
(load "bessel.l")             # adjust this line for the location of the "bessel.l" file
(gsl_sf_bessel_J0 0 )         # call the bessel function on the argument "zero"
(d2s (gsl_sf_bessel_J0 0 ))   # output the function result in a more human readable form
(d2s (gsl_sf_bessel_J0 (s2d "0.0")))   # call with both input and output in a more 
                                       # human readable form 

License
=======

This library is licensed under the MIT license, copyright (c) 2016 Greg Lee.


Files
=====

inline
   fp.l       - the PicoLisp source file

separate
   fp.l       - the PicoLisp source file
   fp.c       - the C source file
   build      - a simple build script for Linux

test
   fptest.l   - a set of tests to verify the functions in fp.l

examples
   fft
      fft.l      - the "fftw" example from the "Native C Calls" PicoLisp documentation
      X.l        - creates input data for "fft"

   bessel_inline
      bessel.l   - shows how to create an inline wrapper for a bessel function from 
                   the GNU Scientific Library

   bessel_separate
      bessel.l   - shows how to create a separately compiled PicoLisp wrapper for a 
                   bessel function from the GNU Scientific Library
      bessel.c   - shows how to create a PicoLisp C wrapper for a bessel function from 
                   the GNU Scientific Library (the C wrapper translates between a PicoLisp
                   64 bit integer and a C 64 bit floating point number and calls a bessel 
                   function from the GNU Scientific Library)
      build      - a simple build file for Linux to compile the C wrapper and make 
                   the shared library

readme.txt - this file

license.txt - the MIT license 

--------------------------------------------------------------------------------

Greg Lee

23 Jan 2016
