module HelloGtkApp

    using Gtk

    function hellogtkapp()

        # design gui layout

        win = GtkWindow("Hello Gtk!")
        vbox = GtkBox(:v)
        push!(win, vbox)
        label = GtkLabel("Hello, World!")
        GAccessor.justify(label, Gtk.GConstants.GtkJustification.CENTER)
        push!(vbox, label)
        button = GtkButton("Click Me!")
        push!(vbox, button)
        set_gtk_property!(vbox, :expand, label, true)

        # set button callback

        id = signal_connect(button, "button-press-event") do widget, event
            if get_gtk_property(vbox[1], :label, String) == "Hello, World!"
                GAccessor.text(label, "Hello, Julia!")
            else
                GAccessor.text(label, "Hello, World!")
            end
        end

        # launch gui

        showall(win)

        while true
            println("(hit Enter to end session)")
            input = readline()
            if input == ""
                break
            end
        end

    end

    function julia_main()
        hellogtkapp()
    end

end
