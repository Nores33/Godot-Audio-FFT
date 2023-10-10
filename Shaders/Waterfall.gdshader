shader_type canvas_item;

const float values[100] = {70.0f, 42.0f, 100.0f, 55.0f, 31.0f, 77.0f, 16.0f, 3.0f, 7.0f, 20.0f, 71.0f, 84.0f, 5.0f, 69.0f, 47.0f, 46.0f, 86.0f, 48.0f, 23.0f, 43.0f, 37.0f, 41.0f, 93.0f, 74.0f, 85.0f, 17.0f, 81.0f, 79.0f, 2.0f, 25.0f, 96.0f, 52.0f, 67.0f, 53.0f, 80.0f, 64.0f, 26.0f, 68.0f, 12.0f, 13.0f, 99.0f, 59.0f, 65.0f, 56.0f, 50.0f, 98.0f, 19.0f, 34.0f, 97.0f, 21.0f, 87.0f, 83.0f, 10.0f, 73.0f, 61.0f, 29.0f, 92.0f, 14.0f, 38.0f, 27.0f, 9.0f, 35.0f, 1.0f, 60.0f, 91.0f, 6.0f, 39.0f, 49.0f, 11.0f, 94.0f, 24.0f, 62.0f, 78.0f, 76.0f, 58.0f, 72.0f, 66.0f, 36.0f, 95.0f, 75.0f, 22.0f, 28.0f, 18.0f, 33.0f, 89.0f, 15.0f, 40.0f, 30.0f, 32.0f, 45.0f, 4.0f, 63.0f, 54.0f, 8.0f, 90.0f, 44.0f, 57.0f, 51.0f, 82.0f, 80.0f}; 
uniform float time : hint_range(0, 1000); // Time variable to control animation

void fragment() {
    // Calculate current index based on time (values from 0 to 99)
    float index = mod(time, 200.0) / 2.0;

    // Calculate position based on index
    float x = mod(index, 10.0); // 10 elements per row
    float y = floor(index / 10.0); // 10 rows

    // Move pixels drawn at y=0 to y=1 after finishing one cycle
    y += step(100.0, mod(time, 200.0)); // Move to y=1 after finishing one cycle

    // Get the value from data_array based on the current index
    float value = values[int(UV.x * 100.0)];

    // Define colors
    vec3 blue = vec3(0.0, 0.0, 1.0);
    vec3 green = vec3(0.0, 1.0, 0.0);
    vec3 yellow = vec3(1.0, 1.0, 0.0);
    vec3 orange = vec3(1.0, 0.5, 0.0);
    vec3 red = vec3(1.0, 0.0, 0.0);

    // Interpolation factors
    float t_blue_to_green = smoothstep(0.0, 25.0, value); // Interpolate from blue to green for the first 25 units
    float t_green_to_yellow = smoothstep(25.0, 50.0, value); // Interpolate from green to yellow for the next 25 units
    float t_yellow_to_orange = smoothstep(50.0, 75.0, value); // Interpolate from yellow to orange for the next 25 units
    float t_orange_to_red = smoothstep(75.0, 100.0, value); // Interpolate from orange to red for the last 25 units

    // Interpolate between colors based on the value
    vec3 interpolatedColor = mix(blue, green, t_blue_to_green);
    interpolatedColor = mix(interpolatedColor, yellow, t_green_to_yellow);
    interpolatedColor = mix(interpolatedColor, orange, t_yellow_to_orange);
    interpolatedColor = mix(interpolatedColor, red, t_orange_to_red);

    // Output final color with alpha 1.0
    COLOR = vec4(interpolatedColor, 1.0);
}

