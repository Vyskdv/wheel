shader_type canvas_item;
render_mode unshaded;

uniform sampler2D base_texture;
uniform float speed = 1.0;
uniform float max_time = 3.0;


const float EPSILON = 0.0001;

vec2 rotateUV(vec2 uv, vec2 pivot, float rotation) {
	float cos_rot = cos(rotation);
	float sin_rot = sin(rotation);
	mat2 rotation_matrix=mat2(	vec2(sin_rot,-cos_rot),
								vec2(cos_rot,sin_rot)
								);

    if (rotation <= 0.0 + EPSILON){
        rotation = 0.0;
    }
	uv -= pivot;
    uv= uv * rotation_matrix;
    uv += pivot;
	return uv;
}

void vertex() {
    float current_rotation = (max_time - TIME) * (max_time - TIME) * speed;

    if (current_rotation <= 0.0){
        current_rotation = 0.0;
    }
	
	vec2 rotated_uv = rotateUV(VERTEX, 0.5/TEXTURE_PIXEL_SIZE, current_rotation);

	VERTEX = rotated_uv;
}
