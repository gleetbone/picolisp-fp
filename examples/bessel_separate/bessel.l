# (c) 2016 Greg Lee

(if (= *OS "Darwin")
   (default *BesselLib "@lib/libbessel.dylib")
   (default *BesselLib "@lib/libbessel.so") )

(de gsl_sf_bessel_J0 (X)
   (native `*BesselLib "gsl_sf_bessel_J0_c" 'N X) )

# load the required shared libraries

(catch '("Protected symbol") (native "libgsl.so"))

(catch '("Protected symbol") (native "libgslcblas.so"))

(catch '("Protected symbol") (native "libm.so"))

# End of file

