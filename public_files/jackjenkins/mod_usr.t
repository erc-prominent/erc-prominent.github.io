!> This is a template for a new user problem of mhd
module mod_usr

  ! Include a physics module: mod_rho, mod_mhd, mod_mhd ...
  use mod_mhd

  implicit none
  double precision :: L_a,g_cor,T_cor,n_cor,rho_cor,rho_ky15,k_B,m,L_s,B_a,a,v_00,SRadius,gzone,dya,bQ0,heatunit,relax,t1,t2
  double precision, allocatable :: pa(:),ra(:),ya(:),xa(:)
  double precision, allocatable :: pbc(:),rbc(:)
  integer, parameter :: jmax=8000

  integer :: Te_, Alfv_, divB_, beta_, bQ_, rad_, j1_, j2_, j3_, b1t_, b2t_, b3t_

!   Store hydrodynamic barocliniticy
  integer :: hbaro_x, hbaro_y, hbaro_z, N2_
  
!   Store magnetohydrodynamic and tension barocliniticy  
  integer :: mbaro_x, mbaro_y, mbaro_z
  integer :: mtbaro_x, mtbaro_y, mtbaro_z

!   Store evolving vorticity compression and stretching terms 
  integer :: vs_x, vs_y, vs_z
  integer :: vc_x, vc_y, vc_z


