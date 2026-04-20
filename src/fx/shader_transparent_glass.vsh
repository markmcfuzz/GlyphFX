// ----------------------------------------------------------------------------
// GlyphFX | fx/shader_transparent_glass.vsh
//
// Vertex shader for shader_transparent_glass.
// Passes base UV; bump/diffuse/specular UVs computed in PS via per-map scales.
// Transforms tangent frame to world space for bump-mapped reflections.
// ----------------------------------------------------------------------------

TG_VS_OUTPUT VS_Main(TG_VS_INPUT v)
{
    TG_VS_OUTPUT o;

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
