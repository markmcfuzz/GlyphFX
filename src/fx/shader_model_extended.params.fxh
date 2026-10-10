// ----------------------------------------------------------------------------
// GlyphFX | fx/shader_model_extended.params.fxh
//
// All UI-exposed parameters for shader_model_extended.
//
// Same fields as shader_model.params.fxh, followed by the extended tag fields
// in tag order: detail map 2, bump properties (base normal + 2 detail
// normals), specular properties and diffuse lighting flags.
//
// Fields documented as "0 = 1" keep the raw tag value here (0 by default, as
// in a fresh tag); the shader substitutes 1 when the value is 0, the same rule
// OpenSauce (which ringworld's shader_model_extended is based on) applies when
// it builds the map.
// ----------------------------------------------------------------------------

#ifndef GLYPHFX_MODEL_EXTENDED_PARAMS_FXH
#define GLYPHFX_MODEL_EXTENDED_PARAMS_FXH

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
    string UIName   = "Light Color";
    string UIWidget = "Color";
> = float3(1.0, 1.0, 1.0);
#endif

float4 AmbientColor
<
    string UIName   = "Ambient Color";
    string UIWidget = "Color";
> = float4(0.3, 0.3, 0.3, 1.0);

float4 FillLightColor
<
    string UIName   = "Fill Light Color";
    string UIWidget = "Color";
> = float4(0.3, 0.3, 0.35, 1.0);

float LampIntensity
<
    string UIName   = "Light Intensity  (Scene Light)";
    string UIWidget = "slider";
    float  UIMin = 0.0; float UIMax = 2.0; float UIStep = 0.01;
> = 0.6;

float DitherScale
<
    string UIGroup  = "Shader Model Flags";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
> = 1.0;

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
// Shader Model Fields
// ----------------------------------------------------------------------------
bool DetailAfterReflection
<
    string UIName  = "Detail After Reflection";
    string UIGroup = "Shader Model Flags";
    int    UIOrder = 8;
> = false;

bool TwoSided
<
    string UIName  = "Two Sided";
    string UIGroup = "Shader Model Flags";
    int    UIOrder = 9;
> = false;

bool NotAlphaTested
<
    string UIName  = "Not Alpha Tested";
    string UIGroup = "Shader Model Flags";
    int    UIOrder = 10;
> = false;

bool AlphaBlendedDecal
<
    string UIName  = "Alpha Blended Decal";
    string UIGroup = "Shader Model Flags";
    int    UIOrder = 11;
> = false;

bool TrueAtmosphericFog
<
    string UIName  = "True Atmospheric Fog";
    string UIGroup = "Shader Model Flags";
    int    UIOrder = 12;
> = false;

bool DisableTwoSidedCulling
<
    string UIName   = "Disable Two-Sided Culling";
    string UIGroup  = "Shader Model Flags";
    int    UIOrder = 13;
> = false;

bool UseXboxChannelOrder
<
    string UIName  = "Use Xbox Multipurpose Channel Order";
    string UIGroup = "Shader Model Flags";
    int    UIOrder = 14;
> = false;

float Translucency
<
    string UIName   = "Translucency";
    string UIGroup  = "Shader Model Flags";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
    int    UIOrder = 15;
> = 0.0000000;

// ----------------------------------------------------------------------------
// Change Color
// ----------------------------------------------------------------------------
int ChangeColorSource
<
    string UIName   = "Change Color Source  [0=none  1=A  2=B  3=C  4=D]";
    string UIGroup  = "Change Color Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 4; float UIStep = 1;
    int    UIOrder = 16;
> = 0;

float4 ChangeColor
<
    string UIName   = "Change Color (Only for 3ds Max)";
    string UIGroup  = "Change Color Properties";
    string UIWidget = "Color";
    int    UIOrder = 17;
> = float4(1, 1, 1, 1);

// ----------------------------------------------------------------------------
// Self Illumination Color
// ----------------------------------------------------------------------------
bool NoRandomPhaseFlag
<
    string UIName = "No Random Phase";
    string UIGroup = "Self Illumination Properties";
    int UIOrder = 18;
