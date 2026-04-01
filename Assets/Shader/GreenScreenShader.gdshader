shader_type canvas_item;
render_mode unshaded;

// Uniform variables for chroma key effect
uniform vec4 chroma_key_color : source_color = vec4(0.0, 1.0, 0.0, 1.0);
uniform float pickup_range : hint_range(0.0, 1.0) = 0.1;
uniform float fade_amount : hint_range(0.0, 1.0) = 0.1;

const float EPSILON = 0.01;

void fragment() {
    // Get the color from the texture at the given UV coordinates
    vec4 color = texture(TEXTURE, UV);
	
	//This is kind of sloppy, but you're basically only allowed to have 2 transparency values: 0.0 and 1.0.
	//If it's less than 1.0, it's 0.0, and that means skip the shader.
	if (chroma_key_color.a < 1.0 - EPSILON) {
		COLOR = COLOR = vec4(color.rgb, 1.0);
	}
	else {
		vec3 chroma_key_vec3 = vec3(chroma_key_color.r, chroma_key_color.g, chroma_key_color.b);
		float alpha = chroma_key_color.a;

	    // Calculate the distance between the current color and the chroma key color
	    float distance = length(color.rgb - chroma_key_vec3);

	    // If the distance is within the pickup range, discard the pixel
	    // the lesser the distance more likely the colors are
	    if (distance <= pickup_range) {
	        discard;
	    }

	    // Calculate the fade factor based on the pickup range and fade amount
	    float fade_factor = smoothstep(pickup_range, pickup_range + fade_amount, distance);

	    // Set the output color with the original RGB values and the calculated fade factor
	    COLOR = vec4(color.rgb, fade_factor);
	}
}