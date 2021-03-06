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
      module xfslouv
      implicit none
      save
      integer ligne,maxrecs,maxdes
      parameter (ligne  = 69)
      parameter (maxrecs= 64)
      parameter (maxdes = 8)
      character*12 idents(maxdes)
      character*69 tableau(0:maxrecs)
      integer table(3,maxdes), nrecs, nbrecs, nbdes
      integer, dimension(:), allocatable :: liste
      end module xfslouv
      integer function xfslouv97(nomfich, iun, ttlrecs, winind, typesel)
      use xfslouv
      implicit none
      integer ttlrecs,ntmrecs
      character*(*) nomfich
      integer iun, winind, typesel
      character*4 nomvar
      character*2 typvar
      character*1 grtyp
      character*12 etiket
      character*128  titre
      integer key, date0, deet, npas, ni, nj, nk, nbits, datyp
      integer ip1, ip2, ip3, swa, lng, dltf, ubc
      integer ig1, ig2, ig3, ig4, extra1, extra2, extra3
      integer fstinf, fstprm, fstsui
      integer fnom, fstfrm, res
      integer xselouv, xseloup, xselins, xselouf
      integer yymmdd, hhmmss
      integer i, j, inf, kind, mode
      real niveau, f_ip3
      integer m, jour, an, heure, r
      character*4 mois(0:12), month(0:12), mm
      character*15 cniveau, c_ip3
      integer ier, ulng, getulng
      external getulng
      data (mois(i),i=0,12) /'*** ', 'Jan ','Fev ','Mar ','Avr ',
     *                       'Mai ','Juin','Juil','Aout',
     *                       'Sep ','Oct ','Nov ','Dec ' /
      data (month(i),i=0,12) /'***', 'Jan ','Feb ','Mar ','Apr ',
     *                        'May ','Jun ','Jul ','Aug ',
     *                        'Sep ','Oct ','Nov ','Dec ' /
      ulng = getulng()
      if (ttlrecs.gt.0) then
         allocate(liste(ttlrecs))
      endif
*     
      nbdes = 7
      call initid97(idents, maxdes)
      call inittab97(tableau, table, ligne)
      write(titre, 5) nomfich(1:min(len(nomfich),128))
*    
*    
      res = xseloup(titre, ttlrecs, idents, nbdes, winind, typesel)
      if (ttlrecs.eq.0) then
         res = xselins(tableau,table,ttlrecs)
         goto 100
      endif
*     
      i = 0
      key = fstinf(iun, ni, nj, nk,  -1, ' ', -1, -1, -1, ' ', ' ')
      if (key.lt.0) goto 100
      i = i+1
*     
*     
      inf = fstprm(key, date0, deet, npas, ni, nj, nk, nbits,
     *             datyp, ip1, ip2, ip3, typvar, nomvar, etiket, grtyp,
     *             ig1, ig2, ig3, ig4, swa, lng, dltf, ubc,
     *             extra1, extra2, extra3)
*     
*
      call newdate(date0, yymmdd, hhmmss, -3)
      jour = mod(yymmdd, 100)
      m    = mod((yymmdd/100),100)
      an   = yymmdd / 10000
      heure = mod((hhmmss/1000000), 100)
      r     = 0
      if (ulng.eq.0) then
         mm = mois(m)
      else
         mm = month(m)
      endif
      mode = -1
      if (nomvar(1:2).ne.'^^'.and.nomvar(1:2).ne.'>>'.and.nomvar(1:2).ne
     %.'HY'.and.nomvar(1:4).ne.'####') then
        call convip_plus(ip1, niveau, kind, mode, cniveau, .true.)
        cniveau = adjustl(cniveau)
        call convip_plus(ip3, f_ip3, kind, mode, c_ip3, .true.)
        c_ip3 = adjustl(c_ip3)
      else
        write(cniveau, '(i10)') ip1
        write(c_ip3, '(i5)')  ip3
      endif
      if (ulng.eq.0.and.m.ge.6.and.m.le.8) then
         write(tableau(mod(i-1,64)), 11) nomvar, typvar,
     $        cniveau, ip2, c_ip3,
     *        etiket, jour, mm, an, heure
      else
         write(tableau(mod(i-1,64)), 12) nomvar, typvar,
     $        cniveau, ip2, c_ip3,
     *        etiket, jour, mm, an, heure
      endif
      liste(i) = key
      if (ttlrecs.le.1) then
         res = xselins(tableau,table,ttlrecs)
      endif
 50   if (key.lt.0) goto 100
      i = i + 1
