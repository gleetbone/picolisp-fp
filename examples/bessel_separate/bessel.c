/* 
   (c) 2016 Greg Lee
*/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include <gsl/gsl_sf_bessel.h>

// union cast macro from Matt Gallagher
#define UNION_CAST(x, destType) \
 (((union {__typeof__(x) a; destType b;})x).b)

long int gsl_sf_bessel_J0_c( long int i)
{
   double result = gsl_sf_bessel_J0( UNION_CAST( i, double ) );
   return UNION_CAST( result, long int );
}

/* End of file */

