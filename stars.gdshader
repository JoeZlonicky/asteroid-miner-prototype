shader_type canvas_item;

uniform vec4 star_color : source_color = vec4(1.0);

void fragment() {
	vec2 pos = FRAGCOORD.xy;
	if (cos(sin(pos.x) + sin(pos.y)) > 0.999999) {
		COLOR = star_color;
	}
}
