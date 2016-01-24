/*
   (c) 2016 Greg Lee
*/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

// union cast macro from Matt Gallagher
#define UNION_CAST(x, destType) \
 (((union {__typeof__(x) a; destType b;})x).b)

// conversions

// float <-> string

char *f2s( char *s, char *fmt, int i )
{
   sprintf( s, fmt, UNION_CAST( i, float ) );
   return s;
}

int s2f( char *s )
{
   float x;
   sscanf( s, "%f", &x );
   return UNION_CAST( x, int );
}

// double <-> string

char *d2s( char *s, char *fmt, long int i )
{
   sprintf( s, fmt, UNION_CAST( i, double ) );
   return s;
}

long int s2d( char *s )
{
   double x;
   sscanf( s, "%lf", &x );
   return UNION_CAST( x, long int );
}

// float <-> double

long int f2d( int i )
{
   float f = UNION_CAST( i, float );
   double d = ( double ) f;
   return UNION_CAST( d, long int );
}

int d2f( long int i )
{
   double d = UNION_CAST( i, double );
   float f = ( float ) d;
   return UNION_CAST( f, int );
}

// long int <-> double

long int l2d( long int i )
{
   double d = i;
   return UNION_CAST( d, long int );
}

long int d2l( long int i )
{
   long int l = UNION_CAST( i, double );
   return l;
}

// long int <-> float

int l2f( long int i )
{
   float f = i;
   return UNION_CAST( f, int );
}

long int f2l( int i )
{
   long int l = UNION_CAST( i, float );
   return l;
}

// fixed point <-> double

long int fix2d( long int i, int j )
{
   double d = i;
   d = d*pow( 10.0, -j );
   return UNION_CAST( d, long int );
}

long int d2fix( long int i, int j )
{
   double d = UNION_CAST( i, double );
   d = d*pow( 10.0, j );
   long int l = ( long int ) d;
   return l;
}

// fixed point <-> float

int fix2f( long int i, int j )
{
   float f = i;
   f = f*pow( 10.0, -j );
   return UNION_CAST( f, int );
}

long int f2fix( int i, int j )
{
   float f = UNION_CAST( i, float );
   f = f*pow( 10.0, j );
   long int l = ( long int ) f;
   return l;
}

// single precision arithmetic
int fneg( int i )
{
   float result = - UNION_CAST( i, float );
   return UNION_CAST( result, int );
}

int fadd( int i, int j )
{
   float result = UNION_CAST( i, float ) + UNION_CAST( j, float );
   return UNION_CAST( result, int );
}

int fsub( int i, int j )
{
   float result = UNION_CAST( i, float ) - UNION_CAST( j, float );
   return UNION_CAST( result, int );
}

int fmul( int i, int j )
{
   float result = UNION_CAST( i, float ) * UNION_CAST( j, float );
   return UNION_CAST( result, int );
}

int fdiv( int i, int j )
{
   float result = UNION_CAST( i, float ) / UNION_CAST( j, float );
   return UNION_CAST( result, int );
}

// double precision arithmetic
long int dneg( long int i )
{
   double result = - UNION_CAST( i, double );
   return UNION_CAST( result, long int );
}

long int dadd( long int i, long int j )
{
   double result = UNION_CAST( i, double ) + UNION_CAST( j, double );
   return UNION_CAST( result, long int );
}

long int dsub( long int i, long int j )
{
   double result = UNION_CAST( i, double ) - UNION_CAST( j, double );
   return UNION_CAST( result, long int );
}

long int dmul( long int i, long int j )
{
   double result = UNION_CAST( i, double ) * UNION_CAST( j, double );
   return UNION_CAST( result, long int );
}

long int ddiv( long int i, long int j )
{
   double result = UNION_CAST( i, double ) / UNION_CAST( j, double );
   return UNION_CAST( result, long int );
}

// functions in math.h
long int dacos( long int i )
{
   double result = acos( UNION_CAST( i, double ) );
   return UNION_CAST( result, long int );
}

long int dasin( long int i )
{
   double result = asin( UNION_CAST( i, double ) );
   return UNION_CAST( result, long int );
}

long int datan( long int i )
{
   double result = atan( UNION_CAST( i, double ) );
   return UNION_CAST( result, long int );
}

long int datan2( long int i, long int j )
{
   double result = atan2( UNION_CAST( i, double ), UNION_CAST( j, double ) );
   return UNION_CAST( result, long int );
}

