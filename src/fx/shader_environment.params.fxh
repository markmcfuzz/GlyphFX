// ----------------------------------------------------------------------------
// GlyphFX | fx/shader_environment.params.fxh
//
// All UI-exposed parameters for shader_environment.
// ----------------------------------------------------------------------------

#ifndef GLYPHFX_ENVIRONMENT_PARAMS_FXH
#define GLYPHFX_ENVIRONMENT_PARAMS_FXH

// ----------------------------------------------------------------------------
// Viewport light
// ----------------------------------------------------------------------------
float3 LampPos : POSITION
<
    string Object = "PointLight0";
    string Space  = "World";
    int    refID  = 0;
> = float3(-50.0, 150.0, 100.0);

#ifdef _MAX_
float3 LampColor : LIGHTCOLOR
<
    int    LightRef = 0;
    string UIWidget = "None";
> = float3(1.0, 1.0, 1.0);
#else
float3 LampColor
<
    string UIWidget = "Color";
> = float3(1.0, 1.0, 1.0);
#endif

float4 AmbientColor
<
    string UIName = "Lightmap Ambient Color";
    string UIWidget = "Color";
> = float4(0.3, 0.3, 0.3, 1.0);

float4 FillLightColor
<
    string UIName = "Fill Light Color";
    string UIWidget = "Color";
> = float4(0.3, 0.3, 0.35, 1.0);

float LampIntensity
<
    string UIName = "Light Power";
    string UIWidget = "slider";
    float  UIMin = 0.0; float UIMax = 2.0; float UIStep = 0.01;
> = 0.6;

// ----------------------------------------------------------------------------
// Debug Parameters
// ----------------------------------------------------------------------------
//  0 = normal render
//  1 = base map (unlit)
//  2 = primary detail map
//  3 = secondary detail map
//  4 = micro detail map
//  5 = bump map normal
//  6 = self-illumination map
//  7 = specular mask
//  8 = reflection only
//  9 = blend factor (base.a for BLENDED, secondary.a for NORMAL)
int DebugMode
<
    string UIName   = "Debug Mode  [0=Normal  1=Base Map  2=Primary Detail Map  3=Secondary Detail Map  4=Micro Detail Map  5=Bump Map Normal  6=Self-Illumination Map  7=Specular Mask  8=Reflection Only  9=Blend Factor]";
    string UIWidget = "Spinner";
    float  UIMin = 0; float UIMax = 9; float UIStep = 1;
> = 0;

float ReflectionIntensityScale
<
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 4; float UIStep = 0.01;
> = 1.0;

float ReflectionBlur
<
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 8; float UIStep = 0.5;
> = 0.0;

float CubemapVOffset
<
    string UIWidget = "slider";
    float  UIMin = -1; float UIMax = 1; float UIStep = 0.01;
> = 0.0;

float CubemapUOffset
<
    string UIWidget = "slider";
    float  UIMin = -1; float UIMax = 1; float UIStep = 0.01;
> = 0.0;

float CubemapPitch
<
    string UIWidget = "slider";
    float  UIMin = -1.57; float UIMax = 1.57; float UIStep = 0.01;
> = -0.0;

// ----------------------------------------------------------------------------
// Environment Shader Flags
// ----------------------------------------------------------------------------
bool AlphaTested
<
    string UIName  = "Alpha Tested";
    string UIGroup = "Environment Shader Flags";
    int    UIOrder = 0;
> = false;

bool BumpMapIsSpecularMask
<
    string UIName  = "Bump Map Is Specular Mask";
    string UIGroup = "Environment Shader Flags";
    int    UIOrder = 1;
> = false;

bool TrueAtmosphericFog
<
    string UIName  = "True Atmospheric Fog";
    string UIGroup = "Environment Shader Flags";
    int    UIOrder = 2;
> = false;

// ----------------------------------------------------------------------------
// Diffuse Flags
// ----------------------------------------------------------------------------
bool RescaleDetailMaps
<
    string UIName  = "Rescale Detail Maps";
    string UIGroup = "Diffuse Properties";
    int    UIOrder = 4;
> = true;

bool RescaleBumpMap
<
    string UIName  = "Rescale Bump Map";
    string UIGroup = "Bump Properties";
    int    UIOrder = 5;
> = true;

// ----------------------------------------------------------------------------
// Environment Shader Type
//   0 = NORMAL        — secondary detail alpha blends primary/secondary detail
//   1 = BLENDED       — base map alpha blends primary/secondary detail
//   2 = BLENDED BASE SPECULAR — same as BLENDED, specular mask from base alpha
// ----------------------------------------------------------------------------
int EnvironmentType
<
    string UIName   = "Type  [0=Normal  1=Blended  2=Blended Base Specular]";
    string UIGroup  = "Environment Shader Type";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 2; float UIStep = 1;
    int    UIOrder = 3;
> = 0;

// ----------------------------------------------------------------------------
// Diffuse Properties
// ----------------------------------------------------------------------------
Texture2D BaseMapTexture
<
    string UIName       = "Base Map";
    string UIGroup      = "Diffuse Properties";
    string ResourceType = "2D";
    int    UIOrder = 10;
