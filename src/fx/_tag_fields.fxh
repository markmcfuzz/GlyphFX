// ----------------------------------------------------------------------------
// GlyphFX | fx/_tag_fields.fxh
//
// Shows or hides a shader's tag fields in the material UI.
//
// The toolkit edits the shaders from its tag editor and re-applies the
// material parameters from it, so the material UI does not need the tag
// fields: hiding them loads the UI much faster and leaves one place to edit
// them (a change made in the material UI would be lost on export, since Build
// Shaders writes the tag from the toolkit's copy).
//
// Each params file sets its own default and includes this file:
//
//   #ifndef GX_SHOW_TAG_FIELDS
//   #define GX_SHOW_TAG_FIELDS 1
//   #endif
//   #include "_tag_fields.fxh"
//
// and marks every tag field with one of:
//   string UIWidget = GX_TAG_WIDGET("slider");   its widget when shown
//   GX_TAG_HIDDEN                                 fields without a UIWidget
//
// Hidden fields are still compiled and keep their names, so MAXScript can
// read and write them and saved scenes keep their values.  What stays visible
// either way: GlyphFX/3ds Max-only parameters and the textures.
// ----------------------------------------------------------------------------

#ifndef GLYPHFX_TAG_FIELDS_FXH
#define GLYPHFX_TAG_FIELDS_FXH

#if GX_SHOW_TAG_FIELDS
#define GX_TAG_WIDGET(widget) widget
#define GX_TAG_HIDDEN
#else
#define GX_TAG_WIDGET(widget) "None"
#define GX_TAG_HIDDEN string UIWidget = "None";
#endif

#endif // GLYPHFX_TAG_FIELDS_FXH
