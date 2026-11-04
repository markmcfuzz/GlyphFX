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

// ─── Animation Preview ──────────────────────────────────────────────────────
// Every periodic function the shader needs goes in one slot and they are all
// evaluated in a single loop, so the compiler emits PeriodicFunctionEvaluate
// once instead of 19 times (it otherwise doubles the effect's compile time,
// i.e. Max's Reload).
//   slots 0-11   map 1-4 texture animation U / V / rotation (map N at 3N-3)
//   slots 12-18  stage 1-7 constant color 0 (stage N at 11+N)
#define GX_ANIM_SLOTS 19

// The object's A-D Out value for an animation source (0 = none = 1).
float AnimationSourceInput(int source)
{
    if (source == 1) return ObjectFunctionA;
    if (source == 2) return ObjectFunctionB;
    if (source == 3) return ObjectFunctionC;
    if (source == 4) return ObjectFunctionD;
    return 1.0;
}

// Slot K evaluates periodic(function, (phase + time) / period); period 0 = 1.
#define GX_ANIM_SLOT(K, FUNCTION, PERIOD, PHASE)                               \
    fn[K] = (FUNCTION);                                                        \
    tm[K] = ((PHASE) + AnimationTime) / ((PERIOD) == 0.0 ? 1.0 : (PERIOD));

#define GX_TEXANIM_SLOTS(N)                                                    \
    GX_ANIM_SLOT(3 * N - 3, UAnimationFunction##N,                             \
                 UAnimationPeriod##N, UAnimationPhase##N)                      \
    GX_ANIM_SLOT(3 * N - 2, VAnimationFunction##N,                             \
                 VAnimationPeriod##N, VAnimationPhase##N)                      \
    GX_ANIM_SLOT(3 * N - 1, RotationAnimationFunction##N,                      \
                 RotationAnimationPeriod##N, RotationAnimationPhase##N)

#define GX_COLOR0_SLOT(N)                                                      \
    GX_ANIM_SLOT(11 + N, Stage##N##_Color0AnimationFunction,                   \
                 Stage##N##_Color0AnimationPeriod, 0.0)

// ─── Map UV transform ───────────────────────────────────────────────────────
// shader_texture_animation_evaluate (shaders.c): scale the UV, offset it by
// the map offset plus the animated U/V, then rotate it by the map rotation
// plus the animated rotation (degrees) around the animation center.
// A map scale of 0 means 1 - the Halo tag convention (stock tag dumps store
// 0), so values can be copied from Guerrilla verbatim.  The scale is also
// multiplied by the model's base map scale, as the engine does.
float2 MapUVTransform(float2 uv, float uScale, float vScale,
                      float uOffset, float vOffset, float rotDeg,
                      float uAnim, float vAnim, float rAnim, float2 center)
{
    float2 baseScale = float2(ModelBaseMapScaleU == 0.0 ? 1.0 : ModelBaseMapScaleU,
                              ModelBaseMapScaleV == 0.0 ? 1.0 : ModelBaseMapScaleV);
    float2 sc = float2(uScale == 0.0 ? 1.0 : uScale,
                       vScale == 0.0 ? 1.0 : vScale) * baseScale;

    float2 p = uv * sc + float2(uOffset, vOffset) - center + float2(uAnim, vAnim);

    float s, c;
    sincos(radians(rotDeg + rAnim), s, c);
    return float2(c * p.x - s * p.y, s * p.x + c * p.y) + center;
}

// Map N's UV, with its 2D Texture Animation N: each animated value is
// periodic * scale * source input (all 0 without Animation Preview).
#define GX_MAP_UV(N, uv)                                                       \
    MapUVTransform(uv, Map##N##_UScale, Map##N##_VScale,                       \
                   Map##N##_UOffset, Map##N##_VOffset, Map##N##_Rotation,      \
                   anim[3 * N - 3] * UAnimationScale##N *                      \
                       AnimationSourceInput(UAnimationSource##N),              \
                   anim[3 * N - 2] * VAnimationScale##N *                      \
                       AnimationSourceInput(VAnimationSource##N),              \
                   anim[3 * N - 1] * RotationAnimationScale##N *               \
                       AnimationSourceInput(RotationAnimationSource##N),       \
                   float2(AnimationCenterU##N, AnimationCenterV##N))

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

        [loop] for (int i = 0; i < GX_ANIM_SLOTS; i++)
            anim[i] = PeriodicFunctionEvaluate(fn[i], tm[i]);
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
