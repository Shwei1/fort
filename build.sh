gfortran -Wall -Wextra -std=f2008 -pedantic -g gtk_app.f90 $(pkg-config --cflags --libs gtk-4-fortran) -o app
