program buffer_vs_dynamic_arrays
use iso_fortran_env
  use omp_lib
  implicit none
  integer, parameter :: default_n = 3000, default_m = 3000, default_p = 3000, default_n_loops = 1
  integer :: n, m, p, n_loops
  integer :: i, num_args
  character(len=32) :: arg
  real(8) :: t1, t2
  real(8) :: full_time1, full_time2
  integer :: total_size
  real(8), allocatable :: buffer(:)
  integer :: nthreads

  call get_command_argument(0, arg) 
  num_args = command_argument_count()

  ! Default values
  n = default_n
  m = default_m
  p = default_p
  n_loops = default_n_loops

  ! Parse command-line arguments
  if (num_args >= 1) call get_command_argument(1, arg); read(arg, *) n
  if (num_args >= 2) call get_command_argument(2, arg); read(arg, *) m
  if (num_args >= 3) call get_command_argument(3, arg); read(arg, *) p
  if (num_args >= 4) call get_command_argument(4, arg); read(arg, *) n_loops

  nthreads = omp_get_max_threads()
  print *, "Matrix dimensions: n =", n, ", m =", m, ", p =", p
  print *, "Number of loops: ", n_loops
  print *, "Using ", nthreads
  
  ! Total size for preallocated buffer
  total_size = n*m + m*p + n*p
  ! First Approach: Preallocated Buffer (fast memory access)
  ! I want to get the timing of the big allocation
  allocate(buffer(total_size))
  full_time1 = 0.0d0
  do i = 1, n_loops
    call preallocated_buffer_approach(n, m, p, buffer, full_time1)
  end do
    deallocate(buffer)

  ! Second Approach: On-the-fly allocation
  t1 = omp_get_wtime()
  do i = 1, n_loops
    call dynamic_allocation_approach(n, m, p)
  end do
  t2 = omp_get_wtime()
  full_time2 = t2 - t1

  ! Print results
  print *, "Preallocated buffer time: ", full_time1/n_loops
  print *, "Dynamic allocation time: ", full_time2/n_loops
contains

  subroutine preallocated_buffer_approach(n, m, p, buffer, time_out)
  implicit none
    integer, intent(in) :: n, m, p
    real(8), allocatable, intent(inout) :: buffer(:)
    real(8), intent(inout) :: time_out
    real(8), pointer :: A(:,:), B(:,:), C(:,:)
    integer :: total_size
    real(8) :: t1, t2, time
    real(8) :: flops 
    


    ! Point the pointer arrays to slices of the buffer
    call assign_pointers(A, B, C, buffer, n, m, p)

    ! Initialize matrices A and B
    A = 1.0
    B = 2.0
    C = 0.0

    ! Perform matrix multiplication C = A * B
    !call matrix_multiply_optimized(A, B, C, n, m, p)
  t1 = omp_get_wtime()
    call dgemm('N', 'N', M, N, M, 1.0D0, A, M, B, M, 0.0D0, C, M)
  t2 = omp_get_wtime()
  flops = 2 * m * n * p 
  flops = flops / (1d9)
  time = t2 - t1 
  print *, "time for dgemm ", time
  time_out = time_out + time

  end subroutine preallocated_buffer_approach


  subroutine dynamic_allocation_approach(n, m, p)
    integer, intent(in) :: n, m, p
    real(8), allocatable :: A(:,:), B(:,:), C(:,:)
    real(8) :: t1, t2, time
    real(8) :: flops 


    ! Dynamically allocate arrays just before usage
    allocate(A(n, m))
    allocate(B(m, p))
    allocate(C(n, p))

    ! Initialize matrices A and B
    A = 1.0
    B = 2.0
    C = 0.0

    ! Perform matrix multiplication C = A * B
    !call matrix_multiply_optimized(A, B, C, n, m, p)
  t1 = omp_get_wtime()
    call dgemm('N', 'N', M, N, M, 1.0D0, A, M, B, M, 0.0D0, C, M)
  t2 = omp_get_wtime()
  flops = 2 * m * n * p 
  flops = flops / (1d9)
  time = t2 - t1 
  print *, time



    ! Deallocate the arrays after computation
    deallocate(A)
    deallocate(B)
    deallocate(C)
  end subroutine dynamic_allocation_approach

subroutine assign_pointers(A, B, C, buffer, n, m, p)
    real(8), pointer :: A(:,:), B(:,:), C(:,:)
    real(8), allocatable, intent(inout) :: buffer(:)
    integer, intent(in) :: n, m, p

    ! Map pointers A, B, and C to sections of the buffer
    call pointer_map(A, buffer, 1, n, m)
    call pointer_map(B, buffer, n*m + 1, m, p)
    call pointer_map(C, buffer, n*m + m*p + 1, n, p)

end subroutine assign_pointers

subroutine pointer_map(mat, buf, start_idx, rows, cols)
    real(8), pointer :: mat(:,:)
    real(8), target, allocatable, intent(inout) :: buf(:)
    integer, intent(in) :: start_idx, rows, cols

    mat(1:rows, 1:cols) => buf(start_idx:start_idx + rows*cols - 1)

end subroutine pointer_map

subroutine matrix_multiply_optimized(A, B, C, n, m, p)
  use omp_lib
  integer, intent(in) :: n, m, p
  real(8), intent(in) :: A(n, m), B(m, p)
  real(8), intent(inout) :: C(n, p)
  integer :: i, j, k
  real(8) :: t1, t2

  t1 = omp_get_wtime()

  ! random omp bullshit go!
  !$omp parallel do collapse(2) private(i, j, k) shared(A, B, C) schedule(static)
  do i = 1, n
    do j = 1, p
      do k = 1, m
        C(i, j) = C(i, j) + A(i, k) * B(k, j)
      end do
    end do
  end do
  t2 = omp_get_wtime()

  print *, "time for mult", t2-t1
end subroutine matrix_multiply_optimized

end program buffer_vs_dynamic_arrays


