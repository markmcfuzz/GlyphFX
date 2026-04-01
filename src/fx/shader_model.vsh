// ----------------------------------------------------------------------------
// GlyphFX | fx/model.vsh
//
// Vertex shader for shader_model.
// ----------------------------------------------------------------------------

VS_OUTPUT VS_Main(VS_INPUT v)
{
    VS_OUTPUT o;

    float3 wPos    = mul(v.position, matW).xyz;
    float3 wNormal = mul(v.normal, (float3x3)matWIT);

    o.clipPos = mul(v.position, matWVP);
    o.wPos    = wPos;
    o.wNormal = wNormal;
    o.oNormal = v.normal;
    o.lampVec = LampPos - wPos;

    // Base map and multipurpose map share the same UV channel, scaled by tag values
    o.uv0 = v.uv0 * float2(MapUScale, MapVScale);

    // Detail map tiles independently — VScale=0 means copy UScale (square tiling)
    float dvscale = (DetailMapVScale == 0.0) ? DetailMapScale : DetailMapVScale;
    o.uv1 = v.uv0 * float2(DetailMapScale, dvscale);

    return o;
}