contains

  !> This routine should set user methods, and activate the physics module
  subroutine usr_init()
    

    ! A routine for initial conditions is always required
    usr_set_parameters=> initglobaldata_usr
    usr_special_bc    => specialbound_usr
    usr_init_one_grid => initial_conditions
    usr_set_B0        => specialset_B0
    usr_set_J0        => specialset_J0
    usr_source          => special_source
    usr_gravity       => gravity
    usr_refine_grid     => special_refine_grid
    usr_modify_output => set_output_vars

    ! Choose independent normalization units if using dimensionless variables.
    unit_length        = 1.d8 ! cm
    unit_temperature   = 1.d6 ! K
    unit_numberdensity = 1.d8 ! cm^-3

    ! Active the physics module: rho_activate(), mhd_activate(), mhd_activate()
    call set_coordinate_system("Cartesian_3D")
    call mhd_activate()


    Te_ = var_set_extravar("Te", "Te")
    Alfv_ = var_set_extravar("Alfv", "Alfv")
    divB_ = var_set_extravar("divB", "divB")
    beta_ = var_set_extravar("beta", "beta")
    bQ_ = var_set_extravar("bQ", "bQ")
    rad_ = var_set_extravar("rad", "rad")

    hbaro_x = var_set_extravar("hbarox", "hbarox")
    hbaro_y = var_set_extravar("hbaroy", "hbaroy")
    hbaro_z = var_set_extravar("hbaroz", "hbaroz")
    N2_ = var_set_extravar("N2", "N2")

    mbaro_x = var_set_extravar("mbarox", "mbarox")
    mbaro_y = var_set_extravar("mbaroy", "mbaroy")
    mbaro_z = var_set_extravar("mbaroz", "mbaroz")
    mtbaro_x = var_set_extravar("mtbarox", "mtbarox")
    mtbaro_y = var_set_extravar("mtbaroy", "mtbaroy")
    mtbaro_z = var_set_extravar("mtbaroz", "mtbaroz")

    vs_x = var_set_extravar("vsx","vsx")
    vs_y = var_set_extravar("vsy","vsy")
    vs_z = var_set_extravar("vsz","vsz")
    vc_x = var_set_extravar("vcx","vcx")
    vc_y = var_set_extravar("vcy","vcy")
    vc_z = var_set_extravar("vcz","vcz")

    j1_ = var_set_extravar("j1", "j1")
    j2_ = var_set_extravar("j2", "j2")
    j3_ = var_set_extravar("j3", "j3")

    b1t_ = var_set_extravar("b1t", "b1t")
    b2t_ = var_set_extravar("b2t", "b2t")
    b3t_ = var_set_extravar("b3t", "b3t")

  end subroutine usr_init
  

  subroutine initglobaldata_usr
    heatunit=unit_pressure/unit_time          ! 3.697693390805347E-003 erg*cm^-3/s
    L_a   = 12.0d8/unit_length
    g_cor = -2.74d4*unit_length/(unit_velocity**2)
    T_cor = 1.0d6/unit_temperature
    k_B   = const_kb
    m     = const_mp
    rho_ky15=3.2d-15
    rho_cor=rho_ky15/unit_density
    n_cor = rho_cor
    B_a   = 10.0d0/unit_magneticfield
    a     = abs(T_cor/g_cor)
    v_00  = 12.0d5/unit_velocity !6
    SRadius=696.34d0
    gzone=0.0d0
    dya=(xprobmax2-xprobmin2)/dble(jmax)
    bQ0=1.0d-4/heatunit

    relax=400.0d0/unit_time
    t1=(1200.d0/unit_time)+relax
    t2=(1400.d0/unit_time)+relax
    
    

    call inithdstatic

  end subroutine initglobaldata_usr

  subroutine inithdstatic
  !! initialize the table in a vertical line through the global domain
    integer :: j,na,nb,ibc,im1
    double precision, allocatable :: Ta(:),gg(:)!,raa(jmax,jmax)
    double precision:: rpho,Tpho,wtra,res,rhob,pb,htra,Ttr,Fc,invT,kappa
  
    rpho=rho_cor ! number density at the bottom relaxla
    Tpho=T_cor ! temperature of chromosphere

    allocate(ya(jmax),xa(jmax),Ta(jmax),gg(jmax),pa(jmax),ra(jmax))!,raa(jmax,jmax))
    do j=1,jmax
      ya(j)=(dble(j)-0.5d0)*dya-gzone
      Ta(j)=T_cor
      gg(j)=g_cor*(SRadius/(SRadius+ya(j)))**2
    enddo

    !! solution of hydrostatic equation assuming an exponential decay in density
    nb=int(gzone/dya)
    ra(1)=rpho
    pa(1)=rpho*Tpho
    invT=gg(1)/Ta(1)
    invT=0.d0
    do j=2,jmax
       invT=invT+(gg(j)/Ta(j)+gg(j-1)/Ta(j-1))*0.5d0
       pa(j)=pa(1)*exp(invT*dya)
       ra(j)=pa(j)/Ta(j)
    end do

    !! initialized rho and p in the fixed bottom boundary
    na=floor(gzone/dya+0.5d0)
    res=gzone-(dble(na)-0.5d0)*dya
    rhob=ra(na)+res/dya*(ra(na+1)-ra(na))
    pb=pa(na)+res/dya*(pa(na+1)-pa(na))
    allocate(rbc(nghostcells))
    allocate(pbc(nghostcells))
    do ibc=nghostcells,1,-1
      na=floor(((dble(nghostcells-ibc+1)-0.5d0))/dya+0.5d0)
      res=(dble(nghostcells-ibc+1)-0.5d0)-(dble(na)-0.5d0)*dya
      rbc(ibc)=ra(na)+res/dya*(ra(na+1)-ra(na))
      pbc(ibc)=pa(na)+res/dya*(pa(na+1)-pa(na))
    enddo


    if (mype==0) then
     print *,'3D MHD JK2021 Flux Rope'
     print *,'B_a: ', B_a
     print *, 'relax = ', relax
     print *, 'time_max = ', time_max
    endif


  end subroutine inithdstatic

  !> A routine for specifying initial conditions
  subroutine initial_conditions(ixI^L, ixO^L, w, x)
    use mod_global_parameters


    integer, intent(in)             :: ixI^L, ixO^L
    double precision, intent(in)    :: x(ixI^S,1:ndim)
    double precision, intent(inout) :: w(ixI^S,1:nw)
    double precision                :: Bloc(ixI^S,1:ndim), ggg(ixO^S), test(ixI^S,1:nw), gravity_field(ixI^S,ndim), gradp(ixO^S), B2(ixO^S), vpert(ixO^S)
    double precision :: res
    integer :: ixO^D, na, ix^D
    !integer :: ix^D,na,idims,imode
    
    logical, save:: first=.true.

    if (first) then
       if (mype==0) then
          print *,'3D MHD JK2021 Flux Rope'
          print *,'PI: ', dpi
          print *,'L_a: ', L_a
          print *,'g_cor: ', g_cor
          print *,'T_cor: ', T_cor
          print *,'rho_cor: ', rho_cor
          print *,'n_cor: ', n_cor
          print *,'k_B: ', k_B
          print *,'m: ', m
          print *,'L_s: ', L_s
          print *,'B_a: ', B_a
          print *,'a: ', a
          print *,'v_00: ', v_00
          print *,'nghostcells: ', nghostcells
          print *,'SRadius: ', SRadius
          print *,'gzone: ', gzone
          print *,'dya: ', dya
          print *,'bQ0: ', bQ0
          !print *,ndir, ndim
          print*, 'heatunit = ', heatunit
          print*, 'unit_density = ', unit_density
          print*, 'unit_numberdensity = ', unit_numberdensity
          print*, 'unit_pressure = ', unit_pressure
          print*, 'unit_velocity = ', unit_velocity
          print*, 'unit_time = ', unit_time
          print*, 'unit_mass = ', unit_mass
          print*, 'unit_magfield = ', unit_magneticfield
          print*, 'time_max = ', time_max
          print*, 'relax = ', relax

          !print*, 'usr_grav = ', usr_grav
          !print*, 'kpara', tc_k_para
       end if
        first=.false.
    end if


    ! first process is not used in this simulation
    if (firstprocess) then
      call mhd_to_primitive(ixI^L,ixO^L,w,x)
      vpert(ixO^S)=(12.0d5/unit_velocity)*sin((x(ixO^S,2)*dpi)/25.0d0)
      w(ixO^S,mom(1))=w(ixO^S,mom(1))-vpert(ixO^S)
      call mhd_to_conserved(ixI^L,ixO^L,w,x)
    else
      !If B0field is set, then the background field is set by the use_set_b0 subroutine (linked to specialset_B0 here)
      w(ixO^S,mag(:))=0.0d0


      !This fills the vertical direction with a stratificaton from the inithdstatic subroutine
      do ix3=ixOmin3,ixOmax3
        do ix2=ixOmin2,ixOmax2
          do ix1=ixOmin1,ixOmax1
            na=floor((x(ix^D,2)-xprobmin2+gzone)/dya+0.5d0)
            res=x(ix^D,2)-xprobmin2+gzone-(dble(na)-0.5d0)*dya
            w(ix^D,rho_)=ra(na)+(one-cos(dpi*res/dya))/two*(ra(na+1)-ra(na))
            w(ix^D,p_)  =pa(na)+(one-cos(dpi*res/dya))/two*(pa(na+1)-pa(na))
          end do
        end do
      enddo

      ! fill internal energy auxiliary variable with p_ values
      if(mhd_solve_eaux) w(ixO^S,paux_)=w(ixO^S,p_)

      !Sets the initial velocity acriss the 2D domain at zero
      w(ixO^S,mom(:))=0.0d0

      call mhd_to_conserved(ixI^L,ixO^L,w,x)
    endif

  end subroutine initial_conditions

  

  subroutine specialset_B0(ixI^L,ixO^L,x,wB0)
  ! Here one can add a steady (time-independent) background magnetic field
    integer, intent(in)           :: ixI^L,ixO^L
    double precision, intent(in)  :: x(ixI^S,1:ndim)
    double precision, intent(inout) :: wB0(ixI^S,1:ndir)

    !eq 3.
    wB0(ixO^S,1)=-((2*L_a)/(dpi*a))*B_a*cos((dpi*x(ixO^S,1))/(2*L_a))*exp(-x(ixO^S,2)/a)
    !eq 4.
    wB0(ixO^S,2)=B_a*sin((dpi*x(ixO^S,1))/(2*L_a))*exp(-x(ixO^S,2)/a)
    !eq 5.
    wB0(ixO^S,3)=-sqrt(1-((2*L_a)/(dpi*a))**2)*B_a*cos((dpi*x(ixO^S,1))/(2*L_a))*exp(-x(ixO^S,2)/a)
    
  end subroutine specialset_B0

  subroutine specialset_J0(ixI^L,ixO^L,x,wJ0)
  ! Here add a time-independent background current density (curl of the magnetic field)
    integer, intent(in)           :: ixI^L,ixO^L
    double precision, intent(in)  :: x(ixI^S,1:ndim)
    double precision, intent(inout) :: wJ0(ixI^S,7-2*ndir:ndir)

    wJ0(ixO^S,1)=(1/a)*sqrt(1-((2*L_a)/(dpi*a))**2)*B_a*cos((dpi*x(ixO^S,1))/(2*L_a))*exp(-x(ixO^S,2)/a)
    wJ0(ixO^S,2)=-(dpi/(2*L_a))*sqrt(1-((2*L_a)/(dpi*a))**2)*B_a*sin((dpi*x(ixO^S,1))/(2*L_a))*exp(-x(ixO^S,2)/a)
    wJ0(ixO^S,3)=cos((dpi*x(ixO^S,1))/(2*L_a))*exp(-x(ixO^S,2)/a)*(((dpi*B_a)/(2*L_a))-((2*l_a)/(dpi*(a**2))))

  end subroutine specialset_J0


  subroutine driven_velocity(ixI^L,ixO^L,qt,x,vdx,vdz)
    use mod_global_parameters
    integer, intent(in)             :: ixI^L, ixO^L
    double precision, intent(in) :: qt, x(ixI^S,1:ndim)
    double precision, intent(out) :: vdx(ixI^S),vdz(ixI^S)
    double precision :: v_0t,tb,r1,r2
    integer :: fflag

    

    tb=0.0d0+relax

    if (qt>tb) then
      v_0t=v_00
      ! if (qt>=tb.and.qt<tr) then      
      !   v_0t=v_00*((qt-tb)/(tr-tb))
      !   !write(*,*) v_0t*116
      ! endif
      if (qt>t1.and.qt<t2) then
        v_0t=v_00*((t2-qt)/(t2-t1))
      endif
      if (qt>t2) then
        v_0t=0.0d0
      end if
      fflag=2015
      if (fflag==2015 .and. qt<t2) then
        where((x(ixO^S,1)>(0.0d0)).and.(x(ixO^S,1)<(L_a/4.0d0)))!
          vdx(ixO^S)=-(v_0t*x(ixO^S,1))/(L_a/4.0d0)!eq 6.
          vdz(ixO^S)=vdx(ixO^S)!eq 11.
        endwhere
        where((x(ixO^S,1)>=(L_a/4.0d0)).and.(x(ixO^S,1)<=L_a))!
          vdx(ixO^S)=-(v_0t*(L_a-x(ixO^S,1)))/(3.0d0*L_a/4.0d0)!eq 7.
          vdz(ixO^S)=vdx(ixO^S)!eq 12.
        endwhere
        where((x(ixO^S,1)<(0.0d0)).and.(x(ixO^S,1)>(-L_a/4.0d0)))!
          vdx(ixO^S)=(v_0t*abs(x(ixO^S,1)))/(L_a/4.0d0)!eq 6.
          vdz(ixO^S)=vdx(ixO^S)!eq 11.
        endwhere
        where((x(ixO^S,1)<=(-L_a/4.0d0)).and.(x(ixO^S,1)>=(-L_a)))!
          vdx(ixO^S)=(v_0t*(L_a-abs(x(ixO^S,1))))/(3.0d0*L_a/4.0d0)!eq 7.
          vdz(ixO^S)=vdx(ixO^S)!eq 12.
        endwhere
        where((x(ixO^S,1)<-L_a))
          vdx(ixO^S)=0.0d0
          vdz(ixO^S)=0.0d0
        endwhere
        where((x(ixO^S,1)>L_a))
          vdx(ixO^S)=0.0d0
          vdz(ixO^S)=0.0d0
        endwhere
        call random_number(r1)
        call random_number(r2)
        where(x(ixO^S,1)<(L_a/2.0d0).and.x(ixO^S,1)>(-L_a/2.0d0))
          vdx(ixO^S)=vdx(ixO^S)*((r1/2.0d0)+1.0d0)
          vdz(ixO^S)=vdz(ixO^S)*((r2/2.0d0)+1.0d0)
        endwhere
      endif
    else
      vdx(ixO^S)=0.0d0
      vdz(ixO^S)=0.0d0
    endif

  end subroutine driven_velocity

  subroutine specialbound_usr(qt,ixI^L,ixO^L,iB,w,x)
    use mod_global_parameters
    ! special boundary types, user defined
    integer, intent(in) :: ixO^L, iB, ixI^L
    double precision, intent(in) :: qt, x(ixI^S,1:ndim)
    double precision, intent(inout) :: w(ixI^S,1:nw)
    double precision                :: Bloc(ixI^S,1:ndim)
    double precision :: pth(ixI^S),tmp(ixI^S),ggrid(ixI^S),invT(ixI^S), B2(ixI^S),mom_stationary(ixI^S,1:ndim)
    double precision :: r1,r2
    integer :: ix^D,ixOs^L,ixC^L,hxC^L,jxO^L,idir,ixIM^L

    select case(iB)
    case(3)

      if (qt<relax) then
        !print*, 'qt<relax'
        w(ixO^S,mom(1))=-w(ixOmin1:ixOmax1,ixOmax2+nghostcells:ixOmax2+1:-1,ixOmin3:ixOmax3,mom(1))/w(ixOmin1:ixOmax1,ixOmax2+nghostcells:ixOmax2+1:-1,ixOmin3:ixOmax3,rho_)
        w(ixO^S,mom(2))=-w(ixOmin1:ixOmax1,ixOmax2+nghostcells:ixOmax2+1:-1,ixOmin3:ixOmax3,mom(2))/w(ixOmin1:ixOmax1,ixOmax2+nghostcells:ixOmax2+1:-1,ixOmin3:ixOmax3,rho_)
        w(ixO^S,mom(3))=-w(ixOmin1:ixOmax1,ixOmax2+nghostcells:ixOmax2+1:-1,ixOmin3:ixOmax3,mom(3))/w(ixOmin1:ixOmax1,ixOmax2+nghostcells:ixOmax2+1:-1,ixOmin3:ixOmax3,rho_)
      else if (qt>=t2) then
        !print*, 'qt>t2'
        w(ixO^S,mom(1))=-w(ixOmin1:ixOmax1,ixOmax2+nghostcells:ixOmax2+1:-1,ixOmin3:ixOmax3,mom(1))/w(ixOmin1:ixOmax1,ixOmax2+nghostcells:ixOmax2+1:-1,ixOmin3:ixOmax3,rho_)
        w(ixO^S,mom(2))=-w(ixOmin1:ixOmax1,ixOmax2+nghostcells:ixOmax2+1:-1,ixOmin3:ixOmax3,mom(2))/w(ixOmin1:ixOmax1,ixOmax2+nghostcells:ixOmax2+1:-1,ixOmin3:ixOmax3,rho_)
        w(ixO^S,mom(3))=-w(ixOmin1:ixOmax1,ixOmax2+nghostcells:ixOmax2+1:-1,ixOmin3:ixOmax3,mom(3))/w(ixOmin1:ixOmax1,ixOmax2+nghostcells:ixOmax2+1:-1,ixOmin3:ixOmax3,rho_)
        call random_number(r1)
        call random_number(r2)
        where(x(ixO^S,1)<(L_a/1.5d0).and.x(ixO^S,1)>(-L_a/1.5d0))
          w(ixO^S,mom(1))=w(ixO^S,mom(1))*((r1/2.0d0)+1.0d0)
          w(ixO^S,mom(3))=w(ixO^S,mom(3))*((r2/2.0d0)+1.0d0)
        endwhere
      else
        call driven_velocity(ixI^L,ixO^L,qt,x,w(ixI^S,mom(1)),w(ixI^S,mom(3)))
        do idir=1,ndir
          mom_stationary(ixO^S,idir) =-w(ixOmin1:ixOmax1,ixOmax2+nghostcells:ixOmax2+1:-1,ixOmin3:ixOmax3,mom(idir))/w(ixOmin1:ixOmax1,ixOmax2+nghostcells:ixOmax2+1:-1,ixOmin3:ixOmax3,rho_)
        end do
        w(ixO^S,mom(1))=w(ixO^S,mom(1))+mom_stationary(ixO^S,1)
        w(ixO^S,mom(2))=mom_stationary(ixO^S,2)
        w(ixO^S,mom(3))=w(ixO^S,mom(3))+mom_stationary(ixO^S,3)
      endif
      
      
      
      do ix2=ixOmax2,ixOmin2,-1
        w(ixOmin1:ixOmax1,ix2,ixOmin3:ixOmax3,mag(:))=(1.0d0/3.0d0)* &
                   (-w(ixOmin1:ixOmax1,ix2+2,ixOmin3:ixOmax3,mag(:)) &
              +4.0d0*w(ixOmin1:ixOmax1,ix2+1,ixOmin3:ixOmax3,mag(:)))
      enddo
      


      do ix2=ixOmin2,ixOmax2
        do ix1=ixOmin1,ixOmax1
          w(ix1,ix2,ixOmin3:ixOmax3,rho_)=rbc(ix2)
          w(ix1,ix2,ixOmin3:ixOmax3,p_)=pbc(ix2)
        enddo
      enddo

      if(mhd_solve_eaux) w(ixO^S,paux_)=w(ixO^S,p_)

      call mhd_to_conserved(ixI^L,ixO^L,w,x)
    case(4)
      ixOs^L=ixO^L;
      ixOsmin2=ixOmin2-1;ixOsmax2=ixOmin2-1;
      call mhd_get_pthermal(w,x,ixI^L,ixOs^L,pth)
      ixOsmin2=ixOmin2-1;ixOsmax2=ixOmax2;
      call getggrav(ggrid,ixI^L,ixOs^L,x)

      !> fill pth, rho ghost layers according to gravity stratification
      invT(ixOmin2-1^%2ixO^S)=w(ixOmin2-1^%2ixO^S,rho_)/pth(ixOmin2-1^%2ixO^S)
      tmp=0.d0
      do ix2=ixOmin2,ixOmax2
        tmp(ixOmin2-1^%2ixO^S)=tmp(ixOmin2-1^%2ixO^S)+0.5d0*&
            (ggrid(ix2^%2ixO^S)+ggrid(ix2-1^%2ixO^S))*invT(ixOmin2-1^%2ixO^S)
        w(ix2^%2ixO^S,p_)=pth(ixOmin2-1^%2ixO^S)*dexp(tmp(ixOmin2-1^%2ixO^S)*dxlevel(2))
        w(ix2^%2ixO^S,rho_)=w(ix2^%2ixO^S,p_)*invT(ixOmin2-1^%2ixO^S)
      enddo
      do idir=1,ndir
        w(ixO^S,mom(idir)) =-w(ixOmin1:ixOmax1,ixOmin2-1:ixOmin2-nghostcells:-1,ixOmin3:ixOmax3,mom(idir))&
                     /w(ixOmin1:ixOmax1,ixOmin2-1:ixOmin2-nghostcells:-1,ixOmin3:ixOmax3,rho_)
      end do
      do ix2=ixOmin2,ixOmax2
          w(ixOmin1:ixOmax1,ix2,ixOmin3:ixOmax3,mag(:))=(1.0d0/3.0d0)* &
                      (-w(ixOmin1:ixOmax1,ix2-2,ixOmin3:ixOmax3,mag(:))&
                 +4.0d0*w(ixOmin1:ixOmax1,ix2-1,ixOmin3:ixOmax3,mag(:)))
      enddo

      if(mhd_solve_eaux) w(ixO^S,paux_)=w(ixO^S,p_)

      call mhd_to_conserved(ixI^L,ixO^L,w,x)
    case default
       call mpistop("Special boundary is not defined for this region")
    end select
    
  end subroutine specialbound_usr

  subroutine special_source(qdt,ixI^L,ixO^L,iw^LIM,qtC,wCT,qt,w,x)
    !use mod_radiative_cooling
    integer, intent(in) :: ixI^L, ixO^L, iw^LIM
    double precision, intent(in) :: qdt, qtC, qt
    double precision, intent(in) :: x(ixI^S,1:ndim), wCT(ixI^S,1:nw)
    double precision, intent(inout) :: w(ixI^S,1:nw)

    double precision :: lQgrid(ixI^S),bQgrid(ixI^S), nnQ(ixO^S), l_cor

    call getbQ(bQgrid,ixI^L,ixO^L,qtC,wCT,x)
    w(ixO^S,e_)=w(ixO^S,e_)+(qdt*bQgrid(ixO^S))

  end subroutine special_source

  subroutine getbQ(bQgrid,ixI^L,ixO^L,qt,w,x)
  !subroutine getbQ(bQgrid,ixI^L,ixO^L,qt,w,x,ens)
  ! calculate background heating bQ
    use mod_radiative_cooling
    integer, intent(in) :: ixI^L, ixO^L
    double precision, intent(in) :: qt, x(ixI^S,1:ndim), w(ixI^S,1:nw)!, ens(ixI^S)
    double precision, intent (out) :: bQgrid(ixI^S)

    double precision  :: Btotal(ixI^S,1:ndir)
    double precision  :: a_d(ixO^S),B2(ixO^S),pth(ixO^S)
    double precision  :: a_m,nQ,a_h,T_c,l_cor
    integer :: idir


    call findL(t_cor,l_cor)


    bQgrid(ixO^S)=(n_cor**2)*l_cor*exp(-2*x(ixO^S,2)/a)

  end subroutine getbQ

  subroutine gravity(ixI^L,ixO^L,wCT,x,gravity_field)
    integer, intent(in)             :: ixI^L, ixO^L
    double precision, intent(in)    :: x(ixI^S,1:ndim)
    double precision, intent(in)    :: wCT(ixI^S,1:nw)
    double precision, intent(out)   :: gravity_field(ixI^S,ndim)

    double precision                :: ggrid(ixI^S)

    gravity_field=0.d0
    call getggrav(ggrid,ixI^L,ixO^L,x)
    gravity_field(ixO^S,2)=ggrid(ixO^S)
    
  end subroutine gravity

  subroutine getggrav(ggrid,ixI^L,ixO^L,x)
    integer, intent(in)             :: ixI^L, ixO^L
    double precision, intent(in)    :: x(ixI^S,1:ndim)
    double precision, intent(out)   :: ggrid(ixI^S)

    ggrid(ixO^S)=g_cor*(SRadius/(SRadius+x(ixO^S,2)))**2
  end subroutine



  subroutine special_refine_grid(igrid,level,ixI^L,ixO^L,qt,w,x,refine,coarsen)
  ! Enforce additional refinement or coarsening
  ! One can use the coordinate info in x and/or time qt=t_n and w(t_n) values w.
    integer, intent(in) :: igrid, level, ixI^L, ixO^L
    double precision, intent(in) :: qt, w(ixI^S,1:nw), x(ixI^S,1:ndim)
    integer, intent(inout) :: refine, coarsen
    double precision :: Te(ixI^S),pth(ixI^S)

    ! fix the bottom layer to the highest level
    if (any(x(ixO^S,2)<=xprobmin2+0.05d0)) then
      refine=1
      coarsen=-1
    endif

