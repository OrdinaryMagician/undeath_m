// overexposed zoom blur

void main()
{
	vec2 p = (vec2(.5,.55)-TexCoord)*vec2(1.25,1.);
	vec4 res = texture(InputTexture,TexCoord)*8.;
	vec2 d = (p/150.);
	float w = .35;
	vec2 s = TexCoord;
	for ( int i=0; i<64; i++ )
	{
		res += w*texture(InputTexture,s);
		w *= .995;
		s += d;
	}
	res /= 16.;
	FragColor = vec4(res.rgb,1.);
}
