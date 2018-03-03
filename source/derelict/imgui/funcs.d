/*
 * Copyright (c) 2017 Derelict Developers
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 *
 * * Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 *
 * * Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the distribution.
 *
 * * Neither the names 'Derelict', 'DerelictImgui', nor the names of its contributors
 *   may be used to endorse or promote products derived from this software
 *   without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
module derelict.imgui.funcs;

private
{
    import derelict.util.system;
    import derelict.imgui.types;
    import core.stdc.stdarg:va_list;
}

extern(C) @nogc nothrow
{
    alias da_igGetIO                        = ImGuiIO* function();
    alias da_igGetStyle                     = ImGuiStyle* function();
    alias da_igGetDrawData                  = ImDrawData* function();
    alias da_igNewFrame                     = void function();
    alias da_igRender                       = void function();
    alias da_igShutdown                     = void function();
    alias da_igShowDemoWindow               = void function(bool* p_open = null);
    alias da_igShowMetricsWindow            = void function(bool* p_open = null);
    alias da_igShowStyleEditor              = void function(ImGuiStyle* ref_ = null);
    alias da_igShowStyleSelector            = bool function(const char* label = null);
    alias da_igShowFontSelector             = void function(const char* label = null);
    alias da_igShowUserGuide                = void function();

    // Window
    alias da_igBegin                        = bool function(const char* name, bool* p_opened = null, ImGuiWindowFlags flags = 0);
    alias da_igEnd                          = void function();
    alias da_igBeginChild                   = bool function(const char* str_id, const ImVec2 size = ImVec2(0, 0), bool border = false, ImGuiWindowFlags extra_flags = 0);
    alias da_igBeginChildEx                 = bool function(ImGuiID id, const ImVec2 size = ImVec2(0, 0), bool border = false, ImGuiWindowFlags extra_flags = 0);
    alias da_igEndChild                     = void function();
    alias da_igGetContentRegionMax          = void function(ImVec2* outParam);
    alias da_igGetContentRegionAvail        = void function(ImVec2* outParam);
    alias da_igGetContentRegionAvailWidth   = float function();
    alias da_igGetWindowContentRegionMin    = void function(ImVec2* outParam);
    alias da_igGetWindowContentRegionMax    = void function(ImVec2* outParam);
    alias da_igGetWindowContentRegionWidth  = float function();
    alias da_igGetWindowDrawList            = ImDrawList* function();
    alias da_igGetWindowPos                 = void function(ImVec2* outParam);
    alias da_igGetWindowSize                = void function(ImVec2* outParam);
    alias da_igGetWindowWidth               = float function();
    alias da_igGetWindowHeight              = float function();
    alias da_igIsWindowCollapsed            = bool function();
    alias da_igSetWindowFontScale           = void function(float scale);

    alias da_igSetNextWindowPos             = void function(const ImVec2 pos, ImGuiCond cond = 0, const ImVec2 pivot = ImVec2(0,0));
    alias da_igSetNextWindowSize            = void function(const ImVec2 size, ImGuiCond cond = 0);
    alias da_igSetNextWindowSizeConstraints = void function(const ImVec2 size_min, const ImVec2 size_max, ImGuiSizeConstraintCallback custom_callback = null, void* custom_callback_data = null);
    alias da_igSetNextWindowContentSize     = void function(const ImVec2 size);
    alias da_igSetNextWindowCollapsed       = void function(bool collapsed, ImGuiCond cond = 0);
    alias da_igSetNextWindowFocus           = void function();
    alias da_igSetWindowPos                 = void function(const ImVec2 pos, ImGuiCond cond = 0);
    alias da_igSetWindowSize                = void function(const ImVec2 size, ImGuiCond cond = 0);
    alias da_igSetWindowCollapsed           = void function(bool collapsed, ImGuiCond cond = 0);
    alias da_igSetWindowFocus               = void function();
    alias da_igSetWindowPosByName           = void function(const char* name, const ImVec2 pos, ImGuiCond cond = 0);
    alias da_igSetWindowSize2               = void function(const char* name, const ImVec2 size, ImGuiCond cond = 0);
    alias da_igSetWindowCollapsed2          = void function(const char* name, bool collapsed, ImGuiCond cond = 0);
    alias da_igSetWindowFocus2              = void function(const char* name);

    alias da_igGetScrollX                   = float function();
    alias da_igGetScrollY                   = float function();
    alias da_igGetScrollMaxX                = float function();
    alias da_igGetScrollMaxY                = float function();
    alias da_igSetScrollX                   = void function(float scroll_x);
    alias da_igSetScrollY                   = void function(float scroll_y);
    alias da_igSetScrollHere                = void function(float center_y_ratio = 0.5f);
    alias da_igSetScrollFromPosY            = void function(float pos_y, float center_y_ratio = 0.5f);
    alias da_igSetKeyboardFocusHere         = void function(int offset = 0);
    alias da_igSetStateStorage              = void function(ImGuiStorage* tree);
    alias da_igGetStateStorage              = ImGuiStorage* function();

    alias da_igPushFont                     = void function(ImFont* font);
    alias da_igPopFont                      = void function();
    alias da_igPushStyleColorU32            = void function(ImGuiCol idx, ImU32 col);
    alias da_igPushStyleColor               = void function(ImGuiCol idx, const ImVec4 col);
    alias da_igPopStyleColor                = void function(int count = 1);
    alias da_igPushStyleVar                 = void function(ImGuiStyleVar idx, float val);
    alias da_igPushStyleVarVec              = void function(ImGuiStyleVar idx, const ImVec2 val);
    alias da_igPopStyleVar                  = void function(int count = 1);
    alias da_igGetStyleColorVec4            = void function(ImVec4* pout, ImGuiCol idx);
    alias da_igGetFont                      = ImFont* function();
    alias da_igGetFontSize                  = float function();
    alias da_igGetFontTexUvWhitePixel       = void function(ImVec2* pOut);
    alias da_igGetColorU32                  = ImU32 function(ImGuiCol idx, float alpha_mul = 1.0f);
    alias da_igGetColorU32Vec               = ImU32 function(const ImVec4* col);
    alias da_igGetColorU32U32               = ImU32 function(ImU32 col);

    alias da_igPushItemWidth                = void function(float item_width);
    alias da_igPopItemWidth                 = void function();
    alias da_igCalcItemWidth                = float function();
    alias da_igPushTextWrapPos              = void function(float wrap_pos_x = 0.0f);
    alias da_igPopTextWrapPos               = void function();
    alias da_igPushAllowKeyboardFocus       = void function(bool v);
    alias da_igPopAllowKeyboardFocus        = void function();
    alias da_igPushButtonRepeat             = void function(bool repeat);
    alias da_igPopButtonRepeat              = void function();

    alias da_igSeparator                    = void function();
    alias da_igSameLine                     = void function(float pos_x = 0.0f, float spacing_w = -1.0f);
    alias da_igNewLine                      = void function();
    alias da_igSpacing                      = void function();
    alias da_igDummy                        = void function(const ImVec2* size);
    alias da_igIndent                       = void function(float indent_w = 0.0f);
    alias da_igUnindent                     = void function(float indent_w = 0.0f);
    alias da_igBeginGroup                   = void function();
    alias da_igEndGroup                     = void function();
    alias da_igGetCursorPos                 = void function(ImVec2* pOut);
    alias da_igGetCursorPosX                = float function();
    alias da_igGetCursorPosY                = float function();
    alias da_igSetCursorPos                 = void function(const ImVec2 locl_pos);
    alias da_igSetCursorPosX                = void function(float x);
    alias da_igSetCursorPosY                = void function(float y);
    alias da_igGetCursorStartPos            = void function(ImVec2* pOut);
    alias da_igGetCursorScreenPos           = void function(ImVec2* pOut);
    alias da_igSetCursorScreenPos           = void function(const ImVec2 pos);
    alias da_igAlignTextToFramePadding      = void function();
    alias da_igGetTextLineHeight            = float function();
    alias da_igGetTextLineHeightWithSpacing = float function();
    alias da_igGetFrameHeightWithSpacing    = float function();

    alias da_igColumns                      = void function(int count = 1, const char* id = null, bool border = true);
    alias da_igNextColumn                   = void function();
    alias da_igGetColumnIndex               = int function();
    alias da_igGetColumnWidth               = float function(int column_index = -1);
    alias da_igSetColumnWidth               = void function(int column_index, float width);
    alias da_igGetColumnOffset              = float function(int column_index = -1);
    alias da_igSetColumnOffset              = void function(int column_index, float offset_x);
    alias da_igGetColumnsCount              = int function();

    alias da_igPushIDStr                    = void function(const char* str_id);
    alias da_igPushIDStrRange               = void function(const char* str_begin, const char* str_end);
    alias da_igPushIDPtr                    = void function(const void* ptr_id);
    alias da_igPushIDInt                    = void function(int int_id);
    alias da_igPopID                        = void function();
    alias da_igGetIDStr                     = ImGuiID  function(const char* str_id);
    alias da_igGetIDStrRange                = ImGuiID  function(const char* str_begin, const char* str_end);
    alias da_igGetIDPtr                     = ImGuiID  function(const void* ptr_id);

    alias da_igText                         = void function(const char* fmt, ...);
    alias da_igTextV                        = void function(const char* fmt, va_list args);
    alias da_igTextColored                  = void function(const ImVec4 col, const char* fmt, ...);
    alias da_igTextColoredV                 = void function(const ImVec4 col, const char* fmt, va_list args);
    alias da_igTextDisabled                 = void function(const char* fmt, ...);
    alias da_igTextDisabledV                = void function(const char* fmt, va_list args);
    alias da_igTextWrapped                  = void function(const char* fmt, ...);
    alias da_igTextWrappedV                 = void function(const char* fmt, va_list args);
    alias da_igTextUnformatted              = void function(const char* text, const char* text_end = null);
    alias da_igLabelText                    = void function(const char* label, const char* fmt, ...);
    alias da_igLabelTextV                   = void function(const char* label, const char* fmt, va_list args);
    alias da_igBullet                       = void function();
    alias da_igBulletText                   = void function(const char* fmt, ...);
    alias da_igBulletTextV                  = void function(const char* fmt, va_list args);
    alias da_igButton                       = bool function(const char* label, const ImVec2 size = ImVec2(0, 0));
    alias da_igSmallButton                  = bool function(const char* label);
    alias da_igInvisibleButton              = bool function(const char* str_id, const ImVec2 size);
    alias da_igImage                        = void function(ImTextureID user_texture_id, const ImVec2 size, const ImVec2 uv0 = ImVec2(0, 0), const ImVec2 uv1 = ImVec2(1, 1), const ImVec4 tint_col = ImVec4(1, 1, 1, 1), const ImVec4 border_col = ImVec4(0, 0, 0, 0));
    alias da_igImageButton                  = bool function(ImTextureID user_texture_id, const ImVec2 size, const ImVec2 uv0 = ImVec2(0, 0), const ImVec2 uv1 = ImVec2(1, 1), int frame_padding = -1, const ImVec4 bg_col = ImVec4(0, 0, 0, 0), const ImVec4 tint_col = ImVec4(1, 1, 1, 1));
    alias da_igCheckbox                     = bool function(const char* label, bool* v);
    alias da_igCheckboxFlags                = bool function(const char* label, uint* flags, uint flags_value);
    alias da_igRadioButtonBool              = bool function(const char* label, bool active);
    alias da_igRadioButton                  = bool function(const char* label, int* v, int v_button);
    alias da_igCombo                        = bool function(const char* label, int* current_item, const char** items, int items_count, int height_in_items = -1);
    alias da_igCombo2                       = bool function(const char* label, int* current_item, const char* items_separated_by_zeros, int height_in_items = -1);
    alias da_igCombo3                       = bool function(const char* label, int* current_item, bool function(void* data, int idx, const(char)** out_text) items_getter, void* data, int items_count, int height_in_items = -1);
    alias da_igPlotLines                    = void function(const char* label, const float* values, int values_count, int values_offset = 0, const char* overlay_text = null, float scale_min = float.max, float scale_max = float.max, ImVec2 graph_size = ImVec2(0, 0), size_t stride = float.sizeof);
    alias da_igPlotLines2                   = void function(const char* label, float function(void* data, int idx) values_getter, void* data, int values_count, int values_offset = 0, const char* overlay_text = null, float scale_min = float.max, float scale_max = float.max, ImVec2 graph_size = ImVec2(0, 0));
    alias da_igPlotHistogram                = void function(const char* label, const float* values, int values_count, int values_offset = 0, const char* overlay_text = null, float scale_min = float.max, float scale_max = float.max, ImVec2 graph_size = ImVec2(0, 0), size_t stride = float.sizeof);
    alias da_igPlotHistogram2               = void function(const char* label, float function(void* data, int idx) values_getter, void* data, int values_count, int values_offset = 0, const char* overlay_text = null, float scale_min = float.max, float scale_max = float.max, ImVec2 graph_size = ImVec2(0, 0));
    alias da_igProgressBar                  = void function(float fraction, const ImVec2* size_arg /+= ImVec2(-1,0)+/, const(char)* overlay = null);

    alias da_igDragFloat                    = bool function(const char* label, float* v, float v_speed = 1.0f, float v_min = 0.0f, float v_max = 0.0f, const char* display_format = "%.3f", float power = 1.0f);     // If v_max >= v_max we have no bound
    alias da_igDragFloat2                   = bool function(const char* label, ref float[2] v, float v_speed = 1.0f, float v_min = 0.0f, float v_max = 0.0f, const char* display_format = "%.3f", float power = 1.0f);
    alias da_igDragFloat3                   = bool function(const char* label, ref float[3] v, float v_speed = 1.0f, float v_min = 0.0f, float v_max = 0.0f, const char* display_format = "%.3f", float power = 1.0f);
    alias da_igDragFloat4                   = bool function(const char* label, ref float[4] v, float v_speed = 1.0f, float v_min = 0.0f, float v_max = 0.0f, const char* display_format = "%.3f", float power = 1.0f);
    alias da_igDragFloatRange2              = bool function(const char* label, float* v_current_min, float* v_current_max, float v_speed = 1.0f, float v_min = 0.0f, float v_max = 0.0f, const char* display_format = "%.3f", const char* display_format_max = null, float power = 1.0f);
    alias da_igDragInt                      = bool function(const char* label, int* v, float v_speed = 1.0f, int v_min = 0, int v_max = 0, const char* display_format = "%.3f");                                       // If v_max >= v_max we have no bound
    alias da_igDragInt2                     = bool function(const char* label, ref int[2] v, float v_speed = 1.0f, int v_min = 0, int v_max = 0, const char* display_format = "%.3f");
    alias da_igDragInt3                     = bool function(const char* label, ref int[3] v, float v_speed = 1.0f, int v_min = 0, int v_max = 0, const char* display_format = "%.3f");
    alias da_igDragInt4                     = bool function(const char* label, ref int[4] v, float v_speed = 1.0f, int v_min = 0, int v_max = 0, const char* display_format = "%.3f");
    alias da_igDragIntRange2                = bool function(const char* label, int* v_current_min, int* v_current_max, float v_speed = 1.0f, int v_min = 0, int v_max = 0, const char* display_format = "%.0f", const char* display_format_max = null);

    alias da_igInputText                    = bool function(const char* label, char* buf, size_t buf_size, ImGuiInputTextFlags flags = 0, ImGuiTextEditCallback callback = null, void* user_data = null);
    alias da_igInputTextMultiline           = bool function(const char* label, char* buf, size_t buf_size, const ImVec2 size = ImVec2(0,0), ImGuiInputTextFlags flags = 0, ImGuiTextEditCallback callback = null, void* user_data = null);
    alias da_igInputFloat                   = bool function(const char* label, float* v, float step = 0.0f, float step_fast = 0.0f, int decimal_precision = -1, ImGuiInputTextFlags extra_flags = 0);
    alias da_igInputFloat2                  = bool function(const char* label, ref float[2] v, int decimal_precision = -1, ImGuiInputTextFlags extra_flags = 0);
    alias da_igInputFloat3                  = bool function(const char* label, ref float[3] v, int decimal_precision = -1, ImGuiInputTextFlags extra_flags = 0);
    alias da_igInputFloat4                  = bool function(const char* label, ref float[4] v, int decimal_precision = -1, ImGuiInputTextFlags extra_flags = 0);
    alias da_igInputInt                     = bool function(const char* label, int* v, int step = 1, int step_fast = 100, ImGuiInputTextFlags extra_flags = 0);
    alias da_igInputInt2                    = bool function(const char* label, ref int[2] v, ImGuiInputTextFlags extra_flags = 0);
    alias da_igInputInt3                    = bool function(const char* label, ref int[3] v, ImGuiInputTextFlags extra_flags = 0);
    alias da_igInputInt4                    = bool function(const char* label, ref int[4] v, ImGuiInputTextFlags extra_flags = 0);

    alias da_igSliderFloat                  = bool function(const char* label, float* v, float v_min, float v_max, const char* display_format = "%.3f", float power = 1.0f);
    alias da_igSliderFloat2                 = bool function(const char* label, ref float[2] v, float v_min, float v_max, const char* display_format = "%.3f", float power = 1.0f);
    alias da_igSliderFloat3                 = bool function(const char* label, ref float[3] v, float v_min, float v_max, const char* display_format = "%.3f", float power = 1.0f);
    alias da_igSliderFloat4                 = bool function(const char* label, ref float[4] v, float v_min, float v_max, const char* display_format = "%.3f", float power = 1.0f);
    alias da_igSliderAngle                  = bool function(const char* label, float* v_rad, float v_degrees_min = -360.0f, float v_degrees_max = +360.0f);
    alias da_igSliderInt                    = bool function(const char* label, int* v, int v_min, int v_max, const char* display_format = "%.0f");
    alias da_igSliderInt2                   = bool function(const char* label, ref int[2] v, int v_min, int v_max, const char* display_format = "%.0f");
    alias da_igSliderInt3                   = bool function(const char* label, ref int[3] v, int v_min, int v_max, const char* display_format = "%.0f");
    alias da_igSliderInt4                   = bool function(const char* label, ref int[4] v, int v_min, int v_max, const char* display_format = "%.0f");
    alias da_igVSliderFloat                 = bool function(const char* label, const ImVec2 size, float* v, float v_min, float v_max, const char* display_format = "%.3f", float power = 1.0f);
    alias da_igVSliderInt                   = bool function(const char* label, const ImVec2 size, int* v, int v_min, int v_max, const char* display_format = "%.0f");

    alias da_igColorEdit3                   = bool function(const char* label, ref float[3] col, ImGuiColorEditFlags flags = 0);
    alias da_igColorEdit4                   = bool function(const char* label, ref float[4] col, ImGuiColorEditFlags flags = 0);
    alias da_igColorPicker3                 = bool function(const char* label, ref float[3] col, ImGuiColorEditFlags flags = 0);
    alias da_igColorPicker4                 = bool function(const char* label, ref float[4] col, ImGuiColorEditFlags flags = 0, const float* ref_col = null);
    alias da_igColorButton                  = bool function(const char* desc_id, const ImVec4 col, ImGuiColorEditFlags flags = 0, ImVec2 size = ImVec2(0,0));  // display a colored square/button, hover for details, return true when pressed.
    alias da_igSetColorEditOptions          = void function(ImGuiColorEditFlags flags);

    alias da_igTreeNode                     = bool function(const char* str_label_id);
    alias da_igTreeNodeStr                  = bool function(const char* str_id, const char* fmt, ...);
    alias da_igTreeNodePtr                  = bool function(const void* ptr_id, const char* fmt, ...);
    alias da_igTreeNodeStrV                 = bool function(const char* str_id, const char* fmt, va_list args);
    alias da_igTreeNodePtrV                 = bool function(const void* ptr_id, const char* fmt, va_list args);
    alias da_igTreeNodeEx                   = bool function(const char* label, ImGuiTreeNodeFlags flags);
    alias da_igTreeNodeExStr                = bool function(const char* str_id, ImGuiTreeNodeFlags flags, const char* fmt, ...);
    alias da_igTreeNodeExPtr                = bool function(const void* ptr_id, ImGuiTreeNodeFlags flags, const char* fmt, ...);
    alias da_igTreeNodeExV                  = bool function(const char* str_id, ImGuiTreeNodeFlags flags, const char* fmt, va_list args);
    alias da_igTreeNodeExVPtr               = bool function(const void* ptr_id, ImGuiTreeNodeFlags flags, const char* fmt, va_list args);
    alias da_igTreePushStr                  = void function(const char* str_id = null);
    alias da_igTreePushPtr                  = void function(const void* ptr_id = null);
    alias da_igTreePop                      = void function();
    alias da_igTreeAdvanceToLabelPos        = void function();
    alias da_igGetTreeNodeToLabelSpacing    = float function();
    alias da_igSetNextTreeNodeOpen          = void function(bool opened, ImGuiCond cond = 0);
    alias da_igCollapsingHeader             = bool function(const char* label, ImGuiTreeNodeFlags flags = 0);
    alias da_igCollapsingHeaderEx           = bool function(const char* label, bool* p_open, ImGuiTreeNodeFlags flags = 0);

    alias da_igSelectable                   = bool function(const char* label, bool selected = false, ImGuiSelectableFlags flags = 0, const ImVec2 size = ImVec2(0, 0));
    alias da_igSelectableEx                 = bool function(const char* label, bool* p_selected, ImGuiSelectableFlags flags = 0, const ImVec2 size = ImVec2(0, 0));
    alias da_igListBox                      = bool function(const char* label, int* current_item, const char** items, int items_count, int height_in_items = -1);
    alias da_igListBox2                     = bool function(const char* label, int* current_item, bool function(void* data, int idx, const char** out_text) items_getter, void* data, int items_count, int height_in_items = -1);
    alias da_igListBoxHeader                = bool function(const char* label, const ImVec2 size = ImVec2(0, 0));
    alias da_igListBoxHeader2               = bool function(const char* label, int items_count, int height_in_items = -1);
    alias da_igListBoxFooter                = void function();

    alias da_igValueBool                    = void function(const char* prefix, bool b);
    alias da_igValueInt                     = void function(const char* prefix, int v);
    alias da_igValueUInt                    = void function(const char* prefix, uint v);
    alias da_igValueFloat                   = void function(const char* prefix, float v, const char* float_format = null);

    alias da_igSetTooltip                   = void function(const(char)* fmt, ...);
    alias da_igSetTooltipV                  = void function(const(char)* fmt, va_list args);
    alias da_igBeginTooltip                 = void function();
    alias da_igEndTooltip                   = void function();

    // Widgets: Menus
    alias da_igBeginMainMenuBar             = bool function();
    alias da_igEndMainMenuBar               = void function();
    alias da_igBeginMenuBar                 = bool function();
    alias da_igEndMenuBar                   = void function();
    alias da_igBeginMenu                    = bool function(const(char)* label, bool enabled = true);
    alias da_igEndMenu                      = void function();
    alias da_igMenuItem                     = bool function(const(char)* label, const(char)* shortcut = null, bool selected = false, bool enabled = true);
    alias da_igMenuItemPtr                  = bool function(const(char)* label, const(char)* shortcut, bool* p_selected, bool enabled = true);

    alias da_igOpenPopup                    = void function(const(char)* str_id);
    alias da_igBeginPopup                   = bool function(const(char)* str_id);
    alias da_igBeginPopupModal              = bool function(const(char)* name, bool* p_opened = null, ImGuiWindowFlags extra_flags = 0);
    alias da_igBeginPopupContextItem        = bool function(const(char)* str_id, int mouse_button = 1);
    alias da_igBeginPopupContextWindow      = bool function(const(char)* str_id = null, int mouse_button = 1, bool also_over_items = true);
    alias da_igBeginPopupContextVoid        = bool function(const(char)* str_id = null, int mouse_button = 1);
    alias da_igEndPopup                     = void function();
    alias da_igIsPopupOpen                  = bool function(const(char)* str_id);
    alias da_igCloseCurrentPopup            = void function();

    alias da_igLogToTTY                     = void function(int max_depth = -1);
    alias da_igLogToFile                    = void function(int max_depth = -1, const char* filename = null);
    alias da_igLogToClipboard               = void function(int max_depth = -1);
    alias da_igLogFinish                    = void function();
    alias da_igLogButtons                   = void function();
    alias da_igLogText                      = void function(const char* fmt, ...);

    alias da_igPushClipRect                 = void function(const ImVec2 clip_rect_min, const ImVec2 clip_rect_max, bool intersect_with_current_clip_rect);
    alias da_igPopClipRect                  = void function();

    alias da_igIsItemHovered                = bool function(ImGuiHoveredFlags flags = 0);
    alias da_igIsItemActive                 = bool function();
    alias da_igIsItemClicked                = bool function(int mouse_button = 0);
    alias da_igIsItemVisible                = bool function();
    alias da_igIsAnyItemHovered             = bool function();
    alias da_igIsAnyItemActive              = bool function();
    alias da_igGetItemRectMin               = void function(ImVec2* pOut);
    alias da_igGetItemRectMax               = void function(ImVec2* pOut);
    alias da_igGetItemRectSize              = void function(ImVec2* pOut);
    alias da_igSetItemAllowOverlap          = void function();
    alias da_igIsWindowFocused              = bool function(ImGuiFocusedFlags flags = 0);
    alias da_igIsWindowHovered              = bool function(ImGuiHoveredFlags flags = 0);
    alias da_igIsAnyWindowHovered           = bool function();
    alias da_igIsRectVisible                = bool function(const ImVec2 item_size);
    alias da_igIsRectVisible2               = bool function(const ImVec2 rect_min, const ImVec2 rect_max);

    alias da_igGetTime                      = float function();
    alias da_igGetFrameCount                = int function();
    alias da_igGetStyleColorName            = const(char)* function(ImGuiCol idx);
    alias da_igCalcItemRectClosestPoint     = void function(ImVec2* pOut, const ImVec2 pos, bool on_edge = false, float outward = +0.0f);
    alias da_igCalcTextSize                 = void function(ImVec2* pOut, const char* text, const char* text_end = null, bool hide_text_after_double_hash = false, float wrap_width = -1.0f);
    alias da_igCalcListClipping             = void function(int items_count, float items_height, int* out_items_display_start, int* out_items_display_end);

    alias da_igBeginChildFrame              = bool function(ImGuiID id, const ImVec2 size, ImGuiWindowFlags extra_flags = 0);
    alias da_igEndChildFrame                = void function();

    alias da_igColorConvertU32ToFloat4      = void function(ImVec4* pOut, ImU32 in_);
    alias da_igColorConvertFloat4ToU32      = ImU32 function(const ImVec4 in_);
    alias da_igColorConvertRGBtoHSV         = void function(float r, float g, float b, float* out_h, float* out_s, float* out_v);
    alias da_igColorConvertHSVtoRGB         = void function(float h, float s, float v, float* out_r, float* out_g, float* out_b);

    alias da_igGetKeyIndex                  = int  function(ImGuiKey imgui_key);
    alias da_igIsKeyDown                    = bool function(int user_key_index);
    alias da_igIsKeyPressed                 = bool function(int user_key_index, bool repeat = true);
    alias da_igIsKeyReleased                = bool function(int user_key_index);
    alias da_igIsMouseDown                  = bool function(int button);
    alias da_igIsMouseClicked               = bool function(int button, bool repeat = false);
    alias da_igIsMouseDoubleClicked         = bool function(int button);
    alias da_igIsMouseReleased              = bool function(int button);
    alias da_igIsMouseDragging              = bool function(int button = 0, float lock_threshold = -1.0f);
    alias da_igIsMouseHoveringRect          = bool function(const ImVec2 r_min, const ImVec2 r_max, bool clip = true);
    alias da_igIsMousePosValid              = bool function(const ImVec2* mouse_pos = null);
    alias da_igGetMousePos                  = void function(ImVec2* pOut);
    alias da_igGetMousePosOnOpeningCurrentPopup = void function(ImVec2* pOut);
    alias da_igGetMouseDragDelta            = void function(ImVec2* pOut, int button = 0, float lock_threshold = -1.0f);
    alias da_igResetMouseDragDelta          = void function(int button = 0);
    alias da_igGetMouseCursor               = ImGuiMouseCursor function();
    alias da_igSetMouseCursor               = void function(ImGuiMouseCursor type);
    alias da_igCaptureKeyboardFromApp       = void function(bool capture = true);
    alias da_igCaptureMouseFromApp          = void function(bool capture = true);

    alias da_igMemAlloc                     = void* function(size_t sz);
    alias da_igMemFree                      = void function(void* ptr);
    alias da_igGetClipboardText             = const(char)* function();
    alias da_igSetClipboardText             = void function(const(char)* text);

    alias da_igGetVersion                   = const(char)* function();
    alias da_igCreateContext                = ImGuiContext* function(void* function(size_t) malloc_fn = null, void function(void*) free_fn = null);
    alias da_igDestroyContext               = void function(ImGuiContext* ctx);
    alias da_igGetCurrentContext            = ImGuiContext* function();
    alias da_igSetCurrentContext            = void function(ImGuiContext* ctx);
}

extern(C) @nogc nothrow
{
    // ImGuiIO
    alias da_ImGuiIO_AddInputCharacter      = void function(ushort c);
    alias da_ImGuiIO_AddInputCharactersUTF8 = void function(const(char*) utf8_chars);
    alias da_ImGuiIO_ClearInputCharacters   = void function();

    // ImGuiTextFilter
    alias da_ImGuiTextFilter_Create         = ImGuiTextFilter* function(const char* default_filter = "");
    alias da_ImGuiTextFilter_Destroy        = void function(ImGuiTextFilter* filter);
    alias da_ImGuiTextFilter_Clear          = void function(ImGuiTextFilter* filter);
    alias da_ImGuiTextFilter_Draw           = bool function(ImGuiTextFilter* filter, const char* label = "Filter (inc,-exc)", float width = 0.0f);
    alias da_ImGuiTextFilter_PassFilter     = bool function(const(ImGuiTextFilter)* filter, const char* text, const char* text_end = null);
    alias da_ImGuiTextFilter_IsActive       = bool function(const(ImGuiTextFilter)* filter);
    alias da_ImGuiTextFilter_Build          = void function(ImGuiTextFilter* filter);
    alias da_ImGuiTextFilter_GetInputBuf    = const(char)* function(ImGuiTextFilter* filter);

    // ImGuiTextBuffer
    alias da_ImGuiTextBuffer_Create         = ImGuiTextBuffer* function();
    alias da_ImGuiTextBuffer_Destroy        = void function(ImGuiTextBuffer* buffer);
    alias da_ImGuiTextBuffer_index          = char function(ImGuiTextBuffer* buffer, int i);
    alias da_ImGuiTextBuffer_begin          = const char* function(const(ImGuiTextBuffer)* buffer);
    alias da_ImGuiTextBuffer_end            = const char* function(const(ImGuiTextBuffer)* buffer);
    alias da_ImGuiTextBuffer_size           = int function(const(ImGuiTextBuffer)* buffer);
    alias da_ImGuiTextBuffer_empty          = bool function(ImGuiTextBuffer* buffer);
    alias da_ImGuiTextBuffer_clear          = void function(ImGuiTextBuffer* buffer);
    alias da_ImGuiTextBuffer_c_str          = const char* function(const(ImGuiTextBuffer)* buffer);
    alias da_ImGuiTextBuffer_appendf         = void function(ImGuiTextBuffer* buffer, const(char)* fmt, ...);
    alias da_ImGuiTextBuffer_appendfv        = void  function(ImGuiTextBuffer* buffer, const(char)* fmt, va_list args);

    // ImGuiStorage
    alias da_ImGuiStorage_Create = ImGuiStorage* function();
    alias da_ImGuiStorage_Destroy = void function(ImGuiStorage* storage);
    alias da_ImGuiStorage_Clear = void function(ImGuiStorage* storage);
    alias da_ImGuiStorage_GetInt = int function(ImGuiStorage* storage, ImGuiID key, int default_val);
    alias da_ImGuiStorage_SetInt = void function(ImGuiStorage* storage, ImGuiID key, int val);
    alias da_ImGuiStorage_GetBool = bool function(ImGuiStorage* storage, ImGuiID key, bool default_val);
    alias da_ImGuiStorage_SetBool = void function(ImGuiStorage* storage, ImGuiID key, bool val);
    alias da_ImGuiStorage_GetFloat = float function(ImGuiStorage* storage, ImGuiID key, float default_val);
    alias da_ImGuiStorage_SetFloat = void function(ImGuiStorage* storage, ImGuiID key, float val);
    alias da_ImGuiStorage_GetVoidPtr = void* function(ImGuiStorage* storage, ImGuiID key);
    alias da_ImGuiStorage_SetVoidPtr = void function(ImGuiStorage* storage, ImGuiID key, void* val);
    alias da_ImGuiStorage_GetIntRef = int* function(ImGuiStorage* storage, ImGuiID key, int default_val);
    alias da_ImGuiStorage_GetBoolRef = bool* function(ImGuiStorage* storage, ImGuiID key, bool default_val);
    alias da_ImGuiStorage_GetFloatRef = float* function(ImGuiStorage* storage, ImGuiID key, float default_val);
    alias da_ImGuiStorage_GetVoidPtrRef = void** function(ImGuiStorage* storage, ImGuiID key, void* default_val);
    alias da_ImGuiStorage_SetAllInt = void function(ImGuiStorage* storage, int val);

    // ImGuiTextEditCallbackData
    alias da_ImGuiTextEditCallbackData_DeleteChars = void function(ImGuiTextEditCallbackData* data, int pos, int bytes_count);
    alias da_ImGuiTextEditCallbackData_InsertChars = void function(ImGuiTextEditCallbackData* data, int pos, const char* text, const char* text_end = null);
    alias da_ImGuiTextEditCallbackData_HasSelection = bool function(ImGuiTextEditCallbackData* data);

    // ImGuiListClipper
    alias da_ImGuiListClipper_Begin         = void function(ImGuiListClipper* clipper, int items_count, float items_height = -1.0f);
    alias da_ImGuiListClipper_End           = void function(ImGuiListClipper* clipper);
    alias da_ImGuiListClipper_Step          = bool function(ImGuiListClipper* clipper);
    alias da_ImGuiListClipper_GetDisplayStart = int function(ImGuiListClipper* clipper);
    alias da_ImGuiListClipper_GetDisplayEnd = int function(ImGuiListClipper* clipper);

    // ImDrawList
    alias da_ImDrawList_GetVertexBufferSize = int function(ImDrawList* list);
    alias da_ImDrawList_GetVertexPtr = ImDrawVert* function(ImDrawList* list, int n);
    alias da_ImDrawList_GetIndexBufferSize  = int function(ImDrawList* list);
    alias da_ImDrawList_GetIndexPtr         = ImDrawIdx* function(ImDrawList* list, int n);
    alias da_ImDrawList_GetCmdSize          = int function(ImDrawList* list);
    alias da_ImDrawList_GetCmdPtr           = ImDrawCmd* function(ImDrawList* list, int n);
    alias da_ImDrawList_Clear               = void function(ImDrawList* list);
    alias da_ImDrawList_ClearFreeMemory     = void function(ImDrawList* list);
    alias da_ImDrawList_PushClipRect        = void function(ImDrawList* list, ImVec2 clip_rect_min, ImVec2 clip_rect_max, bool intersect_with_current_clip_rect = false);
    alias da_ImDrawList_PushClipRectFullScreen = void function(ImDrawList* list);
    alias da_ImDrawList_PopClipRect         = void function(ImDrawList* list);
    alias da_ImDrawList_PushTextureID       = void function(ImDrawList* list, const ImTextureID texture_id);
    alias da_ImDrawList_PopTextureID        = void function(ImDrawList* list);
    alias da_ImDrawList_GetClipRectMin      = void function(ImVec2 *pOut, ImDrawList* list);
    alias da_ImDrawList_GetClipRectMax      = void function(ImVec2 *pOut, ImDrawList* list);
    alias da_ImDrawList_AddLine             = void function(ImDrawList* list, const ImVec2 a, const ImVec2 b, ImU32 col, float thickness = 1.0f);
    alias da_ImDrawList_AddRect             = void function(ImDrawList* list, const ImVec2 a, const ImVec2 b, ImU32 col, float rounding = 0.0f, int rounding_corners_flags = 0x0F, float thickness = 1.0f);
    alias da_ImDrawList_AddRectFilled       = void function(ImDrawList* list, const ImVec2 a, const ImVec2 b, ImU32 col, float rounding = 0.0f, int rounding_corners_flags = 0x0F);
    alias da_ImDrawList_AddRectFilledMultiColor = void function(ImDrawList* list, const ImVec2 a, const ImVec2 b, ImU32 col_upr_left, ImU32 col_upr_right, ImU32 col_bot_right, ImU32 col_bot_left);
    alias da_ImDrawList_AddQuad             = void function(ImDrawList* list, const ImVec2 a, const ImVec2 b, const ImVec2 c, const ImVec2 d, ImU32 col, float thickness = 1.0f);
    alias da_ImDrawList_AddQuadFilled       = void function(ImDrawList* list, const ImVec2 a, const ImVec2 b, const ImVec2 c, const ImVec2 d, ImU32 col);
    alias da_ImDrawList_AddTriangle         = void function(ImDrawList* list, const ImVec2 a, const ImVec2 b, const ImVec2 c, ImU32 col, float thickness = 1.0f);
    alias da_ImDrawList_AddTriangleFilled   = void function(ImDrawList* list, const ImVec2 a, const ImVec2 b, const ImVec2 c, ImU32 col);
    alias da_ImDrawList_AddCircle           = void function(ImDrawList* list, const ImVec2 centre, float radius, ImU32 col, int num_segments = 12, float thickness = 1.0f);
    alias da_ImDrawList_AddCircleFilled     = void function(ImDrawList* list, const ImVec2 centre, float radius, ImU32 col, int num_segments = 12);
    alias da_ImDrawList_AddText             = void function(ImDrawList* list, const ImVec2 pos, ImU32 col, const char* text_begin, const char* text_end = null);
    alias da_ImDrawList_AddTextExt          = void function(ImDrawList* list, const ImFont* font, float font_size, const ImVec2 pos, ImU32 col, const char* text_begin, const char* text_end = null, float wrap_width = 0.0f, const ImVec4* cpu_fine_clip_rect = null);
    alias da_ImDrawList_AddImage            = void function(ImDrawList* list, ImTextureID user_texture_id, const ImVec2 a, const ImVec2 b, const ImVec2 uv_a = ImVec2(0,0), const ImVec2 uv_b = ImVec2(1,1), ImU32 col = 0xFFFFFFFF);
    alias da_ImDrawList_AddImageQuad        = void function(ImDrawList* list, ImTextureID user_texture_id, const ImVec2 a, const ImVec2 b, const ImVec2 c, const ImVec2 d, const ImVec2 uv_a = ImVec2(0,0), const ImVec2 uv_b = ImVec2(1,0), const ImVec2 uv_c = ImVec2(1,1), const ImVec2 uv_d = ImVec2(0,1), ImU32 col = 0xFFFFFFFF);
    alias da_ImDrawList_AddPolyline         = void function(ImDrawList* list, const ImVec2* points, const int num_points, ImU32 col, bool closed, float thickness);
    alias da_ImDrawList_AddConvexPolyFilled = void function(ImDrawList* list, const ImVec2* points, const int num_points, ImU32 col, bool anti_aliased);
    alias da_ImDrawList_AddBezierCurve      = void function(ImDrawList* list, const ImVec2 pos0, const ImVec2 cp0, const ImVec2 cp1, const ImVec2 pos1, ImU32 col, float thickness, int num_segments = 0);
    alias da_ImDrawList_PathClear           = void function(ImDrawList* list);
    alias da_ImDrawList_PathLineTo          = void function(ImDrawList* list, const ImVec2 pos);
    alias da_ImDrawList_PathLineToMergeDuplicate = void function(ImDrawList* list, const ImVec2 pos);
    alias da_ImDrawList_PathFillConvex      = void function(ImDrawList* list, ImU32 col);
    alias da_ImDrawList_PathStroke          = void function(ImDrawList* list, ImU32 col, bool closed, float thickness = 1.0f);
    alias da_ImDrawList_PathArcTo           = void function(ImDrawList* list, const ImVec2 centre, float radius, float a_min, float a_max, int num_segments = 10);
    alias da_ImDrawList_PathArcToFast       = void function(ImDrawList* list, const ImVec2 centre, float radius, int a_min_of_12, int a_max_of_12);
    alias da_ImDrawList_PathBezierCurveTo   = void function(ImDrawList* list, const ImVec2 p1, const ImVec2 p2, const ImVec2 p3, int num_segments = 0);
    alias da_ImDrawList_PathRect            = void function(ImDrawList* list, const ImVec2 rect_min, const ImVec2 rect_max, float rounding = 0.0f, int rounding_corners_flags = 0x0F);
    alias da_ImDrawList_ChannelsSplit       = void function(ImDrawList* list, int channels_count);
    alias da_ImDrawList_ChannelsMerge       = void function(ImDrawList* list);
    alias da_ImDrawList_ChannelsSetCurrent  = void function(ImDrawList* list, int channel_index);
    alias da_ImDrawList_AddCallback         = void function(ImDrawList* list, ImDrawCallback callback, void* callback_data);
    alias da_ImDrawList_AddDrawCmd          = void function(ImDrawList* list);
    alias da_ImDrawList_PrimReserve         = void function(ImDrawList* list, int idx_count, int vtx_count);
    alias da_ImDrawList_PrimRect            = void function(ImDrawList* list, const ImVec2 a, const ImVec2 b, ImU32 col);
    alias da_ImDrawList_PrimRectUV          = void function(ImDrawList* list, const ImVec2 a, const ImVec2 b, const ImVec2 uv_a, const ImVec2 uv_b, ImU32 col);
    alias da_ImDrawList_PrimQuadUV          = void function(ImDrawList* list, const ImVec2 a, const ImVec2 b, const ImVec2 c, const ImVec2 d, const ImVec2 uv_a, const ImVec2 uv_b, const ImVec2 uv_c, const ImVec2 uv_d, ImU32 col);
    alias da_ImDrawList_PrimVtx             = void function(ImDrawList* list, const ImVec2 pos, const ImVec2 uv, ImU32 col);
    alias da_ImDrawList_PrimWriteVtx        = void function(ImDrawList* list, const ImVec2 pos, const ImVec2 uv, ImU32 col);
    alias da_ImDrawList_PrimWriteIdx        = void function(ImDrawList* list, ImDrawIdx idx);
    alias da_ImDrawList_UpdateClipRect      = void function(ImDrawList* list);
    alias da_ImDrawList_UpdateTextureID     = void function(ImDrawList* list);

    // ImDrawData
    alias da_ImDrawData_DeIndexAllBuffers   = void function(ImDrawData* drawData);
    alias da_ImDrawData_ScaleClipRects      = void function(ImDrawData* drawData, const ImVec2 sc);

    // ImFontAtlas
    alias da_ImFontAtlas_AddFont            = ImFont* function(ImFontAtlas* atlas, const ImFontConfig* font_cfg);
    alias da_ImFontAtlas_AddFontDefault     = ImFont* function(ImFontAtlas* atlas, const ImFontConfig* font_cfg = null);
    alias da_ImFontAtlas_AddFontFromFileTTF = ImFont* function(ImFontAtlas* atlas, const char* filename, float size_pixels, const ImFontConfig* font_cfg = null, const(ImWchar)* glyph_ranges = null);
    alias da_ImFontAtlas_AddFontFromMemoryTTF = ImFont* function(void* font_data, int font_size, float size_pixels, const ImFontConfig* font_cfg = null, const(ImWchar)* glyph_ranges = null);
    alias da_ImFontAtlas_AddFontFromMemoryCompressedTTF = ImFont* function(const void* compressed_font_data, int compressed_font_size, float size_pixels, const ImFontConfig* font_cfg = null, const(ImWchar)* glyph_ranges = null);
    alias da_ImFontAtlas_AddFontFromMemoryCompressedBase85TTF = ImFont* function(const char* compressed_font_data_base85, float size_pixels, const ImFontConfig* font_cfg = null, const(ImWchar)* glyph_ranges = null);
    alias da_ImFontAtlas_ClearTexData       = void function(ImFontAtlas* atlas);
    alias da_ImFontAtlas_ClearInputData     = void function(ImFontAtlas* atlas);
    alias da_ImFontAtlas_ClearFonts         = void function(ImFontAtlas* atlas);
    alias da_ImFontAtlas_Clear              = void function(ImFontAtlas* atlas);

    alias da_ImFontAtlas_GetTexDataAsAlpha8 = void function(ImFontAtlas* atlas,ubyte** out_pixels,int* out_width,int* out_height,int* out_bytes_per_pixel = null);
    alias da_ImFontAtlas_GetTexDataAsRGBA32 = void function(ImFontAtlas* atlas,ubyte** out_pixels,int* out_width,int* out_height,int* out_bytes_per_pixel = null);
    alias da_ImFontAtlas_SetTexID           = void function(ImFontAtlas* atlas, ImTextureID id);

    alias da_ImFontAtlas_GetGlyphRangesDefault = const(ImWchar)* function(ImFontAtlas* atlas);
    alias da_ImFontAtlas_GetGlyphRangesKorean = const(ImWchar)* function(ImFontAtlas* atlas);
    alias da_ImFontAtlas_GetGlyphRangesJapanese = const(ImWchar)* function(ImFontAtlas* atlas);
    alias da_ImFontAtlas_GetGlyphRangesChinese = const(ImWchar)* function(ImFontAtlas* atlas);
    alias da_ImFontAtlas_GetGlyphRangesCyrillic = const(ImWchar)* function(ImFontAtlas* atlas);
    alias da_ImFontAtlas_GetGlyphRangesThai = const(ImWchar)* function(ImFontAtlas* atlas);

    alias da_ImFontAtlas_GetTexID           = ImTextureID function(ImFontAtlas* atlas);
    alias da_ImFontAtlas_GetTexPixelsAlpha8 = ubyte* function(ImFontAtlas* atlas);
    alias da_ImFontAtlas_GetTexPixelsRGBA32 = uint* function(ImFontAtlas* atlas);
    alias da_ImFontAtlas_GetTexWidth        = int function(ImFontAtlas* atlas);
    alias da_ImFontAtlas_GetTexHeight       = int function(ImFontAtlas* atlas);
    alias da_ImFontAtlas_GetTexDesiredWidth = int function(ImFontAtlas* atlas);
    alias da_ImFontAtlas_SetTexDesiredWidth = void function(ImFontAtlas* atlas, int TexDesiredWidth_);
    alias da_ImFontAtlas_GetTexGlyphPadding = int function(ImFontAtlas* atlas);
    alias da_ImFontAtlas_SetTexGlyphPadding = void function(ImFontAtlas* atlas, int TexGlyphPadding_);
    alias da_ImFontAtlas_GetTexUvWhitePixel = void function(ImFontAtlas* atlas, ImVec2* pOut);

    // ImFontAtlas::Fonts;
    alias da_ImFontAtlas_Fonts_size         = int function(ImFontAtlas* atlas);
    alias da_ImFontAtlas_Fonts_index        = ImFont* function(ImFontAtlas* atlas, int index);

    // ImFont
    alias da_ImFont_GetFontSize             = float function(const ImFont* font);
    alias da_ImFont_SetFontSize             = void function(ImFont* font, float FontSize_);
    alias da_ImFont_GetScale                = float function(const ImFont* font);
    alias da_ImFont_SetScale                = void function(ImFont* font, float Scale_);
    alias da_ImFont_GetDisplayOffset        = void function(const ImFont* font, ImVec2* pOut);
    alias da_ImFont_GetFallbackGlyph        = const ImFont_Glyph* function(const ImFont* font);
    alias da_ImFont_SetFallbackGlyph        = void function(ImFont* font, const ImFont_Glyph* FallbackGlyph_);
    alias da_ImFont_GetFallbackAdvanceX     = float function(const ImFont* font);
    alias da_ImFont_GetFallbackChar         = ImWchar function(const ImFont* font);
    alias da_ImFont_GetConfigDataCount      = short function(const ImFont* font);
    alias da_ImFont_GetConfigData           = ImFontConfig* function(ImFont* font);
    alias da_ImFont_GetContainerAtlas       = ImFontAtlas* function(ImFont* font);
    alias da_ImFont_GetAscent               = float function(const ImFont* font);
    alias da_ImFont_GetDescent              = float function(const ImFont* font);
    alias da_ImFont_GetMetricsTotalSurface  = int function(const ImFont* font);

    alias da_ImFont_ClearOutputData         = void function(const ImFont* font);
    alias da_ImFont_BuildLookupTable        = void function(ImFont* font);
    alias da_ImFont_FindGlyph               = const ImFont_Glyph* function(const ImFont* font, ImWchar c);
    alias da_ImFont_SetFallbackChar         = void function(ImFont* font, ImWchar c);
    alias da_ImFont_GetCharAdvance          = float function(const ImFont* font, ImWchar c);
    alias da_ImFont_IsLoaded                = bool function(const ImFont* font);
    alias da_ImFont_CalcTextSizeA           = void function(const ImFont* font, ImVec2* pOut, float size, float max_width, float wrap_width, const char* text_begin, const char* text_end = null, const char** remaining = null); // utf8
    alias da_ImFont_CalcWordWrapPositionA   = const char* function(const ImFont* font, float scale, const char* text, const char* text_end, float wrap_width);
    alias da_ImFont_RenderChar              = void function(const ImFont* font, ImDrawList* draw_list, float size, ImVec2 pos, ImU32 col, ushort c);
    alias da_ImFont_RenderText              = void function(const ImFont* font, ImDrawList* draw_list, float size, ImVec2 pos, ImU32 col, const ImVec4* clip_rect, const char* text_begin, const char* text_end, float wrap_width = 0.0f, bool cpu_fine_clip = false);

    // ImFont::Glyphs
    alias da_ImFont_Glyphs_size             = int function(const ImFont* font);
    alias da_ImFont_Glyphs_index            = ImFont_Glyph* function(ImFont* font, int index);

    // ImFont::IndexXAdvance
    alias da_ImFont_IndexXAdvance_size      = int function(const ImFont* font);
    alias da_ImFont_IndexXAdvance_index     = float function(const ImFont* font, int index);

    // ImFont::IndexLookup
    alias da_ImFont_IndexLookup_size        = int function(const ImFont* font);
    alias da_ImFont_IndexLookup_index       = ushort function(const ImFont* font, int index);

}

__gshared
{
    da_igGetIO igGetIO;
    da_igGetStyle igGetStyle;
    da_igGetDrawData igGetDrawData;
    da_igNewFrame igNewFrame;
    da_igRender igRender;
    da_igShutdown igShutdown;
    da_igShowDemoWindow igShowDemoWindow;
    da_igShowMetricsWindow igShowMetricsWindow;
    da_igShowStyleEditor igShowStyleEditor;
    da_igShowStyleSelector igShowStyleSelector;
    da_igShowFontSelector igShowFontSelector;
    da_igShowUserGuide igShowUserGuide;

    // Window
    da_igBegin igBegin;
    da_igEnd igEnd;
    da_igBeginChild igBeginChild;
    da_igBeginChildEx igBeginChildEx;
    da_igEndChild igEndChild;
    da_igGetContentRegionMax igGetContentRegionMax;
    da_igGetContentRegionAvail igGetContentRegionAvail;
    da_igGetContentRegionAvailWidth igGetContentRegionAvailWidth;
    da_igGetWindowContentRegionMin igGetWindowContentRegionMin;
    da_igGetWindowContentRegionMax igGetWindowContentRegionMax;
    da_igGetWindowContentRegionWidth igGetWindowContentRegionWidth;
    da_igGetWindowDrawList igGetWindowDrawList;
    da_igGetWindowPos igGetWindowPos;
    da_igGetWindowSize igGetWindowSize;
    da_igGetWindowWidth igGetWindowWidth;
    da_igGetWindowHeight igGetWindowHeight;
    da_igIsWindowCollapsed igIsWindowCollapsed;
    da_igSetWindowFontScale igSetWindowFontScale;

    da_igSetNextWindowPos igSetNextWindowPos;
    da_igSetNextWindowSize igSetNextWindowSize;
    da_igSetNextWindowSizeConstraints igSetNextWindowSizeConstraints;
    da_igSetNextWindowContentSize igSetNextWindowContentSize;
    da_igSetNextWindowCollapsed igSetNextWindowCollapsed;
    da_igSetNextWindowFocus igSetNextWindowFocus;
    da_igSetWindowPos igSetWindowPos;
    da_igSetWindowSize igSetWindowSize;
    da_igSetWindowCollapsed igSetWindowCollapsed;
    da_igSetWindowFocus igSetWindowFocus;
    da_igSetWindowPosByName igSetWindowPosByName;
    da_igSetWindowSize2 igSetWindowSize2;
    da_igSetWindowCollapsed2 igSetWindowCollapsed2;
    da_igSetWindowFocus2 igSetWindowFocus2;

    da_igGetScrollX igGetScrollX;
    da_igGetScrollY igGetScrollY;
    da_igGetScrollMaxX igGetScrollMaxX;
    da_igGetScrollMaxY igGetScrollMaxY;
    da_igSetScrollX igSetScrollX;
    da_igSetScrollY igSetScrollY;
    da_igSetScrollHere igSetScrollHere;
    da_igSetScrollFromPosY igSetScrollFromPosY;
    da_igSetKeyboardFocusHere igSetKeyboardFocusHere;
    da_igSetStateStorage igSetStateStorage;
    da_igGetStateStorage igGetStateStorage;

    da_igPushFont igPushFont;
    da_igPopFont igPopFont;
    da_igPushStyleColorU32 igPushStyleColorU32;
    da_igPushStyleColor igPushStyleColor;
    da_igPopStyleColor igPopStyleColor;
    da_igPushStyleVar igPushStyleVar;
    da_igPushStyleVarVec igPushStyleVarVec;
    da_igPopStyleVar igPopStyleVar;
    da_igGetStyleColorVec4 igGetStyleColorVec4;
    da_igGetFont igGetFont;
    da_igGetFontSize igGetFontSize;
    da_igGetFontTexUvWhitePixel igGetFontTexUvWhitePixel;
    da_igGetColorU32 igGetColorU32;
    da_igGetColorU32Vec igGetColorU32Vec;
    da_igGetColorU32U32 igGetColorU32U32;

    da_igPushItemWidth igPushItemWidth;
    da_igPopItemWidth igPopItemWidth;
    da_igCalcItemWidth igCalcItemWidth;
    da_igPushTextWrapPos igPushTextWrapPos;
    da_igPopTextWrapPos igPopTextWrapPos;
    da_igPushAllowKeyboardFocus igPushAllowKeyboardFocus;
    da_igPopAllowKeyboardFocus igPopAllowKeyboardFocus;
    da_igPushButtonRepeat igPushButtonRepeat;
    da_igPopButtonRepeat igPopButtonRepeat;

    da_igSeparator igSeparator;
    da_igSameLine igSameLine;
    da_igNewLine igNewLine;
    da_igSpacing igSpacing;
    da_igDummy igDummy;
    da_igIndent igIndent;
    da_igUnindent igUnindent;
    da_igBeginGroup igBeginGroup;
    da_igEndGroup igEndGroup;
    da_igGetCursorPos igGetCursorPos;
    da_igGetCursorPosX igGetCursorPosX;
    da_igGetCursorPosY igGetCursorPosY;
    da_igSetCursorPos igSetCursorPos;
    da_igSetCursorPosX igSetCursorPosX;
    da_igSetCursorPosY igSetCursorPosY;
    da_igGetCursorStartPos igGetCursorStartPos;
    da_igGetCursorScreenPos igGetCursorScreenPos;
    da_igSetCursorScreenPos igSetCursorScreenPos;
    da_igAlignTextToFramePadding igAlignTextToFramePadding;
    da_igGetTextLineHeight igGetTextLineHeight;
    da_igGetTextLineHeightWithSpacing igGetTextLineHeightWithSpacing;
    da_igGetFrameHeightWithSpacing igGetFrameHeightWithSpacing;

    da_igColumns igColumns;
    da_igNextColumn igNextColumn;
    da_igGetColumnIndex igGetColumnIndex;
    da_igGetColumnWidth igGetColumnWidth;
    da_igSetColumnWidth igSetColumnWidth;
    da_igGetColumnOffset igGetColumnOffset;
    da_igSetColumnOffset igSetColumnOffset;
    da_igGetColumnsCount igGetColumnsCount;

    da_igPushIDStr igPushIDStr;
    da_igPushIDStrRange igPushIDStrRange;
    da_igPushIDPtr igPushIDPtr;
    da_igPushIDInt igPushIDInt;
    da_igPopID igPopID;
    da_igGetIDStr igGetIDStr;
    da_igGetIDStrRange igGetIDStrRange;
    da_igGetIDPtr igGetIDPtr;

    da_igText igText;
    da_igTextV igTextV;
    da_igTextColored igTextColored;
    da_igTextColoredV igTextColoredV;
    da_igTextDisabled igTextDisabled;
    da_igTextDisabledV igTextDisabledV;
    da_igTextWrapped igTextWrapped;
    da_igTextWrappedV igTextWrappedV;
    da_igTextUnformatted igTextUnformatted;
    da_igLabelText igLabelText;
    da_igLabelTextV igLabelTextV;
    da_igBullet igBullet;
    da_igBulletText igBulletText;
    da_igBulletTextV igBulletTextV;
    da_igButton igButton;
    da_igSmallButton igSmallButton;
    da_igInvisibleButton igInvisibleButton;
    da_igImage igImage;
    da_igImageButton igImageButton;
    da_igCheckbox igCheckbox;
    da_igCheckboxFlags igCheckboxFlags;
    da_igRadioButtonBool igRadioButtonBool;
    da_igRadioButton igRadioButton;
    da_igCombo igCombo;
    da_igCombo2 igCombo2;
    da_igCombo3 igCombo3;
    da_igPlotLines igPlotLines;
    da_igPlotLines2 igPlotLines2;
    da_igPlotHistogram igPlotHistogram;
    da_igPlotHistogram2 igPlotHistogram2;
    da_igProgressBar igProgressBar;

    da_igDragFloat igDragFloat;
    da_igDragFloat2 igDragFloat2;
    da_igDragFloat3 igDragFloat3;
    da_igDragFloat4 igDragFloat4;
    da_igDragFloatRange2 igDragFloatRange2;
    da_igDragInt igDragInt;
    da_igDragInt2 igDragInt2;
    da_igDragInt3 igDragInt3;
    da_igDragInt4 igDragInt4;
    da_igDragIntRange2 igDragIntRange2;

    da_igInputText igInputText;
    da_igInputTextMultiline igInputTextMultiline;
    da_igInputFloat igInputFloat;
    da_igInputFloat2 igInputFloat2;
    da_igInputFloat3 igInputFloat3;
    da_igInputFloat4 igInputFloat4;
    da_igInputInt igInputInt;
    da_igInputInt2 igInputInt2;
    da_igInputInt3 igInputInt3;
    da_igInputInt4 igInputInt4;

    da_igSliderFloat igSliderFloat;
    da_igSliderFloat2 igSliderFloat2;
    da_igSliderFloat3 igSliderFloat3;
    da_igSliderFloat4 igSliderFloat4;
    da_igSliderAngle igSliderAngle;
    da_igSliderInt igSliderInt;
    da_igSliderInt2 igSliderInt2;
    da_igSliderInt3 igSliderInt3;
    da_igSliderInt4 igSliderInt4;
    da_igVSliderFloat igVSliderFloat;
    da_igVSliderInt igVSliderInt;

    da_igColorEdit3 igColorEdit3;
    da_igColorEdit4 igColorEdit4;
    da_igColorPicker3 igColorPicker3;
    da_igColorPicker4 igColorPicker4;
    da_igColorButton igColorButton;
    da_igSetColorEditOptions igSetColorEditOptions;

    da_igTreeNode igTreeNode;
    da_igTreeNodeStr igTreeNodeStr;
    da_igTreeNodePtr igTreeNodePtr;
    da_igTreeNodeStrV igTreeNodeStrV;
    da_igTreeNodePtrV igTreeNodePtrV;
    da_igTreeNodeEx igTreeNodeEx;
    da_igTreeNodeExStr igTreeNodeExStr;
    da_igTreeNodeExPtr igTreeNodeExPtr;
    da_igTreeNodeExV igTreeNodeExV;
    da_igTreeNodeExVPtr igTreeNodeExVPtr;
    da_igTreePushStr igTreePushStr;
    da_igTreePushPtr igTreePushPtr;
    da_igTreePop igTreePop;
    da_igTreeAdvanceToLabelPos igTreeAdvanceToLabelPos;
    da_igGetTreeNodeToLabelSpacing igGetTreeNodeToLabelSpacing;
    da_igSetNextTreeNodeOpen igSetNextTreeNodeOpen;
    da_igCollapsingHeader igCollapsingHeader;
    da_igCollapsingHeaderEx igCollapsingHeaderEx;

    da_igSelectable igSelectable;
    da_igSelectableEx igSelectableEx;
    da_igListBox igListBox;
    da_igListBox2 igListBox2;
    da_igListBoxHeader igListBoxHeader;
    da_igListBoxHeader2 igListBoxHeader2;
    da_igListBoxFooter igListBoxFooter;

    da_igValueBool igValueBool;
    da_igValueInt igValueInt;
    da_igValueUInt igValueUInt;
    da_igValueFloat igValueFloat;

    da_igSetTooltip igSetTooltip;
    da_igSetTooltipV igSetTooltipV;
    da_igBeginTooltip igBeginTooltip;
    da_igEndTooltip igEndTooltip;

    // Widgets: Menus
    da_igBeginMainMenuBar  igBeginMainMenuBar;
    da_igEndMainMenuBar    igEndMainMenuBar;
    da_igBeginMenuBar      igBeginMenuBar;
    da_igEndMenuBar        igEndMenuBar;
    da_igBeginMenu         igBeginMenu;
    da_igEndMenu           igEndMenu;
    da_igMenuItem          igMenuItem;
    da_igMenuItemPtr       igMenuItemPtr;

    da_igOpenPopup igOpenPopup;
    da_igBeginPopup igBeginPopup;
    da_igBeginPopupModal igBeginPopupModal;
    da_igBeginPopupContextItem igBeginPopupContextItem;
    da_igBeginPopupContextWindow igBeginPopupContextWindow;
    da_igBeginPopupContextVoid igBeginPopupContextVoid;
    da_igEndPopup igEndPopup;
    da_igIsPopupOpen igIsPopupOpen;
    da_igCloseCurrentPopup igCloseCurrentPopup;

    da_igLogToTTY igLogToTTY;
    da_igLogToFile igLogToFile;
    da_igLogToClipboard igLogToClipboard;
    da_igLogFinish igLogFinish;
    da_igLogButtons igLogButtons;
    da_igLogText igLogText;

    da_igPushClipRect igPushClipRect;
    da_igPopClipRect igPopClipRect;

    da_igIsItemHovered igIsItemHovered;
    da_igIsItemActive igIsItemActive;
    da_igIsItemClicked igIsItemClicked;
    da_igIsItemVisible igIsItemVisible;
    da_igIsAnyItemHovered igIsAnyItemHovered;
    da_igIsAnyItemActive igIsAnyItemActive;
    da_igGetItemRectMin igGetItemRectMin;
    da_igGetItemRectMax igGetItemRectMax;
    da_igGetItemRectSize igGetItemRectSize;
    da_igSetItemAllowOverlap igSetItemAllowOverlap;
    da_igIsWindowFocused igIsWindowFocused;
    da_igIsWindowHovered igIsWindowHovered;
    da_igIsAnyWindowHovered igIsAnyWindowHovered;
    da_igIsRectVisible igIsRectVisible;
    da_igIsRectVisible2 igIsRectVisible2;

    da_igGetTime igGetTime;
    da_igGetFrameCount igGetFrameCount;
    da_igGetStyleColorName igGetStyleColorName;
    da_igCalcItemRectClosestPoint igCalcItemRectClosestPoint;
    da_igCalcTextSize igCalcTextSize;
    da_igCalcListClipping igCalcListClipping;

    da_igBeginChildFrame igBeginChildFrame;
    da_igEndChildFrame igEndChildFrame;

    da_igColorConvertU32ToFloat4 igColorConvertU32ToFloat4;
    da_igColorConvertFloat4ToU32 igColorConvertFloat4ToU32;
    da_igColorConvertRGBtoHSV igColorConvertRGBtoHSV;
    da_igColorConvertHSVtoRGB igColorConvertHSVtoRGB;

    da_igGetKeyIndex igGetKeyIndex;
    da_igIsKeyDown igIsKeyDown;
    da_igIsKeyPressed igIsKeyPressed;
    da_igIsKeyReleased igIsKeyReleased;
    da_igIsMouseDown igIsMouseDown;
    da_igIsMouseClicked igIsMouseClicked;
    da_igIsMouseDoubleClicked igIsMouseDoubleClicked;
    da_igIsMouseReleased igIsMouseReleased;
    da_igIsMouseDragging igIsMouseDragging;
    da_igIsMouseHoveringRect igIsMouseHoveringRect;
    da_igIsMousePosValid igIsMousePosValid;
    da_igGetMousePos igGetMousePos;
    da_igGetMousePosOnOpeningCurrentPopup igGetMousePosOnOpeningCurrentPopup;
    da_igGetMouseDragDelta igGetMouseDragDelta;
    da_igResetMouseDragDelta igResetMouseDragDelta;
    da_igGetMouseCursor igGetMouseCursor;
    da_igSetMouseCursor igSetMouseCursor;
    da_igCaptureKeyboardFromApp igCaptureKeyboardFromApp;
    da_igCaptureMouseFromApp igCaptureMouseFromApp;

    da_igMemAlloc igMemAlloc;
    da_igMemFree igMemFree;
    da_igGetClipboardText igGetClipboardText;
    da_igSetClipboardText igSetClipboardText;

    da_igGetVersion igGetVersion;
    da_igCreateContext igCreateContext;
    da_igDestroyContext igDestroyContext;
    da_igGetCurrentContext igGetCurrentContext;
    da_igSetCurrentContext igSetCurrentContext;
}

__gshared
{
    // ImGuiIO
    da_ImGuiIO_AddInputCharacter ImGuiIO_AddInputCharacter;
    da_ImGuiIO_AddInputCharactersUTF8 ImGuiIO_AddInputCharactersUTF8;
    da_ImGuiIO_ClearInputCharacters ImGuiIO_ClearInputCharacters;

    // ImGuiTextFilter
    da_ImGuiTextFilter_Create ImGuiTextFilter_Create;
    da_ImGuiTextFilter_Destroy ImGuiTextFilter_Destroy;
    da_ImGuiTextFilter_Clear ImGuiTextFilter_Clear;
    da_ImGuiTextFilter_Draw ImGuiTextFilter_Draw;
    da_ImGuiTextFilter_PassFilter ImGuiTextFilter_PassFilter;
    da_ImGuiTextFilter_IsActive ImGuiTextFilter_IsActive;
    da_ImGuiTextFilter_Build ImGuiTextFilter_Build;
    da_ImGuiTextFilter_GetInputBuf ImGuiTextFilter_GetInputBuf;

    // ImGuiTextBuffer
    da_ImGuiTextBuffer_Create ImGuiTextBuffer_Create;
    da_ImGuiTextBuffer_Destroy ImGuiTextBuffer_Destroy;
    da_ImGuiTextBuffer_index ImGuiTextBuffer_index;
    da_ImGuiTextBuffer_begin ImGuiTextBuffer_begin;
    da_ImGuiTextBuffer_end ImGuiTextBuffer_end;
    da_ImGuiTextBuffer_size ImGuiTextBuffer_size;
    da_ImGuiTextBuffer_empty ImGuiTextBuffer_empty;
    da_ImGuiTextBuffer_clear ImGuiTextBuffer_clear;
    da_ImGuiTextBuffer_c_str ImGuiTextBuffer_c_str;
    da_ImGuiTextBuffer_appendf ImGuiTextBuffer_appendf;
    da_ImGuiTextBuffer_appendfv ImGuiTextBuffer_appendfv;

    // ImGuiStorage
    da_ImGuiStorage_Create ImGuiStorage_Create;
    da_ImGuiStorage_Destroy ImGuiStorage_Destroy;
    da_ImGuiStorage_Clear ImGuiStorage_Clear;
    da_ImGuiStorage_GetInt ImGuiStorage_GetInt;
    da_ImGuiStorage_SetInt ImGuiStorage_SetInt;
    da_ImGuiStorage_GetBool ImGuiStorage_GetBool;
    da_ImGuiStorage_SetBool ImGuiStorage_SetBool;
    da_ImGuiStorage_GetFloat ImGuiStorage_GetFloat;
    da_ImGuiStorage_SetFloat ImGuiStorage_SetFloat;
    da_ImGuiStorage_GetVoidPtr ImGuiStorage_GetVoidPtr;
    da_ImGuiStorage_SetVoidPtr ImGuiStorage_SetVoidPtr;
    da_ImGuiStorage_GetIntRef ImGuiStorage_GetIntRef;
    da_ImGuiStorage_GetBoolRef ImGuiStorage_GetBoolRef;
    da_ImGuiStorage_GetFloatRef ImGuiStorage_GetFloatRef;
    da_ImGuiStorage_GetVoidPtrRef ImGuiStorage_GetVoidPtrRef;
    da_ImGuiStorage_SetAllInt ImGuiStorage_SetAllInt;

    // ImGuiTextEditCallbackData
    da_ImGuiTextEditCallbackData_DeleteChars ImGuiTextEditCallbackData_DeleteChars;
    da_ImGuiTextEditCallbackData_InsertChars ImGuiTextEditCallbackData_InsertChars;
    da_ImGuiTextEditCallbackData_HasSelection ImGuiTextEditCallbackData_HasSelection;

    // ImGuiListClipper
    da_ImGuiListClipper_Begin ImGuiListClipper_Begin;
    da_ImGuiListClipper_End ImGuiListClipper_End;
    da_ImGuiListClipper_Step ImGuiListClipper_Step;
    da_ImGuiListClipper_GetDisplayStart ImGuiListClipper_GetDisplayStart;
    da_ImGuiListClipper_GetDisplayEnd ImGuiListClipper_GetDisplayEnd;

    // ImDrawList
    da_ImDrawList_GetVertexBufferSize ImDrawList_GetVertexBufferSize;
    da_ImDrawList_GetVertexPtr ImDrawList_GetVertexPtr;
    da_ImDrawList_GetIndexBufferSize ImDrawList_GetIndexBufferSize;
    da_ImDrawList_GetIndexPtr ImDrawList_GetIndexPtr;
    da_ImDrawList_GetCmdSize ImDrawList_GetCmdSize;
    da_ImDrawList_GetCmdPtr ImDrawList_GetCmdPtr;
    da_ImDrawList_Clear ImDrawList_Clear;
    da_ImDrawList_ClearFreeMemory ImDrawList_ClearFreeMemory;
    da_ImDrawList_PushClipRect ImDrawList_PushClipRect;
    da_ImDrawList_PushClipRectFullScreen ImDrawList_PushClipRectFullScreen;
    da_ImDrawList_PopClipRect ImDrawList_PopClipRect;
    da_ImDrawList_PushTextureID ImDrawList_PushTextureID;
    da_ImDrawList_PopTextureID ImDrawList_PopTextureID;
    da_ImDrawList_GetClipRectMin ImDrawList_GetClipRectMin;
    da_ImDrawList_GetClipRectMax ImDrawList_GetClipRectMax;
    da_ImDrawList_AddLine ImDrawList_AddLine;
    da_ImDrawList_AddRect ImDrawList_AddRect;
    da_ImDrawList_AddRectFilled ImDrawList_AddRectFilled;
    da_ImDrawList_AddRectFilledMultiColor ImDrawList_AddRectFilledMultiColor;
    da_ImDrawList_AddQuad ImDrawList_AddQuad;
    da_ImDrawList_AddQuadFilled ImDrawList_AddQuadFilled;
    da_ImDrawList_AddTriangle ImDrawList_AddTriangle;
    da_ImDrawList_AddTriangleFilled ImDrawList_AddTriangleFilled;
    da_ImDrawList_AddCircle ImDrawList_AddCircle;
    da_ImDrawList_AddCircleFilled ImDrawList_AddCircleFilled;
    da_ImDrawList_AddText ImDrawList_AddText;
    da_ImDrawList_AddTextExt ImDrawList_AddTextExt;
    da_ImDrawList_AddImage ImDrawList_AddImage;
    da_ImDrawList_AddImageQuad ImDrawList_AddImageQuad;
    da_ImDrawList_AddPolyline ImDrawList_AddPolyline;
    da_ImDrawList_AddConvexPolyFilled ImDrawList_AddConvexPolyFilled;
    da_ImDrawList_AddBezierCurve ImDrawList_AddBezierCurve;
    da_ImDrawList_PathClear ImDrawList_PathClear;
    da_ImDrawList_PathLineTo ImDrawList_PathLineTo;
    da_ImDrawList_PathLineToMergeDuplicate ImDrawList_PathLineToMergeDuplicate;
    da_ImDrawList_PathFillConvex ImDrawList_PathFillConvex;
    da_ImDrawList_PathStroke ImDrawList_PathStroke;
    da_ImDrawList_PathArcTo ImDrawList_PathArcTo;
    da_ImDrawList_PathArcToFast ImDrawList_PathArcToFast;
    da_ImDrawList_PathBezierCurveTo ImDrawList_PathBezierCurveTo;
    da_ImDrawList_PathRect ImDrawList_PathRect;
    da_ImDrawList_ChannelsSplit ImDrawList_ChannelsSplit;
    da_ImDrawList_ChannelsMerge ImDrawList_ChannelsMerge;
    da_ImDrawList_ChannelsSetCurrent ImDrawList_ChannelsSetCurrent;
    da_ImDrawList_AddCallback ImDrawList_AddCallback;
    da_ImDrawList_AddDrawCmd ImDrawList_AddDrawCmd;
    da_ImDrawList_PrimReserve ImDrawList_PrimReserve;
    da_ImDrawList_PrimRect ImDrawList_PrimRect;
    da_ImDrawList_PrimRectUV ImDrawList_PrimRectUV;
    da_ImDrawList_PrimQuadUV ImDrawList_PrimQuadUV;
    da_ImDrawList_PrimVtx ImDrawList_PrimVtx;
    da_ImDrawList_PrimWriteVtx ImDrawList_PrimWriteVtx;
    da_ImDrawList_PrimWriteIdx ImDrawList_PrimWriteIdx;
    da_ImDrawList_UpdateClipRect ImDrawList_UpdateClipRect;
    da_ImDrawList_UpdateTextureID ImDrawList_UpdateTextureID;

    // ImDrawData
    da_ImDrawData_DeIndexAllBuffers ImDrawData_DeIndexAllBuffers;
    da_ImDrawData_ScaleClipRects ImDrawData_ScaleClipRects;

    // ImFontAtlas
    da_ImFontAtlas_AddFont                  ImFontAtlas_AddFont;
    da_ImFontAtlas_AddFontDefault           ImFontAtlas_AddFontDefault;
    da_ImFontAtlas_AddFontFromFileTTF       ImFontAtlas_AddFontFromFileTTF;
    da_ImFontAtlas_AddFontFromMemoryTTF     ImFontAtlas_AddFontFromMemoryTTF;
    da_ImFontAtlas_AddFontFromMemoryCompressedTTF ImFontAtlas_AddFontFromMemoryCompressedTTF;
    da_ImFontAtlas_AddFontFromMemoryCompressedBase85TTF ImFontAtlas_AddFontFromMemoryCompressedBase85TTF;
    da_ImFontAtlas_ClearTexData             ImFontAtlas_ClearTexData;
    da_ImFontAtlas_ClearInputData           ImFontAtlas_ClearInputData;
    da_ImFontAtlas_ClearFonts               ImFontAtlas_ClearFonts;
    da_ImFontAtlas_Clear                    ImFontAtlas_Clear;

    da_ImFontAtlas_GetTexDataAsAlpha8       ImFontAtlas_GetTexDataAsAlpha8;
    da_ImFontAtlas_GetTexDataAsRGBA32       ImFontAtlas_GetTexDataAsRGBA32;
    da_ImFontAtlas_SetTexID                 ImFontAtlas_SetTexID;

    da_ImFontAtlas_GetGlyphRangesDefault    ImFontAtlas_GetGlyphRangesDefault;
    da_ImFontAtlas_GetGlyphRangesKorean     ImFontAtlas_GetGlyphRangesKorean;
    da_ImFontAtlas_GetGlyphRangesJapanese   ImFontAtlas_GetGlyphRangesJapanese;
    da_ImFontAtlas_GetGlyphRangesChinese    ImFontAtlas_GetGlyphRangesChinese;
    da_ImFontAtlas_GetGlyphRangesCyrillic   ImFontAtlas_GetGlyphRangesCyrillic;
    da_ImFontAtlas_GetGlyphRangesThai       ImFontAtlas_GetGlyphRangesThai;

    da_ImFontAtlas_GetTexID                 ImFontAtlas_GetTexID;
    da_ImFontAtlas_GetTexPixelsAlpha8       ImFontAtlas_GetTexPixelsAlpha8;
    da_ImFontAtlas_GetTexPixelsRGBA32       ImFontAtlas_GetTexPixelsRGBA32;
    da_ImFontAtlas_GetTexWidth              ImFontAtlas_GetTexWidth;
    da_ImFontAtlas_GetTexHeight             ImFontAtlas_GetTexHeight;
    da_ImFontAtlas_GetTexDesiredWidth       ImFontAtlas_GetTexDesiredWidth;
    da_ImFontAtlas_SetTexDesiredWidth       ImFontAtlas_SetTexDesiredWidth;
    da_ImFontAtlas_GetTexGlyphPadding       ImFontAtlas_GetTexGlyphPadding;
    da_ImFontAtlas_SetTexGlyphPadding       ImFontAtlas_SetTexGlyphPadding;
    da_ImFontAtlas_GetTexUvWhitePixel       ImFontAtlas_GetTexUvWhitePixel;

    // ImFontAtlas::Fonts;
    da_ImFontAtlas_Fonts_size               ImFontAtlas_Fonts_size;
    da_ImFontAtlas_Fonts_index              ImFontAtlas_Fonts_index;

    // ImFont
    da_ImFont_GetFontSize                   ImFont_GetFontSize;
    da_ImFont_SetFontSize                   ImFont_SetFontSize;
    da_ImFont_GetScale                      ImFont_GetScale;
    da_ImFont_SetScale                      ImFont_SetScale;
    da_ImFont_GetDisplayOffset              ImFont_GetDisplayOffset;
    da_ImFont_GetFallbackGlyph              ImFont_GetFallbackGlyph;
    da_ImFont_SetFallbackGlyph              ImFont_SetFallbackGlyph;
    da_ImFont_GetFallbackAdvanceX           ImFont_GetFallbackAdvanceX;
    da_ImFont_GetFallbackChar               ImFont_GetFallbackChar;
    da_ImFont_GetConfigDataCount            ImFont_GetConfigDataCount;
    da_ImFont_GetConfigData                 ImFont_GetConfigData;
    da_ImFont_GetContainerAtlas             ImFont_GetContainerAtlas;
    da_ImFont_GetAscent                     ImFont_GetAscent;
    da_ImFont_GetDescent                    ImFont_GetDescent;
    da_ImFont_GetMetricsTotalSurface        ImFont_GetMetricsTotalSurface;

    da_ImFont_ClearOutputData               ImFont_ClearOutputData;
    da_ImFont_BuildLookupTable              ImFont_BuildLookupTable;
    da_ImFont_FindGlyph                     ImFont_FindGlyph;
    da_ImFont_SetFallbackChar               ImFont_SetFallbackChar;
    da_ImFont_GetCharAdvance                ImFont_GetCharAdvance;
    da_ImFont_IsLoaded                      ImFont_IsLoaded;
    da_ImFont_CalcTextSizeA                 ImFont_CalcTextSizeA;
    da_ImFont_CalcWordWrapPositionA         ImFont_CalcWordWrapPositionA;
    da_ImFont_RenderChar                    ImFont_RenderChar;
    da_ImFont_RenderText                    ImFont_RenderText;

    // ImFont::Glyph
    da_ImFont_Glyphs_size                   ImFont_Glyphs_size;
    da_ImFont_Glyphs_index                  ImFont_Glyphs_index;

    // ImFont::IndexXAdvance
    da_ImFont_IndexXAdvance_size            ImFont_IndexXAdvance_size;
    da_ImFont_IndexXAdvance_index           ImFont_IndexXAdvance_index;

    // ImFont::IndexLookup
    da_ImFont_IndexLookup_size              ImFont_IndexLookup_size;
    da_ImFont_IndexLookup_index             ImFont_IndexLookup_index;

}

// obsolete types for the compatibility
alias igPushIdStr = igPushIDStr;
alias igPushIdStrRange = igPushIDStrRange;
alias igPushIdPtr = igPushIDPtr;
alias igPushIdInt = igPushIDInt;
alias igPopId = igPopID;
alias igGetIdStr = igGetIDStr;
alias igGetIdStrRange = igGetIDStrRange;
alias igGetIdPtr = igGetIDPtr;
