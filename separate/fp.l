# (c) 2016 Greg Lee

### Floating point math library ###

(if (= *OS "Darwin")
   (default *FpLib "@lib/libfp.dylib")
   (default *FpLib "@lib/libfp.so") )

# String to/from floating point number conversions
(de r2s (X . @)
   (if (args)
      (native `*FpLib "f2s" 'S '(NIL (257) . 0) (next) X) 
      (native `*FpLib "f2s" 'S '(NIL (257) . 0) "%f" X) ) )

(de s2r (X)
   (native `*FpLib "s2f" 'I X) )

(de d2s (X . @)
   (if (args) 
      (native `*FpLib "d2s" 'S '(NIL (257) . 0) (next) X) 
      (native `*FpLib "d2s" 'S '(NIL (257) . 0) "%f" X) ) )

(de s2d (X)
   (native `*FpLib "s2d" 'N X) )

# Conversions between integer, fixed, and floating point types
(de r2d (X)
   (native `*FpLib "f2d" 'N X) )

(de d2r (X)
   (native `*FpLib "d2f" 'I X) )

(de l2d (X)
   (native `*FpLib "l2d" 'N X) )

(de d2l (X)
   (native `*FpLib "d2l" 'N X) )

(de l2r (X)
   (native `*FpLib "l2f" 'I X) )

(de r2l (X)
   (native `*FpLib "f2l" 'N X) )

(de fix2d (X)
   (native `*FpLib "fix2d" 'N X *Scl) )

(de d2fix (X)
   (native `*FpLib "d2fix" 'N X *Scl) )

(de fix2r (X)
   (native `*FpLib "fix2f" 'I X *Scl) )

(de r2fix (X)
   (native `*FpLib "f2fix" 'N X *Scl) )

# Single precision math
(de rneg (X)
   (native `*FpLib "fneg" 'I X) )

(de radd (X Y)
   (native `*FpLib "fadd" 'I X Y) )

(de r+ (X . @)
   (let ("Result" X)
      (while (args) 
	     (setq "Result" (radd "Result" (next) ) ) )
      "Result") )

(de rsub (X Y)
   (native `*FpLib "fsub" 'I X Y) )

(de r- (X . @)
   (if (args)
      (let ("Result" X)
         (while (args) 
	        (setq "Result" (rsub "Result" (next) ) ) )
	     "Result")
      (let ("Result" (rneg X) )
         "Result") ) )

(de rmul (X Y)
   (native `*FpLib "fmul" 'I X Y) )

(de r* (X . @)
   (let ("Result" X)
      (while (args) 
	     (setq "Result" (rmul "Result" (next) ) ) )
      "Result") )

(de rdiv (X Y)
   (native `*FpLib "fdiv" 'I X Y) )

(de r/ (X . @)
   (let ("Result" X)
      (while (args) 
	     (setq "Result" (rdiv "Result" (next) ) ) )
      "Result") )

# Double precision math
(de dneg (X)
   (native `*FpLib "dneg" 'N X) )

(de dadd (X Y)
   (native `*FpLib "dadd" 'N X Y) )

(de d+ (X . @)
   (let ("Result" X)
      (while (args) 
	     (setq "Result" (dadd "Result" (next) ) ) )
      "Result") )

(de dsub (X Y)
   (native `*FpLib "dsub" 'N X Y) )

(de d- (X . @)
   (if (args)
      (let ("Result" X)
         (while (args) 
	        (setq "Result" (dsub "Result" (next) ) ) )
	     "Result")
      (let ("Result" (dneg X) )
         "Result") ) )

(de dmul (X Y)
   (native `*FpLib "dmul" 'N X Y) )

(de d* (X . @)
   (let ("Result" X)
      (while (args) 
	     (setq "Result" (dmul "Result" (next) ) ) )
      "Result") )

(de ddiv (X Y)
   (native `*FpLib "ddiv" 'N X Y) )

(de d/ (X . @)
   (let ("Result" X)
      (while (args) 
	     (setq "Result" (ddiv "Result" (next) ) ) )
      "Result") )


# Functions and constants from math.h
(de dacos (X)
   (native `*FpLib "dacos" 'N X) )

(de dasin (X)
   (native `*FpLib "dasin" 'N X) )

(de datan (X)
   (native `*FpLib "datan" 'N X) )

(de datan2 (X Y)
   (native `*FpLib "datan2" 'N X Y) )

(de dcos (X)
   (native `*FpLib "dcos" 'N X) )

(de dcosh (X)
   (native `*FpLib "dcosh" 'N X) )

(de dsin (X)
   (native `*FpLib "dsin" 'N X) )

(de dsinh (X)
   (native `*FpLib "dsinh" 'N X) )

(de dtan (X)
   (native `*FpLib "dtan" 'N X) )

(de dtanh (X)
   (native `*FpLib "dtanh" 'N X) )

(de dexp (X)
   (native `*FpLib "dexp" 'N X) )

(de dfrexp (X)
   (list (native `*FpLib "dfrexp" 'N X '("E" (4 . I) ) ) "E") )
   
(de dldexp (X Y)
   (native `*FpLib "dldexp" 'N X Y) )

(de dlog (X)
   (native `*FpLib "dlog" 'N X) )

(de dlog10 (X)
   (native `*FpLib "dlog10" 'N X) )

(de dmodf (X)
   (list (native `*FpLib "dmodf" 'N X '("IP" (8 . N) ) ) "IP") )
   
(de dpow (X Y)
   (native `*FpLib "dpow" 'N X Y) )

(de dsqrt (X)
   (native `*FpLib "dsqrt" 'N X) )

(de dceil (X)
   (native `*FpLib "dceil" 'N X) )

(de dfabs (X)
   (native `*FpLib "dfabs" 'N X) )

(de dfloor (X)
   (native `*FpLib "dfloor" 'N X) )

(de dfmod (X Y)
   (native `*FpLib "dfmod" 'N X Y) )


(de rhuge ()
   (native `*FpLib "fhuge" 'I) )

(de dm_e ()
   (native `*FpLib "dm_e" 'N) )

(de dlog2e ()
   (native `*FpLib "dlog2e" 'N) )

(de dlog10e () 
   (native `*FpLib "dlog10e" 'N) )

(de dln2 ()
   (native `*FpLib "dln2" 'N) )

(de dln10 ()
   (native `*FpLib "dln10" 'N) )

(de dpi ()
   (native `*FpLib "dpi" 'N) )

(de dpi_2 ()
   (native `*FpLib "dpi_2" 'N) )

(de dpi_4 ()
   (native `*FpLib "dpi_4" 'N) )

(de d1_pi ()
   (native `*FpLib "d1_pi" 'N) )

(de d2_pi ()
   (native `*FpLib "d2_pi" 'N) )

(de d2_sqrtpi ()
   (native `*FpLib "d2_sqrtpi" 'N) )

(de dsqrt2 ()
   (native `*FpLib "dsqrt2" 'N) )

(de dsqrt1_2 ()
   (native `*FpLib "dsqrt1_2" 'N) )

(de dhuge_val ()
   (native `*FpLib "dhuge_val" 'N) )

# End of file


