shader_type canvas_item;

#define SAMPLES 256
#define TOLERANCE 0.5

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

vec4 Draw_FFT_Lines(float x, float y){
    if(x < float(SAMPLES)){
        float start_line = values[int(x)];
        float end_line = values[int(x)+1];
        if((y < start_line && y > end_line)||(y > start_line && y < end_line)||(y > values[int(x)]-TOLERANCE && y < values[int(x)]+TOLERANCE)){
            return vec4(0.5, 0.0, 1.0, 1.0); //return purple
        }
    }
    return vec4(0.0, 0.0, 0.0, 1.0); //return black
}

vec4 Draw_FFT_Points(float x, float y){
    if(x < float(SAMPLES)){
        float value = values[int(x)];
        if(y > value-TOLERANCE && y < value+TOLERANCE){
            return vec4(0.5, 0.0, 1.0, 1.0); //return purple
        }
    }
    return vec4(0.0, 0.0, 0.0, 1.0); //return black
}

void fragment() {
	COLOR = Draw_FFT_Lines(UV.x * float(SAMPLES), (1.0 - UV.y) * 100.0);
}
