shader_type canvas_item;

#define SAMPLES 256

uniform float values[SAMPLES];

uniform float time_factor = 0.1;

uniform sampler2D prev;
uniform sampler2D Color_Gradient : hint_default_black;

void fragment() {
	vec2 tex_size = vec2(textureSize(prev, 0));
	float pixel_size = 1.0/tex_size.y;
	
	float time_elapsed = mod(TIME, time_factor);
	
	if(time_elapsed < pixel_size){
		if (UV.y < pixel_size) {
			vec3 sampled_color = texture(Color_Gradient, vec2(values[int(UV.x * float(SAMPLES))]/100.0, 0.0)).rgb;
			COLOR = vec4(sampled_color, 1.0);
		} else {
			COLOR = texture(prev, UV.xy-vec2(0,1) / vec2(textureSize(prev, 0)));
		}
	}
	else{
		COLOR = texture(prev, UV);
	}
}