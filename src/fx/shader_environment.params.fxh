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

// Disabled by default
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
// Radiosity Properties
// ----------------------------------------------------------------------------
bool SimpleParameterization
<
    string UIName = "Simple Parameterization";
    string UIGroup = "Shader General Fields";
    int    UIOrder = 0;
> = false;

bool IgnoreNormals
<
    string UIName = "Ignore Normals";
    string UIGroup = "Shader General Fields";
    int    UIOrder = 1;
> = false;

bool TransparentLit
<
    string UIName = "Transparent Lit";
    string UIGroup = "Shader General Fields";
    int    UIOrder = 2;
> = false;

int DetailLevel
<
    string UIName   = "Detail Level  [0=High  1=Medium  2=Low 3=Turd]";
    string UIGroup  = "Shader General Fields";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 3; float UIStep = 1;
    int    UIOrder = 3;
> = 0;

float Power
<
    string UIName   = "Power";
    string UIGroup  = "Shader General Fields";
    string UIWidget = "slider";
    float  UIMin = -0; float UIMax = 9999; float UIStep = 1;
    int    UIOrder = 4;
> = 1;

float4 ColorOfEmittedLight
<
    string UIName   = "Color of Emitted Light";
    string UIGroup  = "Shader General Fields";
    string UIWidget = "Color";
    int    UIOrder = 5;
> = float4(0, 0, 0, 0);

float4 TintColor
<
    string UIName   = "Tint Color";
    string UIGroup  = "Shader General Fields";
    string UIWidget = "Color";
    int    UIOrder = 6;
> = float4(1, 1, 1, 1);

// ----------------------------------------------------------------------------
// Physics Properties
// ----------------------------------------------------------------------------
float MaterialType
<
    string UIName   = "Material Type";
    string UIGroup  = "Shader General Fields";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 32; float UIStep = 1;
    int    UIOrder = 7;
> = 0;

// ----------------------------------------------------------------------------
// Environment Shader Flags
// ----------------------------------------------------------------------------
bool AlphaTested
<
    string UIName  = "Alpha Tested";
    string UIGroup = "Environment Shader Flags";
    int    UIOrder = 8;
> = false;

bool BumpMapIsSpecularMask
<
    string UIName  = "Bump Map Is Specular Mask";
    string UIGroup = "Environment Shader Flags";
    int    UIOrder = 9;
> = false;

bool TrueAtmosphericFog
<
    string UIName  = "True Atmospheric Fog";
    string UIGroup = "Environment Shader Flags";
    int    UIOrder = 10;
> = false;

bool BumpAttenuation
<
    string UIName  = "Use Variant 2 for Calculation Bump Attenuation";
    string UIGroup = "Environment Shader Flags";
    int    UIOrder = 11;
> = false;

// ----------------------------------------------------------------------------
// Environment Shader Type
//   0 = NORMAL        - secondary detail alpha blends primary/secondary detail
//   1 = BLENDED       - base map alpha blends primary/secondary detail
//   2 = BLENDED BASE SPECULAR - same as BLENDED, specular mask from base alpha
// ----------------------------------------------------------------------------
int EnvironmentType
<
    string UIName   = "Type  [0=Normal  1=Blended  2=Blended Base Specular]";
    string UIGroup  = "Environment Shader Type";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 2; float UIStep = 1;
    int    UIOrder = 12;
> = 0;

int LensFlareSpacing
<
    string UIName   = "Lens Flare Spacing";
    string UIGroup  = "Lens Flares";
    string UIWidget = "Spinner";
    int    UIOrder = 13;
    float  UIMin = 0; float UIMax = 255; float UIStep = 1;
> = 0;

Texture2D LensFlare
<
    string UIName       = "Lens Flare";
    string UIGroup      = "Lens Flares";
    string ResourceType = "2D";
    int    UIOrder = 14;
>;

// ----------------------------------------------------------------------------
// Diffuse Properties
// ----------------------------------------------------------------------------
bool RescaleDetailMaps
<
    string UIName  = "Rescale Detail Maps";
    string UIGroup = "Diffuse Properties";
    int    UIOrder = 15;
> = false;

bool RescaleBumpMap
<
    string UIName  = "Rescale Bump Map";
    string UIGroup = "Bump Properties";
    int    UIOrder = 16;
> = false;

bool EnableBaseMap
<
    string UIName  = "Enable Base Map";
    string UIGroup = "Environment Shader Flags";
    int    UIOrder = 17;
> = false;

Texture2D BaseMapTexture
<
    string UIName       = "Base Map";
    string UIGroup      = "Diffuse Properties";
    string ResourceType = "2D";
    int    UIOrder = 17;
>;