>;

int DetailMapFunction
<
    string UIName   = "Detail Map Function  [0=Double/Biased Multiply  1=Multiply 2=Double/Biased Add]";
    string UIGroup  = "Diffuse Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 2; float UIStep = 1;
    int    UIOrder = 11;
> = 0;

float PrimaryDetailMapScale
<
    string UIName   = "Primary Detail Map Scale";
    string UIGroup  = "Diffuse Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 200; float UIStep = 0.1;
    int    UIOrder = 12;
> = 0.0;

Texture2D PrimaryDetailMapTexture
<
    string UIName       = "Primary Detail Map";
    string UIGroup      = "Diffuse Properties";
    string ResourceType = "2D";
    int    UIOrder = 13;
>;

float SecondaryDetailMapScale
<
    string UIName   = "Secondary Detail Map Scale";
    string UIGroup  = "Diffuse Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 200; float UIStep = 0.1;
    int    UIOrder = 14;
> = 0.0;

Texture2D SecondaryDetailMapTexture
<
    string UIName       = "Secondary Detail Map";
    string UIGroup      = "Diffuse Properties";
    string ResourceType = "2D";
    int    UIOrder = 15;
>;

int MicroDetailMapFunction
<
    string UIName   = "Micro Detail Map Function  [0=Double/Biased Multiply  1=Multiply 2=Double/Biased Add]";
    string UIGroup  = "Diffuse Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 2; float UIStep = 1;
    int    UIOrder = 16;
> = 0;

float MicroDetailMapScale
<
    string UIName   = "Micro Detail Map Scale";
    string UIGroup  = "Diffuse Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 200; float UIStep = 0.1;
    int    UIOrder = 17;
> = 0.0;

Texture2D MicroDetailMapTexture
<
    string UIName       = "Micro Detail Map";
    string UIGroup      = "Diffuse Properties";
    string ResourceType = "2D";
    int    UIOrder = 18;
>;

float4 MaterialColor
<
    string UIName   = "Material Color";
    string UIGroup  = "Diffuse Properties";
    string UIWidget = "Color";
    int    UIOrder = 19;
> = float4(0, 0, 0, 1);

// ----------------------------------------------------------------------------
// Bump Properties
// ----------------------------------------------------------------------------
float BumpMapScale
<
    string UIName   = "Bump Map Scale";
    string UIGroup  = "Bump Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 200; float UIStep = 0.1;
    int    UIOrder = 20;
> = 0.0;

Texture2D BumpMapTexture
<
    string UIName       = "Bump Map";
    string UIGroup      = "Bump Properties";
    string ResourceType = "2D";
    int    UIOrder = 21;
>;

// ----------------------------------------------------------------------------
// Self-Illumination Properties
//
// Three effects are added together.  The self-illumination map channels:
//   R = primary mask, G = secondary mask, B = plasma mask,
//   A = plasma animation reference.
//
// Each effect blends between <on color> and <off color> using an animation
// value.  In the viewport, the animation value is exposed as a manual slider
// (0 = fully off, 1 = fully on).
// ----------------------------------------------------------------------------
float4 PrimaryOnColor
<
    string UIName   = "Primary On Color";
    string UIGroup  = "Self-Illumination Properties";
    string UIWidget = "Color";
    int    UIOrder = 30;
> = float4(0, 0, 0, 1);

float4 PrimaryOffColor
<
    string UIName   = "Primary Off Color";
    string UIGroup  = "Self-Illumination Properties";
    string UIWidget = "Color";
    int    UIOrder = 31;
> = float4(0, 0, 0, 1);

float PrimaryAnimationValue
<
    string UIName   = "Primary Animation Value";
    string UIGroup  = "Self-Illumination Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
    int    UIOrder = 32;
> = 0.0;

float4 SecondaryOnColor
<
    string UIName   = "Secondary On Color";
    string UIGroup  = "Self-Illumination Properties";
    string UIWidget = "Color";
    int    UIOrder = 33;
> = float4(0, 1, 0, 1);

float4 SecondaryOffColor
<
    string UIName   = "Secondary Off Color";
    string UIGroup  = "Self-Illumination Properties";
    string UIWidget = "Color";
    int    UIOrder = 34;
> = float4(0, 0, 0, 1);

float SecondaryAnimationValue
<
    string UIName   = "Secondary Animation Value";
    string UIGroup  = "Self-Illumination Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
    int    UIOrder = 35;
> = 0.0;

float4 PlasmaOnColor
<
    string UIName   = "Plasma On Color";
    string UIGroup  = "Self-Illumination Properties";
    string UIWidget = "Color";
    int    UIOrder = 36;
> = float4(0, 0, 0, 1);

float4 PlasmaOffColor
<
    string UIName   = "Plasma Off Color";
    string UIGroup  = "Self-Illumination Properties";
    string UIWidget = "Color";
    int    UIOrder = 37;
> = float4(0, 0, 0, 1);

float PlasmaAnimationValue
<
    string UIName   = "Plasma Animation Value";
    string UIGroup  = "Self-Illumination Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
    int    UIOrder = 38;
