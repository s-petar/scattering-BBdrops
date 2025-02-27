unset multiplot

reset
set encoding iso_8859_1
set term pngcairo enhanced font "Calibri,18" size 800,600
set output      'wF_B56.337G_fit.png'
set fit logfile 'wF_B56.337G_fit.log'

set sample 1000
set key left

set style line 1  lt 1 lw 3 lc rgb "cyan"
set style line 2  lt 1 lw 3 lc rgb "orange"
set style line 3  lt 1 lw 3 lc rgb "gray"

set style line 4  lt 1 lw 1 lc rgb "blue"
set style line 5  lt 1 lw 1 lc rgb "red"
set style line 6  lt 1 lw 1 lc rgb "black"

set format y
set format x
set xlabel "r / a_{11}"
set ylabel "F(r)"

f11(x) = a11 + b11/x
f22(x) = a22 + b22/x
f12(x) = a12 + b12/x

fit [20:] f11(x) 'wF_B56.337G_11.txt' u 1:2 via a11, b11
fit [20:] f22(x) 'wF_B56.337G_22.txt' u 1:2 via a22, b22
fit [20:] f12(x) 'wF_B56.337G_12.txt' u 1:2 via a12, b12
t11 = sprintf("f_{11} = %.3e + %.3e / r", a11, b11)
t22 = sprintf("f_{22} = %.3e + %.3e / r ", a22, b22)
t12 = sprintf("f_{12} = %.3e + %.3e / r", a12, b12)

plot [1:10][:] \
  f11(x) w l ls 1 ti t11, 'wF_B56.337G_11.txt' u 1:($2) w l ls 4 ti 'U_{11}(r)', \
  f22(x) w l ls 2 ti t22, 'wF_B56.337G_22.txt' u 1:($2) w l ls 5 ti 'U_{22}(r)', \
  f12(x) w l ls 3 ti t12, 'wF_B56.337G_12.txt' u 1:($2) w l ls 6 ti 'U_{12}(r)'

unset multiplot
unset output
reset
set terminal GNUTERM