!     ! fix the bottom layer to the lowest level
!     if (any(x(ixO^S,2)<=xprobmin2+0.05d0)) then
!       refine=-1
!       coarsen=1
!     endif

    call mhd_get_pthermal(w,x,ixI^L,ixO^L,pth)
    Te(ixO^S)=pth(ixO^S)/w(ixO^S,rho_)
    if (any(Te(ixO^S) <=2.0d-3)) then
      refine=1
      coarsen=-1
    endif

  end subroutine special_refine_grid


  subroutine set_output_vars(ixI^L,ixO^L,qt,w,x)
    use mod_global_parameters
    use mod_radiative_cooling

    integer, intent(in)             :: ixI^L,ixO^L
    double precision, intent(in)    :: qt, x(ixI^S,1:ndim)
    double precision, intent(inout) :: w(ixI^S,nw)
  
    double precision :: pth(ixI^S),B2(ixI^S)
    double precision :: ens(ixI^S),divb(ixI^S),wlocal(ixI^S,1:nw),Qe(ixI^S)
    double precision :: Btotal(ixI^S,1:ndir)
    double precision :: grad_rho_(ixI^S,1:ndir), grad_p_(ixI^S,1:ndir)
    double precision :: B_dot_grad_B_(ixI^S,1:ndir), grad_pmag_(ixI^S,1:ndir)
    double precision :: Te(ixI^S), inv_rho(ixI^S), inv_rho_sq(ixI^S), part_one(ixI^S), part_two(ixI^S), Bmag(ixI^S), pmag(ixI^S)
    double precision, allocatable :: grad_rho_x(:,:,:),grad_rho_y(:,:,:),grad_rho_z(:,:,:)
    double precision, allocatable :: grad_p_x(:,:,:),grad_p_y(:,:,:),grad_p_z(:,:,:)
    double precision, allocatable :: vort_x(:,:,:),vort_y(:,:,:),vort_z(:,:,:)
    double precision, allocatable :: dbxdx(:,:,:),dbzdz(:,:,:)
    double precision, allocatable :: dbxdy(:,:,:),dbxdz(:,:,:),dbydx(:,:,:),dbydz(:,:,:),dbzdx(:,:,:),dbzdy(:,:,:)
    double precision, allocatable :: dbdgbxdx(:,:,:),dbdgbxdy(:,:,:),dbdgbxdz(:,:,:),dbdgbydx(:,:,:),dbdgbydz(:,:,:),dbdgbzdx(:,:,:),dbdgbzdy(:,:,:),dbdgbzdz(:,:,:)
    double precision, allocatable :: dvxdx(:,:,:),dvxdy(:,:,:),dvxdz(:,:,:),dvydx(:,:,:),dvydy(:,:,:),dvydz(:,:,:),dvzdx(:,:,:),dvzdy(:,:,:),dvzdz(:,:,:)
    double precision, allocatable :: grad_pmag_x(:,:,:),grad_pmag_y(:,:,:),grad_pmag_z(:,:,:)
    integer :: idirmin,idir,ix^D, idims

    wlocal(ixI^S,1:nw)=w(ixI^S,1:nw)
