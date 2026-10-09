// ----------------------------------------------------------------------------
// GlyphFX | fx/shader_model_extended.vsh
//
// Vertex shader for shader_model_extended.
// Same as shader_model.vsh, plus the tangent frame for the normal maps and the
// UVs of detail map 2 and the two detail normal maps.
// ----------------------------------------------------------------------------

// Tag fields documented as "0 defaults to 1".
float OneIfZero(float x)
{
    return (x == 0.0) ? 1.0 : x;
}

SME_VS_OUTPUT VS_Main(SME_VS_INPUT v)
{
    SME_VS_OUTPUT o;

    float3 wPos    = mul(v.position, matW).xyz;
    float3 wNormal = mul(v.normal, (float3x3)matWIT);

    o.clipPos   = mul(v.position, matWVP);
    o.wPos      = wPos;
    o.wNormal   = wNormal;
    o.oNormal   = v.normal;
    o.lampVec   = LampPos - wPos;
    o.wTangent  = mul(v.tangent,  (float3x3)matW);
    o.wBinormal = mul(v.binormal, (float3x3)matW);

    // Base, multipurpose, base normal and specular color maps share the same
    // UV channel, scaled by tag values.
    o.uv0 = v.uv0 * float2(MapUScale, MapVScale);

    // Detail maps tile independently. "detail map scale" covers BOTH axes;
    // "detail map v-scale" is only a multiplier on top of it for V (0 = 1x).
    //   scale 10, v-scale 1   -> U 10, V 10
    //   scale 10, v-scale 0.5 -> U 10, V  5
    float d1v = DetailMapScale  * OneIfZero(DetailMapVScale);
    float d2v = Detail2MapScale * OneIfZero(Detail2MapVScale);
    o.uvDetail = float4(v.uv0 * float2(DetailMapScale,  d1v),
                        v.uv0 * float2(Detail2MapScale, d2v));

    // Detail normals: same scale / v-scale rule, but here a scale of 0 also
    // means 1 (as in OpenSauce: uv * (scale, scale * v_scale), both defaulted).
    float n1 = OneIfZero(DetailNormal1Scale);
    float n2 = OneIfZero(DetailNormal2Scale);
    o.uvDetailNormal = float4(v.uv0 * float2(n1, n1 * OneIfZero(DetailNormal1VScale)),
                              v.uv0 * float2(n2, n2 * OneIfZero(DetailNormal2VScale)));

    return o;
}
