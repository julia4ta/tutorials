using Gtk

# convert glade file using GtkBuilder()

glade = GtkBuilder(filename = "thermostat.glade")

# assign variables

window = glade["window"]
f_label = glade["f_label"]
c_label = glade["c_label"]
up_button = glade["up_button"]
down_button = glade["down_button"]

# define f to c function

function f_to_c(f)
    Int(round((f - 32) * 5 / 9))
end

# convert f_label from String to Int

f_string = get_gtk_property(f_label, :label, String)
f_int = parse(Int, f_string[1:2])

# convert f_int to Celsius

c_int = f_to_c(f_int)

# convert c_int to String

c_string = string(c_int, "\U000B0", "C")

# assign c_string to c_label

GAccessor.text(c_label, c_string)

# add degree sign to f_label

f_string = string(f_int, "\U000B0", "F")
GAccessor.text(f_label, f_string)

# launch gui

showall(window)

# define update_gui function

function update_gui(f_int)
    global c_int = f_to_c(f_int)
    global f_string = string(f_int, "\U000B0", "F")
    global c_string = string(c_int, "\U000B0", "C")
    GAccessor.text(f_label, f_string)
    GAccessor.text(c_label, c_string)
end

# set button callbacks

id1 = signal_connect(up_button, "button-press-event") do widget, event
    global f_int += 1
    update_gui(f_int)
end

id2 = signal_connect(down_button, "button-press-event") do widget, event
    global f_int -= 1
    update_gui(f_int)
end