> = false;

int SelfIlluminationColorSource
<
    string UIName = "Self Illum Color Source  [0=None  1=A  2=B  3=C  4=D]";
    string UIGroup = "Self Illumination Properties";
    string UIWidget = "slider";
    float UIMin = 0; float UIMax = 4; float UIStep = 1;
    int UIOrder = 19;
> = 0.0;

int SelfIlluminationAnimationFunction
<
    string UIName   = "Self Illum Animation Function [0=One  1=Zero  2=Cosine  3=Cosine (Variable Period) 4=Diagonal Wave  5=Diagonal Wave (Variable Period)  6=Slide  7=Slide (Variable Period) 8=Noise 9=Jitter 10=Wander 11=Spark]";
    string UIGroup  = "Self Illumination Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 11; float UIStep = 1;
    int    UIOrder = 20;
> = 0;

float SelfIlluminationAnimationPeriod
<
    string UIName   = "Self Illum Animation Period................(Seconds)";
    string UIGroup  = "Self Illumination Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 21;
> = 0.0;

float4 AnimationColorLowerBound
<
    string UIName = "Animation Color Lower Bound";
    string UIGroup = "Self Illumination Properties";
    string UIWidget = "Color";
    int UIOrder = 22;
> = float4(0, 0, 0, 0);

float4 AnimationColorUpperBound
<
    string UIName = "Animation Color Upper Bound";
    string UIGroup = "Self Illumination Properties";
    string UIWidget = "Color";
    int UIOrder = 23;
> = float4(0, 0, 0, 0);

float4 SelfIlluminationColor
<
    string UIName   = "Self Illumination Color (Only for 3ds Max)";
    string UIGroup  = "Self Illumination Properties";
    string UIWidget = "Color";
    int    UIOrder = 24;
> = float4(0, 0, 0, 0);

// ----------------------------------------------------------------------------
// Base Map Properties
// ----------------------------------------------------------------------------
float MapUScale
<
    string UIName   = "Map U Scale";
    string UIGroup  = "Base Map Properties";
    string UIWidget = "slider";
    float  UIMin = -64; float UIMax = 64; float UIStep = 0.01;
    int    UIOrder = 25;
> = 1.0;

float MapVScale
<
    string UIName   = "Map V Scale";
    string UIGroup  = "Base Map Properties";
    string UIWidget = "slider";
    float  UIMin = -64; float UIMax = 64; float UIStep = 0.01;
    int    UIOrder = 26;
> = 1.0;

bool EnableBaseMap
<
    string UIName  = "Enable Base Map..................(only for 3ds Max)";
    string UIGroup = "Base Map Properties";
    int    UIOrder = 27;
> = true;

Texture2D BaseMapTexture
<
    string UIName       = "Base Map";
    string UIGroup      = "Base Map Properties";
    string ResourceType = "2D";
    int    UIOrder = 28;
>;

// ----------------------------------------------------------------------------
// Multipurpose Properties
// ----------------------------------------------------------------------------
bool EnableMultipurposeMap
<
    string UIName  = "Enable Multipurpose Map........(only for 3ds Max)";
    string UIGroup = "Multipurpose Properties";
    int    UIOrder = 29;
> = true;

Texture2D MultipurposeMapTexture
<
    string UIName       = "Multipurpose Map";
    string UIGroup      = "Multipurpose Properties";
    string ResourceType = "2D";
    int    UIOrder = 30;
>;

int DetailFunction
<
    string UIName   = "Detail Function  [0=Double Biased Multiply  1=Multiply  2=Double Biased Add]";
    string UIGroup  = "Multipurpose Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 2; float UIStep = 1;
    int    UIOrder = 31;
> = 0;

int DetailMask
<
    string UIName   = "Detail Mask  [0=None  1=Refl_Inv  2=Refl  3=SI_Inv  4=SI  5=CC_Inv  6=CC  7=Aux_Inv  8=Aux]";
    string UIGroup  = "Multipurpose Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
    int    UIOrder = 32;
> = 0;