!   output temperature
    call mhd_get_pthermal(wlocal,x,ixI^L,ixI^L,pth)
    Te(ixO^S)=pth(ixO^S)/w(ixO^S,rho_)
    w(ixO^S,Te_)=Te(ixO^S)

    do idir=1,ndir
      if(B0field) then
        Btotal(ixI^S,idir)=w(ixI^S,mag(idir))+block%B0(ixI^S,idir,0)
      else
        Btotal(ixI^S,idir)=w(ixI^S,mag(idir))
      endif
    end do
!   B^2
    B2(ixI^S)=sum((Btotal(ixI^S,:))**2,dim=ndim+1)
    Bmag(ixI^S)=sqrt(B2(ixI^S))
    pmag(ixI^S)=B2(ixI^S)/2.0d0

!    output Alfven wave speed B/sqrt(rho)
    w(ixO^S,Alfv_)=dsqrt(B2(ixO^S)/w(ixO^S,rho_))

!   output divB1
    call get_divb(wlocal,ixI^L,ixO^L,divb)
    w(ixO^S,divB_)=divb(ixO^S)

    ! output the plasma beta p*2/B**2
    w(ixO^S,beta_)=pth(ixO^S)*two/B2(ixO^S)

    !store the cooling rate 
    if(mhd_radiative_cooling) call getvar_cooling(ixI^L,ixO^L,wlocal,x,Qe)
    w(ixO^S,rad_)=Qe(ixO^S)

