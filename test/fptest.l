# (c) 2016 Greg Lee

# Tests for fp.l

# Note - floating point values are inherently approximations. Tests
# that return values from trigonometric or trancendental functions 
# may fail because the last few bit(s) of precision disagree. These
# tests pass on x86_64 Linux using gcc.

# load the library
(load "./fp.l")

# string to float
(test 1065353216 (s2r "1.0"))
(test -1082130432 (s2r "-1.0"))
(test 1093780111 (s2r "11.11"))
(test -1052455731 (s2r "-12.3"))
(test 1401664201 (s2r "1.2E12"))

# float to string
(test "2.000000" (r2s 1073741824))
(test "-1.300000" (r2s -1079613850))
(test "12.700000" (r2s 1095447347))
(test "-13.900000" (r2s -1050778010))
(test "1.00" (r2s 1065353216 "%.2f"))
(test "11.12" (r2s 1093793743 "%5.2f"))
(test "1.112300e+01" (r2s 1093793743 "%e"))

# string to double
(test 4607182418800017408 (s2d "1.0"))
(test -4616189618054758400 (s2d "-1.0"))
(test 4622443992037269176 (s2d "11.11"))
(test -4600258134372935270 (s2d "-12.3"))
(test 4787738004267466752 (s2d "1.2E12"))

# double to string
(test "2.000000" (d2s 4611686018427387904))
(test "-1.300000" (d2s -4614838538166547251))
(test "12.700000" (d2s 4623339082463209062))
(test "-13.900000" (d2s -4599357414447461171))
(test "1.00" (d2s 4607182418800017408 "%.2f"))
(test "11.12" (d2s 4622451310386663653 "%5.2f"))
(test "1.112300e+01" (d2s 4622451310386663653 "%e"))

# float to double
(test 0 (r2d 0))
(test 4607182418800017408 (r2d 1065353216))
(test -4616189618054758400 (r2d -1082130432))
(test 4623001312705904640 (r2d 1094818202))
(test -4599357414662209536 (r2d -1050778010))

# double to float
(test 0 (d2r 0))
(test 1065353216 (d2r 4607182418800017408))
(test -1082130432 (d2r -4616189618054758400))
(test 1094818202 (d2r 4623001312705904640))
(test -1050778010 (d2r -4599357414662209536))

# long int to double
(test 0 (l2d 0))
(test 4607182418800017408 (l2d 1))
(test -4616189618054758400 (l2d -1))
(test 4638355772470722560 (l2d 123))
(test -4584875526895697920 (l2d -125))

# double to long int (truncates)
(test 0 (d2l 0))
(test 1 (d2l 4607182418800017408))
(test -1 (d2l -4616189618054758400))
(test 1 (d2l 4609434218613702656))
(test -1 (d2l -4613937818241073152))
(test 123 (d2l 4638355772470722560))
(test -125 (d2l -4584875526895697920))

# long int to float
(test 0 (l2r 0))
(test 1065353216 (l2r 1))
(test -1082130432 (l2r -1))
(test 1123418112 (l2r 123))
(test -1023803392 (l2r -125))

# float to long int (truncates)
(test 0 (r2l 0))
(test 1 (r2l 1065353216))
(test -1 (r2l -1082130432))
(test 1 (r2l 1069547520))
(test -1 (r2l -1077936128))
(test 123 (r2l 1123418112))
(test -125 (r2l -1023803392))

# fixed point to double
(setq *Scl 2 )
(test 0 (fix2d 0))
(test 4607182418800017408 (fix2d 1.0))
(test -4646453807550688133 (fix2d -1))
(test 4608218246714312622 (fix2d 1.23))
(test -4615063718147915776 (fix2d -1.25))

# double to fixed point
(setq *Scl 2 )
(test 0 (d2fix 0.00))
(test 100 (d2fix 4607182418800017408))
(test -100 (d2fix -4616189618054758400))
(test 150 (d2fix 4609434218613702656))
(test -150 (d2fix -4613937818241073152))
(test 123 (d2fix 4608218246714312622))
(test -125 (d2fix -4615063718147915776))

