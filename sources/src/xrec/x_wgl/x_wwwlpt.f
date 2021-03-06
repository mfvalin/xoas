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
      SUBROUTINE X_WWWLPT(PATFIL)
      implicit none
      CHARACTER *(*) PATFIL
      INTEGER NPAT,ITP(32, 128)
      INTEGER IPATT(32), IPATN(32), NTP(128),ipat,i,j
      EXTERNAL WGLDPT
      DATA NTP /128 * 0/
      OPEN(66,FILE=PATFIL,FORM='UNFORMATTED')
      DO 23000 I =1,128
         READ(66,END=888) IPAT,NTP(IPAT),(ITP(J,I),J=1,32)
         DO 23004 J = 1,32
            IPATT(J) = ITP(33-J,I)
            IPATN(J) = NOT(IPATT(J))
23004    CONTINUE
         CALL X_WGLDPT(I,32,IPATT)
         CALL X_WGLDPT(-I,32,IPATN)
23000 CONTINUE
 888  CLOSE(66)
      RETURN
      END
