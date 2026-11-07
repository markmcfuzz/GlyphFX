// ----------------------------------------------------------------------------
// TEMPORAL - prueba: ¿dónde pone 3ds Max la luz por defecto (PointLight0) que
// recibe un DirectX Shader cuando la escena no tiene luces?  No va en el commit.
//
// Uso: escena SIN luces.  Asigna este .fx a una esfera (DirectX Shader) y
// cambia "Mode":
//   0  diferencia entre la luz que pasa Max y una luz en el ojo:
//      negro = iguales (la luz está en el ojo);
//      rojo  = la luz de Max ilumina más ahí;  azul = la del ojo ilumina más.
//   1  N·L de la luz que pasa Max (gris).
//   2  N·L de una luz en el ojo (gris), lo que hace el OSL con LampFromView = 1.
//   3  dónde está la luz respecto a la cámara:
//      verde puro = en el ojo (a menos de 1 unidad);
//      si no, color = 0.5 + 0.5 * dirección (R = derecha, G = arriba,
//      B = hacia atrás de la cámara).  Ej.: gris medio con algo de rojo y
//      verde = arriba a la derecha.
//   4  el color de la luz que pasa Max (LampColor).
// Repite Mode 0 y 3 con otra vista y en una vista ortográfica.
// ----------------------------------------------------------------------------

float4x4 matWVP  : WorldViewProjection   < string UIWidget = "None"; >;
float4x4 matW    : World                 < string UIWidget = "None"; >;
float4x4 matWIT  : WorldInverseTranspose < string UIWidget = "None"; >;
float4x4 ViewIXf : ViewInverse           < string UIWidget = "None"; >;

float3 LampPos : POSITION
<
    string Object = "PointLight0";
    string Space  = "World";
    int    refID  = 0;
> = float3(-50.0, 150.0, 100.0);

float3 LampColor : LIGHTCOLOR
<
    int    LightRef = 0;
    string UIWidget = "None";
> = float3(1.0, 1.0, 1.0);

int Mode
<
    string UIName   = "Mode";
    string UIWidget = "slider";
    int UIMin = 0; int UIMax = 4; int UIStep = 1;
> = 0;

struct VSIn  { float4 position : POSITION; float3 normal : NORMAL; };
struct VSOut { float4 clipPos : SV_POSITION; float3 wPos : TEXCOORD0; float3 wNormal : TEXCOORD1; };

VSOut VS_Main(VSIn v)
{
    VSOut o;
    o.clipPos = mul(v.position, matWVP);
    o.wPos    = mul(v.position, matW).xyz;
    o.wNormal = mul(v.normal, (float3x3)matWIT);
    return o;
}

float4 PS_Main(VSOut i) : SV_Target
{
    float3 N   = normalize(i.wNormal);
    float3 eye = ViewIXf[3].xyz;
    float  nlMax = saturate(dot(N, normalize(LampPos - i.wPos)));
    float  nlEye = saturate(dot(N, normalize(eye - i.wPos)));

    if (Mode == 1) return float4(nlMax.xxx, 1);
    if (Mode == 2) return float4(nlEye.xxx, 1);
    if (Mode == 4) return float4(LampColor, 1);
    if (Mode == 3)
    {
        float3 d = LampPos - eye;
        if (length(d) < 1.0) return float4(0, 1, 0, 1);
        float3 l = float3(dot(d, ViewIXf[0].xyz), dot(d, ViewIXf[1].xyz), dot(d, ViewIXf[2].xyz));
        return float4(0.5 + 0.5 * normalize(l), 1);
    }
    float diff = (nlMax - nlEye) * 4.0;
    return float4(saturate(diff), 0, saturate(-diff), 1);
}

technique11 test_lamp_pos
<
    string Script = "Pass=p0;";
>
{
    pass p0
    <
        string Script = "Draw=geometry;";
    >
    {
        SetVertexShader  ( CompileShader( vs_5_0, VS_Main() ) );
        SetGeometryShader( NULL );
        SetPixelShader   ( CompileShader( ps_5_0, PS_Main() ) );
    }
}
