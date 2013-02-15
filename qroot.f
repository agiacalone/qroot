C     Simple quadratic equation solver
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


C 3456789112345678921234567893123456789412345678951234567896123456
      PROGRAM QROOT
      REAL a,b,c,root_a,root_b
      CHARACTER restart

      WRITE (*,*) 'This program calculates the real or complex'
      WRITE (*,*) '(imaginary) roots of a quadratic equation'

100   WRITE (*,*) 'Give me a, b, and c (spaces only, no comma):'
      READ (*,*) a,b,c

      root_a = (-b+SQRT((b**2)-4*a*c))/(2*a)
      root_b = (-b-SQRT((b**2)-4*a*c))/(2*a)

      WRITE (*,*) 'Root 1 =', root_a
      WRITE (*,*) 'Root 2 =', root_b

      WRITE (*,*) 'Calculate another? (y/n)'
      READ (*,*) restart
      IF (restart == 'y') THEN
C         GOTOs are bad. Don't ever use them.
          GOTO 100
      END IF
      END

