! Author: Petar Stipanovic (pero@pmfst.hr)
! Project: EQUAFLU (HrZZ)
! Numerov algorithm solves: Y''(r)=U(r) + V(r)*Y(r)
! Used here for given Ep to solve in 3D: 
!   Y''(r)= Ep(r)/Ck*Y(r)
!   U(r) = 0
!   V(r) = Ep(r)/Ck, Ck=-h_bar**2/(2*mi)
      PROGRAM KKdrops
      IMPLICIT real*8 (A-H,P-V,X-Z)
      IMPLICIT integer (I-N)
      IMPLICIT logical (O)
      IMPLICIT character*30 (W)

      PARAMETER (Kmax = 400000) ! Number of points X(k)
      PARAMETER (h = 2.0d-3)    ! X(k+1)-X(k)
      PARAMETER (xFit = 20.d0)  ! lowest point selected for Fit
      PARAMETER (kFit = 1000)   ! every kFit-th point selected for fit
      DIMENSION Y(0:2), V(0:2)

      Ck = -2.0 ! in h_bar**2/(2*m a11**2), length in a11
      ! Potential energy Ep parameters for K-K in B=56.337G
      r0 = 1.2913692451617864
      u0 = 2.643274535701389*2.d0
      wFile='B56.337G_22'

      Ck = -1.0*DABS(Ck)
      write(*,*)wFile, Ck
        !Initial conditions
        Xo=0.5d0
        Yo=1.d-13
        Y1=1.d-12

        !After analysing tmp files can be deleted to save free space
        OPEN(21,FILE="Ep\"//TRIM(wFile)//".tmp")     !All points
        OPEN(22,FILE="Uo\"//TRIM(wFile)//".tmp")     !All points
        OPEN(23,FILE="Uo\"//TRIM(wFile)//"_fit.tmp") !Points for fit
        X=Xo
        Y(0)=Yo
        V(0)=Ep(X,r0,u0)/Ck
        write(22,'(2G26.16)')Xo, Y(0)

        X=Xo+h
        Y(1)=Y1
        V(1)=Ep(X,r0,u0)/Ck
        V(2)=Ep(X+h,r0,u0)/Ck
        !write(*,*)V(1), V(2), Y(1)
        write(22,'(2G26.16)')X, Y(1)
        write(21,*)Xo, V(0)*Ck
        write(21,*)Xo+h, V(1)*Ck
        n=1
        do k = 1, Kmax
          X = Xo + (k+1)*h
          V(n+1)=Ep(X,r0,u0)/Ck
          write(21,*)X, V(n+1)*Ck
          Y(n+1) = ( (2.d0 - h*h*V(n)*5.d0/6.d0) * Y(n) 
     &              -(1.d0 + h*h*V(n-1)/12.d0) * Y(n-1) )
     &           /   (1.d0 + h*h*V(n+1)/12.d0)
          write(22,'(2G26.16)')X, Y(n+1)
          if(X.GT.xFit.AND.MOD(k,kFit).EQ.0)
     &      write(23,'(2G26.16)')X,Y(n+1)
          Y(n-1)=Y(n)
          Y(n)=Y(n+1)
          V(n-1)=V(n)
          V(n)=V(n+1)
        enddo

        CLOSE(21)
        CLOSE(22)
        CLOSE(23)
      STOP
      END

      DOUBLE PRECISION FUNCTION Ep(r12,r0,u0)
      IMPLICIT real*8 (A-H,P-V,X-Z)
      IMPLICIT integer (I-N)
      IMPLICIT logical (O)
      IMPLICIT character*30 (W)
      Ep = u0*((r0/r12)**10-(r0/r12)**6)
      RETURN
      END