# fixed point to float
(setq *Scl 2 )
(test 0 (fix2r 0))
(test 1065353216 (fix2r 1.0))
(test -1138501878 (fix2r -1))
(test 1067282596 (fix2r 1.23))
(test -1080033280 (fix2r -1.25))

# float to fixed point
(setq *Scl 2 )
(test 0 (r2fix 0.00))
(test 100 (r2fix 1065353216))
(test -100 (r2fix -1082130432))
(test 150 (r2fix 1069547520))
(test -150 (r2fix -1077936128))
(test 123 (r2fix 1067282596))
(test -125 (r2fix -1080033280))

# single precision add
(test 1073741824 (radd 1065353216 1065353216))
(test 1073741824 (radd 1067869798 1060320051))
(test 1058642329 (radd 1067869798 -1087163597))
(test 1086324736 (r+ 1065353216 1073741824 1077936128))
(test 1065353216 (r+ 1065353216))

# single precision subtract
(test 0 (rsub 1065353216 1065353216))
(test 1065353216 (rsub 1073741824 1065353216))
(test 1073741824 (rsub 1067869798 -1087163597))
(test -1065353216 (r- 1065353216 1073741824 1077936128))
(test -1082130432 (r- 1065353216))

# single precision multiply
(test 0 (rmul 1065353216 0))
(test 1073741824 (rmul 1073741824 1065353216))
(test -1083640382 (rmul 1067869798 -1087163597))
(test 1086324736 (r* 1065353216 1073741824 1077936128))
(test 1065353216 (r* 1065353216))

# single precision divide
(test 0 (rdiv 0 1065353216))
(test 1073741824 (rdiv 1073741824 1065353216))
(test -1074940197 (rdiv 1067869798 -1087163597))
(test 1042983595 (r/ 1065353216 1073741824 1077936128))
(test 1065353216 (r/ 1065353216))

# double precision add
(test 4611686018427387904 (dadd 4607182418800017408 4607182418800017408))
(test 4607182418800017408 (dadd 4611686018427387904 -4616189618054758400))
(test 4607182418800017408 (dadd 4611686018427387904 -4616189618054758400))
(test 4618441417868443648 (d+ 4607182418800017408 4611686018427387904 4613937818241073152))
(test 4607182418800017408 (d+ 4607182418800017408))

# double precision subtract
(test 0 (dsub 4607182418800017408 4607182418800017408))
(test 4607182418800017408 (dsub 4611686018427387904 4607182418800017408))
(test 4613937818241073152 (dsub 4611686018427387904 -4616189618054758400))
(test -4609434218613702656 (d- 4607182418800017408 4611686018427387904 4611686018427387904))
(test -4616189618054758400 (d- 4607182418800017408))

# double precision multiply
(test 0 (dmul 4607182418800017408 0))
(test 4611686018427387904 (dmul 4611686018427387904 4607182418800017408))
(test -4611686018427387904 (dmul 4611686018427387904 -4616189618054758400))
(test 4616189618054758400 (d* 4607182418800017408 4611686018427387904 4611686018427387904))
(test 4607182418800017408 (d* 4607182418800017408))

# double precision divide
(test 0 (ddiv 0 4607182418800017408))
(test 4611686018427387904 (ddiv 4611686018427387904 4607182418800017408))
(test -4611686018427387904 (ddiv 4611686018427387904 -4616189618054758400))
(test 4598175219545276416 (d/ 4607182418800017408 4611686018427387904 4611686018427387904))
(test 4607182418800017408 (d/ 4607182418800017408))

# acos
(test 4609753056924675352 (dacos 0) )
(test 4609301942964057488 (dacos 4591870180066957722))

# asin
(test 0 (dasin 0) )
(test 4591882244033050756 (dasin 4591870180066957722))

