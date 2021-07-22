// equirectangular envmap
#define RECIPROCAL_PI2 0.15915494

void SetupMaterial( inout Material mat )
{
	vec3 norm = normalize(vWorldNormal.xyz);
	vec3 eye = normalize(uCameraPos.xyz-pixelpos.xyz);
	vec3 rvec = normalize(reflect(eye,norm));
	vec2 uv = vec2(atan(-rvec.z,-rvec.x)*RECIPROCAL_PI2+.5,rvec.y*.5+.5);
	vec2 uv2 = vec2(atan(-rvec.z,abs(rvec.x))*RECIPROCAL_PI2+.5,rvec.y*.5+.5);
	mat.Base = textureGrad(tex,uv,dFdx(uv2),dFdy(uv2));
	mat.Normal = ApplyNormalMap(vTexCoord.st);
}
