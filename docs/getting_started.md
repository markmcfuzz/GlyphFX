# Getting Started

This guide explains how to use **GlyphFX** shaders in Autodesk 3ds Max.

## Requirements

- Autodesk 3ds Max 2023 to 2026
- A DirectX 11 compatible GPU

## Installation

1. Clone or download this repository:
```bash
   git clone https://github.com/markmcfuzz/GlyphFX.git
```

2. Point 3ds Max to the `fx/` folder - you can keep it anywhere on disk.

## 3ds Max Configuration

> [!IMPORTANT]
> This step is crucial for the shaders to function correctly in 3ds Max.
> 1. Open 3ds Max and go to **File** -> **Preferences** -> **Gamma and LUT** and uncheck **Enable Gamma/LUT Correction**.
>
> 2. For rendering, press **F10** to open the Render Setup dialog, go to the **Renderer** tab and select **Quicksilver Hardware Renderer**.

> [!WARNING]
> For 3ds Max 2025 and later go to **Rendering** -> **Color Management** and change the `Color Management Mode` tab to **Unmanaged** then click in `Save As System Defaults` close and restart 3ds Max.

### Viewport preset (first time only)

The viewport needs its own settings to show the shaders as in game. Set them up once and save them as a preset:

1. Click the viewport's shading label (top left, e.g. `[High Quality]`) and select **High Quality**.
2. Open the same menu again and select **Active Viewport Settings**.
3. In the **Settings** tab:
   - **Rendering Level:** Advanced.
   - **Illuminate:** Default Lights, with **2 Default Lights**.
   - Uncheck **Highlights**, **Reflections From Environment**, **Progressive Skylight**, **Shadows** and **Ambient Occlusion**.
   - Leave **Material Rendering Level** on **Advanced Material** and **Transparency** on **Stochastic**.
4. Click the save icon next to **Preset**, name it `Halo CE` and click **OK**.

From then on, pick it from the same menu: **User Defined** -> **Halo CE**.

## Loading a Shader in 3ds Max

1. Open the **Material Editor** (`M` key) and select **Slate Material Editor**.
2. **Opaque shaders** (`shader_model`, `shader_model_extended`, `shader_environment`):
   - Create a **Standard (Legacy)** material and set **Self-Illumination** to 100 and **Specular Level** to 0.
   - Put an **OSL Map** in the **Diffuse** slot and load the shader, for example:

      `GlyphFX/src/osl/shader_model.osl`

3. **Transparent shaders:** right click in the space and select **Materials** -> **General** -> **DirectX Shader**,
   click the `.fx` file slot path (under `HLSL File` dropdown) and select the shader, for example:

      `GlyphFX/src/fx/shader_transparent_generic.fx`

4. The shader parameters will appear in the material UI - assign your
   textures and configure the flags to match your tag.

## Texture Slots

Each shader exposes its texture slots directly in the material UI.
Refer to the [Shader Types](shader_types.md) document for the specific
slots and parameters of each shader.

> [!WARNING]
> **OSL shaders:** don't use PNG textures with an alpha channel. The OSL map loads them with premultiplied alpha
> (the color is multiplied by the alpha), which breaks transparency and the multipurpose map channels.
> Save them as **TIF** with a separate (unassociated) alpha channel instead.

> [!TIP]
> - Use the `Halo CE` viewport preset (see above). With **Standard** (Rendering Level **Basic**)
>   transparencies draw wrong, the whole model looks semi-transparent and animations play slowly.
> - Use the **Debug Mode** parameter to inspect individual texture channels
>   directly in the viewport.
> - Texture paths are not embedded in the `.fx` file - you must assign them
>   manually in the Material Editor each time.