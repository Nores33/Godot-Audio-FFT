extends Control

const VU_COUNT = 256
const FREQ_MAX = 11050.0

const WIDTH = 256
const HEIGHT = 100
const MIN_DB = 60

var spectrum
var values = []

func _ready():
	$WaterfallTimer.start()
	$FFTTimer.start()
	spectrum = AudioServer.get_bus_effect_instance(0, 0)
	$"Waterfall Display".get_material().set_shader_parameter("time",1.0)
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

func _on_fft_timer_timeout():
	$"FFT Display".get_material().set_shader_parameter("values",values)

func _on_waterfall_timer_timeout():
	$"Waterfall Display".get_material().set_shader_parameter("values",values)