int DetailMapFunction
<
    string UIName   = "Detail Map Function  [0=Double/Biased Multiply  1=Multiply 2=Double/Biased Add]";
    string UIGroup  = "Diffuse Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 2; float UIStep = 1;
    int    UIOrder = 18;
> = 0;

bool EnablePrimaryDetailMap
<
    string UIName  = "Enable Primary Detail Map";
    string UIGroup = "Environment Shader Flags";
    int    UIOrder = 19;
> = false;

float PrimaryDetailMapScale
<
    string UIName   = "Primary Detail Map Scale";
    string UIGroup  = "Diffuse Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 200; float UIStep = 0.1;
    int    UIOrder = 19;
> = 0.0;

Texture2D PrimaryDetailMapTexture
<
    string UIName       = "Primary Detail Map";
    string UIGroup      = "Diffuse Properties";
    string ResourceType = "2D";
    int    UIOrder = 20;
>;

bool EnableSecondaryDetailMap
<
    string UIName  = "Enable Secondary Detail Map";
    string UIGroup = "Environment Shader Flags";
    int    UIOrder = 21;
> = false;

float SecondaryDetailMapScale
<
    string UIName   = "Secondary Detail Map Scale";
    string UIGroup  = "Diffuse Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 200; float UIStep = 0.1;
    int    UIOrder = 21;
> = 0.0;

Texture2D SecondaryDetailMapTexture
<
    string UIName       = "Secondary Detail Map";
    string UIGroup      = "Diffuse Properties";
    string ResourceType = "2D";
    int    UIOrder = 22;
>;

bool EnableMicroDetailMap
<
    string UIName  = "Enable Micro Detail Map";
    string UIGroup = "Environment Shader Flags";
    int    UIOrder = 23;
> = false;

int MicroDetailMapFunction
<
    string UIName   = "Micro Detail Map Function  [0=Double/Biased Multiply  1=Multiply 2=Double/Biased Add]";
    string UIGroup  = "Diffuse Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 2; float UIStep = 1;
    int    UIOrder = 23;
> = 0;

float MicroDetailMapScale
<
    string UIName   = "Micro Detail Map Scale";
    string UIGroup  = "Diffuse Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 200; float UIStep = 0.1;
    int    UIOrder = 24;
> = 0.0;

Texture2D MicroDetailMapTexture
<
    string UIName       = "Micro Detail Map";
    string UIGroup      = "Diffuse Properties";
    string ResourceType = "2D";
    int    UIOrder = 25;
>;

float4 MaterialColor
<
    string UIName   = "Material Color";
    string UIGroup  = "Diffuse Properties";
    string UIWidget = "Color";
    int    UIOrder = 26;
> = float4(0, 0, 0, 1);

// ----------------------------------------------------------------------------
// Bump Properties
// ----------------------------------------------------------------------------
bool EnableBumpMap
<
    string UIName  = "Enable Bump Map";
    string UIGroup = "Environment Shader Flags";
    int    UIOrder = 27;
> = false;

float BumpMapScale
<
    string UIName   = "Bump Map Scale";
    string UIGroup  = "Bump Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 200; float UIStep = 0.1;
    int    UIOrder = 27;
> = 0.0;

Texture2D BumpMapTexture
<
    string UIName       = "Bump Map";
    string UIGroup      = "Bump Properties";
    string ResourceType = "2D";
    int    UIOrder = 28;
>;

// ----------------------------------------------------------------------------
// Texture Scrolling Animation
// ----------------------------------------------------------------------------
int UAnimationFunction
<
    string UIName   = "U Animation Function  [0=None  1=Zero  2=Cosine  3=Cosine (Variable Period) 4=Diagonal Wave  5=Diagonal Wave (Variable Period)  6=Slide  7=Slide (Variable Period) 8=Noise 9=Jitter 10=Wander 11=Spark]";
    string UIGroup  = "Texture Scrolling Animation";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 11; float UIStep = 1;
    int    UIOrder = 29;
> = 0;

float UAnimationPeriod
<
    string UIName   = "U Animation Period................(Seconds)";
    string UIGroup  = "Texture Scrolling Animation";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 30;
> = 0.0;

float UAnimationScale
<
    string UIName   = "U Animation Scale................(Repeats)";
    string UIGroup  = "Texture Scrolling Animation";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 31;
> = 0.0;

int VAnimationFunction
<
    string UIName   = "V Animation Function  [0=None  1=Zero  2=Cosine  3=Cosine (Variable Period) 4=Diagonal Wave  5=Diagonal Wave (Variable Period)  6=Slide  7=Slide (Variable Period) 8=Noise 9=Jitter 10=Wander 11=Spark]";
    string UIGroup  = "Texture Scrolling Animation";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 11; float UIStep = 1;
    int    UIOrder = 32;
