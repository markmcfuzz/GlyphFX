// ----------------------------------------------------------------------------
// GlyphFX | fx/shader_transparent_plasma.vsh
//
// Vertex shader for shader_transparent_plasma.
// Ported from shaders/vsh/transparent_plasma_m.vsh (the per-node skinning
// blend is dropped - 3ds Max handles mesh transforms itself, same as every
// other GlyphFX shader).
//
//   D0.rgb = view-angle tint:       lerp(ParallelTintColor,      PerpendicularTintColor,      NdotV)
//   D0.a   = view-angle brightness: lerp(ParallelBrightness,     PerpendicularBrightness,     NdotV)
//            (the tag also multiplies this by 1-fog in-engine; dropped here -
//            no fog uniforms are bound in the Max viewport, same as every
//            other GlyphFX shader)
//   T0/T1  = world-space UVW fed to the primary/secondary noise volumes,
//            built from the UN-offset vertex position so the noise pattern
//            doesn't shift when Offset Amount changes (matches the original,
//            which derives texcoords from V_POSITION before the offset is
//            applied to R_POSITION)
// ----------------------------------------------------------------------------

// How far a noise map has moved after AnimationTime: time / period *
// direction (0 without Animation Preview, or with a period of 0).  With
// AnimationLoopLength the move over the loop is rounded, per axis, to whole
// repeats of the noise volume (it wraps every 1 on each axis), so the loop
// has no jump; if that is 0 on every axis it keeps the game's speed.
float3 NoiseMove(float period, float3 direction)
{
    if (!AnimationPreview || period == 0.0) return (float3)0;
    float3 perSecond = direction / period;
    if (AnimationLoopLength > 0.0)
    {
        float3 repeats = round(perSecond * AnimationLoopLength);
        if (any(repeats != 0.0))
            return AnimationTime * repeats / AnimationLoopLength;
    }
    return AnimationTime * perSecond;
}

TP_VS_OUTPUT VS_Main(TP_VS_INPUT v)
{
    TP_VS_OUTPUT o;

    float3 wPos    = mul(v.position, matW).xyz;
    float3 wNormal = normalize(mul(v.normal, (float3x3)matWIT));
    float3 V       = normalize(ViewIXf[3].xyz - wPos);

    // Offset Amount (tag "offset amount", world units) pushes the rendered
    // surface off the base geometry along the normal - e.g. a shield-door
    // sheet floating slightly off its frame mesh to avoid z-fighting.
    // Applied in object space (assumes a 1:1 object/world scale) because the
    // Max DirectX Shader material only exposes matWVP combined, not a
    // standalone view-projection matrix to re-project an offset world position.
    float3 offsetPosObj = v.position.xyz + normalize(v.normal) * OffsetAmount;
    o.clipPos = mul(float4(offsetPosObj, 1.0), matWVP);

    float NdotV = dot(wNormal, V);
    o.D0 = saturate(float4(
        lerp(ParallelTintColor.rgb, PerpendicularTintColor.rgb, NdotV),
        lerp(ParallelBrightness,    PerpendicularBrightness,    NdotV)));

    // Noise animation (rasterizer_xbox_plasma_energy.c): each noise map moves
    // along its direction by time / period, in noise map units.
    float3 primaryMove   = NoiseMove(PrimaryAnimationPeriod,
                                     float3(PrimaryAnimationDirectionI,
                                            PrimaryAnimationDirectionJ,
                                            PrimaryAnimationDirectionK));
    float3 secondaryMove = NoiseMove(SecondaryAnimationPeriod,
                                     float3(SecondaryAnimationDirectionI,
                                            SecondaryAnimationDirectionJ,
                                            SecondaryAnimationDirectionK));

    o.T0 = wPos / max(PrimaryNoiseMapScale,   0.0001) + primaryMove;
    o.T1 = wPos / max(SecondaryNoiseMapScale, 0.0001) + secondaryMove;

    return o;
}
