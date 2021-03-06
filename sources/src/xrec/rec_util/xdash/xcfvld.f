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
      SUBROUTINE XCFVLD (IENTRY,IIX,IIY)
*     implicit none
*
*
*
* THE VARIABLES IN DASHD1 ARE USED FOR COMMUNICATION WITH SUBROUTINE
* DASHD.
*
      COMMON /XDASHD1/ ISL,L,ISIZE,IP(155),NWDSTR,IPFLAG(155),MNCSTR
*
* FPART CAN BE USED TO ADJUST THE LENGTH OF THE FIRST PATTERN ELEMENT
*
      COMMON /XDASHD2/ FPART,IPAU,IGP,IOFFS,TENSN,NP,SMALL,L1
*
* THE VARIABLES IN DSAVE1 AND DSAVE2 HAVE TO BE SAVED FOR THE NEXT
* CALL TO CFVLD.
* THE FLAGS IFSTFL AND IVCTFG ARE INITIALIZED IN THE BLOCK DATA DASHBD.
*
      COMMON /XDSAVE1/ X,Y,X2,Y2,X3,Y3,M,BTI,IB,IX,IY
      COMMON /XDSAVE2/ IFSTFL,IVCTFG
*
      EQUIVALENCE (ISIZE,SIZE)
      CHARACTER *15 IPCHA
*
      DATA CMN/1.5/
*
*  ISL= -1  ALL BLANK  ) FLAG TO AVOID MOST CALCULATIONS
*        0  DASHED     )   IF PATTERN IS ALL SOLID OR
*        1  ALL SOLID  )   ALL BLANK
*
*     X,IX,Y,IY    CURRENT POSITION
*     X1,Y1        START OF A USER LINE SEGMENT
*     X2,Y2        END OF A USER LINE SEGMENT
*     X3,Y3        START OF A GAP PATTERN SEGMENT
*
*  SYMBOLS,IF PRESENT ARE CENTERED IN AN IMMEDIATLY PRECEEDING
*     GAP SEGMENT, OR DONE AT THE CURRENT POSITION OTHERWISE
*
*  SEGMENT TYPES ARE RECOGNIZED AS FOLLOWS
*     SOLID - WORD IN IP-ARRAY CONTAINS POSITIVE INTEGER, CORRESPONDING
*             ELEMENT IN IPFLAG IS 1.
*     GAP - WORD IN IP-ARRAY CONTAINS POSITIVE INTEGER, CORRESPONDING
*             ELEMENT IN IPFLAG IS -1.
*     SYMBOL - WORD IN IP-ARRAY CONTAINS CHARACTER REPRESENTATIONS.
*             CORRESPONDING ELEMENT IN IPFLAG IS 0.
*             SYMBOL COUNT FOR CHAR STRING IN CHAR NUMBER MNCSTR+1.
*     THE IP ARRAY AND THE IPFLAG ARRAY ARE COMPOSED OF L ELEMENTS.
*
*     BTI - BITS THIS INCREMENT
*     BPBX,BPBY BITS PER BIT X(Y)
*
      NWDSM1 = NWDSTR - 1
*
      GO TO (330,305,350),IENTRY
*
   30 CONTINUE
      X = IX
      Y = IY
      X2 = X
      X3 = X
      Y2 = Y
      Y3 = Y
      M = 1
      BTI = FLOAT(IP(1))*FPART
      IB = IPFLAG(1)
      IF (IPFLAG(1) .NE. 0) GO TO 40
      IB = 0
      BTI = 0
   40 GO TO 300
*
* MAIN LOOP START
*
   50 CONTINUE
         X1 = X2
         Y1 = Y2
         MX = IIX
         MY = IIY
         X2 = MX
         Y2 = MY
         DX = X2-X1
         DY = Y2-Y1
         D = SQRT(DX*DX+DY*DY)
         IF (D .LT. CMN) GO TO 190
   60    BPBX = DX/D
         BPBY = DY/D
         CALL XPLOTIT (IX,IY,0)
   70    BTI = BTI-D
         IF (BTI) 100,100,80
