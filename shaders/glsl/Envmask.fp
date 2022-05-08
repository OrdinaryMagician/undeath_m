// basic texture + masked equirectangular envmap + gradient rim
#define RECIPROCAL_PI2 0.15915494

#ifndef RIMSTEP
#define RIMSTEP .5
#endif
#ifndef ENVFACT
#define ENVFACT 1.
#endif
#ifndef RIMFACT
#define RIMFACT 1.
#endif

void SetupMaterial( inout Material mat )
{
	vec4 base = getTexel(vTexCoord.st);
	float mask = texture(masktex,vTexCoord.st).x;
	vec3 norm = normalize(vWorldNormal.xyz);
	vec3 eye = normalize(uCameraPos.xyz-pixelpos.xyz);
	vec3 rvec = normalize(reflect(eye,norm));
	vec2 uv = vec2(atan(rvec.z,rvec.x)*RECIPROCAL_PI2+.5,asin(rvec.y)*RECIPROCAL_PI2+.5);
	vec2 uv2 = vec2(atan(rvec.z,abs(rvec.x))*RECIPROCAL_PI2+.5,asin(rvec.y)*RECIPROCAL_PI2+.5);
	vec3 envcol = textureGrad(envtex,uv,dFdx(uv2),dFdy(uv2)).rgb*ENVFACT;
#ifdef RIM_LIGHTING
	float rim = smoothstep(RIMSTEP,1.,1.-abs(dot(eye,norm)));
	vec3 rimcol = texture(rimtex,vec2(.25+.5*rim,.5)).rgb;
	envcol = mix(envcol,rimcol,rim*RIMFACT);
#endif
	mat.Base = vec4(base.rgb+envcol*mask,base.a);
	mat.Normal = ApplyNormalMap(vTexCoord.st);
	if ( (uTextureMode&TEXF_Brightmap) != 0 )
		mat.Bright = texture(brighttexture,vTexCoord.st);
}
