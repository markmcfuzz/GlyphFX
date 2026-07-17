// ----------------------------------------------------------------------------
// GlyphFX | fx/shader_transparent_generic.vsh
//
// Vertex shader for shader_transparent_generic.
// Computes four independently-transformed UV channels from the single mesh UV
// (one per map) plus the two Halo vertex color registers the combiner stages
// can read.  Values match the original transparent_generic.vsh:
//
//   vColor0.rgb = vertex color 0 "diffuse light".  In-engine this carries
//                 per-vertex lighting for transparent-lit geometry; the
//                 viewport has no Halo lighting so white (unlit) is used.
//   vColor0.a   = vertex alpha 0 "fade none" - always 1.
//   vColor1     = vertex color 1 fade values, with  x = |dot(N, V)|:
//                   rgb = x       fade-when-parallel      (vertex blue 1)
//                   a   = 1 - x   fade-when-perpendicular (vertex alpha 1)
//                 (in-engine both are also multiplied by fog density and
//                 translucency, neither of which exists in the viewport).
// ----------------------------------------------------------------------------

// Applies per-map scale / offset / rotation (degrees) to the base UV.
// Rotation is applied around the UV origin before scale and offset.
// A scale of 0 means 1 - the Halo tag convention (stock tag dumps store 0),
// so values can be copied from Guerrilla verbatim.
float2 MapUVTransform(float2 uv, float uScale, float vScale,
                      float uOffset, float vOffset, float rotDeg)
{
    float  a = radians(rotDeg);
    float  s = sin(a);
    float  c = cos(a);
    float2 r = float2(uv.x * c - uv.y * s,
                      uv.x * s + uv.y * c);
    float2 sc = float2(uScale == 0.0 ? 1.0 : uScale,
                       vScale == 0.0 ? 1.0 : vScale);
    return r * sc + float2(uOffset, vOffset);
}

STG_VS_OUTPUT VS_Main(STG_VS_INPUT v)
{
    STG_VS_OUTPUT o;

    o.clipPos = mul(v.position, matWVP);

    o.uv0 = MapUVTransform(v.uv0, Map1_UScale, Map1_VScale, Map1_UOffset, Map1_VOffset, Map1_Rotation);
    o.uv1 = MapUVTransform(v.uv0, Map2_UScale, Map2_VScale, Map2_UOffset, Map2_VOffset, Map2_Rotation);
    o.uv2 = MapUVTransform(v.uv0, Map3_UScale, Map3_VScale, Map3_UOffset, Map3_VOffset, Map3_Rotation);
    o.uv3 = MapUVTransform(v.uv0, Map4_UScale, Map4_VScale, Map4_UOffset, Map4_VOffset, Map4_Rotation);

    float3 wPos    = mul(v.position, matW).xyz;
    float3 wNormal = normalize(mul(v.normal, (float3x3)matWIT));
    float3 V       = normalize(ViewIXf[3].xyz - wPos);

    float facing = abs(dot(wNormal, V));

    o.vColor0 = float4(1.0, 1.0, 1.0, 1.0);
    o.vColor1 = float4(facing, facing, facing, 1.0 - facing);

    return o;
}
