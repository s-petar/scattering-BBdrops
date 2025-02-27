# Short-range pair correlations and scattering parameters for Bos-Bose drops interactions (K-K)
Scattering solutions for different potential models of K-K interactions, sqeezed in magnetic field B = 56.337 G
- fortran, gnuplot & python codes/scripts

0. Testing scattering length (as) and effective range (re)
./test/

1. Scattering solutions
./Uo_*.f -> ./Uo/B56.337G_*

2. Plotting solutions and fitting scattering length as
./Uo/B56.337G_*_fit.plt

3. Extraction, scaling and derivative calculation of radial wave function F(r)
./Uo_wF.f -> ./U0/wF_B56.337G_*.txt (r,F,F'/F,F''/F)

4. Fitting scaled solutions
./Uo/wF_B56.337G_fit.plt -> ./Uo/wF_B56.337G_fit.png,log
