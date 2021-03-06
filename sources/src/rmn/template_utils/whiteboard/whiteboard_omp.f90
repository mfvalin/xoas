!* Code revision: $Id: whiteboard.tmpl90 955 2014-05-30 18:13:33Z armnlib $
!/* RMNLIB - Library of useful routines for C and FORTRAN programming
! * Copyright (C) 1975-2005  Environnement Canada
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
!copyright (C) 2007  LGPLv2
!**s/r whiteboard.ftn90
!object
!  Fortran Interface to the C implementation of the whiteboard
!  To compile FILENAME.tmpl90:
!     r.tmpl90.ftn90 FILENAME
!     r.compile -src FILENAME.ftn90
!  Interface is avail in FILENAME_interface.cdk90
!author
!  Stephane Chamberland, August 2007
!revision
!  v0_00 -       - initial version
!implicits
!** end of rpn-doc sections
!**s/r CAT(wb_get_,TYPE2CHAR,OMPSUFFIX)
integer function wb_get_i4_omp(key,value,wb) result(status)
  implicit none
!arguments
      type :: whiteboard
        sequence
        integer*8 :: wb
      end type whiteboard
  type(whiteboard),intent(IN),optional :: wb
  integer, intent(OUT) :: value
  character (len=*), intent(IN) :: key
!  wb    : instance of a whiteboard [global WB if not provided]
!  key   : key identifying the whiteboard entry to get
!  value : returned value associated with key
!  status: returned error code: ; use WB_IS_OK(status) to check
!object
!  retrieve a copy of the value associated with key stored in the whiteboard
!  saclar form
!** end of rpn-doc sections
  integer*8 :: my_wb
  integer,external :: f_wb_get
!$omp critical
  my_wb = 0
  if(present(wb)) my_wb = wb%wb
  status = f_wb_get(my_wb, key, 2 , 4 ,value,0)
!$omp end critical
  return
end function
!TODO:
!!$integer function CAT(wb_get_,TYPE2CHAR,_a)(key,value,nbval,status,mode)
!!$  logical, intent(IN),optional :: mode
!**s/r CAT(wb_get_,TYPE2CHAR,OMPSUFFIX)_a
integer function  wb_get_i4_omp_a(key,value,nbval,wb) result(status)
  implicit none
!arguments
      type :: whiteboard
        sequence
        integer*8 :: wb
      end type whiteboard
  type(whiteboard),intent(IN),optional :: wb
  integer, intent(OUT) :: nbval
  integer, dimension(:), intent(OUT) :: value
  character (len=*), intent(IN) :: key
!  wb    : instance of a whiteboard [global WB if not provided]
!  key   : key identifying the whiteboard entry to get
!  value : returned value associated with key
!  nbval : number of returned values in the array
!  status: returned error code; use WB_IS_OK(status) to check
!object
!  retrieve a copy of the value associated with key stored in the whiteboard
!  array form
!** end of rpn-doc sections
  integer*8 :: my_wb
  integer,external :: f_wb_get
!$omp critical
  my_wb = 0
  if(present(wb)) my_wb = wb%wb
  nbval  = 0
  status = f_wb_get(my_wb, key,2,4,value,size(value))
  if ((status >= 0)) nbval = status
!$omp end critical
!TODO: error when not enough room to get all WB values [not the default]
!!$  if present(mode0) then
!!$     if (status > size(value) .and. mode == ERR_ON_SUB_ARRAY) status = WB_ERR_WRONGDIMENSION
!!$  endif
  return
end function
!**s/r CAT(wb_get_,TYPE2CHAR,OMPSUFFIX)
integer function wb_get_i8_omp(key,value,wb) result(status)
  implicit none
!arguments
      type :: whiteboard
        sequence
        integer*8 :: wb
      end type whiteboard
  type(whiteboard),intent(IN),optional :: wb
  integer*8, intent(OUT) :: value
  character (len=*), intent(IN) :: key
!  wb    : instance of a whiteboard [global WB if not provided]
!  key   : key identifying the whiteboard entry to get
!  value : returned value associated with key
!  status: returned error code: ; use WB_IS_OK(status) to check
!object
!  retrieve a copy of the value associated with key stored in the whiteboard
!  saclar form
!** end of rpn-doc sections
  integer*8 :: my_wb
  integer,external :: f_wb_get
!$omp critical
  my_wb = 0
  if(present(wb)) my_wb = wb%wb
  status = f_wb_get(my_wb, key, 2 , 8 ,value,0)
!$omp end critical
  return
end function
!TODO:
!!$integer function CAT(wb_get_,TYPE2CHAR,_a)(key,value,nbval,status,mode)
!!$  logical, intent(IN),optional :: mode
!**s/r CAT(wb_get_,TYPE2CHAR,OMPSUFFIX)_a
integer function  wb_get_i8_omp_a(key,value,nbval,wb) result(status)
  implicit none
!arguments
      type :: whiteboard
        sequence
        integer*8 :: wb
      end type whiteboard
  type(whiteboard),intent(IN),optional :: wb
  integer, intent(OUT) :: nbval
  integer*8, dimension(:), intent(OUT) :: value
  character (len=*), intent(IN) :: key
!  wb    : instance of a whiteboard [global WB if not provided]
!  key   : key identifying the whiteboard entry to get
!  value : returned value associated with key
!  nbval : number of returned values in the array
!  status: returned error code; use WB_IS_OK(status) to check
!object
!  retrieve a copy of the value associated with key stored in the whiteboard
!  array form
!** end of rpn-doc sections
  integer*8 :: my_wb
  integer,external :: f_wb_get
!$omp critical
  my_wb = 0
  if(present(wb)) my_wb = wb%wb
  nbval  = 0
  status = f_wb_get(my_wb, key,2,8,value,size(value))
  if ((status >= 0)) nbval = status
!$omp end critical
!TODO: error when not enough room to get all WB values [not the default]
!!$  if present(mode0) then
!!$     if (status > size(value) .and. mode == ERR_ON_SUB_ARRAY) status = WB_ERR_WRONGDIMENSION
!!$  endif
  return
end function
!**s/r CAT(wb_get_,TYPE2CHAR,OMPSUFFIX)
integer function wb_get_r4_omp(key,value,wb) result(status)
  implicit none
!arguments
      type :: whiteboard
        sequence
        integer*8 :: wb
      end type whiteboard
  type(whiteboard),intent(IN),optional :: wb
  real, intent(OUT) :: value
  character (len=*), intent(IN) :: key
!  wb    : instance of a whiteboard [global WB if not provided]
!  key   : key identifying the whiteboard entry to get
!  value : returned value associated with key
!  status: returned error code: ; use WB_IS_OK(status) to check
!object
!  retrieve a copy of the value associated with key stored in the whiteboard
!  saclar form
!** end of rpn-doc sections
  integer*8 :: my_wb
  integer,external :: f_wb_get
!$omp critical
  my_wb = 0
  if(present(wb)) my_wb = wb%wb
  status = f_wb_get(my_wb, key, 1 , 4 ,value,0)
!$omp end critical
  return
end function
!TODO:
!!$integer function CAT(wb_get_,TYPE2CHAR,_a)(key,value,nbval,status,mode)
!!$  logical, intent(IN),optional :: mode
!**s/r CAT(wb_get_,TYPE2CHAR,OMPSUFFIX)_a
integer function  wb_get_r4_omp_a(key,value,nbval,wb) result(status)
  implicit none
!arguments
      type :: whiteboard
        sequence
        integer*8 :: wb
      end type whiteboard
  type(whiteboard),intent(IN),optional :: wb
  integer, intent(OUT) :: nbval
  real, dimension(:), intent(OUT) :: value
  character (len=*), intent(IN) :: key
!  wb    : instance of a whiteboard [global WB if not provided]
!  key   : key identifying the whiteboard entry to get
!  value : returned value associated with key
!  nbval : number of returned values in the array
!  status: returned error code; use WB_IS_OK(status) to check
!object
!  retrieve a copy of the value associated with key stored in the whiteboard
!  array form
!** end of rpn-doc sections
  integer*8 :: my_wb
  integer,external :: f_wb_get
!$omp critical
  my_wb = 0
  if(present(wb)) my_wb = wb%wb
  nbval  = 0
  status = f_wb_get(my_wb, key,1,4,value,size(value))
  if ((status >= 0)) nbval = status
!$omp end critical
!TODO: error when not enough room to get all WB values [not the default]
!!$  if present(mode0) then
!!$     if (status > size(value) .and. mode == ERR_ON_SUB_ARRAY) status = WB_ERR_WRONGDIMENSION
!!$  endif
  return
end function
!**s/r CAT(wb_get_,TYPE2CHAR,OMPSUFFIX)
integer function wb_get_r8_omp(key,value,wb) result(status)
  implicit none
!arguments
      type :: whiteboard
        sequence
        integer*8 :: wb
      end type whiteboard
  type(whiteboard),intent(IN),optional :: wb
  real*8, intent(OUT) :: value
  character (len=*), intent(IN) :: key
!  wb    : instance of a whiteboard [global WB if not provided]
!  key   : key identifying the whiteboard entry to get
!  value : returned value associated with key
!  status: returned error code: ; use WB_IS_OK(status) to check
!object
!  retrieve a copy of the value associated with key stored in the whiteboard
!  saclar form
!** end of rpn-doc sections
  integer*8 :: my_wb
  integer,external :: f_wb_get
!$omp critical
  my_wb = 0
  if(present(wb)) my_wb = wb%wb
  status = f_wb_get(my_wb, key, 1 , 8 ,value,0)
!$omp end critical
  return
end function
!TODO:
!!$integer function CAT(wb_get_,TYPE2CHAR,_a)(key,value,nbval,status,mode)
!!$  logical, intent(IN),optional :: mode
!**s/r CAT(wb_get_,TYPE2CHAR,OMPSUFFIX)_a
integer function  wb_get_r8_omp_a(key,value,nbval,wb) result(status)
  implicit none
!arguments
      type :: whiteboard
        sequence
        integer*8 :: wb
      end type whiteboard
  type(whiteboard),intent(IN),optional :: wb
  integer, intent(OUT) :: nbval
  real*8, dimension(:), intent(OUT) :: value
  character (len=*), intent(IN) :: key
!  wb    : instance of a whiteboard [global WB if not provided]
!  key   : key identifying the whiteboard entry to get
!  value : returned value associated with key
!  nbval : number of returned values in the array
!  status: returned error code; use WB_IS_OK(status) to check
!object
!  retrieve a copy of the value associated with key stored in the whiteboard
!  array form
!** end of rpn-doc sections
  integer*8 :: my_wb
  integer,external :: f_wb_get
!$omp critical
  my_wb = 0
  if(present(wb)) my_wb = wb%wb
  nbval  = 0
  status = f_wb_get(my_wb, key,1,8,value,size(value))
  if ((status >= 0)) nbval = status
!$omp end critical
!TODO: error when not enough room to get all WB values [not the default]
!!$  if present(mode0) then
!!$     if (status > size(value) .and. mode == ERR_ON_SUB_ARRAY) status = WB_ERR_WRONGDIMENSION
!!$  endif
  return
end function
!**s/r CAT(wb_get_,TYPE2CHAR,OMPSUFFIX)
integer function wb_get_l1_omp(key,value,wb) result(status)
  implicit none
!arguments
      type :: whiteboard
        sequence
        integer*8 :: wb
      end type whiteboard
  type(whiteboard),intent(IN),optional :: wb
  logical, intent(OUT) :: value
  character (len=*), intent(IN) :: key
!  wb    : instance of a whiteboard [global WB if not provided]
!  key   : key identifying the whiteboard entry to get
!  value : returned value associated with key
!  status: returned error code: ; use WB_IS_OK(status) to check
!object
!  retrieve a copy of the value associated with key stored in the whiteboard
!  saclar form
!** end of rpn-doc sections
  integer*8 :: my_wb
  integer,external :: f_wb_get
!$omp critical
  my_wb = 0
  if(present(wb)) my_wb = wb%wb
  status = f_wb_get(my_wb, key, 4 , 1 ,value,0)
!$omp end critical
  return
end function
!TODO:
!!$integer function CAT(wb_get_,TYPE2CHAR,_a)(key,value,nbval,status,mode)
!!$  logical, intent(IN),optional :: mode
!**s/r CAT(wb_get_,TYPE2CHAR,OMPSUFFIX)_a
integer function  wb_get_l1_omp_a(key,value,nbval,wb) result(status)
  implicit none
!arguments
      type :: whiteboard
        sequence
        integer*8 :: wb
      end type whiteboard
  type(whiteboard),intent(IN),optional :: wb
  integer, intent(OUT) :: nbval
  logical, dimension(:), intent(OUT) :: value
  character (len=*), intent(IN) :: key
!  wb    : instance of a whiteboard [global WB if not provided]
!  key   : key identifying the whiteboard entry to get
!  value : returned value associated with key
!  nbval : number of returned values in the array
!  status: returned error code; use WB_IS_OK(status) to check
!object
!  retrieve a copy of the value associated with key stored in the whiteboard
!  array form
!** end of rpn-doc sections
  integer*8 :: my_wb
  integer,external :: f_wb_get
!$omp critical
  my_wb = 0
  if(present(wb)) my_wb = wb%wb
  nbval  = 0
  status = f_wb_get(my_wb, key,4,1,value,size(value))
  if ((status >= 0)) nbval = status
!$omp end critical
!TODO: error when not enough room to get all WB values [not the default]
!!$  if present(mode0) then
!!$     if (status > size(value) .and. mode == ERR_ON_SUB_ARRAY) status = WB_ERR_WRONGDIMENSION
!!$  endif
  return
end function
!**s/r CAT(wb_get_,TYPE2CHAR,OMPSUFFIX)
integer function wb_get_cc_omp(key,value,wb) result(status)
  implicit none
!arguments
      type :: whiteboard
        sequence
        integer*8 :: wb
      end type whiteboard
  type(whiteboard),intent(IN),optional :: wb
  character(len=*), intent(OUT) :: value
  character (len=*), intent(IN) :: key
!  wb    : instance of a whiteboard [global WB if not provided]
!  key   : key identifying the whiteboard entry to get
!  value : returned value associated with key
!  status: returned error code: ; use WB_IS_OK(status) to check
!object
!  retrieve a copy of the value associated with key stored in the whiteboard
!  saclar form
!** end of rpn-doc sections
  integer*8 :: my_wb
  integer,external :: f_wb_get
!$omp critical
  my_wb = 0
  if(present(wb)) my_wb = wb%wb
  status = f_wb_get(my_wb, key, 3 , len(value) ,value,0)
!$omp end critical
  return
end function
!TODO:
!!$integer function CAT(wb_get_,TYPE2CHAR,_a)(key,value,nbval,status,mode)
!!$  logical, intent(IN),optional :: mode
!**s/r CAT(wb_get_,TYPE2CHAR,OMPSUFFIX)_a
integer function  wb_get_cc_omp_a(key,value,nbval,wb) result(status)
  implicit none
!arguments
      type :: whiteboard
        sequence
        integer*8 :: wb
      end type whiteboard
  type(whiteboard),intent(IN),optional :: wb
  integer, intent(OUT) :: nbval
  character(len=*), dimension(:), intent(OUT) :: value
  character (len=*), intent(IN) :: key
!  wb    : instance of a whiteboard [global WB if not provided]
!  key   : key identifying the whiteboard entry to get
!  value : returned value associated with key
!  nbval : number of returned values in the array
!  status: returned error code; use WB_IS_OK(status) to check
!object
!  retrieve a copy of the value associated with key stored in the whiteboard
!  array form
!** end of rpn-doc sections
  integer*8 :: my_wb
  integer,external :: f_wb_get
!$omp critical
  my_wb = 0
  if(present(wb)) my_wb = wb%wb
  nbval  = 0
  status = f_wb_get(my_wb, key,3,len(value),value,size(value))
  if ((status >= 0)) nbval = status
!$omp end critical
!TODO: error when not enough room to get all WB values [not the default]
!!$  if present(mode0) then
!!$     if (status > size(value) .and. mode == ERR_ON_SUB_ARRAY) status = WB_ERR_WRONGDIMENSION
!!$  endif
  return
end function
!**s/r CAT(wb_put_,TYPE2CHAR,OMPSUFFIX)
integer function wb_put_i4_omp(key,value,options0,wb) result(status)
  implicit none
!arguments
      type :: whiteboard
        sequence
        integer*8 :: wb
      end type whiteboard
  type(whiteboard),intent(IN),optional :: wb
  integer, intent(IN),optional  :: options0
  integer, intent(IN) :: value
  character (len=*), intent(IN) :: key
!  wb     : instance of a whiteboard [global WB if not provided]
!  key    : key identifying the whiteboard entry to set
!  value  : value associated with key
!  options: define if value is REWRITEABLE or not
!  status : returned error code; use WB_IS_OK(status) to check
!object
!  save a copy of the value in the whiteboard associated with a key name
!  scalar form
!** end of rpn-doc sections
  integer*8 :: my_wb
  integer :: options
  integer,external :: f_wb_put
  integer,external :: omp_get_num_threads
  if (omp_get_num_threads() > 1) then
     status = -1
     return
  endif
  options = 256
  if (present(options0)) options = options0
  my_wb = 0
  if(present(wb)) my_wb = wb%wb
 status = f_wb_put(my_wb,key,2,4,value,0,options)
  return
end function
!**s/r CAT(wb_put_,TYPE2CHAR,_a,OMPSUFFIX)
integer function wb_put_i4_a_omp(key,value,options0,wb) result(status)
  implicit none
!arguments
      type :: whiteboard
        sequence
        integer*8 :: wb
      end type whiteboard
  type(whiteboard),intent(IN),optional :: wb
  integer, intent(IN),optional :: options0
  integer, dimension(:), intent(IN) :: value
  character(len=*), intent(IN) :: key
!  wb     : instance of a whiteboard [global WB if not provided]
!  key    : key identifying the whiteboard entry to set
!  value  : value associated with key
!  options: define if value is REWRITEABLE or not
!  status : returned error code; use WB_IS_OK(status) to check
!object
!  save a copy of the values in the whiteboard associated with a key name
!  array form
!** end of rpn-doc sections
  integer*8 :: my_wb
  integer :: options
  integer,external :: f_wb_put
  integer,external :: omp_get_num_threads
  if (omp_get_num_threads() > 1) then
     status = -1
     return
  endif
  if (size(value) .eq. 0) then
     status = -1
     return
  endif
  options = 256
  if (present(options0)) options = options0
  my_wb = 0
  if(present(wb)) my_wb = wb%wb
  status = f_wb_put(my_wb,key,2,4,value,size(value),options)
  return
end function
!**s/r CAT(wb_put_,TYPE2CHAR,OMPSUFFIX)
integer function wb_put_i8_omp(key,value,options0,wb) result(status)
  implicit none
!arguments
      type :: whiteboard
        sequence
        integer*8 :: wb
      end type whiteboard
  type(whiteboard),intent(IN),optional :: wb
  integer, intent(IN),optional  :: options0
  integer*8, intent(IN) :: value
  character (len=*), intent(IN) :: key
!  wb     : instance of a whiteboard [global WB if not provided]
!  key    : key identifying the whiteboard entry to set
!  value  : value associated with key
!  options: define if value is REWRITEABLE or not
!  status : returned error code; use WB_IS_OK(status) to check
!object
!  save a copy of the value in the whiteboard associated with a key name
!  scalar form
!** end of rpn-doc sections
  integer*8 :: my_wb
  integer :: options
  integer,external :: f_wb_put
  integer,external :: omp_get_num_threads
  if (omp_get_num_threads() > 1) then
     status = -1
     return
  endif
  options = 256
  if (present(options0)) options = options0
  my_wb = 0
  if(present(wb)) my_wb = wb%wb
 status = f_wb_put(my_wb,key,2,8,value,0,options)
  return
end function
!**s/r CAT(wb_put_,TYPE2CHAR,_a,OMPSUFFIX)
integer function wb_put_i8_a_omp(key,value,options0,wb) result(status)
  implicit none
!arguments
      type :: whiteboard
        sequence
        integer*8 :: wb
      end type whiteboard
  type(whiteboard),intent(IN),optional :: wb
  integer, intent(IN),optional :: options0
  integer*8, dimension(:), intent(IN) :: value
  character(len=*), intent(IN) :: key
!  wb     : instance of a whiteboard [global WB if not provided]
!  key    : key identifying the whiteboard entry to set
!  value  : value associated with key
!  options: define if value is REWRITEABLE or not
!  status : returned error code; use WB_IS_OK(status) to check
!object
!  save a copy of the values in the whiteboard associated with a key name
!  array form
!** end of rpn-doc sections
  integer*8 :: my_wb
  integer :: options
  integer,external :: f_wb_put
  integer,external :: omp_get_num_threads
  if (omp_get_num_threads() > 1) then
     status = -1
     return
  endif
  if (size(value) .eq. 0) then
     status = -1
     return
  endif
  options = 256
  if (present(options0)) options = options0
  my_wb = 0
  if(present(wb)) my_wb = wb%wb
  status = f_wb_put(my_wb,key,2,8,value,size(value),options)
  return
end function
!**s/r CAT(wb_put_,TYPE2CHAR,OMPSUFFIX)
integer function wb_put_r4_omp(key,value,options0,wb) result(status)
  implicit none
!arguments
      type :: whiteboard
        sequence
        integer*8 :: wb
      end type whiteboard
  type(whiteboard),intent(IN),optional :: wb
  integer, intent(IN),optional  :: options0
  real, intent(IN) :: value
  character (len=*), intent(IN) :: key
!  wb     : instance of a whiteboard [global WB if not provided]
!  key    : key identifying the whiteboard entry to set
!  value  : value associated with key
!  options: define if value is REWRITEABLE or not
!  status : returned error code; use WB_IS_OK(status) to check
!object
!  save a copy of the value in the whiteboard associated with a key name
!  scalar form
!** end of rpn-doc sections
  integer*8 :: my_wb
  integer :: options
  integer,external :: f_wb_put
  integer,external :: omp_get_num_threads
  if (omp_get_num_threads() > 1) then
     status = -1
     return
  endif
  options = 256
  if (present(options0)) options = options0
  my_wb = 0
  if(present(wb)) my_wb = wb%wb
 status = f_wb_put(my_wb,key,1,4,value,0,options)
  return
end function
!**s/r CAT(wb_put_,TYPE2CHAR,_a,OMPSUFFIX)
integer function wb_put_r4_a_omp(key,value,options0,wb) result(status)
  implicit none
!arguments
      type :: whiteboard
        sequence
        integer*8 :: wb
      end type whiteboard
  type(whiteboard),intent(IN),optional :: wb
  integer, intent(IN),optional :: options0
  real, dimension(:), intent(IN) :: value
  character(len=*), intent(IN) :: key
!  wb     : instance of a whiteboard [global WB if not provided]
!  key    : key identifying the whiteboard entry to set
!  value  : value associated with key
!  options: define if value is REWRITEABLE or not
!  status : returned error code; use WB_IS_OK(status) to check
!object
!  save a copy of the values in the whiteboard associated with a key name
!  array form
!** end of rpn-doc sections
  integer*8 :: my_wb
  integer :: options
  integer,external :: f_wb_put
  integer,external :: omp_get_num_threads
  if (omp_get_num_threads() > 1) then
     status = -1
     return
  endif
  if (size(value) .eq. 0) then
     status = -1
     return
  endif
  options = 256
  if (present(options0)) options = options0
  my_wb = 0
  if(present(wb)) my_wb = wb%wb
  status = f_wb_put(my_wb,key,1,4,value,size(value),options)
  return
end function
!**s/r CAT(wb_put_,TYPE2CHAR,OMPSUFFIX)
integer function wb_put_r8_omp(key,value,options0,wb) result(status)
  implicit none
!arguments
      type :: whiteboard
        sequence
        integer*8 :: wb
      end type whiteboard
  type(whiteboard),intent(IN),optional :: wb
  integer, intent(IN),optional  :: options0
  real*8, intent(IN) :: value
  character (len=*), intent(IN) :: key
!  wb     : instance of a whiteboard [global WB if not provided]
!  key    : key identifying the whiteboard entry to set
!  value  : value associated with key
!  options: define if value is REWRITEABLE or not
!  status : returned error code; use WB_IS_OK(status) to check
!object
!  save a copy of the value in the whiteboard associated with a key name
!  scalar form
!** end of rpn-doc sections
  integer*8 :: my_wb
  integer :: options
  integer,external :: f_wb_put
  integer,external :: omp_get_num_threads
  if (omp_get_num_threads() > 1) then
     status = -1
     return
  endif
  options = 256
  if (present(options0)) options = options0
  my_wb = 0
  if(present(wb)) my_wb = wb%wb
 status = f_wb_put(my_wb,key,1,8,value,0,options)
  return
end function
!**s/r CAT(wb_put_,TYPE2CHAR,_a,OMPSUFFIX)
integer function wb_put_r8_a_omp(key,value,options0,wb) result(status)
  implicit none
!arguments
      type :: whiteboard
        sequence
        integer*8 :: wb
      end type whiteboard
  type(whiteboard),intent(IN),optional :: wb
  integer, intent(IN),optional :: options0
  real*8, dimension(:), intent(IN) :: value
  character(len=*), intent(IN) :: key
!  wb     : instance of a whiteboard [global WB if not provided]
!  key    : key identifying the whiteboard entry to set
!  value  : value associated with key
!  options: define if value is REWRITEABLE or not
!  status : returned error code; use WB_IS_OK(status) to check
!object
!  save a copy of the values in the whiteboard associated with a key name
!  array form
!** end of rpn-doc sections
  integer*8 :: my_wb
  integer :: options
  integer,external :: f_wb_put
  integer,external :: omp_get_num_threads
  if (omp_get_num_threads() > 1) then
     status = -1
     return
  endif
  if (size(value) .eq. 0) then
     status = -1
     return
  endif
  options = 256
  if (present(options0)) options = options0
  my_wb = 0
  if(present(wb)) my_wb = wb%wb
  status = f_wb_put(my_wb,key,1,8,value,size(value),options)
  return
end function
!**s/r CAT(wb_put_,TYPE2CHAR,OMPSUFFIX)
integer function wb_put_l1_omp(key,value,options0,wb) result(status)
  implicit none
!arguments
      type :: whiteboard
        sequence
        integer*8 :: wb
      end type whiteboard
  type(whiteboard),intent(IN),optional :: wb
  integer, intent(IN),optional  :: options0
  logical, intent(IN) :: value
  character (len=*), intent(IN) :: key
!  wb     : instance of a whiteboard [global WB if not provided]
!  key    : key identifying the whiteboard entry to set
!  value  : value associated with key
!  options: define if value is REWRITEABLE or not
!  status : returned error code; use WB_IS_OK(status) to check
!object
!  save a copy of the value in the whiteboard associated with a key name
!  scalar form
!** end of rpn-doc sections
  integer*8 :: my_wb
  integer :: options
  integer,external :: f_wb_put
  integer,external :: omp_get_num_threads
  if (omp_get_num_threads() > 1) then
     status = -1
     return
  endif
  options = 256
  if (present(options0)) options = options0
  my_wb = 0
  if(present(wb)) my_wb = wb%wb
 status = f_wb_put(my_wb,key,4,1,value,0,options)
  return
end function
!**s/r CAT(wb_put_,TYPE2CHAR,_a,OMPSUFFIX)
integer function wb_put_l1_a_omp(key,value,options0,wb) result(status)
  implicit none
!arguments
      type :: whiteboard
        sequence
        integer*8 :: wb
      end type whiteboard
  type(whiteboard),intent(IN),optional :: wb
  integer, intent(IN),optional :: options0
  logical, dimension(:), intent(IN) :: value
  character(len=*), intent(IN) :: key
!  wb     : instance of a whiteboard [global WB if not provided]
!  key    : key identifying the whiteboard entry to set
!  value  : value associated with key
!  options: define if value is REWRITEABLE or not
!  status : returned error code; use WB_IS_OK(status) to check
!object
!  save a copy of the values in the whiteboard associated with a key name
!  array form
!** end of rpn-doc sections
  integer*8 :: my_wb
  integer :: options
  integer,external :: f_wb_put
  integer,external :: omp_get_num_threads
  if (omp_get_num_threads() > 1) then
     status = -1
     return
  endif
  if (size(value) .eq. 0) then
     status = -1
     return
  endif
  options = 256
  if (present(options0)) options = options0
  my_wb = 0
  if(present(wb)) my_wb = wb%wb
  status = f_wb_put(my_wb,key,4,1,value,size(value),options)
  return
end function
!**s/r CAT(wb_put_,TYPE2CHAR,OMPSUFFIX)
integer function wb_put_cc_omp(key,value,options0,wb) result(status)
  implicit none
!arguments
      type :: whiteboard
        sequence
        integer*8 :: wb
      end type whiteboard
  type(whiteboard),intent(IN),optional :: wb
  integer, intent(IN),optional  :: options0
  character(len=*), intent(IN) :: value
  character (len=*), intent(IN) :: key
!  wb     : instance of a whiteboard [global WB if not provided]
!  key    : key identifying the whiteboard entry to set
!  value  : value associated with key
!  options: define if value is REWRITEABLE or not
!  status : returned error code; use WB_IS_OK(status) to check
!object
!  save a copy of the value in the whiteboard associated with a key name
!  scalar form
!** end of rpn-doc sections
  integer*8 :: my_wb
  integer :: options
  integer,external :: f_wb_put
  integer,external :: omp_get_num_threads
  if (omp_get_num_threads() > 1) then
     status = -1
     return
  endif
  options = 256
  if (present(options0)) options = options0
  my_wb = 0
  if(present(wb)) my_wb = wb%wb
 status = f_wb_put(my_wb,key,3,len(value),value,0,options)
  return
end function
!**s/r CAT(wb_put_,TYPE2CHAR,_a,OMPSUFFIX)
integer function wb_put_cc_a_omp(key,value,options0,wb) result(status)
  implicit none
!arguments
      type :: whiteboard
        sequence
        integer*8 :: wb
      end type whiteboard
  type(whiteboard),intent(IN),optional :: wb
  integer, intent(IN),optional :: options0
  character(len=*), dimension(:), intent(IN) :: value
  character(len=*), intent(IN) :: key
!  wb     : instance of a whiteboard [global WB if not provided]
!  key    : key identifying the whiteboard entry to set
!  value  : value associated with key
!  options: define if value is REWRITEABLE or not
!  status : returned error code; use WB_IS_OK(status) to check
!object
!  save a copy of the values in the whiteboard associated with a key name
!  array form
!** end of rpn-doc sections
  integer*8 :: my_wb
  integer :: options
  integer,external :: f_wb_put
  integer,external :: omp_get_num_threads
  if (omp_get_num_threads() > 1) then
     status = -1
     return
  endif
  if (size(value) .eq. 0) then
     status = -1
     return
  endif
  options = 256
  if (present(options0)) options = options0
  my_wb = 0
  if(present(wb)) my_wb = wb%wb
  status = f_wb_put(my_wb,key,3,len(value),value,size(value),options)
  return
end function
!**s/r wb_read -- Read a dictionary or namelist into the whiteboard
integer function wb_read_omp(prefix_name,file,section,mode,wb) result(status)
  implicit none
!arguments
      type :: whiteboard
        sequence
        integer*8 :: wb
      end type whiteboard
  type(whiteboard),intent(IN),optional :: wb
  character(len=*), intent(in) :: prefix_name
  character(len=*), intent(in) :: file
  character(len=*), intent(in) :: section
  integer, intent(in) :: mode
!  wb     : instance of a whiteboard [global WB if not provided]
!  prefix_name : prefix to add to var name found in the config file as WB keyname
!  file    : config filename to read
!  section : section name to read in the config file
!  mode    : parsing mode of the config file [WB_ALLOW_DEFINE...]
!object
!  Read a dictionary or namelist into the whiteboard
!** end of rpn-doc sections
  integer*8 :: my_wb
  integer,external :: f_wb_read
  integer,external :: omp_get_num_threads
  if (omp_get_num_threads() > 1) then
     status = -1
     return
  endif
  my_wb = 0
  if(present(wb)) my_wb = wb%wb
  status = f_wb_read(my_wb,prefix_name,file,section,mode)
return
end function
!**s/r wb_keys -- 
integer function wb_keys_omp(keys,nkeys,key_pattern,wb) result(status)
  implicit none
!arguments
      type :: whiteboard
        sequence
        integer*8 :: wb
      end type whiteboard
  type(whiteboard),intent(IN),optional :: wb
  character(len=*), intent(in) :: key_pattern
  integer, intent(out) :: nkeys
  character(len=*), intent(out) :: keys(:)
!  wb     : instance of a whiteboard [global WB if not provided]
!  keys  : list of found WB key names that start with key_pattern
!  nkeys : number of found key name
!  key_pattern : key prefix to match against
!object
!  retreive all key names in the wahitboard starting with key_pattern
!** end of rpn-doc sections
  integer*8 :: my_wb
  integer,external :: f_wb_get_keys
!$omp critical
  my_wb = 0
  if(present(wb)) my_wb = wb%wb
  nkeys = f_wb_get_keys(my_wb,keys,size(keys),key_pattern)
  status = nkeys
!$omp endcritical
end function
!**s/r wb_get_meta -- 
integer function wb_get_meta_omp(key,type1,typelen,array_size,options,wb) result(status)
  implicit none
!arguments
      type :: whiteboard
        sequence
        integer*8 :: wb
      end type whiteboard
  type(whiteboard),intent(IN),optional :: wb
  character(len=*), intent(in) :: key
  integer, intent(out) :: type1,typelen,array_size,options
!  wb     : instance of a whiteboard [global WB if not provided]
!  key    : string identifying the whiteboard entry to get meta from
!  type1  : fortran type [WB_FORTRAN_*] 
!  typelen: lenght of the fortran type [4,8,len(string)]
!  array_size: number of elements in the array; 0=scalar
!  options: as they are set in by the put
!  status : returned error code; use WB_IS_OK(status) to check
!object
!  Retreive meta data of WB entry conresponding to provided key name
!** end of rpn-doc sections
  integer*8 :: my_wb
  integer,external :: f_wb_get_meta
!$omp critical
  my_wb = 0
  if(present(wb)) my_wb = wb%wb
  status = f_wb_get_meta(my_wb,key,type1,typelen,array_size,options)
!$omp end critical
end function
!**s/r wb_checkpoint -- 
integer function wb_checkpoint_setname_omp(filename) result(status)
  implicit none
!arguments
  character(len=*),intent(in) :: filename
!  filename : name of the wb checkpoint file
!  status : returned error code; use WB_IS_OK(status) to check
!object
!  Set the name of the checkpoint file
!** end of rpn-doc sections
  integer,external :: f_wb_checkpoint_name
  status = f_wb_checkpoint_name(filename)
end function 
!**s/r wb_checkpoint -- 
integer function wb_checkpoint_getname_omp(filename) result(status)
  implicit none
!arguments
  character(len=*),intent(out) :: filename
!  filename : name of the wb checkpoint file
!  status : returned error code; use WB_IS_OK(status) to check
!object
!  Get the name of the checkpoint file
!** end of rpn-doc sections
  integer,external :: f_wb_checkpoint_get_name
  status = f_wb_checkpoint_get_name(filename)
end function 
!**s/r wb_checkpoint -- 
integer function wb_checkpoint_omp(wb) result(status)
  implicit none
!arguments
      type :: whiteboard
        sequence
        integer*8 :: wb
      end type whiteboard
  type(whiteboard),intent(IN),optional :: wb
!  wb     : instance of a whiteboard [global WB if not provided]
!  status : returned error code; use WB_IS_OK(status) to check
!object
!  Save a copy of the whiteboard to disk for re-start purpose
!** end of rpn-doc sections
  integer*8 :: my_wb
  integer,external :: f_wb_checkpoint
  integer,external :: omp_get_num_threads
  if (omp_get_num_threads() > 1) then
     status = -1
     return
  endif
  my_wb = 0
  if(present(wb)) my_wb = wb%wb
  status = f_wb_checkpoint(my_wb)
end function 
!TODO: may want to remove this and do an auto reload on 1st WB fn call
!**s/r wb_reload -- 
integer function wb_reload_omp(wb) result(status)
  implicit none
!arguments
      type :: whiteboard
        sequence
        integer*8 :: wb
      end type whiteboard
  type(whiteboard),intent(IN),optional :: wb
!  wb     : instance of a whiteboard [global WB if not provided]
!  status : returned error code; use WB_IS_OK(status) to check
!object
!  Force a reload of the saved copy of the whiteboard, if ant,
!  as written by wb_checkpoint; normally done first thing on re-start
!** end of rpn-doc sections
  integer*8 :: my_wb
  integer,external :: f_wb_reload
  integer,external :: omp_get_num_threads
  if (omp_get_num_threads() > 1) then
     status = -1
     return
  endif
  my_wb = 0
  if(present(wb)) my_wb = wb%wb
  status = f_wb_reload(my_wb)
end function
!**s/r wb_check -- 
integer function wb_check_omp(prefix_match,instatus,wb) result(status)
  implicit none
!arguments
      type :: whiteboard
        sequence
        integer*8 :: wb
      end type whiteboard
  type(whiteboard),intent(IN),optional :: wb
  character(len=*),intent(in) :: prefix_match
  integer, intent(in) :: instatus
!  wb     : instance of a whiteboard [global WB if not provided]
!  prefix_match : prefix string to match to WB entry key name
!  instatus: status code to check for
!  status  : number of entries that match instatus; error if <0
!object
!  Check all whiteboard entry for the gien instatus, 
!  return number of entries that match
!** end of rpn-doc sections
  integer*8 :: my_wb
  integer,external :: f_wb_check
!$omp critical
  my_wb = 0
  if(present(wb)) my_wb = wb%wb
  status = f_wb_check(my_wb,prefix_match,instatus)
!$omp end critical
end function
!**s/r wb_lock -- 
integer function wb_lock_omp(prefix_match,wb) result(status)
  implicit none
!arguments
      type :: whiteboard
        sequence
        integer*8 :: wb
      end type whiteboard
  type(whiteboard),intent(IN),optional :: wb
  character(len=*), intent(in) :: prefix_match
!  wb     : instance of a whiteboard [global WB if not provided]
!  prefix_match : prefix string to match to WB entry key name
!  status : returned error code; use WB_IS_OK(status) to check
!object
!  Set all whiteboard entry to WB_REWRITE_NONE if and only if
!  - key name start with prefix_match
!  - status is WB_REWRITE_UNTIL
!  normally done after a wb_read of a config file
!** end of rpn-doc sections
  integer*8 :: my_wb
  integer,external :: f_wb_lock
  integer,external :: omp_get_num_threads
  if (omp_get_num_threads() > 1) then
     status = -1
     return
  endif
  my_wb = 0
  if(present(wb)) my_wb = wb%wb
  status = f_wb_lock(my_wb,prefix_match)
end function
!**s/r wb_error_handler
integer function wb_error_handler_omp(handler_function) result(status)
  implicit none
!arguments
  external :: handler_function
!  handler_function : "pointer" to an external subroutine
!  status : returned error code; use WB_IS_OK(status) to check
!object
!  provide a function to call by the whiteboard upon error
!  the handler_function should have the following form:
!     subtroutine handler_function(error_severity,error_code)
!       integer, intent(in) :: error_severity,error_code
!** end of rpn-doc sections
  integer,external :: omp_get_num_threads
  if (omp_get_num_threads() > 1) then
     status = -1
     return
  endif
  status = 0
  call f_wb_error_handler(handler_function)
end function
!**s/r wb_broadcast_init
integer function wb_broadcast_init_omp(pe_root,pe_me,domain,bcst_function,allreduce_function) result(status)
  implicit none
!arguments
  integer, intent(in) :: pe_root,pe_me
  character(len=*) :: domain
  external :: bcst_function, allreduce_function
!  pe_root : root procesor number to braodcast from
!  pe_me   : actual procesor number
!  domain  : communicator "domain" to broadcast to
!  bcst_function     : "pointer" to an mpi-like broadcast function
!  allreduce_function: "pointer" to an mpi-like allreduce function
!  status : returned error code; use WB_IS_OK(status) to check
!object
!  broadcast
!** end of rpn-doc sections
  integer,external :: omp_get_num_threads
  if (omp_get_num_threads() > 1) then
     status = -1
     return
  endif
  status = 0
  call f_wb_bcst_init(bcst_function,allreduce_function)
end function
!**s/r wb_broadcast
integer function wb_broadcast_omp(key,ispattern,wb) result(status)
  implicit none
!arguments
      type :: whiteboard
        sequence
        integer*8 :: wb
      end type whiteboard
  type(whiteboard),intent(IN),optional :: wb
  character(len=*),intent(in)   :: key
  integer, intent(in), optional :: ispattern
!  wb     : instance of a whiteboard [global WB if not provided]
!  key       : string identifying the whiteboard entry to broadcast
!  ispattern : if .ne. 0: key is a pattern to match
!  status : returned error code; use WB_IS_OK(status) to check
!object
!  broadcast
!** end of rpn-doc sections
  integer*8 :: my_wb
  integer :: ispattern0
  integer,external :: f_wb_bcst
  integer,external :: omp_get_num_threads
  if (omp_get_num_threads() > 1) then
     status = -1
     return
  endif
  my_wb = 0
  if(present(wb)) my_wb = wb%wb
  ispattern0 = 0
  if (present(ispattern)) ispattern0 = ispattern
  status = f_wb_bcst(my_wb,key,ispattern0)
end function
!**s/r wb_verbosity
integer function wb_verbosity_omp(level) result(status)
  implicit none
!arguments
  integer, intent(in) :: level
!  level  : verbosity level
!  status : returned error code; use WB_IS_OK(status) to check
!object
!  Set the wb verbosity level
!** end of rpn-doc sections
  integer,external :: f_wb_verbosity
  integer,external :: omp_get_num_threads
  if (omp_get_num_threads() > 1) then
     status = -1
     return
  endif
  status = f_wb_verbosity(level)
end function
!**s/r wb_new
integer function wb_new_omp(wb) result(status)
  implicit none
!arguments
      type :: whiteboard
        sequence
        integer*8 :: wb
      end type whiteboard
  type(whiteboard),intent(OUT) :: wb
!  wb     : instance of a whiteboard
!  status : returned error code; use WB_IS_OK(status) to check
!object
!  Create a new whiteboard instance
!** end of rpn-doc sections
  integer,external :: f_wb_new
  integer,external :: omp_get_num_threads
  if (omp_get_num_threads() > 1) then
     status = -1
     return
  endif
  status = f_wb_new(wb%wb)
end function
!**s/r wb_free
integer function wb_free_omp(wb) result(status)
  implicit none
!arguments
      type :: whiteboard
        sequence
        integer*8 :: wb
      end type whiteboard
  type(whiteboard),intent(INOUT) :: wb
!  wb     : instance of a whiteboard
!  status : returned error code; use WB_IS_OK(status) to check
!object
!  Delete a whiteboard instance
!** end of rpn-doc sections
  integer,external :: f_wb_free
  integer,external :: omp_get_num_threads
  if (omp_get_num_threads() > 1) then
     status = -1
     return
  endif
  status = f_wb_free(wb%wb)
end function
