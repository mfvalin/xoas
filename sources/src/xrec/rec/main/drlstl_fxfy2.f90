!/* RMNLIB - Library of useful routines for C and FORTRAN programming
! * Copyright (C) 1975-2001  Division de Recherche en Prevision Numerique
! *                          Environnement Canada
! *
! * This library is free software; you can redistribute it and/or
! * modify it under the terms of the GNU Lesser General Public
! * License as published by the Free Software Foundation,
! * version 2.1 of the License.
! *
! * This library is distributed in the hope that it will be useful,
! * but WITHOUT ANY WARRANTY; without even the implied warranty of
! * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
! * Lesser General Public License for more details.
! *
! * You should have received a copy of the GNU Lesser General Public
! * License along with this library; if not, write to the
! * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
! * Boston, MA 02111-1307, USA.
! */
!**s/p  wgldrl    trace des contours
!
   subroutine wgldrl_fxfy2 (z,px,py,l,m,n,mdeb,ndeb,mfin,nfin, lf)
!
   implicit none
   integer   l,m,n,mdeb,ndeb,mfin,nfin,lf
   real      z(l,n),px(l,n),py(l,n)
!
!auteur       systeme ncar
!
!revision001  m. valin  -  c. thibeault  mai 1979  documentation
!
!langage  fortran
!
!objet(wgldrl)
!         wgldrl trace des contours a partir d'un point donne par
!         wglstl
!
!arguments
!
!         z      champ qui contient les lignes a tracer
!
!         l      premiere dimension de z
!
!         m      nombre de donnees a utiliser pour la premiere dimension
!                de z.  si l'on desire utiliser toutes les donnees dans
!                la direction x,  l=mm.
!
!         n      deuxieme dimension de z
!
!implicites
!
!
   common /conis1/ ioffp,spval
!
   integer     ioffp
   real        spval
!
!
   integer, parameter :: irbase=1
      common /conis2/ ixa , iya  , ixb  , iyb  , idir , iss  , np  , cv  , inx(8), iny(8), nr
!
      integer     ixa, iya, ixb, iyb, idir, iss, np, nr, inx, iny
      integer, pointer, dimension(:) :: ir
      common /wglxmem/ ir
      real        cv
!
!
!modules
!
   external       wglplx
!
!notes    des changements peuvent etre fait en changeant les fonctions
!         fx et fy dans wgldrl et maxmin par des fonctions externes.
!         x=1. a z(1,j), x=float(m) a z(m,j).  deviennent des valeurs
!         flottantes
!         y=1. a z(i,1), y=float(n) a z(i,n).  deviennent des valeurs
!         flottantes
!
!*
   real       fx, fy, p1, p2, pass, za, zb, d, e, f, c, pds1, x, y, zc, zd
   integer    codes(0:3), k, ikod, ikod0, nobit, mot, ixa0, ixb0, iya0, iyb0, ixc, ixd, iyc, iyd, inxx(0:3), inyy(0:3), idir0,  i
   logical    between, btac, btbd, btcd
   integer    shiftr, ii, jj
   integer    shift
!
   real       pts(2,128)
   integer    npts
   integer ia
   real xdepart, ydepart
   integer ixa1, ixa2, iya1, iya2
   integer ixb1, ixb2, iyb1, iyb2
   integer ixc1, ixc2, iyc1, iyc2
   integer ixd1, ixd2, iyd1, iyd2
   integer ix, iy, ix1, iy1
   real rx,ry, x1, y1
   real rmdeb, rndeb, rmfin, rnfin
   real rxa, rxb, rxc, rxd
   real rya, ryb, ryc, ryd
   real rxa0, rxb0, rxc0, rxd0
   real rya0, ryb0, ryc0, ryd0
   real epsilon, rinc, ra, rb, ra1,ra2,rb1,rb2
   real zlin,zz1, zz2, zdx
   data  (inxx(i),i=0,3)/ 0, -1, 0, 1/
   data  (inyy(i),i=0,3)/ 1, 0,-1, 0/
   data codes /1,2,1,2/
!
!
   c (p1,p2)       = (p1-cv) / (p1-p2)
   between (d,e,f) = ( min(d,f).lt.e) .and. (max(d,f).ge.e )
   shiftr ( ii, jj ) = ishft ( ii, -jj )
   shift  ( ii, jj ) = ishft ( ii, jj )
   zlin(zz1,zz2,zdx) = zz1 + (zz2 - zz1) * zdx