long int dcos( long int i )
{
   double result = cos( UNION_CAST( i, double ) );
   return UNION_CAST( result, long int );
}

long int dcosh( long int i )
{
   double result = cosh( UNION_CAST( i, double ) );
   return UNION_CAST( result, long int );
}

long int dsin( long int i )
{
   double result = sin( UNION_CAST( i, double ) );
   return UNION_CAST( result, long int );
}

long int dsinh( long int i )
{
   double result = sinh( UNION_CAST( i, double ) );
   return UNION_CAST( result, long int );
}

long int dtan( long int i )
{
   double result = tan( UNION_CAST( i, double ) );
   return UNION_CAST( result, long int );
}

long int dtanh( long int i )
{
   double result = tanh( UNION_CAST( i, double ) );
   return UNION_CAST( result, long int );
}

long int dexp( long int i )
{
   double result = exp( UNION_CAST( i, double ) );
   return UNION_CAST( result, long int );
}

long int dfrexp( long int i, int *exp )
{
   double x = frexp( UNION_CAST( i, double ), exp );
   return UNION_CAST( x, long int );
}

long int dldexp( long int i, int exponent )
{
   double result = ldexp( UNION_CAST( i, double ), exponent );
   return UNION_CAST( result, long int );
}

long int dlog( long int i )
{
   double result = log( UNION_CAST( i, double ) );
   return UNION_CAST( result, long int );
}

long int dlog10( long int i )
{
   double result = log10( UNION_CAST( i, double ) );
   return UNION_CAST( result, long int );
}

long int dmodf( long int i, long int *int_part )
{
   double x = modf( UNION_CAST( i, double ), ( double * ) int_part );
   return UNION_CAST( x, long int );
}

long int dpow( long int i, long int j )
{
   double result = pow( UNION_CAST( i, double ), UNION_CAST( j, double ) );
   return UNION_CAST( result, long int );
}

long int dsqrt( long int i )
{
   double result = sqrt( UNION_CAST( i, double ) );
   return UNION_CAST( result, long int );
}

long int dceil( long int i )
{
   double result = ceil( UNION_CAST( i, double ) );
   return UNION_CAST( result, long int );
}

long int dfabs( long int i )
{
   double result = fabs( UNION_CAST( i, double ) );
   return UNION_CAST( result, long int );
}

long int dfloor( long int i )
{
   double result = floor( UNION_CAST( i, double ) );
   return UNION_CAST( result, long int );
}

long int dfmod( long int i, long int j )
{
   double result = fmod( UNION_CAST( i, double ), UNION_CAST( j, double ) );
   return UNION_CAST( result, long int );
}

// constants from math.h
int fhuge( void )
{
   float result = HUGE;
   return UNION_CAST( result, int );
}

long int dm_e( void )
{
   double result = M_E;
   return UNION_CAST( result, long int );
}

long int dlog2e( void )
{
   double result = M_LOG2E;
   return UNION_CAST( result, long int );
}

long int dlog10e( void )
{
   double result = M_LOG10E;
   return UNION_CAST( result, long int );
}

long int dln2( void )
{
   double result = M_LN2;
   return UNION_CAST( result, long int );
}

long int dln10( void )
{
   double result = M_LN10;
   return UNION_CAST( result, long int );
}

long int dpi( void )
{
   double result = M_PI;
   return UNION_CAST( result, long int );
}

long int dpi_2( void )
{
   double result = M_PI_2;
   return UNION_CAST( result, long int );
}

long int dpi_4( void )
{
   double result = M_PI_4;
   return UNION_CAST( result, long int );
}

long int d1_pi( void )
{
   double result = M_1_PI;
   return UNION_CAST( result, long int );
}

long int d2_pi( void )
{
   double result = M_2_PI;
   return UNION_CAST( result, long int );
}

long int d2_sqrtpi( void )
{
   double result = M_2_SQRTPI;
   return UNION_CAST( result, long int );
}

long int dsqrt2( void )
{
   double result = M_SQRT2;
   return UNION_CAST( result, long int );
}

long int dsqrt1_2( void )
{
   double result = M_SQRT1_2;
  return UNION_CAST( result, long int );
}

long int dhuge_val( void )
{
   double result = HUGE_VAL;
   return UNION_CAST( result, long int );
}

/* End of file */