*
* LINE SEGMENT WILL FIT IN CURRENT PATTERN ELEMENT
*
   80    X = X2
         Y = Y2
         IX = X2
         IY = Y2
         IF (IB) 200,160,90
   90    CALL XPLOTIT (IX,IY,1)
         GO TO 200
*
* LINE SEGMENT WONT FIT IN CURRENT PATTERN ELEMENT
* DO IT TO END OF ELEMENT, SAVE HOW MUCH OF SEGMENT LEFT TO DO (D)
*
  100    BTI = BTI+D
         D = D-BTI
         X = X+BPBX*BTI
         Y = Y+BPBY*BTI
         IX = X+.5
         IY = Y+.5
         IF (IB) 110,160,120
  110    CALL XPLOTIT (IX,IY,0)
         GO TO 130
  120    CALL XPLOTIT (IX,IY,1)
*
* GET THE NEXT PATTERN ELEMENT
*
  130    M = MOD(M,L)+1
         IB = IPFLAG(M)
         IF (IB .NE. 0) BTI = IP(M)
         IF (IB) 140,160,150
  140    X3 = X
         Y3 = Y
         GO TO 70
*
*150  X3 = X
*     Y3 = Y
*
  150    X3 = -1
         GO TO 70
*
* CHARACTER GENERATION
*
  160    S = 0.
         IS = 0
         IS2 = 0
         IF (IGP .EQ. 0) GO TO 162
*V
         DX = X-X3
         DY = Y-Y3
         GO TO 164
*
  162    CONTINUE
         DX = X - X1
         DY = Y - Y1
  164    CONTINUE
*
         IF (DY) 170,180,170
  170    S = ATAN2(DY,DX)
         IS = IFIX(S*180./3.14159265358+.5)
         IS2 = IS
         IF (ABS(IS2).GT.90) IS2 = IS2-SIGN(180,IS2)
*
  180     IF(IGP .EQ. 9) THEN
           MX = X3 + DX*.5
           MY = Y3 + DY*.5
           LIGP = 1
*
       ELSE IF(IGP.EQ.-9) THEN
        IF(ABS(DY).GT.ABS(DX)) THEN
         IS2 = 90
        ELSE
         IS2 = 0
        ENDIF
        MX = X3 + DX*.5
        MY = Y3 + DY*.5
        LIGP = 1
*
          ELSE IF(IGP .EQ. 0) THEN
           MX = X
           MY = Y
           IF (IS.EQ.IS2) THEN
             LIGP = 4
           ELSE
             LIGP = 2
           ENDIF
*
         ELSE
           LIGP = 12
           MX = X3
           MY = Y3
         ENDIF
  184    CONTINUE
         MORG = M
         M = M + NWDSM1
         ICHRCT = IP(MORG+MNCSTR)
            WRITE(IPCHA,'(15A1)') (IP(II),II=MORG,MORG+14)
         if (isize.gt.1024) then
            CALL XPWRIT(MX,MY,IPCHA,ICHRCT,nint(size*8),IS2,LIGP)
	 else
            CALL XPWRIT(MX,MY,IPCHA,ICHRCT,isize,IS2,LIGP)
	 endif
*            CALL XPWRIT(MX,MY,'A',1,30,0,0)
         CALL XPLOTIT (IX,IY,0)
         GO TO 130
  190    X2 = X1
         Y2 = Y1
  200  CONTINUE
*
* EXIT IF CALL WAS TO VECTD.
*
      IF (IVCTFG .NE. 2) GO TO 210
      IVCTFG = 1
      GO TO 300
*
* EXIT IF NOT PLOTTING A GAP
*
  210 IF (IB .GE. 0) GO TO 300
