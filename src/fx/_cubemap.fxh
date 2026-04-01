// ----------------------------------------------------------------------------
// GlyphFX | fx/_cubemap.fxh
//
// Halo CE cross-layout cubemap sampler and helper function.
// Used for reflection mapping in shader_model, and can be used in other 
// shaders as needed.
// ----------------------------------------------------------------------------

#ifndef GLYPHFX_CUBEMAP_FXH
#define GLYPHFX_CUBEMAP_FXH


// ----------------------------------------------------------------------------
// Converts a 3D direction vector into UV coordinates for sampling the Halo CE
// cross-layout cubemap atlas. The atlas is arranged in a 4x3 grid of faces:
// ----------------------------------------------------------------------------
float2 HaloCEFaceAtlasUV(float uc, float vc, float axisMag, float2 faceBase)
{
    float2 uv   = float2(uc, vc) / axisMag * 0.5 + 0.5;
    float2 cell = float2(0.25, 1.0 / 3.0);
    float2 edge = float2(0.005, 0.005);
    return clamp(faceBase + uv * cell, faceBase + edge, faceBase + cell - edge);
}

// ----------------------------------------------------------------------------
// Samples the cubemap atlas using a 3D direction vector.
// ----------------------------------------------------------------------------
float4 SampleHaloCECubeMap(
    Texture2D    tex,
    SamplerState smp,
    float3       dir,
    float        mipLevel)
{
    dir = normalize(dir);
    float x = dir.x, y = dir.y, z = dir.z;
    float ax = abs(x), ay = abs(y), az = abs(z);

    float  mag; float uc, vc; float2 base;

    if (ay >= ax && ay >= az)
    {
        mag = ay;
        if (y >= 0) { uc = -x; vc = -z; base = float2(0.00, 1.0/3.0); } // BACK  col0
        else        { uc =  x; vc = -z; base = float2(0.50, 1.0/3.0); } // FRONT col2
    }
    else if (ax >= ay && ax >= az)
    {
        mag = ax;
        if (x >= 0) { uc =  y; vc = -z; base = float2(0.75, 1.0/3.0); } // RIGHT col3
        else        { uc = -y; vc = -z; base = float2(0.25, 1.0/3.0); } // LEFT  col1
    }
    else
    {
        mag = az;
        if (z >= 0) { uc = -x; vc =  y; base = float2(0.00, 0.0/3.0); } // UP   row0
        else        { uc = -x; vc = -y; base = float2(0.00, 2.0/3.0); } // DOWN row2
    }

    float2 uv      = float2(uc, vc) / mag * 0.5 + 0.5;
    float2 cell    = float2(0.25, 1.0 / 3.0);
    float2 edge    = float2(0.004, 0.004);
    float2 finalUV = clamp(base + uv * cell, base + edge, base + cell - edge);

    finalUV += float2(CubemapUOffset * 0.25, CubemapVOffset * 0.333);

    return tex.SampleLevel(smp, finalUV, mipLevel);
}

#endif // GLYPHFX_CUBEMAP_FXH