!    output heating rate
    call getbQ(ens,ixI^L,ixO^L,global_time,wlocal,x)
    w(ixO^S,bQ_)=ens(ixO^S)
    
!    Equal to ~ 18 degrees i.e., the angle that the condensation threads make with the z axis
!    angle=(((30d0/100d0)*2d0*dpi)*(180d0/dpi)-90d0)*(dpi/180d0)
!    In actual fact, because we're in cartesian we may just rotate at the end of the calculation - more complex in other coordinate systems.
    

    inv_rho(ixI^S)=wlocal(ixI^S,rho_)**-1.0d0
    inv_rho_sq(ixI^S)=wlocal(ixI^S,rho_)**-2.0d0
    
!   store hydrodynamic baroclinicity
    w(ixO^S,hbaro_x)=0.0d0
    w(ixO^S,hbaro_y)=0.0d0
    w(ixO^S,hbaro_z)=0.0d0
    
    allocate(grad_rho_x(ixI^S),grad_rho_y(ixI^S),grad_rho_z(ixI^S))
    allocate(grad_p_x(ixI^S),grad_p_y(ixI^S),grad_p_z(ixI^S))

    call gradient(wlocal(ixI^S,rho_),ixI^L,ixO^L,1,grad_rho_x)
    call gradient(wlocal(ixI^S,rho_),ixI^L,ixO^L,2,grad_rho_y)
    call gradient(wlocal(ixI^S,rho_),ixI^L,ixO^L,3,grad_rho_z)
    call gradient(pth(ixI^S),ixI^L,ixO^L,1,grad_p_x)
    call gradient(pth(ixI^S),ixI^L,ixO^L,2,grad_p_y)
    call gradient(pth(ixI^S),ixI^L,ixO^L,3,grad_p_z)

    grad_rho_(ixO^S,1)=grad_rho_x(ixO^S)
    grad_rho_(ixO^S,2)=grad_rho_y(ixO^S)
    grad_rho_(ixO^S,3)=grad_rho_z(ixO^S)
    grad_p_(ixO^S,1)=grad_p_x(ixO^S)
    grad_p_(ixO^S,2)=grad_p_y(ixO^S)
    grad_p_(ixO^S,3)=grad_p_z(ixO^S)

    deallocate(grad_rho_x,grad_rho_y,grad_rho_z)
    deallocate(grad_p_x,grad_p_y,grad_p_z)

    w(ixO^S,hbaro_x) = inv_rho_sq(ixO^S) * ((grad_rho_(ixO^S,2)*grad_p_(ixO^S,3))-(grad_rho_(ixO^S,3)*grad_p_(ixO^S,2)))
    w(ixO^S,hbaro_y) = inv_rho_sq(ixO^S) * ((grad_rho_(ixO^S,3)*grad_p_(ixO^S,1))-(grad_rho_(ixO^S,1)*grad_p_(ixO^S,3)))
    w(ixO^S,hbaro_z) = inv_rho_sq(ixO^S) * ((grad_rho_(ixO^S,1)*grad_p_(ixO^S,2))-(grad_rho_(ixO^S,2)*grad_p_(ixO^S,1)))

