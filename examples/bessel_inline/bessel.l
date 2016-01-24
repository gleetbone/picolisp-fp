# (c) 2016 Greg Lee

(load "@lib/native.l")

### GSL library ###
(gcc "bessel" '("-lgsl" "-lgslcblas" "-lm")
   (gsl_sf_bessel_J0 (X) gsl_sf_bessel_J0_c 'N X))

#include <gsl/gsl_sf_bessel.h>

// union cast macro from Matt Gallagher
#define UNION_CAST(x, destType) \
 (((union {__typeof__(x) a; destType b;})x).b)

long int gsl_sf_bessel_J0_c( long int i)
{
   double result = gsl_sf_bessel_J0( UNION_CAST( i, double ) );
   return UNION_CAST( result, long int );
}

/**/


