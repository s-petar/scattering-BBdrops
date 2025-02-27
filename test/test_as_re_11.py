# Author: Petar Stipanovic (pero@pmfst.hr)
# Project: EQUAFLU (HrZZ)
# Testing potential parameters for given scattering length and effective range
# Units: hbar**2/(2 m a11**2), m, a11
import numpy as np

# Data for K-K in B=56.337G
a11 = 66.619 # a0
ReffExp = -1155.27/a11 # a11
AsExp =  66.619/a11 # a11
m1 = 1.0
m2 = 1.0

# Eqs. from ch. III.A from Jensen et al: PRA, 74, 043608 (2006) 
def AsRe(r0,r1,u0,u1):
    mu = 1.0 / (1./m1 + 1./m2)
    k0 = np.sqrt(mu*u0)
    k1 = np.sqrt(mu*u1)
    k02 = k0**2
    k12 = k1**2
    zeta = k0 + k1*np.tan(k0*r0)*np.tanh(k1*(r1-r0))

    As = r1 - 1. / (k1*zeta) * (k1*np.tan(k0*r0) + k0*np.tanh(k1*(r1-r0)))

    Rr = -(k02 + k12) / (k0*k12*As*zeta) * (1. + k0*r0/(As*zeta) / (np.cosh(k1*(r1-r0)))**2)
    Rv = ((k02 + k12) / (k0*k12*As*zeta)) * (r1/As) * (1. - np.tanh(k1*(r1-r0))/(k1*r1)) + 1./(k12*As) - r1**3 / (3.*As**2)
    Reff = r1 + Rr + Rv

    eAs = 100. * (As-AsExp) / AsExp
    eReff = 100. * (Reff-ReffExp) / ReffExp

    print(f"{As=} + {eAs:.4f}%")
    print(f"{Reff=} + {eReff:.4f}%")

# Interaction potential parameters - Set 1
r0 = 1.8843457737164
r1 = 5.34908953449612
u0 = 0.922062119798909
u1 = 0.112280670067531
print("\nV11 paramters set 1")
AsRe(r0,r1,u0,u1)

# Interaction potential parameters - Set 2
r0 = 3.5592013575770274
r1 = 6.195646807634084
u0 = 0.091257344419641381
u1 = 0.060391887798762374
print("\nV11 paramters set 2")
AsRe(r0,r1,u0,u1)