> = 0;

float VAnimationPeriod
<
    string UIName   = "V Animation Period................(Seconds)";
    string UIGroup  = "Texture Scrolling Animation";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 32;
> = 0.0;

float VAnimationScale
<
    string UIName   = "V Animation Scale................(Repeats)";
    string UIGroup  = "Texture Scrolling Animation";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 33;
> = 0.0;

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
bool unfilteredFlag
<
    string UIName  = "Unfiltered";
    string UIGroup = "Self-Illumination Properties";
    int    UIOrder = 34;
> = false;

float4 PrimaryOnColor
<
    string UIName   = "Primary On Color";
    string UIGroup  = "Self-Illumination Properties";
    string UIWidget = "Color";
    int    UIOrder = 35;
> = float4(0, 0, 0, 1);

float4 PrimaryOffColor
<
    string UIName   = "Primary Off Color";
    string UIGroup  = "Self-Illumination Properties";
    string UIWidget = "Color";
    int    UIOrder = 36;
> = float4(0, 0, 0, 1);

int PrimaryAnimationFunction
<
    string UIName   = "Primary Animation Function  [0=None  1=Zero  2=Cosine  3=Cosine (Variable Period) 4=Diagonal Wave  5=Diagonal Wave (Variable Period)  6=Slide  7=Slide (Variable Period) 8=Noise 9=Jitter 10=Wander 11=Spark]";
    string UIGroup  = "Self-Illumination Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 11; float UIStep = 1;
    int    UIOrder = 37;
> = 0;

float PrimaryAnimationPeriod
<
    string UIName   = "Primary Animation Period................(Seconds)";
    string UIGroup  = "Self-Illumination Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 38;
> = 0.0;

float PrimaryAnimationPhase
<
    string UIName   = "Primary Animation Phase";
    string UIGroup  = "Self-Illumination Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 39;
> = 0.0;

float PrimaryAnimationValue
<
    //string UIName   = "Primary Animation Value";
    string UIGroup  = "Self-Illumination Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
    int    UIOrder = 40;
> = 0.0;

float4 SecondaryOnColor
<
    string UIName   = "Secondary On Color";
    string UIGroup  = "Self-Illumination Properties";
    string UIWidget = "Color";
    int    UIOrder = 41;
> = float4(0, 0, 0, 1);

float4 SecondaryOffColor
<
    string UIName   = "Secondary Off Color";
    string UIGroup  = "Self-Illumination Properties";
    string UIWidget = "Color";
    int    UIOrder = 42;
> = float4(0, 0, 0, 1);

int SecondaryAnimationFunction
<
    string UIName   = "Secondary Animation Function  [0=None  1=Zero  2=Cosine  3=Cosine (Variable Period) 4=Diagonal Wave  5=Diagonal Wave (Variable Period)  6=Slide  7=Slide (Variable Period) 8=Noise 9=Jitter 10=Wander 11=Spark]";
    string UIGroup  = "Self-Illumination Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 11; float UIStep = 1;
    int    UIOrder = 43;
> = 0;

float SecondaryAnimationPeriod
<
    string UIName   = "Secondary Animation Period................(Seconds)";
    string UIGroup  = "Self-Illumination Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 44;
> = 0.0;

float SecondaryAnimationPhase
<
    string UIName   = "Secondary Animation Phase";
    string UIGroup  = "Self-Illumination Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 45;
> = 0.0;

float SecondaryAnimationValue
<
    //string UIName   = "Secondary Animation Value";
    string UIGroup  = "Self-Illumination Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
    int    UIOrder = 46;
> = 0.0;

float4 PlasmaOnColor
<
    string UIName   = "Plasma On Color";
    string UIGroup  = "Self-Illumination Properties";
    string UIWidget = "Color";
    int    UIOrder = 47;
> = float4(0, 0, 0, 1);

float4 PlasmaOffColor
<
    string UIName   = "Plasma Off Color";
    string UIGroup  = "Self-Illumination Properties";
    string UIWidget = "Color";
    int    UIOrder = 48;
> = float4(0, 0, 0, 1);

int PlasmaAnimationFunction
<
    string UIName   = "Plasma Animation Function  [0=None  1=Zero  2=Cosine  3=Cosine (Variable Period) 4=Diagonal Wave  5=Diagonal Wave (Variable Period)  6=Slide  7=Slide (Variable Period) 8=Noise 9=Jitter 10=Wander 11=Spark]";
    string UIGroup  = "Self-Illumination Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 11; float UIStep = 1;
    int    UIOrder = 49;
> = 0;

