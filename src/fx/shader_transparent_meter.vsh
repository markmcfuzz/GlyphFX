// ----------------------------------------------------------------------------
// GlyphFX | fx/shader_transparent_meter.vsh
//
// Vertex shader for shader_transparent_meter.
//
// Transforms the vertex position to clip space and passes the UV coordinate
// straight through. No lighting, no normals - matches the original
// transparent_meter.vsh which only outputs Pos and T0.
// ----------------------------------------------------------------------------

TM_VS_OUTPUT VS_Main(TM_VS_INPUT v)
{
    TM_VS_OUTPUT o;

    o.clipPos = mul(v.position, matWVP);

    // Shift the meter slightly toward the camera in clip space so it wins
    // the depth test against any coplanar shader_model surface, regardless
    // of sub-material draw order.  Subtracting in clip space is equivalent
    // to subtracting 0.0005 in NDC (clip_z/clip_w), which is small enough
    // to be invisible but large enough to beat any coplanar geometry.
    o.clipPos.z -= 0.0005 * o.clipPos.w;

    o.uv0 = v.uv0;

    return o;
}
