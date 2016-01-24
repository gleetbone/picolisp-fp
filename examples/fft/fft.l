# (c) 2016 Greg Lee

(de FFTW_FORWARD . -1)
(de FFTW_ESTIMATE . 64)

(de l2buf ( L1 P1 )
   (struct P1 'N (cons (car L1) 8 ))
   (struct (+ P1 8) 'N (cons (cadr L1) 8 )))

(de list2buf ( L2 P2 )
   (let ( Len (length L2) L3 L2 )
      (for I2 Len 
         (l2buf (car L3) (+ P2 (* (- I2 1) 16) ) )
         (setq L3 (cdr L3)))))

(de buf2list ( N P )
   (let (L () )
      (for I (range 0 (- N 1) )
         (if (= I 0 ) 
            (setq L (list (struct P '(N N))))
            (setq L (conc L (list (struct (+ P (* I 16) ) '(N N)))))))
   L ))

(de l2s (L1)
   (cons (d2s (car L1)) (d2s (cadr L1)) NIL))

(de list2s (L2)
   (let ( Len (length L2) L () L3 L2)
      (for I (range 1 Len )
         (if (= I 1 ) 
            (setq L (list (l2s (car L3))))
            (setq L (conc L (list (l2s (car L3)))))
         )
         (setq L3 (cdr L3))
       )
   L ))

(de s2l (L1)
   (cons (s2d (car L1)) (s2d (cadr L1)) NIL))

(de s2list (L2)
   (let ( Len (length L2) L () L3 L2)
      (for I (range 1 Len )
         (if (= I 1 ) 
            (setq L (list (s2l (car L3))))
            (setq L (conc L (list (s2l (car L3)))))
         )
         (setq L3 (cdr L3))
       )
   L ))

(de fft (Lst)
   (let
      (Len (length Lst)
         In (native "libfftw3.so" "fftw_malloc" 'N (* Len 16))
         Out (native "libfftw3.so" "fftw_malloc" 'N (* Len 16))
         P (native "libfftw3.so" "fftw_plan_dft_1d" 'N
            Len In Out FFTW_FORWARD FFTW_ESTIMATE ) )
      (list2buf Lst In)
      (native "libfftw3.so" "fftw_execute" NIL P)
      (prog1
         (buf2list Len Out)
         (native "libfftw3.so" "fftw_destroy_plan" NIL P)
         (native "libfftw3.so" "fftw_free" NIL Out)
         (native "libfftw3.so" "fftw_free" NIL In) ) ) )


