module handlers
    use, intrinsic :: iso_c_binding
    use gtk, only: gtk_application_new, G_APPLICATION_FLAGS_NONE,&
        g_signal_connect, gtk_application_window_new, gtk_widget_show, &
        gtk_window_set_title, GTK_ORIENTATION_VERTICAL, gtk_box_new, &
        gtk_window_set_child, gtk_box_append, gtk_button_new_with_label, &
        g_signal_connect
    use g, only: g_application_run, g_object_unref 

    implicit none

    contains

        subroutine activate(app, gdata) bind(c)
            type(c_ptr), value, intent(in) :: app, gdata
            type(c_ptr) :: window
            type(c_ptr) :: box, my_button;
            
            ! Getting new units
            box = gtk_box_new(GTK_ORIENTATION_VERTICAL, 10_c_int)
            window = gtk_application_window_new(app)
            my_button = gtk_button_new_with_label("Calculate"//c_null_char)            
            call gtk_window_set_child(window, box)
            call gtk_box_append(box, my_button)
            call g_signal_connect(my_button, "clicked"//c_null_char, &
                c_funloc(my_button_clicked))

            call gtk_window_set_title(window, "Kosiak :)"//c_null_char)
            call gtk_widget_show(window)
        end subroutine activate

        subroutine my_button_clicked(widget, gdata) bind(c)
            type(c_ptr), value, intent(in) :: widget, gdata
            print '(A)', "Button has been clicked!"
        end subroutine

end module handlers

program gtk_app
    use handlers

    implicit none

    type(c_ptr) :: app
    integer(c_int) :: status
    
    app = gtk_application_new("gtk-fortran.my_first_gtk_app"//c_null_char, &
        G_APPLICATION_FLAGS_NONE)

    call g_signal_connect(app, "activate"//c_null_char, c_funloc(activate), c_null_ptr)
    status = g_application_run(app, 0_c_int, [c_null_ptr])
    call g_object_unref(app)
        

end program gtk_app
        
