# Followed Tutorial: https://www.youtube.com/watch?app=desktop&v=6rMezOhK87Y
extends Control

@export var Line_Color : Color = Color.YELLOW
@export var BG_Color : Color = Color.BLACK

@export var X_Label = ""
@export var X_ticks = 1
@export var Y_Label = ""
@export var Y_ticks = 1

var X_min_value
var X_max_value

var Y_min_value
var Y_max_value

func _ready():
	# Not working
	$Y_Label.set_text(Y_Label)
	$X_Label.set_text(X_Label)
	
	for i in range(X_ticks):
		var x_tick = Label.new()
		x_tick.add_theme_font_size_override("font size", 5)
		x_tick.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		x_tick.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		x_tick.text = "0"
		$X_Ticks_Container.add_child(x_tick)
	
	for i in range(Y_ticks):
		var y_tick = Label.new()
		y_tick.add_theme_font_size_override("font size", 5)
		y_tick.size_flags_vertical = Control.SIZE_EXPAND_FILL
		y_tick.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		y_tick.text = "0"
		$Y_Ticks_Container.add_child(y_tick)
