*/* RMNLIB - Library of useful routines for C and FORTRAN programming
* * Copyright (C) 1975-2001  Division de Recherche en Prevision Numerique
* *                          Environnement Canada
* *
* * This library is free software; you can redistribute it and/or
* * modify it under the terms of the GNU Lesser General Public
* * License as published by the Free Software Foundation,
* * version 2.1 of the License.
* *
* * This library is distributed in the hope that it will be useful,
* * but WITHOUT ANY WARRANTY; without even the implied warranty of
* * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* * Lesser General Public License for more details.
* *
* * You should have received a copy of the GNU Lesser General Public
* * License along with this library; if not, write to the
* * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
* * Boston, MA 02111-1307, USA.
* */
*
***S/P    XLNTH    CALCULE LE NOMBRE DE CARACTERES QUE CONTIENT ILAB,
*                 LE MAXIMUM EST 40.  ROUTINE UTILISEE PAR PLOT80.
*
      SUBROUTINE XLNTH (ILAB,NC)
      IMPLICIT NONE
*
*AUTEUR   SYSTEME NCAR
*
*REVISION 001  RPN  M.VALIN / C.THIBEAULT  1-4-79  REFAIT DOCUMENTATION
*
*IMPLICITES
      INTEGER IBAC,ISET,NDASH,LFRAME,IROW,LTYPE,LNDASH
      COMMON /XAUTOG1/ IBAC,ISET,NDASH,LFRAME,IROW,LTYPE,LNDASH(26)
      CHARACTER *40 LABX,LABY,LTIT
      CHARACTER *(16) LDASHC(26)
      CHARACTER *10 LSYM(26)
      CHARACTER *8  IFMTX,IFMTY
      COMMON /XAUTOG3/ LABX,LABY,LTIT,LDASHC,LSYM,IFMTX,IFMTY
*
*----------------------------------------------------------------------
*
      INTEGER I,NC
      CHARACTER *40 ILAB
*
*----------------------------------------------------------------------
*
      NC = 0
      DO 10 I=1,40
        IF (ILAB(I:I) .EQ. '$') GO TO 20
        NC = I
   10 CONTINUE
   20 CONTINUE
*
      RETURN
      END
