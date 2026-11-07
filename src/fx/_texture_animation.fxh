// ----------------------------------------------------------------------------
// GlyphFX | fx/_texture_animation.fxh
//
// Map UV transform with the tag's 2D texture animation, shared by the
// transparent shaders whose maps carry one (generic, chicago).  Port of
// shader_texture_animation_evaluate (source/shaders/shaders.c, OpenCE).
//
// Include it from the vertex shader, after the params.  It expects, per map N
// (1-4): MapN_UScale/VScale/UOffset/VOffset/Rotation and the tag's
// {U,V,Rotation}Animation{Source,Function,Period,Phase,Scale}N and
// AnimationCenterU/VN; plus the Animation Preview params AnimationPreview,
// AnimationTime, AnimationLoopLength, ObjectFunctionA-D and
// ModelBaseMapScaleU/V.
//
// The periodic functions are evaluated in slots, all in one loop (see
// GX_ANIM_SLOT): emitting PeriodicFunctionEvaluate once per use instead
// doubles the effect's compile time, i.e. Max's Reload.  A vertex shader:
//   1. declares  float anim[SLOTS]  (zeros) and, when AnimationPreview is on,
//      int fn[SLOTS] / float tm[SLOTS] with every slot set to function 1
//      ("zero"),
//   2. fills map N's three slots with GX_TEXANIM_SLOTS(N) (slots 3N-3..3N-1),
//   3. runs GX_EVALUATE_ANIM_SLOTS(SLOTS),
//   4. transforms each map's UV with GX_MAP_UV(N, uv).
// ----------------------------------------------------------------------------

#ifndef GLYPHFX_TEXTURE_ANIMATION_FXH
#define GLYPHFX_TEXTURE_ANIMATION_FXH

// The object's A-D Out value for an animation source (0 = none = 1).
float AnimationSourceInput(int source)
{
    if (source == 1) return ObjectFunctionA;
    if (source == 2) return ObjectFunctionB;
    if (source == 3) return ObjectFunctionC;
    if (source == 4) return ObjectFunctionD;
    return 1.0;
}

// A slot's time in periods: (phase + time) / period; period 0 = 1.  With an
// AnimationLoopLength, cosine, diagonal wave and slide (0.7 cycles per period,
// _periodic.fxh) run the whole number of cycles nearest to the game's in it,
// at least one, so the loop has no jump.  The random functions are unchanged.
float AnimationSlotTime(int function, float period, float phase)
{
    float p = period == 0.0 ? 1.0 : period;
    if (AnimationLoopLength > 0.0 && (function == 2 || function == 4 || function == 6))
    {
        float cycles = max(1.0, round(AnimationLoopLength * 0.7 / abs(p)));
        return phase / p + sign(p) * AnimationTime * cycles / (0.7 * AnimationLoopLength);
    }
    return (phase + AnimationTime) / p;
}

// Slot K evaluates periodic(function, AnimationSlotTime).
#define GX_ANIM_SLOT(K, FUNCTION, PERIOD, PHASE)                               \
    fn[K] = (int)(FUNCTION);                                                   \
    tm[K] = AnimationSlotTime((int)(FUNCTION), (PERIOD), (PHASE));

#define GX_TEXANIM_SLOTS(N)                                                    \
    GX_ANIM_SLOT(3 * N - 3, UAnimationFunction##N,                             \
                 UAnimationPeriod##N, UAnimationPhase##N)                      \
    GX_ANIM_SLOT(3 * N - 2, VAnimationFunction##N,                             \
                 VAnimationPeriod##N, VAnimationPhase##N)                      \
    GX_ANIM_SLOT(3 * N - 1, RotationAnimationFunction##N,                      \
                 RotationAnimationPeriod##N, RotationAnimationPhase##N)

#define GX_EVALUATE_ANIM_SLOTS(SLOTS)                                          \
    [loop] for (int slot = 0; slot < (SLOTS); slot++)                          \
        anim[slot] = PeriodicFunctionEvaluate(fn[slot], tm[slot]);

// Scale the UV, offset it by the map offset plus the animated U/V, then rotate
// it by the map rotation plus the animated rotation (degrees) around the
// animation center.  A map scale of 0 means 1 - the Halo tag convention
// (stock tag dumps store 0), so values can be copied from Guerrilla verbatim.
// The scale is also multiplied by the model's base map scale, as the engine
// does.
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
                       AnimationSourceInput((int)UAnimationSource##N),         \
                   anim[3 * N - 2] * VAnimationScale##N *                      \
                       AnimationSourceInput((int)VAnimationSource##N),         \
                   anim[3 * N - 1] * RotationAnimationScale##N *               \
                       AnimationSourceInput((int)RotationAnimationSource##N),  \
                   float2(AnimationCenterU##N, AnimationCenterV##N))

#endif // GLYPHFX_TEXTURE_ANIMATION_FXH