!    store magnetic baroclinicity

    w(ixI^S,mbaro_x)=0.0d0
    w(ixI^S,mbaro_y)=0.0d0
    w(ixI^S,mbaro_z)=0.0d0
    w(ixI^S,mtbaro_x)=0.0d0
    w(ixI^S,mtbaro_y)=0.0d0
    w(ixI^S,mtbaro_z)=0.0d0

    allocate(dbxdx(ixI^S),dbxdy(ixI^S),dbxdz(ixI^S),dbydx(ixI^S),dbydz(ixI^S),dbzdx(ixI^S),dbzdy(ixI^S),dbzdz(ixI^S))
    allocate(grad_pmag_x(ixI^S),grad_pmag_y(ixI^S),grad_pmag_z(ixI^S))
    
    call gradient(Btotal(ixI^S,1),ixI^L,ixO^L,1,dbxdx)
    call gradient(Btotal(ixI^S,1),ixI^L,ixO^L,2,dbxdy)
    call gradient(Btotal(ixI^S,1),ixI^L,ixO^L,3,dbxdz)
    call gradient(Btotal(ixI^S,2),ixI^L,ixO^L,1,dbydx)
    call gradient(Btotal(ixI^S,2),ixI^L,ixO^L,3,dbydz)
    call gradient(Btotal(ixI^S,3),ixI^L,ixO^L,1,dbzdx)
    call gradient(Btotal(ixI^S,3),ixI^L,ixO^L,2,dbzdy)
    call gradient(Btotal(ixI^S,3),ixI^L,ixO^L,3,dbzdz)

    call gradient(pmag(ixI^S),ixI^L,ixO^L,1,grad_pmag_x)
    call gradient(pmag(ixI^S),ixI^L,ixO^L,2,grad_pmag_y)
    call gradient(pmag(ixI^S),ixI^L,ixO^L,3,grad_pmag_z)

    grad_pmag_(ixO^S,1)=grad_pmag_x(ixO^S)
    grad_pmag_(ixO^S,2)=grad_pmag_y(ixO^S)
    grad_pmag_(ixO^S,3)=grad_pmag_z(ixO^S)

    deallocate(grad_pmag_x,grad_pmag_y,grad_pmag_z)

    B_dot_grad_B_(ixO^S,1)=grad_pmag_(ixO^S,1)-((Btotal(ixO^S,2)*(dbydx(ixO^S)-dbxdy(ixO^S)))-(Btotal(ixO^S,3)*(dbxdz(ixO^S)-dbzdx(ixO^S))))
    B_dot_grad_B_(ixO^S,2)=grad_pmag_(ixO^S,2)-((Btotal(ixO^S,3)*(dbzdy(ixO^S)-dbydz(ixO^S)))-(Btotal(ixO^S,1)*(dbydx(ixO^S)-dbxdy(ixO^S))))
    B_dot_grad_B_(ixO^S,3)=grad_pmag_(ixO^S,3)-((Btotal(ixO^S,1)*(dbxdz(ixO^S)-dbzdx(ixO^S)))-(Btotal(ixO^S,2)*(dbzdy(ixO^S)-dbydz(ixO^S))))

    deallocate(dbxdx,dbxdy,dbxdz,dbydx,dbydz,dbzdx,dbzdy,dbzdz)

    w(ixO^S,mbaro_x) = inv_rho_sq(ixO^S) * ((grad_rho_(ixO^S,2)*(grad_pmag_(ixO^S,3)-B_dot_grad_B_(ixO^S,3)))-(grad_rho_(ixO^S,3)*(grad_pmag_(ixO^S,2)-B_dot_grad_B_(ixO^S,2))))
    w(ixO^S,mbaro_y) = inv_rho_sq(ixO^S) * ((grad_rho_(ixO^S,3)*(grad_pmag_(ixO^S,1)-B_dot_grad_B_(ixO^S,1)))-(grad_rho_(ixO^S,1)*(grad_pmag_(ixO^S,3)-B_dot_grad_B_(ixO^S,3))))
    w(ixO^S,mbaro_z) = inv_rho_sq(ixO^S) * ((grad_rho_(ixO^S,1)*(grad_pmag_(ixO^S,2)-B_dot_grad_B_(ixO^S,2)))-(grad_rho_(ixO^S,2)*(grad_pmag_(ixO^S,1)-B_dot_grad_B_(ixO^S,1))))  
    
