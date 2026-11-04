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
//
// It also evaluates the Animation Preview (see the params): the 2D texture
// animation of each map and the constant color 0 animation of each stage.
// Both only depend on material parameters; the color0 values are passed to
// the pixel shader flat (color0Anim0/1).
// ----------------------------------------------------------------------------

#include "_texture_animation.fxh"

// ─── Animation Preview ──────────────────────────────────────────────────────
// Every periodic function the shader needs goes in one slot, all evaluated
// in one loop (see _texture_animation.fxh):
//   slots 0-11   map 1-4 texture animation U / V / rotation (map N at 3N-3)
//   slots 12-18  stage 1-7 constant color 0 (stage N at 11+N)
#define GX_ANIM_SLOTS 19

#define GX_COLOR0_SLOT(N)                                                      \
    GX_ANIM_SLOT(11 + N, Stage##N##_Color0AnimationFunction,                   \
                 Stage##N##_Color0AnimationPeriod, 0.0)

// ─── Constant color 0 animation ─────────────────────────────────────────────
// The stage's color0 = lower + f * (upper - lower).  With Animation Preview
// on: A Out when "A-Out Controls Color0 Animation" is set, else the periodic
// function of time / period.  Without it, the idle state: 0 (lower bound)
// when A-out drives it (A-out is 0 until the external event fires, e.g. the
// shield being hit) or the function is Zero; 1 (the wave peak, upper bound)
// otherwise.
float Color0AnimationValue(float periodic, int function, bool aOutControls)
{
    if (!AnimationPreview)
        return (aOutControls || function == 1) ? 0.0 : 1.0;
    return aOutControls ? ObjectFunctionA : periodic;
}

#define GX_COLOR0_ANIM(N)                                                      \
    Color0AnimationValue(anim[11 + N], Stage##N##_Color0AnimationFunction,     \
                         Stage##N##_AOutControlsColor0Animation)

// ─── Entry point ────────────────────────────────────────────────────────────

STG_VS_OUTPUT VS_Main(STG_VS_INPUT v)
{
    STG_VS_OUTPUT o;

    // Animation Preview: fill the slots, evaluate them all in one loop.
    float anim[GX_ANIM_SLOTS];
    [unroll] for (int k = 0; k < GX_ANIM_SLOTS; k++) anim[k] = 0.0;

    [branch] if (AnimationPreview)
    {
        int   fn[GX_ANIM_SLOTS];
        float tm[GX_ANIM_SLOTS];
        // Unused slots (stages beyond GX_GENERIC_STAGES) evaluate "zero".
        [unroll] for (int j = 0; j < GX_ANIM_SLOTS; j++) { fn[j] = 1; tm[j] = 0.0; }

        GX_TEXANIM_SLOTS(1)
        GX_TEXANIM_SLOTS(2)
        GX_TEXANIM_SLOTS(3)
        GX_TEXANIM_SLOTS(4)
        GX_COLOR0_SLOT(1)
#if GX_GENERIC_STAGES >= 2
        GX_COLOR0_SLOT(2)
#endif
#if GX_GENERIC_STAGES >= 3
        GX_COLOR0_SLOT(3)
#endif
#if GX_GENERIC_STAGES >= 4
        GX_COLOR0_SLOT(4)
#endif
#if GX_GENERIC_STAGES >= 5
        GX_COLOR0_SLOT(5)
#endif
#if GX_GENERIC_STAGES >= 6
        GX_COLOR0_SLOT(6)
#endif
#if GX_GENERIC_STAGES >= 7
        GX_COLOR0_SLOT(7)
#endif

        GX_EVALUATE_ANIM_SLOTS(GX_ANIM_SLOTS)
    }

    o.clipPos = mul(v.position, matWVP);

    o.uv0 = GX_MAP_UV(1, v.uv0);
    o.uv1 = GX_MAP_UV(2, v.uv0);
    o.uv2 = GX_MAP_UV(3, v.uv0);
    o.uv3 = GX_MAP_UV(4, v.uv0);

    float3 wPos    = mul(v.position, matW).xyz;
    float3 wNormal = normalize(mul(v.normal, (float3x3)matWIT));
    float3 V       = normalize(ViewIXf[3].xyz - wPos);

    float facing = abs(dot(wNormal, V));

    o.vColor0 = float4(1.0, 1.0, 1.0, 1.0);
    o.vColor1 = float4(facing, facing, facing, 1.0 - facing);

    o.color0Anim0 = float4(GX_COLOR0_ANIM(1), 0.0, 0.0, 0.0);
    o.color0Anim1 = float4(0.0, 0.0, 0.0, 0.0);
#if GX_GENERIC_STAGES >= 2
    o.color0Anim0.y = GX_COLOR0_ANIM(2);
#endif
#if GX_GENERIC_STAGES >= 3
    o.color0Anim0.z = GX_COLOR0_ANIM(3);
#endif
#if GX_GENERIC_STAGES >= 4
    o.color0Anim0.w = GX_COLOR0_ANIM(4);
#endif
#if GX_GENERIC_STAGES >= 5
    o.color0Anim1.x = GX_COLOR0_ANIM(5);
#endif
#if GX_GENERIC_STAGES >= 6
    o.color0Anim1.y = GX_COLOR0_ANIM(6);
#endif
#if GX_GENERIC_STAGES >= 7
    o.color0Anim1.z = GX_COLOR0_ANIM(7);
#endif

    return o;
}
