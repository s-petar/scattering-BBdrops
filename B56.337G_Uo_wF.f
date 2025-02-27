! Author: Petar Stipanovic (pero@pmfst.hr)
! Project: EQUAFLU (HrZZ)
!   read waveFunction Uo/wFile.tmp (r,rF)
!   set F(rMAX) = 1.0
!   write wf_wFile_11,12,22.txt (r,F,F'/F,F''/F)
      PROGRAM waveFunction
      IMPLICIT real*8 (A-H,P-V,X-Z)
      IMPLICIT integer (I-N)
      IMPLICIT logical (O)
      IMPLICIT character*50 (W)

      PARAMETER (rMAX=4.d2)
      DIMENSION wFiles(3)
      real*8,DIMENSION (:), ALLOCATABLE :: r, F

      wFiles(1) = 'B56.337G_11'
      wFiles(2) = 'B56.337G_22'
      wFiles(3) = 'B56.337G_12'

      DO iwF = 1, 3
        wFile = wFiles(iwF)
        !Count number of lines and allocate arrays
        OPEN(20,FILE="Uo\"//TRIM(wFile)//".tmp")
        read(20,*, END=10) x, y
        n = 1
        yMax = 1.0
        DO
          read(20,*, END=10) x, y
          if(x.GT.(rMAX/2-1.d-6) .AND. x.LT.(rMAX/2+1.d-6)) yMax = y
          n = n + 1
        ENDDO
 10     CLOSE(20)
        write(*,*) n, 'lines in file ', wFile
        ALLOCATE(r(n), F(n))

        !Read waveFunction data
        OPEN(20,FILE="Uo\"//TRIM(wFile)//".tmp")
        read(20,*) r(1), F(1)
        read(20,*) r(2), F(2)
        F(2) = F(2)/r(2)/yMax
        IF(r(1) .LT. 1.D-6) THEN
          F(1) = F(2)
        ELSE
          F(1) = F(1)/r(1)/yMax
        ENDIF
        DO i = 3, n
          read(20,*) r(i), F(i)
          F(i) = F(i)/r(i)/yMax
        ENDDO
        CLOSE(20)

        !Calculate and save (r,wF,wF'/wF,wF''/wF)
        OPEN(20,FILE="Uo\wF_"//TRIM(wFile)//".txt")
        dr = r(2) - r(1)
        Fd = (F(2) - F(1))/dr
        Fdd = (F(1) - 2.*F(2) + F(3))/(dr*dr)
        F0 = (F(1)+F(2))/2.0
        write(20,'(F12.4,G25.15,2G25.15)') r(1), F(1), Fd/F0, Fdd/F0
        !write(10,'(F12.4,G20.8,2F15.6)') r(1), F(1), Fd, Fdd
        DO i = 2, n-1
          Fd = (F(i+1) - F(i-1))/(2.*dr)
          Fdd = (F(i-1) - 2.*F(i) + F(i+1))/(dr*dr)
          if(r(i) .LE. rMAX) 
     &      write(20,'(F12.4,G25.15,2G25.15)')r(i),F(i),Fd/F(i),Fdd/F(i)
          !write(10,'(F12.4,G20.8,2F15.6)') r(i), F(i), Fd, Fdd
        ENDDO
        CLOSE(20)
        IF (allocated(r)) deallocate(r)
        IF (allocated(F)) deallocate(F)
      ENDDO
      STOP
      END

