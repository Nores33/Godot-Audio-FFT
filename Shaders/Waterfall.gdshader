shader_type canvas_item;

#define SAMPLES 256

uniform float values[SAMPLES];
uniform float time : hint_range(0, 1000); // Time variable to control animation
uniform sampler2D Color_Gradient : hint_default_black;

void fragment() {
    float value = values[int(UV.x * float(SAMPLES))];

   	vec3 sampled_color = texture(Color_Gradient, vec2(value/100.0, 0.0)).rgb;

    // Output final color with alpha 1.0
    COLOR = vec4(sampled_color, 1.0);
}

