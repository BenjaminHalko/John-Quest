varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float percent;
uniform vec3 color;

void main()
{
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	gl_FragColor.rgb = mix(gl_FragColor.rgb,color,percent);
}
