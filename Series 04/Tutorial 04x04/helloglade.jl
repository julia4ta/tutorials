using Gtk

# convert glade file using GtkBuilder()

glade = GtkBuilder(filename = "HelloGlade.glade")

# assign variables

window = glade["window"]
label = glade["label"]
button = glade["button"]

# launch GUI

showall(window)

# set button callback

id = signal_connect(button, "button-press-event") do widget, event
    if get_gtk_property(label, :label, String) == "Hello, World!"
        GAccessor.text(label, "Hello, Julia!")
    else
        GAccessor.text(label, "Hello, World!")
    end
end
