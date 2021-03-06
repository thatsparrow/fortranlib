! Stokes vector related routines
!
! ------------------------------------------------------------------------------
! Copyright (c) 2009-13, Thomas P. Robitaille
!
! All rights reserved.
!
! Redistribution and use in source and binary forms, with or without
! modification, are permitted provided that the following conditions are met:
!
!  * Redistributions of source code must retain the above copyright notice, this
!    list of conditions and the following disclaimer.
!
!  * Redistributions in binary form must reproduce the above copyright notice,
!    this list of conditions and the following disclaimer in the documentation
!    and/or other materials provided with the distribution.
!
! THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
! AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
! IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
! DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
! FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
! DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
! SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
! CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
! OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
! OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
! ------------------------------------------------------------------------------

module type_stokes

  implicit none
  save

  private

  integer,parameter :: sp = selected_real_kind(p=6,r=37)
  integer,parameter :: dp = selected_real_kind(p=15,r=307)

  public :: stokes_dp
  type stokes_dp
     real(dp) :: I,U,Q,V
  end type stokes_dp

  public :: stokes_sp
  type stokes_sp
     real(sp) :: I,U,Q,V
  end type stokes_sp

  public :: operator(+)
  interface operator(+)
     module procedure add_stokes_sp
     module procedure add_stokes_dp
  end interface operator(+)

  public :: operator(-)
  interface operator(-)
     module procedure sub_stokes_sp
     module procedure sub_stokes_dp
  end interface operator(-)

  public :: operator(*)
  interface operator(*)
     module procedure scalar_stokes_mult_sp,stokes_scalar_mult_sp,stokes_stokes_mult_sp
     module procedure scalar_stokes_mult_dp,stokes_scalar_mult_dp,stokes_stokes_mult_dp
  end interface operator(*)

  public :: operator(/)
  interface operator(/)
     module procedure scalar_stokes_div_sp,stokes_scalar_div_sp
     module procedure scalar_stokes_div_dp,stokes_scalar_div_dp
  end interface operator(/)

  public :: operator(**)
  interface operator(**)
     module procedure pow_stokes_sp
     module procedure pow_stokes_dp
  end interface operator(**)

contains

  !!@FOR real(sp):sp real(dp):dp

  !**********************************************************************!
  ! Stokes addition
  !**********************************************************************!

  type(stokes_<T>) function add_stokes_<T>(a,b) result(s)

    implicit none

    type(stokes_<T>),intent(in) :: a,b

    s%I = a%I + b%I
    s%Q = a%Q + b%Q
    s%U = a%U + b%U
    s%V = a%V + b%V

  end function add_stokes_<T>

  !**********************************************************************!
  ! Stokes subtraction
  !**********************************************************************!

  type(stokes_<T>) function sub_stokes_<T>(a,b) result(s)

    implicit none

    type(stokes_<T>),intent(in) :: a,b

    s%I = a%I - b%I
    s%Q = a%Q - b%Q
    s%U = a%U - b%U
    s%V = a%V - b%V

  end function sub_stokes_<T>

  !**********************************************************************!
  ! Scalar * Stokes
  !**********************************************************************!

  type(stokes_<T>) function scalar_stokes_mult_<T>(a,b) result(s)

    implicit none

    @T,intent(in)               :: a
    type(stokes_<T>),intent(in) :: b

    s%I = a * b%I
    s%Q = a * b%Q
    s%U = a * b%U
    s%V = a * b%V

  end function scalar_stokes_mult_<T>

  type(stokes_<T>) function stokes_scalar_mult_<T>(a,b) result(s)

    implicit none

    type(stokes_<T>),intent(in) :: a
    @T,intent(in)               :: b

    s%I = a%I * b
    s%Q = a%Q * b
    s%U = a%U * b
    s%V = a%V * b

  end function stokes_scalar_mult_<T>

    type(stokes_<T>) function stokes_stokes_mult_<T>(a,b) result(s)

    implicit none

    type(stokes_<T>),intent(in) :: a, b

    s%I = a%I * b%I
    s%Q = a%Q * b%Q
    s%U = a%U * b%U
    s%V = a%V * b%V

  end function stokes_stokes_mult_<T>

  !**********************************************************************!
  ! Scalar / Stokes
  !**********************************************************************!

  type(stokes_<T>) function scalar_stokes_div_<T>(a,b) result(s)

    implicit none

    @T,intent(in)               :: a
    type(stokes_<T>),intent(in) :: b

    s%I = a / b%I
    s%Q = a / b%Q
    s%U = a / b%U
    s%V = a / b%V

  end function scalar_stokes_div_<T>

  type(stokes_<T>) function stokes_scalar_div_<T>(a,b) result(s)

    implicit none

    type(stokes_<T>),intent(in) :: a
    @T,intent(in)               :: b

    s%I = a%I / b
    s%Q = a%Q / b
    s%U = a%U / b
    s%V = a%V / b

  end function stokes_scalar_div_<T>

  !**********************************************************************!
  ! Stokes power
  !**********************************************************************!

  type(stokes_<T>) function pow_stokes_<T>(a,power) result(s)

    implicit none

    type(stokes_<T>),intent(in) :: a
    real(<T>),intent(in) :: power

    s%I = a%I ** power
    s%Q = a%Q ** power
    s%U = a%U ** power
    s%V = a%V ** power

  end function pow_stokes_<T>

  !!@END FOR

end module type_stokes
