shader_type canvas_item;

uniform float vignette_intensity : hint_range(0.0, 4.0);

void fragment() {
	vec3 vignette_color = texture(TEXTURE,UV).rgb;
	//screen texture stores gaussian blurred copies on mipmaps
//	COLOR.rgb = textureLod(SCREEN_TEXTURE,SCREEN_UV,(1.0-vignette_color.r)*2.0).rgb;
	COLOR     = texture(SCREEN_TEXTURE, SCREEN_UV);
	COLOR.rgb*= pow(vignette_color.rgb, vec3(vignette_intensity));
}