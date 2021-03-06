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
***S/P  XLABMOD    INITIALISE DES PARAMETRES QUI SONT UTILISES PAR LES
*                 ROUTINES DE GRAPHIQUES
*
      SUBROUTINE XLABMOD (IFMTX,IFMTY,NUMX,NUMY,ISIZX,ISIZY,IXDEC,
     %IYDEC,IXOR)
*
*
*AUTEUR   SYSTEME NCAR
*
*REVISION 001  RPN  M.VALIN / C.THIBEAULT  1-8-78  REFAIT DOCUMENTATION
*
*LANGAGE  FORTRAN
*
*OBJET(LABMOD)
*         LA ROUTINE LABMOD DONNE UNE PLUS GRANDE FLEXIBILITE POUR LA
*         PRESENTATION DE GRAPHIQUES.  ELLE NE TRACE PAS MAIS ELLE
*         INITIALISE DES PARAMETRES QUI SONT UTILISES PAR LES ROUTINES
*         QUI TRACENT.
*
*DIRECTIVES(LABMOD)
*
*LIBRAIRIES
*         SOURCE  NEWPLOT106PL,ID=CMCULIB        DECK=LABMOD
*         OBJET   NCARSYSOB,ID=CMCULIB
*
*                     IXOR)
*
*ARGUMENTS
*         IFMTX   CONTIENT LA CONSTRUCTION HOLLERITH D'UN FORMAT POUR
*                 NUMEROTER L'AXE X.  CE FORMAT EST UTILISE PAR LES
*                 ROUTINES GRIDL-PERIML-GRIDAL-HALFAX.  LA CONSTRUCTION
*                 DU FORMAT DOIT COMMENCER ACEC UNE PARENTHESE A GAUCHE
*                 ET SE TERMINER AVEC UNE PARENTHESE A DROITE ET NE DOI
*                 PAS UTILISER PLUS DE 10 CARACTERES.  SEULS LES FORMAT
*                 E ET F SONT PERMIS.
*                 EX:  IFMTX = 6H(F8.2)  OU  IFMTX = 7H(E10.0)
*         IFMTY   CONTIENT LA CONSTRUCTION HOLLERITH D'UN FORMAT POUR
*                 NUMEROTER L'AXE Y.  CE FORMAT EST UTILISE PAR LES
*                 ROUTINES GRIDL-PERIML-GRIDAL-HALFAX.  LA CONSTRUCTION
*                 DU FORMAT DOIT COMMENCER ACEC UNE PARENTHESE A GAUCHE
*                 ET SE TERMINER AVEC UNE PARENTHESE A DROITE ET NE DOI
*                 PAS UTILISER PLUS DE 10 CARACTERES.  SEULS LES FORMAT
*                 E ET F SONT PERMIS.
*                 EX:  IFMTY = 6H(F8.2)  OU  IFMTY = 7H(E10.0)
*         NUMX    LE NOMBRE DE CARACTERES SPECIFIE PAR IFMTX.  DANS
*                 L'EXEMPLE PLUS HAUT NUMX SERAIT DANS LE PREMIER CAS =
*                 ET DANS LE DEUXIEME CAS NUMX SERAIT = 10.
*         NUMY    LE NOMBRE DE CARACTERES SPECIFIE PAR IFMTY.  DANS
*                 L'EXEMPLE PLUS HAUT NUMY SERAIT DANS LE PREMIER CAS =
*                 ET DANS LE DEUXIEME CAS NUMY SERAIT = 10.
*         ISIZX   CODE POUR DETERMINER LA TAILLE DES CARACTERES POUR
*          ET     LES TITRES DE L'AXE X OU Y.  LA TAILLE DES
*         ISIZY   CARACTERES EST CALCULE EN UNITE DE TRACEUR EXCEPTE
*                 SI ISIZX-Y EST <= 3.  DANS CE CAS, LA REGLE SUIVANT
*                 S'APPLIQUE
*                  ISIZX-Y       TAILLE
*                     0             8
*                     1            12
*                     2            16
*                     3            24
*         IXDEC   LA DIMINUTION EN UNITES DE TRACEUR A PARTIR DE LA
*                 POSITION MINX (SPECIFIE PAR LE PREMIER ARGUMENT DE SE
*                 JUSQU'A L'ADRESSE  X DU TITRE SPECIFIE PAR IFMTY, NUM
*                 ET ISIZY.  PAR EXEMPLE, SI LE PREMIER ARGUMENT DE SET
*                 EST .1  MINX EST 102 C'EST-A-DIRE (.1*1024).  SI IXDE
*                 EST 60 LE TITRE SE TERMINERA A 42 C'EST-A-DIRE
*                 (102-60).  POUR PLUS DE FACILITE DANS LES CALCULS LA
*                 CONVENTION SUIVANTE EST UTILISEE.
*         - IXDEC = 0 VA ECRIRE LE TITRE DE L'AXE-Y A LA GAUCHE DE
*                     CELLE-CI EN FAISANT LE CALCUL SUIVANT:  LA
*                     DIMINUTION X = (NUMY+1/2) * TAILLE DU CARACTERE Y
*                     EX:  NUMY=7, ISIZY=2 ET IXDEC=0 LA DIMINUTION EST
*                     EGALE A (7+1/2)*16 = 120
*         - IXDEC = 1 VA ECRIRE LE TITRE DE L'AXE Y A LA DROITE DE
*                     CELLE-CI EN FAISANT LE CALCUL SUIVANT:  LA
*                     DIMINUTION X = -(MAXX-MINX) + TAILLE DU CARACTERE
*                     Y)  AUSSI SI LES DEUX PREMIERS ARGUMENTS DE SET
*                     SONT .1 ET .8 (MAXX,MINX), ISIZY=3 ET IXDEC=1, LA
*                     DIMINUTION X EST
*                     EX   -((.1*1024) - (.8*1024) + 24) = -741
*         IYDEC   LA DIMINUTION EN UNITES DE TRACEUR A PARTIR DE LA
*                 POSITION MINY (SPECIFIE PAR LE TROISIEME ARGUMENT DE
*                 SET) JUSQU'A L'ADRESSE  Y DU TITRE SPECIFIE PAR IFMTX
*                 NUMX ET ISIZX.  PAR EXEMPLE SI LE TROISIEME ARGUMENT
*                 DE SET EST .2 MINY EST .2*1024 = 205.  SI IYDEC = 30
*                 LE TITRE COMMENCERA A 205-30 = 175.  POUR PLUS DE
*                 FACILITE ON OBSERVE LA CONVENTION SUIVANTE.
*         - IYDEC = 0 VA ECRIRE LE TITRE EN BAS DU GRAPHIQUE.  LE CALCU
*                     DEPEND DE L'ORIENTATION DES TITRES DE L'AXE-X
*                     0 OU 90 DEGRE (VOIR IXOR).  POUR IYDEC = 0,
*                     IXOR = 0, LA DIMINUTION EST EGALE A LA TAILLE DU
*                     CARACTERE; PAR EXEMPLE SI ISIZX = 2, LA DIMINUTIO
*                     EST EGALE A 16.  POUR IYDEC = 0, IXOR = 1 LA
*                     DIMINUTION EST EGALE (NUMX+1/2) * TAILLE X DU
*                     CARACTERE.
*         - IYDEC = 1 ET IXOR = 0 OU 1, LES TITRES SERONT ECRIT EN HAUT
*                     DU GRAPHIQUE.  LE CALCUL SUIVANT SERA FAIT.  LA
*                     DIMINUTION Y = -(MAXY-MINY+ TAILLE X DU CARACTERE
*         IXOR    ORIENTATION DES TITRES SUR L'AXE-X
*                   IXOR = 0     NORMALE OU +X
*                   IXOR = 1     90 DEGRES OU +Y
*                 POUR UNE ORIENTATION NORMALE, LES CARACTERES NON-BLAN
*                 SONT CENTRES SOUS LA LIGNE OU LA DIVISION MAJEURE
*                 OU MINEURE AUXQUELS ILS S'APPLIQUENT
*
*IMPLICITES
*         BLOC /SYSPL1/  ***** POUR UNE EXPLICATION DES ARGUMENTS DANS
*                              LE BLOC COMMON SYSPL1 VOIR LA ROUTINE
*                              SYSDAT *****
*
*MODULES  CFORM,ULIBER,P_ERROR
*
*PRECISION
*         SIMPLE
*
*----------------------------------------------------------------------
*
*     implicit none
*     implicit none laisse a off volontairement
      INTEGER SAVUNIT,SEGUNIT,SEGSAVU,PIPEFLG
      LOGICAL MTCLOS,FLCLOS,SAVCLOS,SEGCLOS,SSCLOS,PASDEF
*
      COMMON /XSYSPL1/ MMAJX   ,MMAJY   ,MMINX   ,MMINY
      COMMON /XSYSPL1/ MXLAB   ,MYLAB   ,MFLG   ,MTYPE
      COMMON /XSYSPL1/ MXA   ,MYA   ,MXB   ,MYB
      COMMON /XSYSPL1/ MX   ,MY   ,MTYPEX   ,MTYPEY
      COMMON /XSYSPL1/ XXA   ,YYA   ,XXB   ,YYB
      COMMON /XSYSPL1/ XXC   ,YYC   ,XXD   ,YYD
      COMMON /XSYSPL1/ XFACTR   ,YFACTR   ,XADD   ,YADD
      COMMON /XSYSPL1/ MUMX   ,MUMY   ,MSIZX   ,MSIZY
      COMMON /XSYSPL1/ MXDEC   ,MYDEC   ,MXOR   ,MOP(30,-1:32)
      COMMON /XSYSPL1/ MXOLD   ,MYOLD   ,MXMAX   ,PASDEF(30)
      COMMON /XSYSPL1/ MYMAX   ,MXFAC   ,MYFAC   ,MODEF
      COMMON /XSYSPL1/ MF2ER   ,MSHFTX   ,MSHFTY
      COMMON /XSYSPL1/ MMGRX   ,MMGRY   ,MMNRX   ,MMNRY
      COMMON /XSYSPL1/ MFRCNT   ,MJXMIN   ,MJYMIN   ,MJXMAX
      COMMON /XSYSPL1/ MJYMAX   ,SMALL   ,XX   ,YY
      COMMON /XSYSPL1/ IVAR   ,IMUNIT   ,IPUNIT
      COMMON /XSYSPL1/ NBITS   ,INDEX   ,MBUF(90)
      COMMON /XSYSPL1/ IWIDE(0:3) ,IWCUR   ,PIPEFLG
      COMMON /XSYSPL1/ IFLSHNT   ,IWCURF   ,IWCURS   ,SAVUNIT
      COMMON /XSYSPL1/ MTCLOS   ,FLCLOS   ,SAVCLOS   ,SEGCLOS
      COMMON /XSYSPL1/ IWCSEG   ,SEGUNIT   ,SSCLOS   ,SEGSAVU
      INTEGER MOPRIN(30)
      EQUIVALENCE (MOPRIN(1), MOP(1,-1))
      COMMON /XSYSPL2/ MFMT(2)
      CHARACTER *(20) MFMT
      INTEGER   IDEC(2)   ,I0SHFT(2)
      CHARACTER *(*)   IFMTX,IFMTY
      EQUIVALENCE   (MXDEC,IDEC(1))   ,(MSHFTX,I0SHFT(1))
*
*----------------------------------------------------------------------
*
      MFMT(1) = IFMTX
      MFMT(2) = IFMTY
      MUMX = NUMX
      MUMY = NUMY
      IF( (MAX0(MUMX,MUMY).LE. 20))THEN
         MSIZX = ISIZX
         MSIZY = ISIZY
         MXDEC = IXDEC
         MYDEC = IYDEC
*
         DO 23002   I=1,2
            JDEC=IABS(IDEC(I))
            JDEC=ishft(iand(ishft(-1,-(I0SHFT(I))),JDEC),I0SHFT(I))
            JDEC=ISIGN(JDEC,IDEC(I))
            IF( (IDEC(I) .EQ. 0))THEN
               JDEC = 655
            ENDIF
            IF( (IDEC(I) .EQ. 1))THEN
               JDEC = 0
            ENDIF
            IDEC(I) = JDEC
*
23002    CONTINUE
         MXOR = IXOR
         RETURN
*
*
      ENDIF
      WRITE (IPUNIT,1001) MUMX,MUMY
      CALL XULIBER (0,'0NUMX OR NUMY .GT. 20 IN XLABMOD CALL')
      CALL P_ERROR
*
      RETURN
*
1001  FORMAT ('0NUMX=',I5,' NUMY=',I5)
*
      END
*C*S/P JUSTFY - LEFT JUSTIFY A STRING OF CHARACTERS
*
      SUBROUTINE XJUSTFY (ICHARR,LEN,NEWLEN)
*
*REVISION   M.VALIN/P.JOLICOEUR  NOV,83   CONVERSION-CRAY
*
*OBJET(JUSTFY)
*    JUSTIFIER A GAUCHE UNE CHAINE DE CARACTERES
*
*ARGUMENTS
*     IN    ICHARR     CHAINE DE CARACTERES
*     IN    LEN        GRANDEUR DE LA CHAINE
*     OUT   NEWLEN     ENTIER CONTENANT LES CAR JUSTIFIES A GAUCHE
*
**
*      implicit none
      CHARACTER   *(*)  ICHARR
      CHARACTER *1,CCC
*
      IN = 0
      IF((ICHARR(1:1).EQ. ' '))THEN
         DO 23002 I=1,LEN
            IF((IN.EQ.0.AND.ICHARR(I:I).EQ. ' '))THEN
               GOTO 23002
            ENDIF
            IN=IN+1
            CCC=ICHARR(I:I)
            ICHARR(IN:IN)=CCC
23002    CONTINUE
         NEWLEN=IN
         DO 23006 I=IN+1,LEN
            ICHARR(I:I)= ' '
23006    CONTINUE
*
      ENDIF
      RETURN
      END
      subroutine p_error
      stop
      end