!
   rmdeb = real(mdeb)
   rndeb = real(ndeb)
   rmfin = real(mfin)
   rnfin = real(nfin)
   rinc = 1.0 / lf
   epsilon = 0.5 * rinc
   npts = 0
   pass = 1
   nobit = (m*(min(iya,iyb)-1) + min(ixa,ixb)-1)
   if(iya.ne.iyb) nobit = nobit + m*n
   ikod0 = nobit
   ikod = -1
   mot = irbase + nobit/32
   nobit = iand(nobit , 31)
   if ( iand(1 , shiftr (ir(mot), 31-nobit)) .ne. 0 ) return
   ir(mot) = ior(ir(mot) , shift( 1, 31-nobit ))
   idir0 = idir
   ixa0 = ixa
   ixb0 = ixb
   iya0 = iya
   iyb0 = iyb
   rxa = real(ixa)
   rya = real(iya)
   rxb = real(ixb)
   ryb = real(iyb)
   rxa0 = rxa
   rya0 = rya
   rxb0 = rxb
   ryb0 = ryb
!
10   continue
   if (abs(rxa-nint(rxa)).lt.epsilon.and.abs(rya-nint(rya)).lt.epsilon) then
      za = z(nint(rxa), nint(rya))
   else
      ixa = min(l-1,max(1,ifix(rxa)))
      iya = min(n-1,max(1,ifix(rya)))
      za = zlin(zlin(z(ixa,iya),z(ixa+1,iya),rxa-real(ixa)),zlin(z(ixa,iya+1),z(ixa+1,iya+1),rxa-real(ixa)), rya-real(iya))
   endif
   if (abs(rxb-nint(rxb)).lt.epsilon.and.abs(ryb-nint(ryb)).lt.epsilon) then
      zb = z(nint(rxb), nint(ryb))
   else
      ixb = min(l-1,max(1,ifix(rxb)))
      iyb = min(n-1,max(1,ifix(ryb)))
      zb = zlin(zlin(z(ixb,iyb),z(ixb+1,iyb),rxb-real(ixb)),zlin(z(ixb,iyb+1),z(ixb+1,iyb+1),rxb-real(ixb)),ryb-real(iyb))
   endif
   if(ioffp.ne.0)then
      if(za.eq.spval .or. zb.eq.spval) goto 66
   endif
   pds1 = c(za,zb)
   x1 = rxa + pds1*(rxb-rxa)
   y1 = rya + pds1*(ryb-rya)
!
   call mapxy2fxfy(x,y,x1,y1,px,py,1,l,n)
!   print *, '### x,y,fx,fy',x1,y1,px(ix1,iy1),py(ix1,iy1),x,y
   call xy2fxfy(fx,fy, x, y)
!   print *, '@@@ x,y,fx,fy',x,y,fx,fy
!    do ia=1,npts
!       print *, ia, pts(1,ia),pts(2,ia)
!    enddo
!   call wglplx(npts, pts)
      do i=1,npts-1
         call wglmvx(pts(1,i),pts(2,i))
         if (3.0 > abs(pts(1,i+1)-pts(1,i))) then
            call wgldrx(pts(1,i+1),pts(2,i+1))
         endif
      enddo
   npts = 1
   pts(1,npts) = fx
   pts(2,npts)  = fy
5  rxc = rxa + inxx(idir) * rinc
   rxd = rxb + inxx(idir) * rinc
   ryc = rya + inyy(idir) * rinc
   ryd = ryb + inyy(idir) * rinc
!
   if(rxc.lt.rmdeb.or.rxd.lt.rmdeb.or.ryc.lt.rndeb.or.ryd.lt.rndeb.or.rxc.gt.rmfin.or.rxd.gt.rmfin.or.ryc.gt.rnfin.or.ryd.gt.rnfin)&
     &then
      rx = min(rxa, rxb)
      ry = min(rya, ryb)
      nobit = (m*(ifix(ry+epsilon)-1) + ifix(rx+epsilon)-1)
      if(rya.ne.ryb) nobit = nobit + m*n
      if (nobit.lt. 0) then
         print *, rxa, rya, rxb, ryb
      endif
!
      mot = irbase + nobit/32
      nobit = iand(nobit , 31)
      ir(mot) = ior(ir(mot) , shift(1,31-nobit))
!
      goto 66
   endif
!
   if (abs(rxc-nint(rxc)).lt.epsilon.and.abs(ryc-nint(ryc)).lt.epsilon) then
      zc = z(nint(rxc), nint(ryc))
   else
      ixc = min(l-1,max(1,ifix(rxc)))
      iyc = min(n-1,max(1,ifix(ryc)))
      zc = zlin(zlin(z(ixc,iyc),z(ixc+1,iyc),rxc-real(ixc)),zlin(z(ixc,iyc+1),z(ixc+1,iyc+1),rxc-real(ixc)),ryc-real(iyc))
   endif
   if (abs(rxd-nint(rxd)).lt.epsilon.and.abs(ryd-nint(ryd)).lt.epsilon) then
      zd = z(nint(rxd), nint(ryd))
   else
      ixd = min(l-1,max(1,ifix(rxd)))
      iyd = min(n-1,max(1,ifix(ryd)))
      zd = zlin(zlin(z(ixd,iyd),z(ixd+1,iyd),rxd-real(ixd)),zlin(z(ixd,iyd+1),z(ixd+1,iyd+1),rxd-real(ixd)),ryd-real(iyd))
   endif
