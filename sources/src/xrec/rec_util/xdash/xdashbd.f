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
      SUBROUTINE XDASHBD
*
***S/P  XDASHBD  ROUTINE QUI INITIALISE DES DICTIONNAIRES
*
*AUTEUR   M. VALIN -  C. THIBEAULT    OCTOBRE 1980
*
*LANGAGE  FORTRAN
*
*OBJET(DASHBD)
*         DASHBD INITIALISE DES (COMMON BLOCKS) UTILISE PAR DASHD ET
*         SES SOUS-ROUTINES
*
*LIBRAIRIES
*         SOURCE  NEWDASHPL,ID=CMCULIB
*         OBJET   NCARSYSOB,ID=CMCULIB
*
*APPEL    CALL DASHBD
*
*-----------------------------------------------------------------------
*     implicit none
*
*
*  DICTIONNAIRE POUR AJUSTER CERTAINS PARAMETRES
*
      COMMON /XDASHD3/ DICIN(8)
      COMMON /XDASHD2/ FPART,IPAU,IGP,IOFFS,TENSN,NP,SMALL,L1
*
*  INITIALISATION DES DICTIONNAIRES
*
C     DATA DICIN /"FPART", "IPAU", "IGP", "IOFFS", "TENSN", "NP",
C    1            "SMALL", "L1"  /
      DATA DICIN /2HFP, 2HIP, 2HIG, 2HIO, 2HTE, 2HNP, 2HSM, 2HL1  /
*
      DATA FPART, IPAU, IGP, IOFFS, TENSN, NP , SMALL, L1
*     1    /  1. ,  3  ,  9 ,   1  ,  2.5 , 150,  128., 70 /
     1    /  1. ,  3  ,  9 ,   1  ,  2.5 , 150,  4., 70 /
*
      RETURN
      END
