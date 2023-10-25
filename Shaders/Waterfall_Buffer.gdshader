shader_type canvas_item;

uniform sampler2D buffer : hint_default_black;

void fragment() {
	COLOR = texture(buffer, UV);
}