*     
*     
      key = fstsui(iun, ni, nj, nk)
      if (key.lt.0) goto 100
      inf = fstprm(key, date0, deet, npas, ni, nj, nk, nbits,
     *     datyp, ip1, ip2, ip3, typvar, nomvar, etiket, grtyp,
     *     ig1, ig2, ig3, ig4, swa, lng, dltf, ubc,
     *     extra1, extra2, extra3)
      call newdate(date0, yymmdd, hhmmss, -3)
      jour = mod(yymmdd, 100)
      m    = mod((yymmdd/100),100)
      an   = yymmdd / 10000
      heure = mod((hhmmss/1000000), 100)
      r     = 0
      if (ulng.eq.0) then
         mm = mois(m)
      else
         mm = month(m)
      endif
      mode = -1
      if (nomvar(1:2).ne.'^^'.and.nomvar(1:2).ne.'>>'.and.nomvar(1:2).ne
     %.'HY'.and.nomvar(1:4).ne.'####') then
        call convip_plus(ip1, niveau, kind, mode, cniveau, .true.)
        cniveau = adjustl(cniveau)
        call convip_plus(ip3, f_ip3, kind, mode, c_ip3, .true.)
        c_ip3 = adjustl(c_ip3)
      else
        write(cniveau, '(i10)') ip1
        write(c_ip3, '(i5)')  ip3
      endif
!      print *, ip3, f_ip3, c_ip3
      if (ulng.eq.0.and.m.ge.6.and.m.le.8) then
         write(tableau(mod(i-1,64)), 11) nomvar, typvar,
     $        cniveau, ip2, c_ip3,
     *        etiket, jour, mm, an, heure
      else
         write(tableau(mod(i-1,64)), 12) nomvar, typvar,
     $        cniveau, ip2, c_ip3,
     *        etiket, jour, mm, an, heure
      endif
*     print *, tableau(mod(i-1,64))
      liste(i) = key
      ntmrecs = mod(i,64)
      if (ntmrecs.eq.0) then
         ntmrecs = 64
      endif
      if (0.eq.mod(i,64).or.i.eq.ttlrecs) then
         res = xselins(tableau,table,ntmrecs)
      endif
      goto 50
 100  continue
      res = xselouf(tableau, table, ntmrecs)
      xfslouv97 = winind
 2    format(40a)
 4    format(3i16)
 5    format(128a)
 6    format(40a)
 11   format(a4,2x, a2, 3x, a15,2x, i5, x, a5,
     *       x, a12, 1x, i2.2,a4,i4.4,'-',i2.2,'Z')
 12   format(a4,2x, a2, 3x, a15,2x, i5, x, a5,
     *       x, a12, 1x, i2.2,a3,i4.4,'-',i2.2,'Z')
      return
      end
c     ****************************************************************
c     **                                                            **
c     ****************************************************************
      integer function xfslfer97(winind)
      use xfslouv
      implicit none
      integer winind
      integer xselfer
      integer i, inf, res
      xfslfer97 = xselfer(winind)
      return
      end
c     ****************************************************************
c     **                                                            **
c     ****************************************************************
      integer function xfslact97(slkeys, nslkeys, winind)
      use xfslouv
      implicit none
      integer nslkeys
      integer slkeys(nslkeys), winind
      integer xselact
      integer i, inf, res
*     
*     
      xfslact97 = xselact(slkeys, nslkeys, winind)
      do 200 i=1, nslkeys
          print *, 'selecteur', i, slkeys(i)
         slkeys(i) = liste(slkeys(i))
 200  continue
      return
      end
c     ****************************************************************
c     **                                                            **
c     ****************************************************************
      subroutine initid97(idents)
      implicit none
      character*12 idents(*)
      integer i, j, ulng
      integer  getulng
      external getulng
      ulng = getulng()
      if (ulng.eq.0) then
         idents(1) =  'Champ'
         idents(2)  = 'Type'
         idents(3)  = '   Niveau'
         idents(4)  = ' Heure'
         idents(5)  = '  IP3'
         idents(6)  = ' Etiquette'
         idents(7) =  ' Date'
      else
         idents(1) =  'Field'
         idents(2)  = 'Type'
         idents(3)  = '   Level'
         idents(4)  = ' Time'
         idents(5)  = '  IP3'
         idents(6)  = ' Stamp    '
         idents(7) =  ' Date'
      endif
      return
      end
*****************************************************************
      subroutine inittab97(tableau, table, len)
      implicit none
      character*64 tableau(*)
      integer table(3, *)
      integer len
      table(1,1)   = 6
      table(2,1)   = len
      table(3,1)   = 0
      table(1,2)   = 5
      table(2,2)   = len
      table(3,2)    = 6
      table(1,3)   = 16
      table(2,3)   = len
      table(3,3)   = 11
      table(1,4)   = 6
      table(2,4)   = len
      table(3,4)   = 27
      table(1,5)   = 6
      table(2,5)   = len
      table(3,5)   = 33
      table(1,6)   = 13
      table(2,6)   = len
      table(3,6)   = 39
      table(1,7)  = 13
      table(2,7)  = len
      table(3,7)  = 52
      return
      end
c     ****************************************************************
      integer function xfslupd97(nomfich, iun, ttlrecs, winind, typesel)
      use xfslouv
      implicit none
      integer ttlrecs,ntmrecs,typesel
      character*(*) nomfich
      integer iun, winind, ier
      integer xfslouv97
      if (allocated(liste)) then
        deallocate(liste)
      endif
      call xselupd(winind)
      ier = xfslouv97(nomfich, iun, ttlrecs, winind, typesel)
      xfslupd97 = 0
      return
      end
c     ****************************************************************