> = 0.0;

float SelfIlluminationMapScale
<
    string UIName   = "Self-Illumination Map Scale";
    string UIGroup  = "Self-Illumination Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 200; float UIStep = 0.1;
    int    UIOrder = 39;
> = 0.0;

Texture2D SelfIlluminationMapTexture
<
    string UIName       = "Self-Illumination Map";
    string UIGroup      = "Self-Illumination Properties";
    string ResourceType = "2D";
    int    UIOrder = 40;
>;

// ----------------------------------------------------------------------------
// Specular Properties
// ----------------------------------------------------------------------------
bool SpecularOverbright
<
    string UIName  = "Overbright";
    string UIGroup = "Specular Properties";
    int    UIOrder = 50;
> = false;

bool SpecularExtraShiny
<
    string UIName  = "Extra Shiny";
    string UIGroup = "Specular Properties";
    int    UIOrder = 51;
> = false;

float SpecBrightness
<
    string UIName   = "Brightness";
    string UIGroup  = "Specular Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
    int    UIOrder = 52;
> = 0.0;

float4 SpecPerpendicularColor
<
    string UIName   = "Perpendicular Color";
    string UIGroup  = "Specular Properties";
    string UIWidget = "Color";
    int    UIOrder = 53;
> = float4(0.0, 0.0, 0.0, 1);

float4 SpecParallelColor
<
    string UIName   = "Parallel Color";
    string UIGroup  = "Specular Properties";
    string UIWidget = "Color";
    int    UIOrder = 54;
> = float4(0.0, 0.0, 0.0, 1);

// ----------------------------------------------------------------------------
// Reflection Properties
// ----------------------------------------------------------------------------
bool DynamicMirror
<
    string UIName  = "Dynamic Mirror";
    string UIGroup = "Reflection Properties";
    int    UIOrder = 59;
> = false;

//   0 = bumped cube-map   — bump map affects reflection direction + fresnel
//   1 = flat cube-map     — bump attenuates fresnel, reflection is unbumped
//   2 = bumped radiosity  — same as bumped cube-map?
int ReflectionType
<
    string UIName   = "Reflection Type  [0=Bumped Cube Map  1=Flat Cube Map  2=Bumped Radiosity]";
    string UIGroup  = "Reflection Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 2; float UIStep = 1;
    int    UIOrder = 60;
> = 0;

float ReflPerpendicularBrightness
<
    string UIName   = "Perpendicular Brightness";
    string UIGroup  = "Reflection Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
    int    UIOrder = 61;
> = 0.0;

float ReflParallelBrightness
<
    string UIName   = "Parallel Brightness";
    string UIGroup  = "Reflection Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
    int    UIOrder = 62;
> = 0.0;

// IMPORTANT: HCE reflection maps are 2D cross-layout atlases, NOT DX11 cubemaps.
Texture2D ReflectionCubeTexture
<
    string UIName       = "Reflection Cube Map";
    string UIGroup      = "Reflection Properties";
    string ResourceType = "2D";
    int    UIOrder = 63;
>;

// ----------------------------------------------------------------------------
// Texture-connected flags
// DX11 samples unbound textures as black (0,0,0,0), which breaks blend modes
// that expect a neutral value.  Set each flag only when the texture is assigned.
// ----------------------------------------------------------------------------
bool EnableBaseMap
<
    string UIName  = "Enable Base Map";
    string UIGroup = "Environment Shader Flags";
> = true;

bool EnablePrimaryDetailMap
<
    string UIName  = "Enable Primary Detail Map";
    string UIGroup = "Environment Shader Flags";
> = true;

bool EnableSecondaryDetailMap
<
    string UIName  = "Enable Secondary Detail Map";
    string UIGroup = "Environment Shader Flags";
> = true;

bool EnableMicroDetailMap
<
    string UIName  = "Enable Micro Detail Map";
    string UIGroup = "Environment Shader Flags";
> = true;

bool EnableBumpMap
<
    string UIName  = "Enable Bump Map";
    string UIGroup = "Environment Shader Flags";
> = true;

bool EnableSelfIlluminationMap
<
    string UIName  = "Enable Self-Illumination Map";
    string UIGroup = "Environment Shader Flags";
> = false;

bool EnableReflectionCube
<
    string UIName  = "Enable Reflection Cube";
    string UIGroup = "Environment Shader Flags";
> = true;

// ----------------------------------------------------------------------------
// Other Properties
// ----------------------------------------------------------------------------
float c_alpha_ref
<
    string UIGroup  = "Other Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
> = 0.5;

float4 c_fog_color_correction_0
<
    string UIGroup  = "Other Properties";
    string UIWidget = "Color";
> = float4(0.5, 0.6, 0.7, 1);

float4 c_fog_color_correction_E
<
    string UIGroup  = "Other Properties";
    string UIWidget = "Color";
> = float4(0, 0, 0, 0);

float4 c_fog_color_correction_1
<
    string UIGroup  = "Other Properties";
    string UIWidget = "Color";
> = float4(1, 1, 1, 1);

#endif // GLYPHFX_ENVIRONMENT_PARAMS_FXH
