unset multiplot

reset
set encoding iso_8859_1
set term pngcairo enhanced font "Calibri,18" size 800,600
set output      'B56.337G_12_fit.png'
set fit logfile 'B56.337G_12_fit.log'

set offsets 0, 0, 0, 0
set bmargin 0.
set lmargin 2.
set rmargin 0.
set tmargin 0.

set sample 1000
#unset key

set style line 1  linetype 1 linewidth 3 lc rgb "cyan"
set style line 2  linetype 1 linewidth 1 lc rgb "blue"
set style line 3  linetype 1 linewidth 1 lc rgb "black"
set style line 4  linetype 1 linewidth 1 lc rgb "red"

f(x)=a*x+b

set multiplot
  set origin 0.18,0.15
  set size 0.80,0.80
    set format y
    set format x
    set xlabel "r / a_{11}"
    set ylabel "U_0(r)"

    fit f(x) 'B56.337G_12_fit.tmp' u 1:2 via a, b
    set key title sprintf("V_{12}:  a_s=%.3f a_{11}",-b/a)

    plot [0:][:] 'B56.337G_12.tmp' u 1:($2) w l ls 1 ti 'U_0(r)', f(x) ls 2 ti 'y = A_{fit} r + B_{fit}', 0 ls 3 ti ''

unset multiplot
unset output

reset
set terminal GNUTERM