float DetailMapScale
<
    string UIName   = "Detail Map Scale";
    string UIGroup  = "Multipurpose Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 64; float UIStep = 0.01;
    int    UIOrder = 33;
> = 1.0;

bool EnableDetailMap
<
    string UIName  = "Enable Detail Map.................(only for 3ds Max)";
    string UIGroup = "Multipurpose Properties";
    int    UIOrder = 34;
> = true;

Texture2D DetailMapTexture
<
    string UIName       = "Detail Map";
    string UIGroup      = "Multipurpose Properties";
    string ResourceType = "2D";
    int    UIOrder = 35;
>;

// Multiplier on top of DetailMapScale for the V axis only (0 = 1x, square tiling).
float DetailMapVScale
<
    string UIName   = "Detail Map V Scale  (multiplier of Detail Map Scale)";
    string UIGroup  = "Multipurpose Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 64; float UIStep = 0.01;
    int    UIOrder = 36;
> = 0.0;

// ----------------------------------------------------------------------------
// Texture Scrolling Animation
// ----------------------------------------------------------------------------
int UAnimationSource
<
    string UIName   = "U Animation Source  [0=None  1=A Out  2=B Out  3=C Out  4=D Out]";
    string UIGroup  = "Texture Scrolling Animation";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 4; float UIStep = 1;
    int    UIOrder = 37;
> = 0;

int UAnimationFunction
<
    string UIName   = "U Animation Function  [0=One  1=Zero  2=Cosine  3=Cosine (Variable Period) 4=Diagonal Wave  5=Diagonal Wave (Variable Period)  6=Slide  7=Slide (Variable Period) 8=Noise 9=Jitter 10=Wander 11=Spark]";
    string UIGroup  = "Texture Scrolling Animation";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 11; float UIStep = 1;
    int    UIOrder = 38;
> = 0;

float UAnimationPeriod
<
    string UIName   = "U Animation Period................(Seconds)";
    string UIGroup  = "Texture Scrolling Animation";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 39;
> = 0.0;

float UAnimationPhase
<
    string UIName   = "U Animation Phase";
    string UIGroup  = "Texture Scrolling Animation";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 40;
> = 0.0;

float UAnimationScale
<
    string UIName   = "U Animation Scale................(Repeats)";
    string UIGroup  = "Texture Scrolling Animation";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 41;
> = 0.0;

int VAnimationSource
<
    string UIName   = "V Animation Source  [0=None  1=A Out  2=B Out  3=C Out  4=D Out]";
    string UIGroup  = "Texture Scrolling Animation";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 4; float UIStep = 1;
    int    UIOrder = 42;
> = 0;

int VAnimationFunction
<
    string UIName   = "V Animation Function  [0=One  1=Zero  2=Cosine  3=Cosine (Variable Period) 4=Diagonal Wave  5=Diagonal Wave (Variable Period)  6=Slide  7=Slide (Variable Period) 8=Noise 9=Jitter 10=Wander 11=Spark]";
    string UIGroup  = "Texture Scrolling Animation";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 11; float UIStep = 1;
    int    UIOrder = 43;
> = 0;

float VAnimationPeriod
<
    string UIName   = "V Animation Period................(Seconds)";
    string UIGroup  = "Texture Scrolling Animation";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 44;
> = 0.0;

float VAnimationPhase
<
    string UIName   = "V Animation Phase";
    string UIGroup  = "Texture Scrolling Animation";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 45;
> = 0.0;

float VAnimationScale
<
    string UIName   = "V Animation Scale................(Repeats)";
    string UIGroup  = "Texture Scrolling Animation";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 46;
> = 0.0;

int RotationAnimationSource
<
    string UIName   = "Rotation Animation Source  [0=None  1=A Out  2=B Out  3=C Out  4=D Out]";
    string UIGroup  = "Texture Scrolling Animation";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 4; float UIStep = 1;
    int    UIOrder = 47;
> = 0;

