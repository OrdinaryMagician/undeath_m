// This should act as Bilinear filtering when texture filtering is disabled
// the algo is pretty much public domain, so no credit given

void SetupMaterial( inout Material mat )
{
	vec2 size = textureSize(tex,0);
	vec2 pxsize = vec2(1./size.x,1./size.y);
	vec2 pos = vTexCoord.st;
	vec2 f = fract(pos*size);
	pos += (.5-f)*pxsize;
	vec4 p0q0 = texture(tex,pos);
	vec4 p1q0 = texture(tex,pos+vec2(pxsize.x,0));
	vec4 p0q1 = texture(tex,pos+vec2(0,pxsize.y));
	vec4 p1q1 = texture(tex,pos+vec2(pxsize.x,pxsize.y));
	vec4 pInterp_q0 = mix(p0q0,p1q0,f.x);
	vec4 pInterp_q1 = mix(p0q1,p1q1,f.x);
	mat.Base = mix(pInterp_q0,pInterp_q1,f.y);
	mat.Normal = ApplyNormalMap(vTexCoord.st);
}
