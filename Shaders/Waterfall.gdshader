shader_type canvas_item;

#define SAMPLES 256

uniform float speed;
uniform float values[SAMPLES];

uniform sampler2D prev;
uniform sampler2D Color_Gradient : hint_default_black;

void fragment() {
	// Place fragment code here.
	if (UV.y < 1.0/float(textureSize(prev,0).y)) {
		vec3 sampled_color = texture(Color_Gradient, vec2(values[int(UV.x * float(SAMPLES))]/100.0, 0.0)).rgb;
		COLOR = vec4(sampled_color, 1.0);
	} else {
		COLOR = texture(prev, vec2(UV.x, UV.y - 1.0/float(textureSize(prev,0).y)));
	}
}