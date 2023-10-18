shader_type canvas_item;

#define SAMPLES 256

uniform float values[SAMPLES];

vec4 Draw_FFT(float x, float y){
	if(x < float(SAMPLES)){
		float end_line = values[int(x)];
		if(y < end_line){
			return vec4(0.5,0.0,1.0,1.0); //return purple
		}
	}
	return vec4(0.0, 0.0, 0.0, 1.0); //return black
}

void fragment() {
	COLOR = Draw_FFT(UV.x * float(SAMPLES), (1.0 - UV.y) * 100.0);
}