!
   if(ioffp.ne.0) then
      if(zc.eq.spval .or. zd.eq.spval) goto 66
   endif
!
   btac = between(za,cv,zc)
   btbd = between(zb,cv,zd)
   btcd = between(zc,cv,zd)
   if(btac.and.btbd.and.btcd) goto 44
   if(btac) goto 11
   if(btbd) goto 33
   if(btcd) goto 22
   goto 66
!
!
11 rxb = rxc
   ryb = ryc
   idir = iand((idir+1),3)
   zb = zc
   goto 55
22 rxa = rxc
   rya = ryc
   rxb = rxd
   ryb = ryd
   za = zc
   zb = zd
   goto 55
33 rxa = rxd
   rya = ryd
   idir = iand((idir+3),3)
   za = zd
   goto 55
44 if(c(zc,zd).gt.pds1) then
   goto 11
   elseif(c(zc,zd).lt.pds1) then
      goto 33
   else
      goto 22
   endif
!
55 pds1 = c(za,zb)
   x1 = rxa + pds1*(rxb-rxa)
   y1 = rya + pds1*(ryb-rya)
!
   call mapxy2fxfy(x,y,x1,y1,px,py,1,l,n)
!   print *, '### x,y,fx,fy',x1,y1,px(ix1,iy1),py(ix1,iy1),x,y
   call xy2fxfy(fx, fy, x, y)
!   print *, '@@@ x,y,fx,fy',x,y,fx,fy
   npts = npts + 1
   pts(1,npts) = fx
   pts(2,npts) = fy
   if (npts.eq.128) then
!    do ia=1,npts
!       print *, ia, pts(1,ia),pts(2,ia)
!    enddo
!      call wglplx(npts, pts)
      do i=1,npts-1
         call wglmvx(pts(1,i),pts(2,i))
         if (3.0 > abs(pts(1,i+1)-pts(1,i))) then
            call wgldrx(pts(1,i+1),pts(2,i+1))
         endif
      enddo
      pts(1,1) = pts(1, npts)
      pts(2,1) = pts(2, npts)
      npts = 1
   endif
!     call wgldrx(fx,fy)
!
   if(iand(idir,1).eq.0)then
      rx = min(rxa, rxb)
      ry = min(rya, ryb)
      if (rya.ne.ryb) then
         if (rxa.eq.rxb.and.(abs(rxa-anint(rxa)).lt.epsilon)) then
            nobit = m*(ifix(ry+epsilon)-1) + nint(rx)-1
            if(rya.ne.ryb) nobit = nobit + m*n
            mot = irbase + nobit/32
            nobit = iand(nobit , 31)
            if( iand(1,shiftr(ir(mot),31-nobit)) .ne. 0) ikod = ikod0
            ir(mot) = ior(ir(mot),shift(1,31-nobit))
         endif
      else
         if (abs(rya-anint(rya)).lt.epsilon) then
            nobit = m*(nint(ry)-1) + ifix(rx+epsilon)-1
            mot = irbase + nobit/32
            nobit = iand(nobit , 31)
            if( iand(1,shiftr(ir(mot),31-nobit)) .ne. 0) ikod = ikod0
            ir(mot) = ior(ir(mot),shift(1,31-nobit))
         endif
      endif
!     print *, 'passe 2 ', nobit
      if (nobit.lt. 0) then
         print *, rxa, rya, rxb, ryb
      endif
   endif
   if(ikod .ne. ikod0) goto 5
   pass = 2
 66   continue
   if(pass.eq.1)then
      pass = 2
      rxa = rxb0
      rxb = rxa0
      rya = ryb0
      ryb = rya0
      idir = iand(3,(2+idir0))
      goto 10
   endif
!
!
!    do ia=1,npts
!       print *, ia, pts(1,ia),pts(2,ia)
!    enddo
!   call wglplx(npts, pts)
      do i=1,npts-1
         call wglmvx(pts(1,i),pts(2,i))
         if (3.0 > abs(pts(1,i+1)-pts(1,i))) then
            call wgldrx(pts(1,i+1),pts(2,i+1))
         endif
      enddo
   return
   end
!**s/p  wglstl    trouve le debut de toutes les lignes de contour a un
!                 niveau donne.
!
      subroutine wglstl_fxfy2 (z,px,py,l,m,n,mdeb,ndeb,mfin,nfin,conv,lf)
!
      implicit none
      integer   l, m, n, mdeb, ndeb, mfin, nfin,lf
      real      z(l,n), px(l,n),py(l,n),conv
