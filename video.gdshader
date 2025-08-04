shader_type canvas_item;

uniform vec4 dark_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 light_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float threshold : hint_range(0.0, 1.0) = 0.5;
uniform float smoothness : hint_range(0.0, 0.5) = 0.1;

void fragment() {
    // Flip UV coordinates horizontally
    vec2 flipped_uv = vec2(1.0 - UV.x, UV.y);
    vec4 tex_color = texture(TEXTURE, flipped_uv);

    // Calculate grayscale value
    float gray = dot(tex_color.rgb, vec3(0.299, 0.587, 0.114));

    // Create smooth transition between colors based on threshold
    float factor = smoothstep(threshold - smoothness, threshold + smoothness, gray);

    // Mix between dark and light colors
    vec3 final_color = mix(dark_color.rgb, light_color.rgb, factor);

    COLOR = vec4(final_color, tex_color.a);
}