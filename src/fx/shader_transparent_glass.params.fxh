// ----------------------------------------------------------------------------
// GlyphFX | fx/shader_transparent_glass.params.fxh
//
// All UI-exposed parameters for shader_transparent_glass.
// Field names, grouping and help text below are transcribed from Guerrilla's
// shader_transparent_glass tag editor so this file doubles as an accurate
// reference of the real tag schema, not just a viewport control panel.
// Every tag field is present with its exact name even where the 3ds Max
// viewport can't act on it - those are called out per-field rather than
// hidden.
//
//   Guerrilla group             → UIGroup here
//   "radiosity properties"        "Shader General Fields"  (base Shader struct)
//   "physics properties"          "Shader General Fields"  (material type)
//   "glass shader"                "Glass Shader Flags"
//   "background tint properties"  "Background Tint Properties"
//   "reflection properties"       "Reflection Properties"
//   "diffuse properties"          "Diffuse Properties"
//   "specular properties"         "Specular Properties"
//
// Enable* booleans are GlyphFX-only: DX11 samples an unbound texture as black
// (0,0,0,0), which breaks blend modes that expect a neutral value, and 3ds Max
// has no way to clear an assigned bitmap once picked.  Each one sits
// immediately above the texture it gates.
// ----------------------------------------------------------------------------

#ifndef GLYPHFX_TRANSPARENT_GLASS_PARAMS_FXH
#define GLYPHFX_TRANSPARENT_GLASS_PARAMS_FXH

// ----------------------------------------------------------------------------
// Viewport light  (GlyphFX-only, not tag data)
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
    string UIName   = "Lightmap Ambient Color";
    string UIWidget = "Color";
> = float4(0.3, 0.3, 0.3, 1.0);

float4 FillLightColor
<
    string UIName   = "Fill Light Color";
    string UIWidget = "Color";
> = float4(0.3, 0.3, 0.35, 1.0);

float LampIntensity
<
    string UIName   = "Light Power";
    string UIWidget = "slider";
    float  UIMin = 0.0; float UIMax = 2.0; float UIStep = 0.01;
> = 0.6;

// ----------------------------------------------------------------------------
// Shader General Fields  (base "Shader" tag struct)
//   Guerrilla "radiosity properties" + "physics properties".
//   Radiosity is baked offline by the tools and physics only matters in
//   structure BSP uses, so none of these affect the viewport render - they
//   are here for tag fidelity.
// ----------------------------------------------------------------------------
bool SimpleParameterization
<
    string UIName  = "Simple Parameterization";
    string UIGroup = "Shader General Fields";
    int    UIOrder = 0;
> = false;

bool IgnoreNormals
<
    string UIName  = "Ignore Normals";
    string UIGroup = "Shader General Fields";
    int    UIOrder = 1;
> = false;

bool TransparentLit
<
    string UIName  = "Transparent Lit";
    string UIGroup = "Shader General Fields";
    int    UIOrder = 2;
> = false;

int DetailLevel
<
    string UIName   = "Detail Level  [0=High 1=Medium 2=Low 3=Turd]";
    string UIGroup  = "Shader General Fields";
    string UIWidget = "slider";
    int    UIOrder = 3;
    float  UIMin = 0; float UIMax = 3; float UIStep = 1;
> = 0;

float Power
<
    string UIName   = "Power";
    string UIGroup  = "Shader General Fields";
    string UIWidget = "slider";
    int    UIOrder = 4;
    float  UIMin = 0; float UIMax = 9999; float UIStep = 1;
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

// Physics properties - only relevant in structure BSP uses.
//   0=Dirt  1=Sand  2=Stone  3=Snow  4=Wood  5=Metal Hollow  6=Metal Thin
//   7=Metal Thick  8=Rubber  9=Glass  10=Force Field  11=Grunt
//   12=Hunter Armor  13=Hunter Skin  14=Elite  15=Jackal
//   16=Jackal Energy Shield  17=Engineer Skin  18=Engineer Force Field
//   19=Flood Combat Form  20=Flood Carrier Form  21=Cyborg Armor
//   22=Cyborg Energy Shield  23=Human Armor  24=Human Skin  25=Sentinel
//   26=Monitor  27=Plastic  28=Water  29=Leaves  30=Elite Energy Shield
//   31=Ice  32=Hunter Shield
float MaterialType
<
    string UIName   = "Material Type  (see enum in header comment)";
    string UIGroup  = "Shader General Fields";
    string UIWidget = "slider";
    int    UIOrder = 7;
    float  UIMin = 0; float UIMax = 32; float UIStep = 1;
