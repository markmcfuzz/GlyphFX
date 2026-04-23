// ----------------------------------------------------------------------------
// GlyphFX | fx/shader_transparent_glass.params.fxh
//
// All UI-exposed parameters for shader_transparent_glass.
// Matches the Guerrilla tag layout:
//   - glass shader flags
//   - background tint properties
//   - reflection properties (bumped / flat cube-map)
//   - diffuse properties
//   - specular properties
// ----------------------------------------------------------------------------

#ifndef GLYPHFX_TRANSPARENT_GLASS_PARAMS_FXH
#define GLYPHFX_TRANSPARENT_GLASS_PARAMS_FXH

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
// Debug Parameters
// ----------------------------------------------------------------------------
//  0 = normal render
//  1 = background tint map
//  2 = bump map normal
//  3 = reflection only
//  4 = diffuse map
//  5 = diffuse detail map
//  6 = specular map
//  7 = specular detail map
//  8 = specular mask
int DebugMode
<
    string UIName   = "Debug Mode  [0=Normal  1=Tint Map  2=Bump Normal  3=Reflection Only  4=Diffuse Map  5=Diffuse Detail  6=Specular Map  7=Specular Detail  8=Specular Mask]";
    string UIWidget = "Spinner";
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
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
// Glass Shader Flags
// ----------------------------------------------------------------------------
bool AlphaTested
<
    string UIName  = "Alpha Tested";
    string UIGroup = "Glass Shader Flags";
    int    UIOrder = 0;
> = false;

bool Decal
<
    string UIName  = "Decal";
    string UIGroup = "Glass Shader Flags";
    int    UIOrder = 1;
> = false;

bool TwoSided
<
    string UIName  = "Two Sided";
    string UIGroup = "Glass Shader Flags";
    int    UIOrder = 2;
> = false;

bool BumpMapIsSpecularMask
<
    string UIName  = "Bump Map Is Specular Mask";
    string UIGroup = "Glass Shader Flags";
    int    UIOrder = 3;
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
    int    UIOrder = 10;
> = float4(0, 0, 0, 1);

float BackgroundTintMapScale
<
    string UIName   = "Background Tint Map Scale";
    string UIGroup  = "Background Tint Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 200; float UIStep = 0.1;
    int    UIOrder = 11;
> = 0.0;

Texture2D BackgroundTintMapTexture
<
    string UIName       = "Background Tint Map";
    string UIGroup      = "Background Tint Properties";
    string ResourceType = "2D";
    int    UIOrder = 12;
>;

// ----------------------------------------------------------------------------
// Reflection Properties
//
// Reflection maps are multiplied by fresnel terms (glancing angles cause
// reflections to disappear) and then added to the background.
// The primary reflection map is textured normally, while the secondary
// reflection map is magnified.
// ----------------------------------------------------------------------------

//   0 = bumped cube-map   - bump map affects reflection direction + fresnel
//   1 = flat cube-map     - bump attenuates fresnel, reflection is unbumped
//   2 = dynamic mirror (bumped)  - mirror reflection (not implemented in viewport)
//   3 = dynamic mirror (flat)    - mirror reflection (not implemented in viewport)
int ReflectionType
<
    string UIName   = "Reflection Type  [0=Bumped Cube Map  1=Flat Cube Map  2=Dynamic Mirror Bumped  3=Dynamic Mirror Flat]";
    string UIGroup  = "Reflection Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 3; float UIStep = 1;
    int    UIOrder = 20;
> = 0;

float ReflPerpendicularBrightness
<
    string UIName   = "Perpendicular Brightness";
    string UIGroup  = "Reflection Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
    int    UIOrder = 21;
> = 0.0;

float4 ReflPerpendicularTintColor
<
    string UIName   = "Perpendicular Tint Color";
    string UIGroup  = "Reflection Properties";
    string UIWidget = "Color";
    int    UIOrder = 22;
> = float4(0, 0, 0, 1);

float ReflParallelBrightness
<
    string UIName   = "Parallel Brightness";
    string UIGroup  = "Reflection Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
    int    UIOrder = 23;