*
* MUST BE IN A GAP AT END OF LASTD. EXIT IF NOT A LABEL GAP.
*
      MO = M
      M = MOD(M,L) + 1
      IF (IPFLAG(M) .NE. 0) GO TO 300
*
* CHECK PREVIOUS PLOTTED ELEMENT. WAS IT A GAP OR A LINE.
*
      MPREV = M - 2
      IF (MPREV .LE. 0) MPREV = MPREV + L
      IB = IPFLAG(MPREV)
      IF (IB .GE. 0) GO TO 250
*
* PREVIOUS ELEMENT WAS A GAP - LOOK FOR NEXT LINE.
* EXIT IF NO LINES IN PATTERN.
*
  230 M = M + NWDSM1
  240 M = MOD(M,L)+1
      IF (M .EQ. MO) GO TO 300
      IB = IPFLAG(M)
      IF  (IB .NE. 0) BTI = IP(M)
*
* IF IP(M) NOT A LINE, CONTINUE LOOKING.
*
      IF (IB) 240,230,280
*
* PREVIOUS ELEMENT WAS A LINE - LOOK FOR NEXT GAP.
* IF NO NON-LABEL GAPS IN PATTERN, GO TO 290.
*
  250 M = M + NWDSM1
  260 M = MOD(M,L)+1
      IF (M .EQ. MO) GO TO 290
      IB = IPFLAG(M)
      IF (IB.NE.0) BTI = IP(M)
*
* IF IP(M) NOT A GAP, CONTINUE LOOKING.
*
      IF (IB) 270,250,260
*
* FOUND A GAP. IF ITS A LABEL GAP, GO LOOK FOR NEXT GAP.
*
  270 MT = M
      M = MOD(M,L)+1
      IF (IPFLAG(M) .EQ. 0) GO TO 250
      M = MT
*
* M POINTS TO NEXT ELEMENT TO PLOT. SET UP AND GO PLOT.
*
  280 X1 = X3
      Y1 = Y3
      X = X3
      Y = Y3
      IX = X+0.5
      IY = Y+0.5
      DX = X2-X1
      DY = Y2-Y1
      D = SQRT(DX*DX+DY*DY)
      IF (D .GE. CMN) GO TO 60
      GO TO 300
*
* NO NON-LABEL GAPS IN THE PATTERN - FILL IN WITH SOLID LINE.
*
  290 IX = X3+0.5
      IY = Y3+0.5
      CALL XPLOTIT (IX,IY,0)
      IX = X2
      IY = Y2
      CALL XPLOTIT (IX,IY,1)
  300 RETURN
*
* ENTRY VECTD (XX,YY)
*
  305 CONTINUE
*
* TEST FOR PREVIOUS CALL TO FRSTD.
*
      IF (IFSTFL .EQ. 2) GO TO 310
*
*
      CALL XULIBER(0,' VECTD    VECTD CALL OCCURS BEFORE A CALL TO FRST
     1D. IT IS TREATED AS A FRSTD CALL.',82)
      GO TO 330
  310 K = 1
      IVCTFG = 2
      IF (ISL) 300,50,320
  320 IX =IIX
      IY = IIY
      CALL XPLOTIT (IX,IY,1)
      GO TO 300
*
*     ENTRY FRSTD (FLDX,FLDY)
*
  330 IX = IIX
      IY = IIY
      IFSTFL = 2
      IF (ISL) 300,30,340
  340 CALL XPLOTIT (IX,IY,0)
      GO TO 300
*
*     ENTRY LASTD
*
  350 CONTINUE
*
* TEST FOR PREVIOUS CALL TO FRSTD
*
      IF (IFSTFL .NE. 2) GO TO 300
      IFSTFL = 1
      K = 1
      IF (ISL .NE. 0) GO TO 300
      GO TO 210
*
      ENTRY XQQQDASH
      CALL XDASHBD
      RETURN
*
      END
