extends Control

const VU_COUNT = 256
const FREQ_MAX = 4000.0

const WIDTH = 256
const HEIGHT = 100
const MIN_DB = 80

var spectrum
var values = []

func _ready():
	$FFTTimer.start()
	spectrum = AudioServer.get_bus_effect_instance(0, 0)
	# $"WaterfallViewport/ColorRect".get_material().set_shader_parameter("time_factor", 5)
	values.resize(VU_COUNT)
	values.fill(0.0)

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
