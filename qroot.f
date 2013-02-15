C     Simple quadratic root equation solver
C	   by Anthony Giacalone
C	  Written in Fortran, using the 77 standard, and compiled
C	   using the f77 compiler frontend for GCC on Linux
C
C     Some interesting observations made while coding this
C      project in Fortran:
C
C      1. Modern programmer's editors (Sublime Text and Gedit)
C         do not handle some of Fortran's idiosyncracies well.
C         Mainly, column formatting, syntax highlighting, and the
C         hard 66-column limit were either not implemented or
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


C 3456789112345678921234567893123456789412345678951234567896123456
      PROGRAM QROOT
      CHARACTER restart
      COMPLEX croot_a,croot_b
      REAL a,b,c,e,rroot_a,rroot_b,discr

      WRITE (*,*) 'This program calculates the real or complex'
      WRITE (*,*) '(imaginary) roots of a quadratic equation'

100   WRITE (*,*) 'Give me a, b, and c (spaces only, no comma):'
      READ (*,*) a,b,c

      e = 1.0e-9
      discr = b * b - 4.0 * a * c

      IF (ABS(discr) < e) THEN
          rroot_a = -b / (2.0 * a)
          WRITE (*,*) "Equation has one real root:"
          WRITE (*,*) "Root = ", rroot_a

      ELSE IF (discr > 0) THEN
          rroot_a = -(b + SIGN(SQRT(discr), b)) / (2.0 * a)
          rroot_b = c / (a * rroot_a)
          WRITE (*,*) "Equation has two real roots:"
          WRITE (*,*) "Root A = ", rroot_a
          WRITE (*,*) "Root B = ", rroot_b

      ELSE
          croot_a = (-b + SQRT(CMPLX(discr))) / (2.0 * a) 
          croot_b = CONJG(croot_a)
          WRITE (*,*) "Equation has two imaginary roots:" 
          WRITE (*,*) "Root A = ", croot_a
          WRITE (*,*) "Root B = ", croot_b

      END IF

      WRITE (*,*) 'Calculate another? (y/n)'
      READ (*,*) restart
      IF (restart == 'y') THEN
C         GOTOs are bad. Don't ever use them.
          GOTO 100
      END IF
      END

