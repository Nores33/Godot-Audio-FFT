extends Control

const VU_COUNT = 256
const FREQ_MAX = 10000.0

const WIDTH = 256
const HEIGHT = 100
@export var MIN_DB = 60

var spectrum
var values = []

# FFT Graph
@export var Line_Color : Color = Color.WHITE
@export var BG_Color : Color = Color.BLACK
@export var Grid_Lines_Color : Color = Color.WEB_GRAY
@export var with_fill : bool = false
@export var Fill_Color : Color = Color.DIM_GRAY

@export var X_Label : String = "Hz"
@export_range(1,10) var X_ticks : int = 1
@export var Y_Label : String = "dB"
@export_range(1,5) var Y_ticks : int = 1

var X_max_value : float = FREQ_MAX/1000.0
var X_min_value : float = 0

var Y_max_value : float = 0
var Y_min_value : float = -MIN_DB

func _ready():
	$FFTTimer.start()
	spectrum = AudioServer.get_bus_effect_instance(0, 0)
	# $"WaterfallViewport/ColorRect".get_material().set_shader_parameter("time_factor", 5)
	values.resize(VU_COUNT)
	values.fill(0.0)
	
	# Prepare FFT Graph
	$"Panel/FFT Graph/Y_Label".set_text(Y_Label)
	$"Panel/FFT Graph/X_Label".set_text(X_Label)
	
	$"Panel/FFT Graph/FFT Display".get_material().set_shader_parameter("line_color", Line_Color)
	$"Panel/FFT Graph/FFT Display".get_material().set_shader_parameter("bg_color", BG_Color)
	$"Panel/FFT Graph/FFT Display".get_material().set_shader_parameter("grid_lines_color", Grid_Lines_Color)
	$"Panel/FFT Graph/FFT Display".get_material().set_shader_parameter("fill_color", Fill_Color)
	$"Panel/FFT Graph/FFT Display".get_material().set_shader_parameter("with_fill", with_fill)
	$"Panel/FFT Graph/FFT Display".get_material().set_shader_parameter("vertical_grid_lines", X_ticks)
	$"Panel/FFT Graph/FFT Display".get_material().set_shader_parameter("horizontal_grid_lines", Y_ticks)
	
	var freq_steps = X_max_value/X_ticks
	for i in range(X_ticks):
		var x_tick = Control.new()
		x_tick.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		$"Panel/FFT Graph/X_Ticks_Container".add_child(x_tick)
		x_tick = Label.new()
		x_tick.vertical_alignment=VERTICAL_ALIGNMENT_CENTER
		x_tick.text = "%.2f" % (freq_steps*(i+1))
		$"Panel/FFT Graph/X_Ticks_Container".add_child(x_tick)
	
	var db_steps = Y_min_value/Y_ticks
	for i in range(Y_ticks):
		var y_tick = Control.new()
		y_tick.size_flags_vertical = Control.SIZE_EXPAND_FILL
		$"Panel/FFT Graph/Y_Ticks_Container".add_child(y_tick)
		y_tick = Label.new()
		y_tick.horizontal_alignment=HORIZONTAL_ALIGNMENT_CENTER
		y_tick.text = "%.1f" % (db_steps*(i+1))
		$"Panel/FFT Graph/Y_Ticks_Container".add_child(y_tick)

func _process(_delta):
	var data = []
	var prev_hz = 0

	for i in range(1, VU_COUNT + 1):
		var hz = i * FREQ_MAX / VU_COUNT
		var magnitude = spectrum.get_magnitude_for_frequency_range(prev_hz, hz).length()
		var energy = clampf((MIN_DB + linear_to_db(magnitude)) / MIN_DB, 0, 1)
		var height = energy * HEIGHT
		data.append(height)
		prev_hz = hz
	
	for i in range(VU_COUNT):
		values[i] = data[i]
	
	$"Panel/Waterfall Graph/WaterfallViewport/ColorRect".get_material().set_shader_parameter("values",values)

func _on_fft_timer_timeout():
	$"Panel/FFT Graph/FFT Display".get_material().set_shader_parameter("values",values)
