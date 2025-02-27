unset multiplot

reset
set encoding iso_8859_1
set term pngcairo enhanced font "Calibri,18" size 800,600
set output      'wF_B56.337G_Fd.png'
set fit logfile 'wF_B56.337G_Fd.log'

set sample 1000
#unset key

set style line 1  linetype 1 linewidth 2 lc rgb "blue"
set style line 2  linetype 1 linewidth 2 lc rgb "red"
set style line 3  linetype 1 linewidth 2 lc rgb "black"

set format y
set format x
set xlabel "r / a_{11}"
set ylabel "F'(r)"

plot [0:20][:] \
  'wF_B56.337G_11.txt' u 1:($3*$2) w l ls 1 ti 'U_{11}(r)', \
  'wF_B56.337G_22.txt' u 1:($3*$2) w l ls 2 ti 'U_{22}(r)', \
  'wF_B56.337G_12.txt' u 1:($3*$2) w l ls 3 ti 'U_{12}(r)'

unset multiplot
unset output
reset
set terminal GNUTERM
