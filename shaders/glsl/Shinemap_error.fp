// pseudo-matcap + ambient glow

void SetupMaterial( inout Material mat )
{
	vec3 rnorm = normalize(vEyeNormal.xyz)*vec3(1,-1,1);
	mat.Base = getTexel(rnorm.xy*.49+.5);
	mat.Normal = ApplyNormalMap(vTexCoord.st);
}

vec4 ProcessLight( Material mat, vec4 color )
{
	float glow = .75+.25*sin(timer*8);
	return vec4(vec3(glow),color.a);
}