!   Fill gradient function assuming the one sided gradient extrapolation
    do idir=1,ndir
      do ix1=ixOmin1-1,ixOmin1-2,-1
        B_dot_grad_B_(ix1,ixOmin2:ixOmax2,ixOmin3:ixOmax3,idir)=(1.0d0/3.0d0)*(-B_dot_grad_B_(ix1+2,ixOmin2:ixOmax2,ixOmin3:ixOmax3,idir)+4.0d0*B_dot_grad_B_(ix1+1,ixOmin2:ixOmax2,ixOmin3:ixOmax3,idir))
      enddo
      do ix1=ixOmax1+1,ixOmax1+2,1
        B_dot_grad_B_(ix1,ixOmin2:ixOmax2,ixOmin3:ixOmax3,idir)=(1.0d0/3.0d0)*(-B_dot_grad_B_(ix1-2,ixOmin2:ixOmax2,ixOmin3:ixOmax3,idir)+4.0d0*B_dot_grad_B_(ix1-1,ixOmin2:ixOmax2,ixOmin3:ixOmax3,idir))
      enddo

      do ix2=ixOmin2-1,ixOmin2-2,-1
        B_dot_grad_B_(ixOmin1:ixOmax1,ix2,ixOmin3:ixOmax3,idir)=(1.0d0/3.0d0)*(-B_dot_grad_B_(ixOmin1:ixOmax1,ix2+2,ixOmin3:ixOmax3,idir)+4.0d0*B_dot_grad_B_(ixOmin1:ixOmax1,ix2+1,ixOmin3:ixOmax3,idir))
      enddo
      do ix2=ixOmax2+1,ixOmax2+2,1
        B_dot_grad_B_(ixOmin1:ixOmax1,ix2,ixOmin3:ixOmax3,idir)=(1.0d0/3.0d0)*(-B_dot_grad_B_(ixOmin1:ixOmax1,ix2-2,ixOmin3:ixOmax3,idir)+4.0d0*B_dot_grad_B_(ixOmin1:ixOmax1,ix2-1,ixOmin3:ixOmax3,idir))
      enddo

      do ix3=ixOmin3-1,ixOmin3-2,-1
        B_dot_grad_B_(ixOmin1:ixOmax1,ixOmin2:ixOmax2,ix3,idir)=(1.0d0/3.0d0)*(-B_dot_grad_B_(ixOmin1:ixOmax1,ixOmin2:ixOmax2,ix3+2,idir)+4.0d0*B_dot_grad_B_(ixOmin1:ixOmax1,ixOmin2:ixOmax2,ix3+1,idir))
      enddo
      do ix3=ixOmax3+1,ixOmax3+2,1
        B_dot_grad_B_(ixOmin1:ixOmax1,ixOmin2:ixOmax2,ix3,idir)=(1.0d0/3.0d0)*(-B_dot_grad_B_(ixOmin1:ixOmax1,ixOmin2:ixOmax2,ix3-2,idir)+4.0d0*B_dot_grad_B_(ixOmin1:ixOmax1,ixOmin2:ixOmax2,ix3-1,idir))
      enddo
    enddo

    allocate(dbdgbxdx(ixI^S),dbdgbxdy(ixI^S),dbdgbxdz(ixI^S),dbdgbydx(ixI^S),dbdgbydz(ixI^S),dbdgbzdx(ixI^S),dbdgbzdy(ixI^S),dbdgbzdz(ixI^S))

    call gradient(B_dot_grad_B_(ixI^S,1),ixI^L,ixO^L,1,dbdgbxdx)
    call gradient(B_dot_grad_B_(ixI^S,1),ixI^L,ixO^L,2,dbdgbxdy)
    call gradient(B_dot_grad_B_(ixI^S,1),ixI^L,ixO^L,3,dbdgbxdz)
    call gradient(B_dot_grad_B_(ixI^S,2),ixI^L,ixO^L,1,dbdgbydx)
    call gradient(B_dot_grad_B_(ixI^S,2),ixI^L,ixO^L,3,dbdgbydz)
    call gradient(B_dot_grad_B_(ixI^S,3),ixI^L,ixO^L,1,dbdgbzdx)
    call gradient(B_dot_grad_B_(ixI^S,3),ixI^L,ixO^L,2,dbdgbzdy)
    call gradient(B_dot_grad_B_(ixI^S,3),ixI^L,ixO^L,3,dbdgbzdz)

    w(ixO^S,mtbaro_x) = inv_rho(ixO^S) * (dbdgbzdy(ixO^S)-dbdgbydz(ixO^S))
    w(ixO^S,mtbaro_y) = inv_rho(ixO^S) * (dbdgbxdz(ixO^S)-dbdgbzdx(ixO^S))
    w(ixO^S,mtbaro_z) = inv_rho(ixO^S) * (dbdgbydx(ixO^S)-dbdgbxdy(ixO^S))

    deallocate(dbdgbxdx,dbdgbxdy,dbdgbxdz,dbdgbydx,dbdgbydz,dbdgbzdx,dbdgbzdy,dbdgbzdz)

