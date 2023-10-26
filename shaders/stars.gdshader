shader_type canvas_item;

uniform vec4 background_color: source_color = vec4(0.0, 0.0, 0.0, 1.0);

uniform sampler2D noise;
uniform float star_density: hint_range(0.01, 1);
uniform vec4 star_color: source_color = vec4(1.0);
uniform float color_mix: hint_range(0.0, 1) = 0.0;

uniform vec2 offset;

bool test(vec2 position, float threshold) {
	return texture(noise, position).r > threshold;
}

void fragment() {
	float threshold = 1.0 - 0.1 * star_density;
	vec2 pos = UV + offset / vec2(1920, 1080);
	if (test(pos, threshold)) {
		COLOR = mix(background_color, star_color, 1.0 - color_mix);
	} else {
		COLOR = background_color;
	}
}
