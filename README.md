<html>
    <p align="center">
        <img width="250px" src="img/GlyphFxLogo.png"/>
    </p>
    <h1 align="center">GlyphFX</h1>
</html>

> HLSL shaders for **Halo Combat Evolved**, converted to `.fx` format for use with the **DirectX Shader** material in Autodesk 3ds Max.

**GlyphFX** aims to bring Halo CE's original shading system into 3ds Max as faithfully as possible - giving artists and modders a real-time viewport representation that closely matches what the game actually renders.

> [!NOTE]
> This project is built as a **submodule** of [**HaloCE Max Toolkit**](https://github.com/markmcfuzz/HaloCE-Max-Toolkit), which automatically assigns and configures these shaders when importing `.gbxmodel` and `scenario_structure_bsp` tags, also create materials based on Halo CE Shaders. However, you can also use the `.fx` files directly in your own 3ds Max projects if you want to set up materials manually.

---

## Supported Shaders

| Shader Type | Status |
|---|---|
| `shader_environment` | In progress |
| `shader_model` | Done |
| `shader_transparent_chicago` | In progress |
| `shader_transparent_chicago_extended` | In progress |
| `shader_transparent_generic` | In progress |
| `shader_transparent_glass` | In progress |
| `shader_transparent_meter` | In progress |
| `shader_transparent_plasma` | In progress |
| `shader_transparent_water` | In progress |

---

## Requirements

<div align="left">
  <a href="https://www.autodesk.com/mx/products/3ds-max/overview" target="_blank"><img src="https://img.shields.io/badge/3ds%20Max-2023%2B-39a5cc?labelColor=302d41&style=for-the-badge&logo=autodesk&logoColor=white" alt="3ds Max"></a>
</div>

<div align="left">
  <a href="https://download.microsoft.com/download/1/7/1/1718ccc4-6315-4d8e-9543-8e28a4e18c4c/dxwebsetup.exe" target="_blank"><img src="https://img.shields.io/badge/DirectX-9%2B-76B900?labelColor=302d41&style=for-the-badge&logo=nvidia&logoColor=white" alt="DirectX"></a>
</div>

<div align="left">
  <a href="https://github.com/markmcfuzz/HaloCE-Max-Toolkit" target="_blank"><img src="https://img.shields.io/badge/Halo%20CE%20Max%20Toolkit-Optional-334455?labelColor=302d41&style=for-the-badge&logo=github&logoColor=white" alt="HaloCE Max Toolkit"></a>
</div>

---

## Getting Started

### Manual use

1. Clone or download this repository:
   ```bash
   git clone https://github.com/markmcfuzz/GlyphFX
   ```

2. In 3ds Max, open the **Material Editor** or **Slate Material Editor** and create a new **DirectX Shader** material.

3. Click the `.fx` file slot and browse to the shader you want, for example:
   ```
   GlyphFX/src/model/model.fx
   ```

4. The material parameters will appear in the UI - assign your textures and tweak values as needed.

### As a submodule (HaloCE Max Toolkit)

If you're using [HaloCE Max Toolkit](https://github.com/markmcfuzz/HaloCE-Max-Toolkit), GlyphFX is included automatically. Clone the Toolkit with:

```bash
git clone --recursive https://github.com/markmcfuzz/HaloCE-Max-Toolkit
```

When importing a `.gbxmodel` tag, the Toolkit will detect the shader type and assign the corresponding `.fx` from GlyphFX, pre-configured with the values from the tag.

---

## Project Structure

```
GlyphFX/
├── src/
│   ├── common/
│   │   ├── includes/       # Shared headers, macros, constants
│   │   └── utils/          # Reusable functions across shaders
│   ├── environment/        # shader_environment
│   ├── model/              # shader_model
│   └── transparent/
│       ├── chicago/
│       ├── chicago_extended/
│       ├── generic/
│       ├── glass/
│       ├── meter/
│       ├── plasma/
│       └── water/
├── examples/               # 3ds Max example scenes
├── docs/                   # Extended documentation
└── README.md
```

---

## Preview

> Screenshots and viewport comparisons coming soon.

---

## References & Credits

- **Halo CE Editing Kit** - Shader source provided by 343 Industries
- **[Censhine](https://github.com/Sledmine/censhine)** - Decrypted shader reference, instrumental for the initial `shader_model` proof of concept
- **Halo CE community** - For keeping this game alive all these years

---

## License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

The original shader source code from the Halo CE Editing Kit is property of **343 Industries / Microsoft**. This project does not redistribute those files.

---

## Contributing

Contributions, corrections, and feedback are welcome! If you know HLSL or have experience with Halo's rendering, feel free to open an issue or a pull request.

---

## Donate
Love the project? Please consider donating to help it improve!

<div align="left">
  <a href="https://ko-fi.com/markmcfuzz" target="_blank"><img src="https://img.shields.io/badge/Ko%e2%80%91fi-Donate-blue?labelColor=302d41&color=adffc7&logo=ko-fi&logoColor=d9e0ee&style=for-the-badge" alt="Ko-fi"></a>
</div>

<br>

---

<p align="center">Copyright © 2026 Mark McFuzz</p>
<div align="center">
  <a href="LICENSE"><img src="https://custom-icon-badges.demolab.com/github/license/markmcfuzz/GlyphFX?label=License&labelColor=302d41&color=91d7e3&logo=law&logoColor=d9e0ee&style=for-the-badge" alt="GitHub Readme Profile License"></a>
</div>
<br>