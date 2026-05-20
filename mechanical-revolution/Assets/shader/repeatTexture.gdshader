shader_type canvas_item;
uniform sampler2D repeated_text;
uniform vec2 repeats = vec2(2.0,2.0);

void fragment() {

	vec2 splitUV = vec2(UV.x/repeats.x,UV.y/repeats.y);
	
	vec4 repeated_texture_color = texture(repeated_text,vec2(mod(UV.x*repeats.x, 1.0),  mod(UV.y*repeats.y, 1.0)) );
	COLOR = repeated_texture_color;
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