!
!auteur   systeme ncar
!
!revision 001   m. valin  -  c. thibeault   mai 1979   documentation
!
!langage  fortran
!
!objet(wglstl)
!
!         wglstl trouve le debut de toutes les lignes de contour au
!         niveau conv.  premierement les bords sont fouilles pour
!         trouver les lignes qui entrecoupent le bord (lignes ouvertes)
!         ensuite l'interieur est fouille pour trouver les lignes qui
!         n'intersectent pas le bord (lignes fermees).  le debut est
!         garde dans ir pour empecher que les lignes soient retracees.
!         si ir est rempli, la fouille s'arrete pour ce niveau.
!
!arguments
!
!         z       champ ou s'effectue la fouille pour trouver les
!                 debuts de lignes de contour.
!
!         l       premiere dimension de z
!
!         m       nombre de donnees dans la direction x.  si l'on desire
!                 utiliser la matrice au complet   l=m.
!
!         n       nombre de donnees dans la direction y.
!                 deuxieme dimension
!
!         conv    niveau du contour
!
!implicites
!
!
   integer, parameter :: irbase=1
      common /conis2/ ixa   , iya   , ixb   ,  iyb   ,  idir  , iss   , np    ,  cv    ,  inx(8), iny(8), nr
!
      integer     ixa, iya, ixb, iyb, idir, iss, np, nr, inx, iny
      integer, pointer, dimension(:) :: ir
      common /wglxmem/ ir
      real        cv
!
!
!modules
!
      external    wgldrl
!
!*
      real      a, b, c
      integer   i, j, nobit, mot, mct, up, down, right, left
      logical   between
      integer   shiftr, ii, jj, lf2
      integer shift
!
      parameter(up=0,left=1,down=2,right=3)
!
!
!
      between(a,b,c)=(min(a,c).lt.b).and.(max(a,c).ge.b)
      shiftr ( ii, jj ) = ishft ( ii, -jj )
      shift  ( ii, jj ) = ishft ( ii, jj )
!
!
!
!     allocation de memoire ( tableau "ir" ). ce tableau
!     contient des valeurs qui indiquent le chemin de chacune des
!     lignes de contour et sert a memoriser ce chemin afin d'eviter
!     les croisements de lignes de contour .
!
!      print *, 'drlstl_fxfy2',conv
      lf2 = lf
      nr =(m*n / 32)*2 + 2
      allocate(ir(nr))
!
      cv = conv
      do 5 i = 1, nr
5     ir ( irbase + i - 1 ) = 0
!
      do 10 i=mdeb+1,mfin
         if(between(z(i-1,1),cv,z(i,1))) then
            ixa = i - 1
            ixb = i
            iya = 1
            iyb = 1
            idir = up
            call wgldrl_fxfy2(z,px,py,l,m,n,mdeb,ndeb,mfin,nfin,lf2)
         endif
         if(between(z(i,n),cv,z(i-1,n))) then
            ixa = i
            ixb = i - 1
            iya = n
            iyb = n
            idir = down
            call wgldrl_fxfy2(z,px,py,l,m,n,mdeb,ndeb,mfin,nfin,lf2)
         endif
10    continue
!
      do 20 j=ndeb+1, nfin
         if(between(z(m,j-1),cv,z(m,j))) then
            ixa = m
            ixb = m
            iya = j - 1
            iyb = j
            idir = left
            call wgldrl_fxfy2(z,px,py,l,m,n,mdeb,ndeb,mfin,nfin,lf2)
         endif
         if(between(z(1,j),cv,z(1,j-1))) then
            ixa = 1
            ixb = 1
            iya = j
            iyb = j - 1
            idir = right
            call wgldrl_fxfy2(z,px,py,l,m,n,mdeb,ndeb,mfin,nfin,lf2)
         endif
20    continue
!
      do 100 j=ndeb+1,nfin-1
      do 100 i=mdeb,mfin-1
!
         if(between(z(i,j),cv,z(i+1,j))) then
            nobit = lf*((j-1)*(m*(lf+1)-1)+(i-1))
            NOBIT = (M*(J-1) + I-1)
            mot = irbase + nobit/32
            nobit = iand(nobit , 31)
            mct = iand (1 , shiftr ( ir(mot), 31-nobit ))
            if(mct.eq.0)then
               ixa = i
               iya = j
               ixb = i+1
               iyb = j
               idir = up
               call wgldrl_fxfy2(z,px,py,l,m,n,mdeb,ndeb,mfin,nfin,lf2)
            endif
         endif
!
100   continue
!
!     liberation de 500 mots de memoire ( tableau "ir" ) car cet espace
!     reserve est maintenant inutile a la poursuite du tracage des
!     lignes de contour ( sous-routine "conisp" ).
!
      deallocate(ir)
!
      return
      end