int RotationAnimationFunction
<
    string UIName   = "Rotation Animation Function  [0=One  1=Zero  2=Cosine  3=Cosine (Variable Period) 4=Diagonal Wave  5=Diagonal Wave (Variable Period)  6=Slide  7=Slide (Variable Period) 8=Noise 9=Jitter 10=Wander 11=Spark]";
    string UIGroup  = "Texture Scrolling Animation";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 11; float UIStep = 1;
    int    UIOrder = 48;
> = 0;

float RotationAnimationPeriod
<
    string UIName   = "Rotation Animation Period................(Seconds)";
    string UIGroup  = "Texture Scrolling Animation";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 49;
> = 0.0;

float RotationAnimationPhase
<
    string UIName   = "Rotation Animation Phase";
    string UIGroup  = "Texture Scrolling Animation";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 50;
> = 0.0;

float RotationAnimationScale
<
    string UIName   = "Rotation Animation Scale................(Repeats)";
    string UIGroup  = "Texture Scrolling Animation";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 51;
> = 0.0;

float RotationAnimationCenterX
<
    string UIName = "Animation Center X";
    string UIGroup = "Texture Scrolling Animation";
    string UIWidget = "slider";
    float UIMin = -1000000; float UIMax = 1000000; float UIStep = 0.1;
    int UIOrder = 52;
> = 0.0;

float RotationAnimationCenterY
<
    string UIName = "Animation Center Y";
    string UIGroup = "Texture Scrolling Animation";
    string UIWidget = "slider";
    float UIMin = -1000000; float UIMax = 1000000; float UIStep = 0.1;
    int UIOrder = 53;
> = 0.0;

// ----------------------------------------------------------------------------
// Reflection Properties
// ----------------------------------------------------------------------------
float PerpendicularBrightness
<
    string UIName   = "Perpendicular Brightness";
    string UIGroup  = "Reflection Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
    int    UIOrder = 54;
> = 0.0;

float4 PerpendicularTintColor
<
    string UIName   = "Perpendicular Tint Color";
    string UIGroup  = "Reflection Properties";
    string UIWidget = "Color";
    int    UIOrder = 55;
> = float4(1, 1, 1, 1);

float ParallelBrightness
<
    string UIName   = "Parallel Brightness";
    string UIGroup  = "Reflection Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
    int    UIOrder = 56;
> = 0.0;

float4 ParallelTintColor
<
    string UIName   = "Parallel Tint Color";
    string UIGroup  = "Reflection Properties";
    string UIWidget = "Color";
    int    UIOrder = 57;
> = float4(1, 1, 1, 1);

int ReflectionMask
<
    string UIGroup  = "Reflection Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1; float UIStep = 1;
    int    UIOrder = 58;
> = 0;

bool EnableReflectionCube
<
    string UIName  = "Enable Reflection Cube..........(only for 3ds Max)";
    string UIGroup = "Reflection Properties";
    int    UIOrder = 59;
> = true;

// IMPORTANT: HCE reflection maps are 2D cross-layout atlases, NOT DX11 cubemaps.
Texture2D ReflectionCubeTexture
<
    string UIName       = "Reflection Cube Map";
    string UIGroup      = "Reflection Properties";
    string ResourceType = "2D";
    int    UIOrder = 60;
>;

// ----------------------------------------------------------------------------
// Extended (only for 3ds Max)
// Turns all the shader_model_extended additions on or off at once: detail
// map 2, the normal maps, the specular color map and specular lighting.
// Off = renders exactly like shader_model, for side-by-side comparison.
// ----------------------------------------------------------------------------
bool EnableExtended
<
    string UIName  = "Enable Extended.....................(only for 3ds Max)";
    string UIGroup = "Extended";
    int    UIOrder = 61;
> = true;

// ----------------------------------------------------------------------------
// Detail Map 2 (extended)
// Applied after detail map 1, with its own function and multipurpose mask.
// ----------------------------------------------------------------------------
int Detail2Function
<
    string UIName   = "Detail 2 Function  [0=Double Biased Multiply  1=Multiply  2=Double Biased Add]";
    string UIGroup  = "Detail 2 Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 2; float UIStep = 1;
    int    UIOrder = 62;
