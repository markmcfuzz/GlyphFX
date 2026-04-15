// ----------------------------------------------------------------------------
// GlyphFX | fx/shader_transparent_chicago.vsh
//
// Vertex shader for shader_transparent_chicago.
// Computes four independently-transformed UV channels from the single mesh UV,
// one per map stage. No lighting — this is a purely textured transparent shader.
// ----------------------------------------------------------------------------

// Applies per-map scale / offset / rotation (degrees) to the base UV.
// Rotation is applied around the UV origin before scale and offset.
float2 MapUVTransform(float2 uv, float uScale, float vScale,
                      float uOffset, float vOffset, float rotDeg)
{
    float  a = radians(rotDeg);
    float  s = sin(a);
    float  c = cos(a);
    float2 r = float2(uv.x * c - uv.y * s,
                      uv.x * s + uv.y * c);
    return r * float2(uScale, vScale) + float2(uOffset, vOffset);
}

TC_VS_OUTPUT VS_Main(TC_VS_INPUT v)
{
    TC_VS_OUTPUT o;

    o.clipPos = mul(v.position, matWVP);

    o.uv0 = MapUVTransform(v.uv0, Map1_UScale, Map1_VScale, Map1_UOffset, Map1_VOffset, Map1_Rotation);
    o.uv1 = MapUVTransform(v.uv0, Map2_UScale, Map2_VScale, Map2_UOffset, Map2_VOffset, Map2_Rotation);
    o.uv2 = MapUVTransform(v.uv0, Map3_UScale, Map3_VScale, Map3_UOffset, Map3_VOffset, Map3_Rotation);
    o.uv3 = MapUVTransform(v.uv0, Map4_UScale, Map4_VScale, Map4_UOffset, Map4_VOffset, Map4_Rotation);

    return o;
}
