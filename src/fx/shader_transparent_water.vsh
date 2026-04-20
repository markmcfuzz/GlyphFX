// ----------------------------------------------------------------------------
// GlyphFX | fx/shader_transparent_water.vsh
//
// Vertex shader for shader_transparent_water.
// Passes base UV; ripple UVs computed in PS via per-ripple parameters.
// Transforms tangent frame to world space for bump-mapped reflections.
// ----------------------------------------------------------------------------

TW_VS_OUTPUT VS_Main(TW_VS_INPUT v)
{
    TW_VS_OUTPUT o;

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
