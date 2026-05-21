shader_type canvas_item;

uniform vec4 color1: source_color;
uniform vec4 color2: source_color;
uniform bool right_to_left = true;
uniform float desired_angle: hint_range(0.0,180.0);
uniform float speed = 20.0;
uniform float width = 40.0;

void fragment() {
	float desired_angle_rad = radians(desired_angle);
	float time_offset = TIME * speed;
	vec2 stretched_uv = FRAGCOORD.xy;
	float pattern = mod(stretched_uv.x * cos(desired_angle_rad) + (stretched_uv.y * 1.0/TEXTURE_PIXEL_SIZE.y) * sin(desired_angle_rad) + time_offset * ((right_to_left)? 1.0: -1.0), width * 2.0);
	if (pattern < width) {
		COLOR = color1;
	} else {
		COLOR = color2;
	}
	// Called for every pixel the material is visible on.
}