> = 0;

int Detail2Mask
<
    string UIName   = "Detail 2 Mask  [0=None  1=Refl_Inv  2=Refl  3=SI_Inv  4=SI  5=CC_Inv  6=CC  7=Aux_Inv  8=Aux]";
    string UIGroup  = "Detail 2 Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
    int    UIOrder = 63;
> = 0;

float Detail2MapScale
<
    string UIName   = "Detail 2 Map Scale";
    string UIGroup  = "Detail 2 Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 64; float UIStep = 0.01;
    int    UIOrder = 64;
> = 1.0;

bool EnableDetail2Map
<
    string UIName  = "Enable Detail 2 Map..............(only for 3ds Max)";
    string UIGroup = "Detail 2 Properties";
    int    UIOrder = 65;
> = true;

Texture2D Detail2MapTexture
<
    string UIName       = "Detail 2 Map";
    string UIGroup      = "Detail 2 Properties";
    string ResourceType = "2D";
    int    UIOrder = 66;
>;

// Multiplier on top of Detail2MapScale for the V axis only (0 = 1x, square tiling).
float Detail2MapVScale
<
    string UIName   = "Detail 2 Map V Scale  (multiplier of Detail 2 Map Scale)";
    string UIGroup  = "Detail 2 Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 64; float UIStep = 0.01;
    int    UIOrder = 67;
> = 0.0;

// ----------------------------------------------------------------------------
// Bump Properties (extended)
// Base normal map RGB holds tangent-space normals. Its alpha interpolates
// between no detail normals, detail normals 1 and detail normals 2:
//   A = none / B = detail 1 / C = detail 2
//   0/0.000 (A) -> 85/0.333 (B) -> 170/0.666 (C) -> 255/1.000 (A)
// Without a base normal map, detail normal 1 is applied on its own at full
// strength and detail normal 2 is unused.
// ----------------------------------------------------------------------------
bool EnableBaseNormalMap
<
    string UIName  = "Enable Base Normal Map........(only for 3ds Max)";
    string UIGroup = "Bump Properties";
    int    UIOrder = 68;
> = true;

Texture2D BaseNormalMapTexture
<
    string UIName       = "Base Normal Map";
    string UIGroup      = "Bump Properties";
    string ResourceType = "2D";
    int    UIOrder = 69;
>;

float BaseNormalCoefficient
<
    string UIName   = "Base Normal Coefficient  (0 = 1)";
    string UIGroup  = "Bump Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 16; float UIStep = 0.01;
    int    UIOrder = 70;
> = 0.0;

bool EnableDetailNormal1Map
<
    string UIName  = "Enable Detail Normal 1 Map....(only for 3ds Max)";
    string UIGroup = "Bump Properties";
    int    UIOrder = 71;
> = true;

Texture2D DetailNormal1MapTexture
<
    string UIName       = "Detail Normal 1 Map";
    string UIGroup      = "Bump Properties";
    string ResourceType = "2D";
    int    UIOrder = 72;
>;

float DetailNormal1Coefficient
<
    string UIName   = "Detail Normal 1 Coefficient  (0 = 1)";
    string UIGroup  = "Bump Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 16; float UIStep = 0.01;
    int    UIOrder = 73;
> = 0.0;

float DetailNormal1Scale
<
    string UIName   = "Detail Normal 1 Scale  (0 = 1)";
    string UIGroup  = "Bump Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 64; float UIStep = 0.01;
    int    UIOrder = 74;
> = 0.0;

// Multiplier on top of DetailNormal1Scale for the V axis only (0 = 1x).
float DetailNormal1VScale
<
    string UIName   = "Detail Normal 1 V Scale  (multiplier of Detail Normal 1 Scale, 0 = 1)";
    string UIGroup  = "Bump Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 64; float UIStep = 0.01;
    int    UIOrder = 75;
> = 0.0;

bool EnableDetailNormal2Map
<
    string UIName  = "Enable Detail Normal 2 Map....(only for 3ds Max)";
    string UIGroup = "Bump Properties";
    int    UIOrder = 76;
