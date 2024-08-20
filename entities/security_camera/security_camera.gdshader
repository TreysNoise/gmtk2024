shader_type spatial;
render_mode cull_disabled;

varying float model_y;
void vertex() {
	model_y = smoothstep(0.0, 1.0, VERTEX.y);
}
void fragment() {
	ALBEDO = vec3(1.0, 0.0, 0.0);
	ALPHA = model_y;
}
