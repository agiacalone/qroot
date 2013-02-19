C     Simple quadratic root equation solver
C      by Anthony Giacalone
C
C     Written in Fortran, using the 77 standard, and compiled
C      using the f77 compiler frontend for GCC on Linux
C
C     Some interesting observations made while coding this
C      project in Fortran:
C
C      1. Modern programmer's editors (Sublime Text and Gedit)
C         do not handle some of Fortran's idiosyncracies well.
C         Mainly, column formatting, syntax highlighting, and the
C         hard 72-column limit were either not implemented or
C         poorly working. VI, on the other hand, had all of these
C         nice features working flawlessly and without any
C         additional setup.
C
C      2. There are two built-in functions to generate output:
C         WRITE (*,*) and PRINT*. From my brief research into the
C         differences between the two functions, PRINT* is just a
C         briefer version of WRITE (*,*) because it is used often.
C         For backwards compatability (and to keep my project as
C         historically accurate as possible) I've chosen to keep
C         with tradition and use the WRITE (*,*) whenever
C         possible.
C
C      3. There are (at least) two different ways to do power
C         arithmetic: 2**2 and SQRT(2). Both are built-in
C         functions, unlike with most modern languages. Also,
C         there are functions to perform arithmetic on imaginary
C         numbers (also built-in), some of which were put into use
C         in this program like CONJ (CONJ calculates the complex
C         conjugate of a complex number). Given the vast amount of
C         built-in mathematical operations in Fortran, it appears
C         to be written and intended for heavy math and 
C         engineering use.
C
C         This program uses STRICT compliance with Fortran77 and
C         has been tested to compile without any warnings with the
C         program FTNCHEK.


C 3456789112345678921234567893123456789412345678951234567896123456789712
      PROGRAM QROOT
      CHARACTER redo
      COMPLEX croota,crootb
      REAL a,b,c,e,rroota,rrootb,discr,imgpta,imgptb

      WRITE (*,*) 'This program calculates the real or complex'
      WRITE (*,*) '(imaginary) roots of a quadratic equation'

 50   WRITE (*,*) 'Give me a, b, and c (spaces only, no comma):'
      READ (*,*) a,b,c

      e = 1.0e-9
      discr = b * b - 4.0 * a * c
      
      IF (a .EQ. 0) THEN
          WRITE (*,100) 'You cannot divide by zero!'
 100      FORMAT (A,/)
C         GOTOs are bad. Don't ever use them.
          GOTO 500
      END IF
      
      IF (ABS(discr) .LT. e) THEN
          rroota = -b / (2.0 * a)
          WRITE (*,*) 'Equation has one real root:'
          WRITE (*,200) rroota
 200      FORMAT ('Root = ',F10.4,/)

      ELSE IF (discr .GT. 0) THEN
          rroota = -(b + SIGN(SQRT(discr), b)) / (2.0 * a)
          rrootb = c / (a * rroota)
          WRITE (*,*) 'Equation has two real roots:'
          WRITE (*,300) 'A', rroota, 'B', rrootb
 300      FORMAT (2('Root ',A1,' = ',F10.4,/))

      ELSE
          croota = (-b + SQRT(CMPLX(discr))) / (2.0 * a) 
          crootb = CONJG(croota)
          imgpta = AIMAG(croota)
          imgptb = AIMAG(crootb)
          WRITE (*,*) 'Equation has two imaginary roots:'
          WRITE (*,400) 'A', imgpta, 'B', imgptb
 400      FORMAT (2('Root ',A1,' = ',F10.4,'*i',/))
      END IF

 500  WRITE (*,*) 'Calculate another? (y/n)'
      READ (*,*) redo
      IF (redo .EQ. 'y') THEN
C         Do as I say...not as I do!
          GOTO 50
      END IF
      END