float PlasmaAnimationPeriod
<
    string UIName   = "Plasma Animation Period................(Seconds)";
    string UIGroup  = "Self-Illumination Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 50;
> = 0.0;

float PlasmaAnimationPhase
<
    string UIName   = "Plasma Animation Phase";
    string UIGroup  = "Self-Illumination Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 51;
> = 0.0;

float PlasmaAnimationValue
<
    //string UIName   = "Plasma Animation Value";
    string UIGroup  = "Self-Illumination Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
    int    UIOrder = 52;
> = 0.0;

float SelfIlluminationMapScale
<
    string UIName   = "Self-Illumination Map Scale";
    string UIGroup  = "Self-Illumination Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 200; float UIStep = 0.1;
    int    UIOrder = 53;
> = 0.0;

bool EnableSelfIlluminationMap
<
    string UIName  = "Enable Self-Illumination Map";
    string UIGroup = "Environment Shader Flags";
    int    UIOrder = 54;
> = false;

Texture2D SelfIlluminationMapTexture
<
    string UIName       = "Self-Illumination Map";
    string UIGroup      = "Self-Illumination Properties";
    string ResourceType = "2D";
    int    UIOrder = 54;
>;

// ----------------------------------------------------------------------------
// Specular Properties
// ----------------------------------------------------------------------------
bool SpecularOverbright
<
    string UIName  = "Overbright";
    string UIGroup = "Specular Properties";
    int    UIOrder = 55;
> = false;

bool SpecularExtraShiny
<
    string UIName  = "Extra Shiny";
    string UIGroup = "Specular Properties";
    int    UIOrder = 56;
> = false;

bool LightmapIsSpecular
<
    string UIName  = "Lightmap Is Specular";
    string UIGroup = "Specular Properties";
    int    UIOrder = 57;
> = false;

float SpecBrightness
<
    string UIName   = "Brightness";
    string UIGroup  = "Specular Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
    int    UIOrder = 58;
> = 0.0;

float4 SpecPerpendicularColor
<
    string UIName   = "Perpendicular Color";
    string UIGroup  = "Specular Properties";
    string UIWidget = "Color";
    int    UIOrder = 59;
> = float4(0.0, 0.0, 0.0, 1);

float4 SpecParallelColor
<
    string UIName   = "Parallel Color";
    string UIGroup  = "Specular Properties";
    string UIWidget = "Color";
    int    UIOrder = 60;
> = float4(0.0, 0.0, 0.0, 1);

// ----------------------------------------------------------------------------
// Reflection Properties
// ----------------------------------------------------------------------------
bool DynamicMirror
<
    string UIName  = "Dynamic Mirror";
    string UIGroup = "Reflection Properties";
    int    UIOrder = 61;
> = false;

//   0 = bumped cube-map   - bump map affects reflection direction + fresnel
//   1 = flat cube-map     - bump attenuates fresnel, reflection is unbumped
//   2 = bumped radiosity  - same as bumped cube-map?
int ReflectionType
<
    string UIName   = "Reflection Type  [0=Bumped Cube Map  1=Flat Cube Map  2=Bumped Radiosity]";
    string UIGroup  = "Reflection Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 2; float UIStep = 1;
    int    UIOrder = 62;
> = 0;

float LightmapBrightnessScale
<
    string UIName   = "Lightmap Brightness Scale";
    string UIGroup  = "Reflection Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
    int    UIOrder = 63;
> = 0.0;

float ReflPerpendicularBrightness
<
    string UIName   = "Perpendicular Brightness";
    string UIGroup  = "Reflection Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
    int    UIOrder = 64;
> = 0.0;

float ReflParallelBrightness
<
    string UIName   = "Parallel Brightness";
    string UIGroup  = "Reflection Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
    int    UIOrder = 65;
> = 0.0;

bool EnableReflectionCube
<
    string UIName  = "Enable Reflection Cube";
    string UIGroup = "Environment Shader Flags";
    int    UIOrder = 66;
> = false;

// IMPORTANT: HCE reflection maps are 2D cross-layout atlases, NOT DX11 cubemaps.
Texture2D ReflectionCubeTexture
<
    string UIName       = "Reflection Cube Map";
    string UIGroup      = "Reflection Properties";
    string ResourceType = "2D";
    int    UIOrder = 67;
>;

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
    int UIOrder = 68;
> = 0;

// GlyphFX-only viewport control (not a tag field).  The ported bump map tends
// to read too strong in Nitrous; this scales the tangent-space slope so the
// relief can be softened (0 = flat) or exaggerated (>1).  1.0 = engine-faithful.
float BumpStrength
<
    string UIName   = "Bump Strength";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 2; float UIStep = 0.01;
    int UIOrder = 69;
> = 1.0;

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