> = true;

Texture2D DetailNormal2MapTexture
<
    string UIName       = "Detail Normal 2 Map";
    string UIGroup      = "Bump Properties";
    string ResourceType = "2D";
    int    UIOrder = 77;
>;

float DetailNormal2Coefficient
<
    string UIName   = "Detail Normal 2 Coefficient  (0 = 1)";
    string UIGroup  = "Bump Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 16; float UIStep = 0.01;
    int    UIOrder = 78;
> = 0.0;

float DetailNormal2Scale
<
    string UIName   = "Detail Normal 2 Scale  (0 = 1)";
    string UIGroup  = "Bump Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 64; float UIStep = 0.01;
    int    UIOrder = 79;
> = 0.0;

// Multiplier on top of DetailNormal2Scale for the V axis only (0 = 1x).
float DetailNormal2VScale
<
    string UIName   = "Detail Normal 2 V Scale  (multiplier of Detail Normal 2 Scale, 0 = 1)";
    string UIGroup  = "Bump Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 64; float UIStep = 0.01;
    int    UIOrder = 80;
> = 0.0;

// ----------------------------------------------------------------------------
// Specular Properties (extended)
// Specular color map RGB tints the specular reflection per pixel. Its alpha
// can mask the specular lighting exponent when the flag is set. Specular
// lighting is only enabled when its exponent is non-zero.
// ----------------------------------------------------------------------------
bool EnableSpecularColorMap
<
    string UIName  = "Enable Specular Color Map.....(only for 3ds Max)";
    string UIGroup = "Specular Properties";
    int    UIOrder = 81;
> = true;

Texture2D SpecularColorMapTexture
<
    string UIName       = "Specular Color Map";
    string UIGroup      = "Specular Properties";
    string ResourceType = "2D";
    int    UIOrder = 82;
>;

float SpecularColorCoefficient
<
    string UIName   = "Specular Color Coefficient  (0 = 1)";
    string UIGroup  = "Specular Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 16; float UIStep = 0.01;
    int    UIOrder = 83;
> = 0.0;

float SpecularColorExponent
<
    string UIName   = "Specular Color Exponent  (0 = 1)";
    string UIGroup  = "Specular Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 16; float UIStep = 0.01;
    int    UIOrder = 84;
> = 0.0;

bool AlphaAsExponentMask
<
    string UIName  = "Specular Color Flags: Alpha as Exponent Mask";
    string UIGroup = "Specular Properties";
    int    UIOrder = 85;
> = false;

float SpecularLightingExponent
<
    string UIName   = "Specular Lighting Exponent  (0 = specular lighting off)";
    string UIGroup  = "Specular Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 256; float UIStep = 0.5;
    int    UIOrder = 86;
> = 0.0;

float SpecularLightingCoefficient
<
    string UIName   = "Specular Lighting Coefficient  (0 = 1)";
    string UIGroup  = "Specular Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 16; float UIStep = 0.01;
    int    UIOrder = 87;
> = 0.0;

// Directional lightmaps from the BSP - no viewport equivalent.
bool DoNotUseDlmsBsp
<
    string UIName  = "Diffuse Lighting Flags: Do Not Use DLMs (BSP)";
    string UIGroup = "Specular Properties";
    int    UIOrder = 88;
> = false;

