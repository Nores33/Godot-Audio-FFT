shader_type canvas_item;

#define SAMPLES 256
#define TOLERANCE 0.5

uniform float values[SAMPLES];
uniform vec4 line_color = vec4(1.0,1.0,1.0,1.0);
uniform vec4 bg_color = vec4(0.0,0.0,0.0,1.0);

uniform int vertical_grid_lines = 9;
uniform int horizontal_grid_lines = 3; 

vec4 Draw_Grid(float x, float y){
	float line_ratio = 0.04;
	float cell_width = float(SAMPLES)/float(vertical_grid_lines);
	float cell_height = 100.0/float(horizontal_grid_lines);
	for(int i=1; i<vertical_grid_lines; i++){
		float x_pos = float(i)*cell_width;
		if(x > x_pos && x < x_pos+line_ratio*cell_width){
			return vec4(0.2,0.2,0.2,1.0);
		}
	}
	for(int i=1; i<horizontal_grid_lines; i++){
		float y_pos = float(i)*cell_height;
		if(y > y_pos && y < y_pos+line_ratio*cell_width){
			return vec4(0.2,0.2,0.2,1.0);
		}
	}
	return bg_color; //return black
}

vec4 Draw_FFT(float x, float y){
	if(x < float(SAMPLES)){
		float end_line = values[int(x)];
		if(y < end_line){
			return line_color; //return purple
		}
	}
	return bg_color; //return black
}

vec4 Draw_FFT_Lines(float x, float y){
    if(x < float(SAMPLES)){
        float start_line = values[int(x)];
        float end_line = values[int(x)+1];
        if((y < start_line && y > end_line)||(y > start_line && y < end_line)||(y > values[int(x)] && y < values[int(x)]+2.0*TOLERANCE)){
            return line_color; //return purple
        }
    }
    return Draw_Grid(x,y); //return grid
}

vec4 Draw_FFT_Points(float x, float y){
    if(x < float(SAMPLES)){
        float value = values[int(x)];
        if(y > value && y < value+2.0*TOLERANCE){
            return line_color; //return purple
        }
    }
    return bg_color; //return black
}

void fragment() {
	COLOR = Draw_FFT_Lines(UV.x * float(SAMPLES), (1.0 - UV.y) * 100.0);
}