# atan
(test 0 (datan 0 4607182418800017408) )
(test 4591846303962680397 (datan 4591870180066957722 4607182418800017408))

# atan2
(test 0 (datan 0 ) )
(test 4591846303962680397 (datan 4591870180066957722))

# cos
(test 4607182418800017408 (dcos 0))
(test 4607137420321232833 (dcos 4591870180066957722))

# cosh
(test 4607182418800017408 (dcosh 0))
(test 4607204955569408824 (dcosh 4591870180066957722))

# sin
(test 0 (dsin 0))
(test 4591858176471321388 (dsin 4591870180066957722))

# sinh
(test 0 (dsinh 0))
(test 4591882195672193459 (dsinh 4591870180066957722))

# tan
(test 0 (dtan 0))
(test 4591894295732226944 (dtan 4591870180066957722))

# tanh
(test 0 (dtanh 0))
(test 4591846256558424378 (dtanh 4591870180066957722))

# dexp
(test 4607182418800017408 (dexp 0))
(test 4607656066507473108 (dexp 4591870180066957722))

# dfrexp
(test (0 0) (dfrexp 0))
(test (4605380978949069210 -3) (dfrexp 4591870180066957722))

# dldexp
(test 0 (dldexp 0 0))
(test 4591870180066957722 (dldexp 4605380978949069210 -3))

# dlog
(test 0 (dlog 4607182418800017408))
(test -4611004657371359979 (dlog 4591870180066957722))

# dlog10
(test 0 (dlog10 4607182418800017408))
(test -4616189618054758400 (dlog10 4591870180066957722))

# dmodf
(test (0 0) (dmodf 0))
(test (4591870180066957728 4607182418800017408) (dmodf 4607632778762754458))
(test (4591870180066957728 4607182418800017408) (dmodf 4607632778762754458))

# dpow
(test 4607182418800017408 (dpow 4607182418800017408 4591870180066957722))
(test 4607505657739150948 (dpow 4611686018427387904 4591870180066957722))

# dsqrt
(test 0 (dsqrt 0))
(test 4599368272914696463 (dsqrt 4591870180066957722))

# dceil
(test 0 (dceil 0))
(test 4607182418800017408 (dceil 4607182418800017408))
(test 4611686018427387904 (dceil 4608533498688228557))

# dfabs
(test 0 (dfabs 0))
(test 4607182418800017408 (dfabs 4607182418800017408))
(test 4607182418800017408 (dfabs -4616189618054758400))

# dfloor
(test 0 (dfloor 0))
(test 4607182418800017408 (dfloor 4607182418800017408))
(test 4607182418800017408 (dfloor 4607632778762754458))
(test -4616189618054758400 (dfloor -4616189618054758400))
(test -4611686018427387904 (dfloor -4615739258092021350))

# dfmod
(test 0 (dfmod 0 4607182418800017408))
(test 4591870180066957728 (dfmod 4611911198408756429 4607182418800017408))

# rhuge
(test 2139095039 (rhuge ()))

# dm_e
(test 4613303445314885481 (dm_e ()))

# dlog2e
(test 4609176140021203710 (dlog2e ()))

# dlog10e
(test 4601495173785380110 (dlog10e ()))

# dln2
(test 4604418534313441775 (dln2 ()))

# dln10
(test 4612367379483415830 (dln10 ()))

# dpi_2
(test 4609753056924675352 (dpi_2 ()))

# dpi_4
(test 4605249457297304856 (dpi_4 ()))

# d1_pi
(test 4599405781057128579 (d1_pi ()))

# d2_pi
(test 4603909380684499075 (d2_pi ()))

# d2_sqrtpi
(test 4607760587169110893 (d2_sqrtpi ()))

# dsqrt2
(test 4609047870845172685 (dsqrt2 ()))

# dsqrt1_2
(test 4604544271217802189 (dsqrt1_2 ()))

# dhuge_val
(test 9218868437227405312 (dhuge_val ()))

# End of file

