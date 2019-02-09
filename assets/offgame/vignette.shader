shader_type canvas_item;

uniform float vignette_intensity : hint_range(0.0, 4.0);

void fragment() {
	vec3 vignette_color = texture(TEXTURE,UV).rgb;
	COLOR     = texture(SCREEN_TEXTURE, SCREEN_UV);
	COLOR.rgb*= pow(vignette_color.rgb, vec3(vignette_intensity));
}