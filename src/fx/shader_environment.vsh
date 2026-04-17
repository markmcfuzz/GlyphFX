// ----------------------------------------------------------------------------
// GlyphFX | fx/shader_environment.vsh
//
// Vertex shader for shader_environment.
// Passes base UV (detail/bump/self-illumination UVs computed in PS via scales).
// Transforms tangent frame to world space for bump-mapped reflections.
// ----------------------------------------------------------------------------

SE_VS_OUTPUT VS_Main(SE_VS_INPUT v)
{
    SE_VS_OUTPUT o;

    float3 wPos    = mul(v.position, matW).xyz;
    float3 wNormal = normalize(mul(v.normal,   (float3x3)matWIT));
    float3 wTan    = normalize(mul(v.tangent,  (float3x3)matW));
    float3 wBin    = normalize(mul(v.binormal, (float3x3)matW));

    o.clipPos    = mul(v.position, matWVP);
    o.wPos       = wPos;
    o.wNormal    = wNormal;
    o.oNormal    = v.normal;
    o.lampVec    = LampPos - wPos;
    o.uv0        = v.uv0;
    o.wTangent   = wTan;
    o.wBinormal  = wBin;

    return o;
}