> = 0;

// ----------------------------------------------------------------------------
// Glass Shader Flags
// ----------------------------------------------------------------------------
bool AlphaTested
<
    string UIName  = "Alpha Tested";
    string UIGroup = "Glass Shader Flags";
    int    UIOrder = 8;
> = false;

bool Decal
<
    string UIName  = "Decal  (not implemented in viewport)";
    string UIGroup = "Glass Shader Flags";
    int    UIOrder = 9;
> = false;

bool TwoSided
<
    string UIName  = "Two Sided";
    string UIGroup = "Glass Shader Flags";
    int    UIOrder = 10;
> = false;

bool BumpMapIsSpecularMask
<
    string UIName  = "Bump Map Is Specular Mask";
    string UIGroup = "Glass Shader Flags";
    int    UIOrder = 11;
> = false;

// ----------------------------------------------------------------------------
// Background Tint Properties
//
// Background pixels are multiplied by the tint map and constant tint color.
// ----------------------------------------------------------------------------
float4 BackgroundTintColor
<
    string UIName   = "Background Tint Color";
    string UIGroup  = "Background Tint Properties";
    string UIWidget = "Color";
    int    UIOrder = 12;
> = float4(0, 0, 0, 1);

float BackgroundTintMapScale
<
    string UIName   = "Background Tint Map Scale";
    string UIGroup  = "Background Tint Properties";
    string UIWidget = "slider";
    int    UIOrder = 13;
    float  UIMin = 0; float UIMax = 200; float UIStep = 0.1;
> = 0.0;

bool EnableBackgroundTintMap
<
    string UIName  = "Enable Background Tint Map";
    string UIGroup = "Background Tint Properties";
    int    UIOrder = 14;
> = false;

Texture2D BackgroundTintMapTexture
<
    string UIName       = "Background Tint Map";
    string UIGroup      = "Background Tint Properties";
    string ResourceType = "2D";
    int    UIOrder = 15;
>;

// ----------------------------------------------------------------------------
// Reflection Properties
//
// Reflection maps are multiplied by fresnel terms (glancing angles cause
// reflections to disappear) and then added to the background.
// The primary reflection map is textured normally, while the secondary
// reflection map is magnified.
// ----------------------------------------------------------------------------

//   0 = bumped cube-map  - bump map affects reflection direction + fresnel
//   1 = flat cube-map    - bump attenuates fresnel, reflection is unbumped
//   2 = dynamic mirror   - real-time mirror reflection; the viewport has no
//                          mirror render target, so it falls back to the
//                          bumped cube-map path
int ReflectionType
<
    string UIName   = "Reflection Type  [0=Bumped Cube-Map 1=Flat Cube-Map 2=Dynamic Mirror]";
    string UIGroup  = "Reflection Properties";
    string UIWidget = "slider";
    int    UIOrder = 16;
    float  UIMin = 0; float UIMax = 2; float UIStep = 1;
> = 0;

float ReflPerpendicularBrightness
<
    string UIName   = "Perpendicular Brightness  [0,1]";
    string UIGroup  = "Reflection Properties";
    string UIWidget = "slider";
    int    UIOrder = 17;
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
> = 0.0;

float4 ReflPerpendicularTintColor
<
    string UIName   = "Perpendicular Tint Color";
    string UIGroup  = "Reflection Properties";
    string UIWidget = "Color";
    int    UIOrder = 18;
> = float4(0, 0, 0, 1);

float ReflParallelBrightness
<
    string UIName   = "Parallel Brightness  [0,1]";
    string UIGroup  = "Reflection Properties";
    string UIWidget = "slider";
    int    UIOrder = 19;
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
> = 0.0;

