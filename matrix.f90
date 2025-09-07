
program matrix
        implicit none

        integer :: N, M
        real, allocatable :: mat(:, :)

        integer :: i

        real :: val

        print '(A)', "Enter the dimensions of your matrix:"
        read(*, *) N, M

        allocate(mat(N, M))

        do i = 1, N

                print '(A, I0, A, I0, A)', "Enter ", M, " numbers for row ", i, ": "
        
                read(*, *) mat(i, :)

        end do

        val = det(mat)

        print *, val

        deallocate(mat)

contains

recursive real function det(A) result(f)
        implicit none

        real, intent(in) :: A(:, :)

        integer :: i0, j0, i_N, j_N
        integer :: sign
        integer :: N

        integer :: x, y, j

        real :: B(size(A,1)-1, size(A,2)-1)

        ! We determine the bounds manually

        i0 = lbound(A, 1)
        j0 = lbound(A, 2)
        i_N = ubound(A, 1)
        j_N = ubound(A, 2)

        f = 0.0

        if (size(A, 1) /= size(A, 2)) then
                print *, "This matrix does not admit a determinant."
                f = 0.0
                return
        end if

        N = size(A, 1)
        
        if (N == 1) then
                f = A(i0, j0)
                return
        end if

        if (N == 2) then
                f = A(i0, j0) * A(i0+1, j0+1) - A(i0 + 1, j0) * A(i0, j0 + 1) 
                return
        end if

        sign = 1

        do j = j0, j_N
                ! Removing row x
                x = i0
                ! Removing column y
                y = j

                ! Filling top left corner

                B(1:x-i0, 1:y-j0) = A(i0:x-1, j0:y-1)

                ! Filling top right corner

                B(1: x-i0, y-j0+1:) = A(i0: x-1, y+1:)

                ! Filling bottom left corner

                B(x-i0+1:, 1:y-j0) = A(x+1:, j0:y-1)

                ! Filling bottom right corner

                B(x-i0+1:, y-j0+1:) = A(x+1:, y+1:)

                f = f + sign * A(x, y) * det(B)
                sign = sign * (-1)
        end do
        
end function det
end program matrix










