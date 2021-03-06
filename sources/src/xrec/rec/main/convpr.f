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
      SUBROUTINE CONVPR( ip1, p, kind, sens )
      implicit none
**********************************************************************
*     Conversion de la coordonnee verticale de/a IP1
*     necessaire avant de lire/ecrire un enregistrement
*     sur un fichier standard.
*
*     Auteurs: N. Ek et B. Dugas - Mars 1996
*
*     Input:    SENS <  0, de IP1 --> sigma ou pression (mb)
*                    >= 0, de sigma ou pression (mb) --> IP1
*
*     Input/
*     Ouput:    IP1  =   Valeur codee de la coordonnee verticale
*               P    =   Valeur reelle de la coordonnee verticale
*               KIND =1, p est en sigma
*                    =2, p est en pression (mb)
**********************************************************************
      integer ip1, kind, sens
      real p
*      external qqexit
      if (sens.ge.0) then
*        Conversion a IP1 ...
         if (kind.eq.1) then
*           ... de sigma ...
            if ( p .lt. 0 .or. p .gt. 1.0 ) then
               write(6,6001) p
*               call qqexit(1)
            endif
            ip1 = nint( p * 10000 ) + 2000
         elseif (kind.eq.2) then
*           ... ou de pression.
            if ( p .le. 0 .or. p .gt. 1200 ) then
               write(6,6002) p
*               call qqexit(2)
            endif
            if (10 .le. p .and. p .le. 1200 ) then
               ip1 = nint ( p )
            elseif ( p .lt. 10. ) then
               if( p .ge. 1. ) then
                  ip1 = 1800 + nint(20*p)
               elseif ( p .ge. 0.1 ) then
                  ip1 = 1600 + nint(200*p)
               elseif ( p .ge. 0.01 ) then
                  ip1 = 1400 + nint(2000*p)
               elseif ( p .ge. 0.001 ) then
                  ip1 = 1200 + nint(20000*p)
               else
                  ip1 = 0
               endif
            endif
         else
*           Valeur illegale de kind.
            write(6,6003) kind
*            call qqexit(3)
         endif
      elseif (sens.lt.0) then
*        Conversion de ip1 ...
         if ( ip1 .gt. 12000) then	
            p  = (ip1 - 12001.0) * 5.0
         elseif ( ip1 .ge. 2000 .and. ip1 .le. 12000 ) then
*     ... a sigma ...
            p = float (ip1 - 2000) / 10000.
         elseif ( ip1 .ge. 0 .and. ip1 .lt. 2000 ) then
*     ... ou a pression.
*           if ( ( 10 .le. ip1 .and. ip1 .le. 1200 )
            if ( ( 0 .le. ip1 .and. ip1 .le. 1200 )
     +           .or.  ip1 .eq.    0 ) then
               p = float(ip1)
            elseif ( ip1 .gt. 1200 ) then
               if ( ip1 .lt. 1400 ) then
                  p = float(ip1-1200) / 20000.
               elseif ( ip1 .lt. 1600) then
                  p = float(ip1-1400) / 2000.
               elseif ( ip1 .lt. 1800) then
                  p = float(ip1-1600) / 200.
               elseif  ( ip1 .lt. 2000) then
                  p = float(ip1-1800) / 20.
               endif
            endif
         else
*     Valeur illegale de ip1.
            write(6,6003) kind
*     call qqexit(4)
         endif
      endif
      return
**********************************************************************
 6001 format(' Dans convpr: sigma initial =',e10.5)
 6002 format(' Dans convpr: pression initiale =',e10.5)
 6003 format(' Dans convpr: kind initial =',I10)
 6004 format(' Dans convpr: ip1 initial =',I10)
      end
