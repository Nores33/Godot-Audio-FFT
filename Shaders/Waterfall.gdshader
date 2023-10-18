shader_type canvas_item;

#define SAMPLES 256

uniform float values[SAMPLES];
uniform float time : hint_range(0, 1000); // Time variable to control animation
uniform sampler2D Color_Gradient : hint_default_black;

void fragment() {
    // Calculate current index based on time (values from 0 to 99)
    float index = mod(time, 200.0) / 2.0;

    // Calculate position based on index
    float x = mod(index, 10.0); // 10 elements per row
    float y = floor(index / 10.0); // 10 rows

    // Move pixels drawn at y=0 to y=1 after finishing one cycle
    y += step(1.0, mod(time, 2.0)); // Move to y=1 after finishing one cycle

    // Get the value from data_array based on the current index
    float value = values[int(UV.x * float(SAMPLES))];

   	vec3 sampled_color = texture(Color_Gradient, vec2(value/100.0, 0.0)).rgb;

    // Output final color with alpha 1.0
    COLOR = vec4(sampled_color, 1.0);
}