> = 0.0;

float4 ReflParallelTintColor
<
    string UIName   = "Parallel Tint Color";
    string UIGroup  = "Reflection Properties";
    string UIWidget = "Color";
    int    UIOrder = 24;
> = float4(0, 0, 0, 1);

// IMPORTANT: HCE reflection maps are 2D cross-layout atlases, NOT DX11 cubemaps.
Texture2D ReflectionCubeTexture
<
    string UIName       = "Reflection Map";
    string UIGroup      = "Reflection Properties";
    string ResourceType = "2D";
    int    UIOrder = 25;
>;

float BumpMapScale
<
    string UIName   = "Bump Map Scale";
    string UIGroup  = "Reflection Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 200; float UIStep = 0.1;
    int    UIOrder = 26;
> = 0.0;

Texture2D BumpMapTexture
<
    string UIName       = "Bump Map";
    string UIGroup      = "Reflection Properties";
    string ResourceType = "2D";
    int    UIOrder = 27;
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
    float  UIMin = 0; float UIMax = 200; float UIStep = 0.1;
    int    UIOrder = 30;
> = 0.0;

Texture2D DiffuseMapTexture
<
    string UIName       = "Diffuse Map";
    string UIGroup      = "Diffuse Properties";
    string ResourceType = "2D";
    int    UIOrder = 31;
>;

float DiffuseDetailMapScale
<
    string UIName   = "Diffuse Detail Map Scale";
    string UIGroup  = "Diffuse Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 200; float UIStep = 0.1;
    int    UIOrder = 32;
> = 0.0;

Texture2D DiffuseDetailMapTexture
<
    string UIName       = "Diffuse Detail Map";
    string UIGroup      = "Diffuse Properties";
    string ResourceType = "2D";
    int    UIOrder = 33;
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
    float  UIMin = 0; float UIMax = 200; float UIStep = 0.1;
    int    UIOrder = 40;
> = 0.0;

Texture2D SpecularMapTexture
<
    string UIName       = "Specular Map";
    string UIGroup      = "Specular Properties";
    string ResourceType = "2D";
    int    UIOrder = 41;
>;

float SpecularDetailMapScale
<
    string UIName   = "Specular Detail Map Scale";
    string UIGroup  = "Specular Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 200; float UIStep = 0.1;
    int    UIOrder = 42;
> = 0.0;

Texture2D SpecularDetailMapTexture
<
    string UIName       = "Specular Detail Map";
    string UIGroup      = "Specular Properties";
    string ResourceType = "2D";
    int    UIOrder = 43;
>;

// ----------------------------------------------------------------------------
// Texture-connected flags
// DX11 samples unbound textures as black (0,0,0,0), which breaks blend modes
// that expect a neutral value.  Set each flag only when the texture is assigned.
// ----------------------------------------------------------------------------
bool EnableBackgroundTintMap
<
    string UIName  = "Enable Background Tint Map";
    string UIGroup = "Glass Shader Flags";
> = false;

bool EnableReflectionCube
<
    string UIName  = "Enable Reflection Cube";
    string UIGroup = "Glass Shader Flags";
> = true;

bool EnableBumpMap
<
    string UIName  = "Enable Bump Map";
    string UIGroup = "Glass Shader Flags";
> = false;

bool EnableDiffuseMap
<
    string UIName  = "Enable Diffuse Map";
    string UIGroup = "Glass Shader Flags";
> = false;

bool EnableDiffuseDetailMap
<
    string UIName  = "Enable Diffuse Detail Map";
    string UIGroup = "Glass Shader Flags";
> = false;

bool EnableSpecularMap
<
    string UIName  = "Enable Specular Map";
    string UIGroup = "Glass Shader Flags";
> = false;

bool EnableSpecularDetailMap
<
    string UIName  = "Enable Specular Detail Map";
    string UIGroup = "Glass Shader Flags";
> = false;

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

#endif // GLYPHFX_TRANSPARENT_GLASS_PARAMS_FXH