float4 ReflParallelTintColor
<
    string UIName   = "Parallel Tint Color";
    string UIGroup  = "Reflection Properties";
    string UIWidget = "Color";
    int    UIOrder = 20;
> = float4(0, 0, 0, 1);

bool EnableReflectionCube
<
    string UIName  = "Enable Reflection Map";
    string UIGroup = "Reflection Properties";
    int    UIOrder = 21;
> = true;

// IMPORTANT: HCE reflection maps are 2D cross-layout atlases, NOT DX11 cubemaps.
Texture2D ReflectionCubeTexture
<
    string UIName       = "Reflection Map";
    string UIGroup      = "Reflection Properties";
    string ResourceType = "2D";
    int    UIOrder = 22;
>;

float BumpMapScale
<
    string UIName   = "Bump Map Scale";
    string UIGroup  = "Reflection Properties";
    string UIWidget = "slider";
    int    UIOrder = 23;
    float  UIMin = 0; float UIMax = 200; float UIStep = 0.1;
> = 0.0;

// Disabled substitutes a flat normal (0.5, 0.5, 1, 1).
bool EnableBumpMap
<
    string UIName  = "Enable Bump Map";
    string UIGroup = "Reflection Properties";
    int    UIOrder = 24;
> = false;

Texture2D BumpMapTexture
<
    string UIName       = "Bump Map";
    string UIGroup      = "Reflection Properties";
    string ResourceType = "2D";
    int    UIOrder = 25;
>;

// ----------------------------------------------------------------------------
// Diffuse Properties
//
// Diffuse lights are accumulated in monochrome and then alpha-blended with
// diffuse map and diffuse detail map.  The color is determined by
// double-multiplying both maps and multiplying with the accumulated light,
// the result being alpha-blended into the framebuffer.  The opacity is
// determined by multiplying both map's alpha channels.
// Since this effect is alpha-blended, it covers up tinting and reflection
// on pixels with high opacity.
// ----------------------------------------------------------------------------
float DiffuseMapScale
<
    string UIName   = "Diffuse Map Scale";
    string UIGroup  = "Diffuse Properties";
    string UIWidget = "slider";
    int    UIOrder = 26;
    float  UIMin = 0; float UIMax = 200; float UIStep = 0.1;
> = 0.0;

bool EnableDiffuseMap
<
    string UIName  = "Enable Diffuse Map";
    string UIGroup = "Diffuse Properties";
    int    UIOrder = 27;
> = false;

Texture2D DiffuseMapTexture
<
    string UIName       = "Diffuse Map";
    string UIGroup      = "Diffuse Properties";
    string ResourceType = "2D";
    int    UIOrder = 28;
>;

float DiffuseDetailMapScale
<
    string UIName   = "Diffuse Detail Map Scale";
    string UIGroup  = "Diffuse Properties";
    string UIWidget = "slider";
    int    UIOrder = 29;
    float  UIMin = 0; float UIMax = 200; float UIStep = 0.1;
> = 0.0;

bool EnableDiffuseDetailMap
<
    string UIName  = "Enable Diffuse Detail Map";
    string UIGroup = "Diffuse Properties";
    int    UIOrder = 30;
> = false;

Texture2D DiffuseDetailMapTexture
<
    string UIName       = "Diffuse Detail Map";
    string UIGroup      = "Diffuse Properties";
    string ResourceType = "2D";
    int    UIOrder = 31;
>;

// ----------------------------------------------------------------------------
// Specular Properties
//
// Specular lights are accumulated in monochrome and then alpha-blended with
// specular map and specular detail map.  The color is determined by
// double-multiplying both maps and multiplying with the accumulated light,
// the result being alpha-blended into the framebuffer.  The opacity is
// determined by multiplying both map's alpha channels.
// Since this effect is alpha-blended, it covers up tinting, reflection and
// diffuse texture on pixels with high opacity.
// ----------------------------------------------------------------------------
float SpecularMapScale
<
    string UIName   = "Specular Map Scale";
    string UIGroup  = "Specular Properties";
    string UIWidget = "slider";
    int    UIOrder = 32;
    float  UIMin = 0; float UIMax = 200; float UIStep = 0.1;