// ----------------------------------------------------------------------------
// Debug Parameters
// These are not tag fields; they help inspect the shader in the viewport.
// ----------------------------------------------------------------------------
// Debug visualisation - set to non-zero to inspect individual channels.
//  0 = normal render
//  1 = base map (unlit)
//  2 = multipurpose map RGB
//  3 = mp.R channel (grayscale)
//  4 = mp.G channel (grayscale)  <- self-illumination mask
//  5 = mp.B channel (grayscale)  <- PC specular/reflection mask
//  6 = mp.A channel (grayscale)  <- PC change-color mask
//  7 = detail map (unlit)
//  8 = reflection only (no diffuse) - tests whether cube map is loading
//  9 = base normal map RGB
// 10 = detail normal weights (R = detail normal 1, G = detail normal 2)
// 11 = final world-space normal (remapped to 0..1)
// 12 = detail map 2 (unlit)
// 13 = specular color map RGB (after exponent/coefficient)
// 14 = specular color map alpha (grayscale)
// 15 = specular lighting only
// 16 = tangent frame fix (R = tangent flipped, G = binormal flipped)
int DebugMode
<
    string UIName   = "Debug Mode  [0=Off  1=Base  2=MP.RGB  3=MP.R  4=MP.G  5=MP.B  6=MP.A  7=Detail  8=ReflOnly  9=BaseNormal  10=DetailNormalWeights  11=Normal  12=Detail2  13=SpecColor  14=SpecAlpha  15=SpecLighting  16=TangentFlips]";
    string UIGroup  = "Debug Parameters";
    string UIWidget = "Spinner";
    float  UIMin = 0; float UIMax = 16; float UIStep = 1;
    int    UIOrder = 89;
> = 0;

// Scales the tangent-space slope of the combined normal map. 0 flattens it,
// 1 = engine-faithful, >1 exaggerates it.
float BumpStrength
<
    string UIName   = "Bump Strength  (only for 3ds Max)";
    string UIGroup  = "Debug Parameters";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 2; float UIStep = 0.01;
    int    UIOrder = 90;
> = 1.0;

// Adjusts reflection intensity without affecting diffuse lighting, for testing cube map loading and alignment.
float ReflectionIntensityScale
<
    string UIName   = "Reflection Intensity Scale";
    string UIGroup  = "Debug Parameters";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 4; float UIStep = 0.01;
    int    UIOrder = 91;
> = 1.0;

// Multiplies the specular lighting exponent, viewport only.  The viewport's
// single unattenuated scene light spreads a low-exponent highlight over most
// of the model; a higher exponent narrows it.  2 is set by eye.
float SpecularLightingTightness
<
    string UIName   = "Specular Lighting Tightness  (only for 3ds Max)";
    string UIGroup  = "Debug Parameters";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 16; float UIStep = 0.1;
    int    UIOrder = 92;
> = 10.0;

float ReflectionBlur
<
    string UIName   = "Reflection Blur  (0=sharp)";
    string UIGroup  = "Debug Parameters";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 8; float UIStep = 0.5;
    int    UIOrder = 93;
> = 0.0;

float CubemapUOffset
<
    string UIName   = "Cubemap U Offset";
    string UIGroup  = "Debug Parameters";
    string UIWidget = "slider";
    float  UIMin = -1; float UIMax = 1; float UIStep = 0.01;
    int    UIOrder = 94;
> = 0.0;

float CubemapVOffset
<
    string UIName   = "Cubemap V Offset";
    string UIGroup  = "Debug Parameters";
    string UIWidget = "slider";
    float  UIMin = -1; float UIMax = 1; float UIStep = 0.01;
    int    UIOrder = 95;
> = 0.0;

float CubemapPitch
<
    string UIName   = "Cubemap Pitch Rotation (radians)";
    string UIGroup  = "Debug Parameters";
    string UIWidget = "slider";
    float  UIMin = -1.57; float UIMax = 1.57; float UIStep = 0.01;
    int    UIOrder = 96;
> = -0.0;

// Rebuilds the sign of Max's tangent/binormal from the UVs so normal maps on
// mirrored UV islands match the game (no seam down symmetric models).
bool FixMirroredTangents
<
    string UIName  = "Fix Mirrored UV Tangents  (only for 3ds Max)";
    string UIGroup = "Debug Parameters";
    int    UIOrder = 97;
> = true;

// ----------------------------------------------------------------------------
// Other Properties (Hidden in 3ds Max UI)
// ----------------------------------------------------------------------------
float c_alpha_ref
<
    string UIGroup  = "Other Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
> = 0.5;

float4 c_fog_color
<
    string UIGroup  = "Other Properties";
    string UIWidget = "Color";
> = float4(0.5, 0.6, 0.7, 1);

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

#endif // GLYPHFX_MODEL_EXTENDED_PARAMS_FXH