!    store BV frequency (N**2)
    part_one=0.0d0
    part_two=0.0d0
    do idims=1,ndim
      part_one(ixO^S)=part_one(ixO^S)+((Btotal(ixO^S,idims)*grad_p_(ixO^S,idims))/(Bmag(ixO^S)*wlocal(ixO^S,rho_)))
      part_two(ixO^S)=part_two(ixO^S)+(Btotal(ixO^S,idims)/(Bmag(ixO^S)*wlocal(ixO^S,rho_)))*(grad_rho_(ixO^S,idims)-((wlocal(ixO^S,rho_)/(mhd_gamma*wlocal(ixO^S,p_))+B2(ixO^S))*grad_p_(ixO^S,idims)))
    end do
    w(ixO^S,N2_)=part_one(ixO^S)*part_two(ixO^S)


!   store vortex stretching and compressible term 
    allocate(vort_x(ixI^S),vort_y(ixI^S),vort_z(ixI^S))
    allocate(dvxdx(ixI^S),dvxdy(ixI^S),dvxdz(ixI^S),dvydx(ixI^S),dvydy(ixI^S),dvydz(ixI^S),dvzdx(ixI^S),dvzdy(ixI^S),dvzdz(ixI^S))

    call gradient(wlocal(ixI^S,mom(1))/wlocal(ixI^S,rho_),ixI^L,ixO^L,1,dvxdx)
    call gradient(wlocal(ixI^S,mom(1))/wlocal(ixI^S,rho_),ixI^L,ixO^L,2,dvxdy)
    call gradient(wlocal(ixI^S,mom(1))/wlocal(ixI^S,rho_),ixI^L,ixO^L,3,dvxdz)
    call gradient(wlocal(ixI^S,mom(2))/wlocal(ixI^S,rho_),ixI^L,ixO^L,1,dvydx)
    call gradient(wlocal(ixI^S,mom(2))/wlocal(ixI^S,rho_),ixI^L,ixO^L,2,dvydy)
    call gradient(wlocal(ixI^S,mom(2))/wlocal(ixI^S,rho_),ixI^L,ixO^L,3,dvydz)
    call gradient(wlocal(ixI^S,mom(3))/wlocal(ixI^S,rho_),ixI^L,ixO^L,1,dvzdx)
    call gradient(wlocal(ixI^S,mom(3))/wlocal(ixI^S,rho_),ixI^L,ixO^L,2,dvzdy)
    call gradient(wlocal(ixI^S,mom(3))/wlocal(ixI^S,rho_),ixI^L,ixO^L,3,dvzdz)

    vort_x(ixO^S)=dvzdy(ixO^S)-dvydz(ixO^S)
    vort_y(ixO^S)=dvxdz(ixO^S)-dvzdx(ixO^S)
    vort_z(ixO^S)=dvydx(ixO^S)-dvxdy(ixO^S)

  
    w(ixO^S,vs_x)= (vort_x(ixO^S)*dvxdx(ixO^S))+(vort_y(ixO^S)*dvxdy(ixO^S))+(vort_z(ixO^S)*dvxdz(ixO^S))
    w(ixO^S,vs_y)= (vort_x(ixO^S)*dvydx(ixO^S))+(vort_y(ixO^S)*dvydy(ixO^S))+(vort_z(ixO^S)*dvydz(ixO^S))
    w(ixO^S,vs_z)= (vort_x(ixO^S)*dvzdx(ixO^S))+(vort_y(ixO^S)*dvzdy(ixO^S))+(vort_z(ixO^S)*dvzdz(ixO^S))


    w(ixO^S,vc_x)=vort_x(ixO^S)*(dvxdx(ixO^S)+dvydy(ixO^S)+dvzdz(ixO^S))
    w(ixO^S,vc_y)=vort_y(ixO^S)*(dvxdx(ixO^S)+dvydy(ixO^S)+dvzdz(ixO^S))
    w(ixO^S,vc_z)=vort_z(ixO^S)*(dvxdx(ixO^S)+dvydy(ixO^S)+dvzdz(ixO^S))
    

!   store current
    call get_current(wlocal,ixI^L,ixO^L,idirmin,curlvec)
    w(ixO^S,j1_)=curlvec(ixO^S,1)
    w(ixO^S,j2_)=curlvec(ixO^S,2)
    w(ixO^S,j3_)=curlvec(ixO^S,3)

!   store total magnetic field
    w(ixO^S,b1t_)=Btotal(ixO^S,1)
    w(ixO^S,b2t_)=Btotal(ixO^S,2)
    w(ixO^S,b3t_)=Btotal(ixO^S,3)
    


  end subroutine set_output_vars


  ! Extra routines can be placed here
  ! ...
end module mod_usr