> = 0.0;

bool EnableSpecularMap
<
    string UIName  = "Enable Specular Map";
    string UIGroup = "Specular Properties";
    int    UIOrder = 33;
> = false;

Texture2D SpecularMapTexture
<
    string UIName       = "Specular Map";
    string UIGroup      = "Specular Properties";
    string ResourceType = "2D";
    int    UIOrder = 34;
>;

float SpecularDetailMapScale
<
    string UIName   = "Specular Detail Map Scale";
    string UIGroup  = "Specular Properties";
    string UIWidget = "slider";
    int    UIOrder = 35;
    float  UIMin = 0; float UIMax = 200; float UIStep = 0.1;
> = 0.0;

bool EnableSpecularDetailMap
<
    string UIName  = "Enable Specular Detail Map";
    string UIGroup = "Specular Properties";
    int    UIOrder = 36;
> = false;

Texture2D SpecularDetailMapTexture
<
    string UIName       = "Specular Detail Map";
    string UIGroup      = "Specular Properties";
    string ResourceType = "2D";
    int    UIOrder = 37;
>;

// ----------------------------------------------------------------------------
// Other Properties  (GlyphFX-only, not tag data)
// ----------------------------------------------------------------------------
float c_alpha_ref
<
    string UIGroup  = "Other Properties";
    string UIWidget = "slider";
    int    UIOrder = 38;
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
> = 0.5;

float4 c_fog_color_correction_0
<
    string UIGroup  = "Other Properties";
    string UIWidget = "Color";
    int    UIOrder = 39;
> = float4(0.5, 0.6, 0.7, 1);

float4 c_fog_color_correction_E
<
    string UIGroup  = "Other Properties";
    string UIWidget = "Color";
    int    UIOrder = 40;
> = float4(0, 0, 0, 0);

float4 c_fog_color_correction_1
<
    string UIGroup  = "Other Properties";
    string UIWidget = "Color";
    int    UIOrder = 41;
> = float4(1, 1, 1, 1);

// ----------------------------------------------------------------------------
// Debug Parameters  (GlyphFX-only, not tag data)
//  0 = normal render
//  1 = background tint map
//  2 = bump map normal
//  3 = reflection only
//  4 = diffuse map
//  5 = diffuse detail map
//  6 = specular map
//  7 = specular detail map
//  8 = specular mask
// ----------------------------------------------------------------------------
int DebugMode
<
    string UIName   = "Debug Mode  [0=Normal 1=Tint Map 2=Bump Normal 3=Reflection Only 4=Diffuse Map 5=Diffuse Detail 6=Specular Map 7=Specular Detail 8=Specular Mask]";
    string UIGroup  = "Debug Parameters";
    string UIWidget = "Spinner";
    int    UIOrder = 42;
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
> = 0;

float ReflectionIntensityScale
<
    string UIGroup  = "Debug Parameters";
    string UIWidget = "slider";
    int    UIOrder = 43;
    float  UIMin = 0; float UIMax = 4; float UIStep = 0.01;
> = 1.0;

float ReflectionBlur
<
    string UIGroup  = "Debug Parameters";
    string UIWidget = "slider";
    int    UIOrder = 44;
    float  UIMin = 0; float UIMax = 8; float UIStep = 0.5;
> = 0.0;

float CubemapVOffset
<
    string UIGroup  = "Debug Parameters";
    string UIWidget = "slider";
    int    UIOrder = 45;
    float  UIMin = -1; float UIMax = 1; float UIStep = 0.01;
> = 0.0;

float CubemapUOffset
<
    string UIGroup  = "Debug Parameters";
    string UIWidget = "slider";
    int    UIOrder = 46;
    float  UIMin = -1; float UIMax = 1; float UIStep = 0.01;
> = 0.0;

float CubemapPitch
<
    string UIGroup  = "Debug Parameters";
    string UIWidget = "slider";
    int    UIOrder = 47;
    float  UIMin = -1.57; float UIMax = 1.57; float UIStep = 0.01;
> = -0.0;

#endif // GLYPHFX_TRANSPARENT_GLASS_PARAMS_FXH
