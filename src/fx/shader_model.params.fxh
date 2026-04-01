// ----------------------------------------------------------------------------
// GlyphFX | fx/model.params.fxh
//
// All UI-exposed parameters for shader_model.
// ----------------------------------------------------------------------------

#ifndef GLYPHFX_MODEL_PARAMS_FXH
#define GLYPHFX_MODEL_PARAMS_FXH

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

float SpecularPower
<
    string UIWidget = "slider";
    float  UIMin = 1.0; float UIMax = 128.0; float UIStep = 1.0;
> = 24.0;

float LampIntensity
<
    string UIName   = "Light Intensity  (Scene Light)";
    string UIWidget = "slider";
    float  UIMin = 0.0; float UIMax = 2.0; float UIStep = 0.01;
> = 1.0;

// Debug visualisation — set to non-zero to inspect individual channels.
//  0 = normal render
//  1 = base map (unlit)
//  2 = multipurpose map RGB
//  3 = mp.R channel (grayscale)
//  4 = mp.G channel (grayscale)  <- self-illumination mask
//  5 = mp.B channel (grayscale)  <- PC specular/reflection mask
//  6 = mp.A channel (grayscale)  <- PC change-color mask
//  7 = detail map (unlit)
//  8 = reflection only (no diffuse) — tests whether cube map is loading
int DebugMode
<
    string UIName   = "Debug Mode  [0=Off  1=Base  2=MP.RGB  3=MP.R  4=MP.G  5=MP.B  6=MP.A  7=Detail  8=ReflOnly]";
    string UIWidget = "Spinner";
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
> = 0;

float ReflectionIntensityScale
<
    string UIName   = "Debug Reflection Intensity Scale";
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
    //string UIName   = "Cubemap Pitch Rotation (radians)";
    string UIWidget = "slider";
    float  UIMin = -1.57; float UIMax = 1.57; float UIStep = 0.01;
> = -0.25;

// ----------------------------------------------------------------------------
// Shader Model Flags
// ----------------------------------------------------------------------------
bool DetailAfterReflection
<
    string UIName  = "Detail After Reflection";
    string UIGroup = "Shader Model Flags";
> = false;

bool TwoSided
<
    string UIName  = "Two Sided";
    string UIGroup = "Shader Model Flags";
> = false;

bool NotAlphaTested
<
    string UIName  = "Not Alpha Tested";
    string UIGroup = "Shader Model Flags";
> = false;

bool AlphaBlendedDecal
<
    string UIName  = "Alpha Blended Decal";
    string UIGroup = "Shader Model Flags";
> = false;

bool TrueAtmosphericFog
<
    string UIName  = "True Atmospheric Fog";
    string UIGroup = "Shader Model Flags";
> = false;

bool UseXboxChannelOrder
<
    string UIName  = "Use Xbox Multipurpose Channel Order";
    string UIGroup = "Shader Model Flags";
> = false;

// ----------------------------------------------------------------------------
// Texture-connected flags
// DX11 samples unbound textures as black (0,0,0,0), which breaks blend modes
// that expect a neutral value. Set each flag only when the texture is assigned.
// ----------------------------------------------------------------------------
bool EnableBaseMap
<
    string UIName  = "Enable Base Map";
    string UIGroup = "Shader Model Flags";
> = false;

bool EnableDetailMap
<
    string UIName  = "Enable Detail Map";
    string UIGroup = "Shader Model Flags";
> = false;

bool EnableMultipurposeMap
<
    string UIName  = "Enable Multipurpose Map";
    string UIGroup = "Shader Model Flags";
> = false;

bool EnableReflectionCube
<
    string UIName  = "Enable Reflection Cube";
    string UIGroup = "Shader Model Flags";
> = false;

// ----------------------------------------------------------------------------
// Base Map Properties
// ----------------------------------------------------------------------------
float Translucency
<
    string UIName   = "Translucency";
    string UIGroup  = "Base Map Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
> = 0.0;

float4 ChangeColor
<
    string UIName   = "Change Color";
    string UIGroup  = "Base Map Properties";
    string UIWidget = "Color";
> = float4(1, 1, 1, 1);

float4 SelfIlluminationColor
<
    string UIName   = "Self Illumination Color";
    string UIGroup  = "Base Map Properties";
    string UIWidget = "Color";
> = float4(0, 0, 0, 0);

float MapUScale
<
    string UIName   = "Map U Scale";
    string UIGroup  = "Base Map Properties";
    string UIWidget = "slider";
    float  UIMin = -64; float UIMax = 64; float UIStep = 0.01;
> = 1.0;

float MapVScale
<
    string UIName   = "Map V Scale";
    string UIGroup  = "Base Map Properties";
    string UIWidget = "slider";
    float  UIMin = -64; float UIMax = 64; float UIStep = 0.01;
> = 1.0;

Texture2D BaseMapTexture
<
    string UIName       = "Base Map";
    string UIGroup      = "Base Map Properties";
    string ResourceType = "2D";
>;

// ----------------------------------------------------------------------------
// Multipurpose Properties
// ----------------------------------------------------------------------------
Texture2D MultipurposeMapTexture
<
    string UIName       = "Multipurpose Map";
    string UIGroup      = "Multipurpose Properties";
    string ResourceType = "2D";
>;

int DetailFunction
<
    string UIName   = "Detail Function  [0=Double Biased Multiply  1=Multiply  2=Biased Add]";
    string UIGroup  = "Multipurpose Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 2; float UIStep = 1;
> = 0;

int DetailMask
<
    string UIName   = "Detail Mask  [0=None  1=Refl_Inv  2=Refl  3=SI_Inv  4=SI  5=CC_Inv  6=CC  7=Aux_Inv  8=Aux]";
    string UIGroup  = "Multipurpose Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
> = 0;

float DetailMapScale
<
    string UIName   = "Detail Map Scale (U)";
    string UIGroup  = "Multipurpose Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 64; float UIStep = 0.01;
> = 1.0;

float DetailMapVScale
<
    string UIName   = "Detail Map V Scale  (0 = square, copies U scale)";
    string UIGroup  = "Multipurpose Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 64; float UIStep = 0.01;
> = 0.0;

Texture2D DetailMapTexture
<
    string UIName       = "Detail Map";
    string UIGroup      = "Multipurpose Properties";
    string ResourceType = "2D";
>;

float PerpendicularBrightness
<
    string UIName   = "Perpendicular Brightness";
    string UIGroup  = "Multipurpose Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
> = 0.0;

float4 PerpendicularTintColor
<
    string UIName   = "Perpendicular Tint Color";
    string UIGroup  = "Multipurpose Properties";
    string UIWidget = "Color";
> = float4(1, 1, 1, 1);

float ParallelBrightness
<
    string UIName   = "Parallel Brightness";
    string UIGroup  = "Multipurpose Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
> = 0.0;

float4 ParallelTintColor
<
    string UIName   = "Parallel Tint Color";
    string UIGroup  = "Multipurpose Properties";
    string UIWidget = "Color";
> = float4(1, 1, 1, 1);

int ReflectionMask
<
    string UIGroup  = "Multipurpose Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1; float UIStep = 1;
> = 0;

// IMPORTANT: HCE reflection maps are 2D cross-layout atlases, NOT DX11 cubemaps.
Texture2D ReflectionCubeTexture
<
    string UIName       = "Reflection Cube Map";
    string UIGroup      = "Multipurpose Properties";
    string ResourceType = "2D";
>;

// ----------------------------------------------------------------------------
// Other Properties
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

#endif // GLYPHFX_MODEL_PARAMS_FXH