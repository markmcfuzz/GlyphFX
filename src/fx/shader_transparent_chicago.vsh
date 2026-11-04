// ----------------------------------------------------------------------------
// GlyphFX | fx/shader_transparent_chicago.vsh
//
// Vertex shader for shader_transparent_chicago.
// Computes four independently-transformed UV channels from the single mesh UV,
// one per map stage. No lighting - this is a purely textured transparent shader.
//
// With Animation Preview on, each map's UV also plays the tag's 2D texture
// animation (_texture_animation.fxh).
// ----------------------------------------------------------------------------

#include "_texture_animation.fxh"

// Slots 0-11: map 1-4 texture animation U / V / rotation (map N at 3N-3).
#define GX_ANIM_SLOTS 12

TC_VS_OUTPUT VS_Main(TC_VS_INPUT v)
{
    TC_VS_OUTPUT o;

    // Animation Preview: fill the slots, evaluate them all in one loop.
    float anim[GX_ANIM_SLOTS];
    [unroll] for (int k = 0; k < GX_ANIM_SLOTS; k++) anim[k] = 0.0;

    [branch] if (AnimationPreview)
    {
        int   fn[GX_ANIM_SLOTS];
        float tm[GX_ANIM_SLOTS];

        GX_TEXANIM_SLOTS(1)
        GX_TEXANIM_SLOTS(2)
        GX_TEXANIM_SLOTS(3)
        GX_TEXANIM_SLOTS(4)

        GX_EVALUATE_ANIM_SLOTS(GX_ANIM_SLOTS)
    }

    o.clipPos = mul(v.position, matWVP);

    o.uv0 = GX_MAP_UV(1, v.uv0);
    o.uv1 = GX_MAP_UV(2, v.uv0);
    o.uv2 = GX_MAP_UV(3, v.uv0);
    o.uv3 = GX_MAP_UV(4, v.uv0);

    return o;
}
