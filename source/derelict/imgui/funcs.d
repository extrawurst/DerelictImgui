/*
 * Copyright (c) 2015 Derelict Developers
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
 * * Neither the names 'Derelict', 'DerelictILUT', nor the names of its contributors
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
	import std.c.stdarg:va_list;
}

ImVec2 foo;

extern(C) @nogc nothrow
{
	alias da_ig_GetIO 						= ImGuiIO* function();
	alias da_ig_GetStyle 					= ImGuiStyle* function();
	alias da_ig_NewFrame 					= void function();
	alias da_ig_Render 						= void function();
	alias da_ig_Shutdown 					= void function();
	alias da_ig_ShowUserGuide 				= void function();
	alias da_ig_ShowStyleEditor 			= void function(ImGuiStyle* ref_);
	alias da_ig_ShowTestWindow 				= void function(bool* opened = null);
	alias da_ig_ShowMetricsWindow 			= void function(bool* opened = null);

	// Window
	alias da_ig_Begin 						= bool function(const char* name = "Debug", bool* p_opened = null, ImGuiWindowFlags flags = 0);
	alias da_ig_Begin2 						= bool function(const char* name, bool* p_opened, const ImVec2 size_on_first_use, float bg_alpha = -1.0f, ImGuiWindowFlags flags = 0);
	alias da_ig_End 						= void function();
	alias da_ig_BeginChild 					= bool function(const char* str_id, const ImVec2 size = ImVec2(0, 0), bool border = false, ImGuiWindowFlags extra_flags = 0);
	alias da_ig_BeginChild2 				= bool function(ImGuiID id, const ImVec2 size = ImVec2(0, 0), bool border = false, ImGuiWindowFlags extra_flags = 0);
	alias da_ig_EndChild 					= void function();
	alias da_ig_GetContentRegionMax 		= void function(ImVec2* outParam);
	alias da_ig_GetWindowContentRegionMin 	= void function(ImVec2* outParam);
	alias da_ig_GetWindowContentRegionMax 	= void function(ImVec2* outParam);
	alias da_ig_GetWindowDrawList 			= ImDrawList* function();
	alias da_ig_GetWindowFont 				= ImFont* function();
	alias da_ig_GetWindowFontSize 			= float function(); 
	alias da_ig_SetWindowFontScale 			= void function(float scale);
	alias da_ig_GetWindowPos 				= void function(ImVec2* outParam);
	alias da_ig_GetWindowSize 				= void function(ImVec2* outParam);
	alias da_ig_GetWindowWidth 				= float function();
	alias da_ig_GetWindowCollapsed 			= bool function();

	alias da_ig_SetNextWindowPos 			= void function(const ImVec2 pos, ImGuiSetCond cond = 0);
	alias da_ig_SetNextWindowSize 			= void function(const ImVec2 size, ImGuiSetCond cond = 0);
	alias da_ig_SetNextWindowCollapsed 		= void function(bool collapsed, ImGuiSetCond cond = 0);
	alias da_ig_SetNextWindowFocus 			= void function();
	alias da_ig_SetWindowPos 				= void function(const ImVec2 pos, ImGuiSetCond cond = 0);
	alias da_ig_SetWindowSize 				= void function(const ImVec2 size, ImGuiSetCond cond = 0);
	alias da_ig_SetWindowCollapsed 			= void function(bool collapsed, ImGuiSetCond cond = 0);
	alias da_ig_SetWindowFocus 				= void function();
	alias da_ig_SetWindowPos2 				= void function(const char* name, const ImVec2 pos, ImGuiSetCond cond = 0);
	alias da_ig_SetWindowSize2 				= void function(const char* name, const ImVec2 size, ImGuiSetCond cond = 0);
	alias da_ig_SetWindowCollapsed2 		= void function(const char* name, bool collapsed, ImGuiSetCond cond = 0);
	alias da_ig_SetWindowFocus2 			= void function(const char* name);
	
	alias da_ig_GetScrollPosY				= float			function();
	alias da_ig_GetScrollMaxY				= float			function();
	alias da_ig_SetScrollPosHere			= void				function();
	alias da_ig_SetKeyboardFocusHere		= void				function(int offset = 0);
	alias da_ig_SetStateStorage				= void				function(ImGuiStorage* tree);
	alias da_ig_GetStateStorage				= ImGuiStorage*	function();

	alias da_ig_PushFont					= void				function(ImFont* font);
	alias da_ig_PopFont						= void				function();
	alias da_ig_PushStyleColor				= void				function(ImGuiCol idx, const ImVec4 col);
	alias da_ig_PopStyleColor				= void				function(int count = 1);
	alias da_ig_PushStyleVar				= void				function(ImGuiStyleVar idx, float val);
	alias da_ig_PushStyleVarVec				= void				function(ImGuiStyleVar idx, const ImVec2 val);
	alias da_ig_PopStyleVar					= void				function(int count = 1);

	alias da_ig_PushItemWidth				= void				function(float item_width);
	alias da_ig_PopItemWidth				= void				function();
	alias da_ig_CalcItemWidth				= float			function();
	alias da_ig_PushAllowKeyboardFocus		= void				function(bool v);
	alias da_ig_PopAllowKeyboardFocus		= void				function();
	alias da_ig_PushTextWrapPos				= void				function(float wrap_pos_x = 0.0f);
	alias da_ig_PopTextWrapPos				= void				function();

	alias da_ig_SetTooltip					= void				function(const char* fmt, ...);
	alias da_ig_SetTooltipV					= void				function(const char* fmt, va_list args);
	alias da_ig_BeginTooltip				= void				function();
	alias da_ig_EndTooltip					= void				function();

	alias da_ig_BeginPopup					= void				function(bool* p_opened);
	alias da_ig_EndPopup					= void				function();

	alias da_ig_BeginGroup					= void				function();
	alias da_ig_EndGroup					= void				function();
	alias da_ig_Separator					= void				function();
	alias da_ig_SameLine					= void				function(int column_x = 0, int spacing_w = -1);
	alias da_ig_Spacing						= void				function();
	alias da_ig_Indent						= void				function();
	alias da_ig_Unindent					= void				function();
	alias da_ig_Columns						= void				function(int count = 1, const char* id = null, bool border = true);
	alias da_ig_NextColumn					= void				function();
	alias da_ig_GetColumnIndex				= int				function();
	alias da_ig_GetColumnOffset				= float			function(int column_index = -1);
	alias da_ig_SetColumnOffset				= void				function(int column_index, float offset_x);
	alias da_ig_GetColumnWidth				= float			function(int column_index = -1);
	alias da_ig_GetColumnsCount				= int				function();
	alias da_ig_GetCursorPos				= void			function(ImVec2* pOut);
	alias da_ig_GetCursorPosX				= float			function();
	alias da_ig_GetCursorPosY				= float			function();
	alias da_ig_SetCursorPos				= void				function(const ImVec2 pos);
	alias da_ig_SetCursorPosX				= void				function(float x);
	alias da_ig_SetCursorPosY				= void				function(float y);
	alias da_ig_GetCursorScreenPos			= void function(ImVec2* pOut);
	alias da_ig_SetCursorScreenPos			= void				function(const ImVec2 pos);
	alias da_ig_AlignFirstTextHeightToWidgets	= void				function();
	alias da_ig_GetTextLineHeight			= float			function();
	alias da_ig_GetTextLineHeightWithSpacing	= float			function();

	alias da_ig_PushID						= void				function(const char* str_id);
	alias da_ig_PushID2						= void				function(const void* ptr_id);
	alias da_ig_PushID3						= void				function(const int int_id);
	alias da_ig_PopID						= void				function();
	alias da_ig_GetID						= ImGuiID			function(const char* str_id);
	alias da_ig_GetID2						= ImGuiID			function(const void* ptr_id);

	alias da_ig_Text						= void				function(const char* fmt, ...);
	alias da_ig_TextV						= void				function(const char* fmt, va_list args);
	alias da_ig_TextColored					= void				function(const ImVec4 col, const char* fmt, ...);
	alias da_ig_TextColoredV				= void				function(const ImVec4 col, const char* fmt, va_list args);
	alias da_ig_TextWrapped					= void				function(const char* fmt, ...);
	alias da_ig_TextWrappedV				= void				function(const char* fmt, va_list args);
	alias da_ig_TextUnformatted				= void				function(const char* text, const char* text_end = null);
	alias da_ig_LabelText					= void				function(const char* label, const char* fmt, ...);
	alias da_ig_LabelTextV					= void				function(const char* label, const char* fmt, va_list args);
	alias da_ig_Bullet						= void				function();
	alias da_ig_BulletText					= void				function(const char* fmt, ...);
	alias da_ig_BulletTextV					= void				function(const char* fmt, va_list args);
	alias da_ig_Button						= bool				function(const char* label, const ImVec2 size = ImVec2(0, 0), bool repeat_when_held = false);
	alias da_ig_SmallButton					= bool				function(const char* label);
	alias da_ig_InvisibleButton				= bool				function(const char* str_id, const ImVec2 size);
	alias da_ig_Image						= void				function(ImTextureID user_texture_id, const ImVec2 size, const ImVec2 uv0 = ImVec2(0, 0), const ImVec2 uv1 = ImVec2(1, 1), const ImVec4 tint_col = ImVec4(1, 1, 1, 1), const ImVec4 border_col = ImVec4(0, 0, 0, 0));
	alias da_ig_ImageButton					= bool				function(ImTextureID user_texture_id, const ImVec2 size, const ImVec2 uv0 = ImVec2(0, 0), const ImVec2 uv1 = ImVec2(1, 1), int frame_padding = -1, const ImVec4 bg_col = ImVec4(0, 0, 0, 1), const ImVec4 tint_col = ImVec4(1, 1, 1, 1));
	alias da_ig_CollapsingHeader			= bool				function(const char* label, const char* str_id = null, bool display_frame = true, bool default_open = false);
	alias da_ig_Checkbox					= bool				function(const char* label, bool* v);
	alias da_ig_CheckboxFlags				= bool				function(const char* label, uint* flags, uint flags_value);
	alias da_ig_RadioButton					= bool				function(const char* label, bool active);
	alias da_ig_RadioButton2				= bool				function(const char* label, int* v, int v_button);
	alias da_ig_Combo						= bool				function(const char* label, int* current_item, const char** items, int items_count, int height_in_items = -1);
	alias da_ig_Combo2						= bool				function(const char* label, int* current_item, const char* items_separated_by_zeros, int height_in_items = -1);
	alias da_ig_Combo3						= bool				function(const char* label, int* current_item, bool function(void* data, int idx, const char** out_text) items_getter, void* data, int items_count, int height_in_items = -1);
	alias da_ig_ColorButton					= bool				function(const ImVec4 col, bool small_height = false, bool outline_border = true);
	alias da_ig_ColorEdit3					= bool				function(const char* label, ref float[3] col);
	alias da_ig_ColorEdit4					= bool				function(const char* label, ref float[4] col, bool show_alpha = true);
	alias da_ig_ColorEditMode				= void				function(ImGuiColorEditMode mode);
	alias da_ig_PlotLines					= void				function(const char* label, const float* values, int values_count, int values_offset = 0, const char* overlay_text = null, float scale_min = float.max, float scale_max = float.max, ImVec2 graph_size = ImVec2(0, 0), size_t stride = float.sizeof);
	alias da_ig_PlotLines2					= void				function(const char* label, float function(void* data, int idx) values_getter, void* data, int values_count, int values_offset = 0, const char* overlay_text = null, float scale_min = float.max, float scale_max = float.max, ImVec2 graph_size = ImVec2(0, 0));
	alias da_ig_PlotHistogram				= void				function(const char* label, const float* values, int values_count, int values_offset = 0, const char* overlay_text = null, float scale_min = float.max, float scale_max = float.max, ImVec2 graph_size = ImVec2(0, 0), size_t stride = float.sizeof);
	alias da_ig_PlotHistogram2				= void				function(const char* label, float function(void* data, int idx) values_getter, void* data, int values_count, int values_offset = 0, const char* overlay_text = null, float scale_min = float.max, float scale_max = float.max, ImVec2 graph_size = ImVec2(0, 0));

	alias da_ig_SliderFloat					= bool				function(const char* label, float* v, float v_min, float v_max, const char* display_format = "%.3f", float power = 1.0f);
	alias da_ig_SliderFloat2				= bool				function(const char* label, ref float[2] v, float v_min, float v_max, const char* display_format = "%.3f", float power = 1.0f);
	alias da_ig_SliderFloat3				= bool				function(const char* label, ref float[3] v, float v_min, float v_max, const char* display_format = "%.3f", float power = 1.0f);
	alias da_ig_SliderFloat4				= bool				function(const char* label, ref float[4] v, float v_min, float v_max, const char* display_format = "%.3f", float power = 1.0f);
	alias da_ig_SliderAngle					= bool				function(const char* label, float* v_rad, float v_degrees_min = -360.0f, float v_degrees_max = +360.0f);
	alias da_ig_SliderInt					= bool				function(const char* label, int* v, int v_min, int v_max, const char* display_format = "%.0f");
	alias da_ig_SliderInt2					= bool				function(const char* label, ref int[2] v, int v_min, int v_max, const char* display_format = "%.0f");
	alias da_ig_SliderInt3					= bool				function(const char* label, ref int[3] v, int v_min, int v_max, const char* display_format = "%.0f");
	alias da_ig_SliderInt4					= bool				function(const char* label, ref int[4] v, int v_min, int v_max, const char* display_format = "%.0f");
	alias da_ig_VSliderFloat				= bool				function(const char* label, const ImVec2 size, float* v, float v_min, float v_max, const char* display_format = "%.3f", float power = 1.0f);
	alias da_ig_VSliderInt					= bool				function(const char* label, const ImVec2 size, int* v, int v_min, int v_max, const char* display_format = "%.0f");

	alias da_ig_DragFloat					= bool				function(const char* label, float* v, float v_step = 1.0f, float v_min = 0.0f, float v_max = 0.0f, const char* display_format = "%.3f");
	alias da_ig_DragInt						= bool				function(const char* label, int* v, int v_step = 1, int v_min = 0, int v_max = 0, const char* display_format = "%.0f");

	alias da_ig_InputText					= bool				function(const char* label, char* buf, size_t buf_size, ImGuiInputTextFlags flags = 0, ImGuiTextEditCallback callback = null, void* user_data = null);
	alias da_ig_InputFloat					= bool				function(const char* label, float* v, float step = 0.0f, float step_fast = 0.0f, int decimal_precision = -1, ImGuiInputTextFlags extra_flags = 0);
	alias da_ig_InputFloat2					= bool				function(const char* label, ref float[2] v, int decimal_precision = -1);
	alias da_ig_InputFloat3					= bool				function(const char* label, ref float[3] v, int decimal_precision = -1);
	alias da_ig_InputFloat4					= bool				function(const char* label, ref float[4] v, int decimal_precision = -1);
	alias da_ig_InputInt					= bool				function(const char* label, int* v, int step = 1, int step_fast = 100, ImGuiInputTextFlags extra_flags = 0);
	alias da_ig_InputInt2					= bool				function(const char* label, ref int[2] v);
	alias da_ig_InputInt3					= bool				function(const char* label, ref int[3] v);
	alias da_ig_InputInt4					= bool				function(const char* label, ref int[4] v);
			
	alias da_ig_TreeNode					= bool				function(const char* str_label_id);
	alias da_ig_TreeNode2					= bool				function(const char* str_id, const char* fmt, ...);
	alias da_ig_TreeNode3					= bool				function(const void* ptr_id, const char* fmt, ...);
	alias da_ig_TreeNodeV					= bool				function(const char* str_id, const char* fmt, va_list args);
	alias da_ig_TreeNodeV2					= bool				function(const void* ptr_id, const char* fmt, va_list args);
	alias da_ig_TreePush					= void				function(const char* str_id = null);
	alias da_ig_TreePush2					= void				function(const void* ptr_id = null);
	alias da_ig_TreePop						= void				function();
	alias da_ig_SetNextTreeNodeOpened		= void				function(bool opened, ImGuiSetCond cond = 0);

	alias da_ig_Selectable					= bool				function(const char* label, bool selected = false, const ImVec2 size = ImVec2(0, 0));
	alias da_ig_Selectable2					= bool				function(const char* label, bool* p_selected, const ImVec2 size = ImVec2(0, 0));
	alias da_ig_ListBox						= bool				function(const char* label, int* current_item, const char** items, int items_count, int height_in_items = -1);
	alias da_ig_ListBox2					= bool				function(const char* label, int* current_item, bool function(void* data, int idx, const char** out_text) items_getter, void* data, int items_count, int height_in_items = -1);
	alias da_ig_ListBoxHeader				= bool				function(const char* label, const ImVec2 size = ImVec2(0, 0));
	alias da_ig_ListBoxHeader2				= bool				function(const char* label, int items_count, int height_in_items = -1);
	alias da_ig_ListBoxFooter				= void				function();

	alias da_ig_Value		= void				function(const char* prefix, bool b);
	alias da_ig_Value2		= void				function(const char* prefix, int v);
	alias da_ig_Value3		= void				function(const char* prefix, uint v);
	alias da_ig_Value4		= void				function(const char* prefix, float v, const char* float_format = null);
	alias da_ig_Color		= void				function(const char* prefix, const ImVec4 v);
	alias da_ig_Color2		= void				function(const char* prefix, uint v);

	alias da_ig_LogToTTY		= void				function(int max_depth = -1);
	alias da_ig_LogToFile		= void				function(int max_depth = -1, const char* filename = null);
	alias da_ig_LogToClipboard	= void				function(int max_depth = -1);
	alias da_ig_LogFinish		= void				function();
	alias da_ig_LogButtons		= void				function();
	alias da_ig_LogText			= void				function(const char* fmt, ...);

	alias da_ig_IsItemHovered				= bool				function();
	alias da_ig_IsItemHoveredRect			= bool				function();
	alias da_ig_IsItemActive				= bool				function();
	alias da_ig_IsAnyItemActive				= bool				function();
	alias da_ig_GetItemRectMin				= void function(ImVec2* pOut);
	alias da_ig_GetItemRectMax				= void function(ImVec2* pOut);
	alias da_ig_GetItemRectSize				= void function(ImVec2* pOut);
	alias da_ig_IsWindowFocused				= bool				function();
	alias da_ig_IsRootWindowFocused			= bool				function();
	alias da_ig_IsRootWindowOrAnyChildFocused	= bool				function();
	alias da_ig_IsClipped					= bool				function(const ImVec2 item_size);
	alias da_ig_IsKeyPressed				= bool				function(int key_index, bool repeat = true);
	alias da_ig_IsMouseClicked				= bool				function(int button, bool repeat = false);
	alias da_ig_IsMouseDoubleClicked		= bool				function(int button);
	alias da_ig_IsMouseHoveringWindow		= bool				function();
	alias da_ig_IsMouseHoveringAnyWindow	= bool				function();
	alias da_ig_IsMouseHoveringRect			= bool				function(const ImVec2 rect_min, const ImVec2 rect_max);
	alias da_ig_IsMouseDragging				= bool				function(int button = 0, float lock_threshold = -1.0f);
	alias da_ig_IsPosHoveringAnyWindow		= bool				function(const ImVec2 pos);
	alias da_ig_GetMousePos					= void function(ImVec2* pOut);
	alias da_ig_GetMouseDragDelta			= void function(ImVec2* pOut, int button = 0, float lock_threshold = -1.0f);
	alias da_ig_GetMouseCursor				= ImGuiMouseCursor function();
	alias da_ig_SetMouseCursor				= void				function(ImGuiMouseCursor type);
	alias da_ig_GetTime						= float			function();
	alias da_ig_GetFrameCount				= int				function();
	alias da_ig_GetStyleColName				= const char*		function(ImGuiCol idx);
	alias da_ig_CalcItemRectClosestPoint	= void function(ImVec2* pOut, const ImVec2 pos, bool on_edge = false, float outward = +0.0f);
	alias da_ig_CalcTextSize				= void function(ImVec2* pOut, const char* text, const char* text_end = null, bool hide_text_after_double_hash = false, float wrap_width = -1.0f);
	alias da_ig_CalcListClipping			= void				function(int items_count, float items_height, int* out_items_display_start, int* out_items_display_end);

	alias da_ig_BeginChildFrame				= void				function(ImGuiID id, const ImVec2 size);
	alias da_ig_EndChildFrame				= void				function();

	alias da_ig_ColorConvertFloat4ToU32		= ImU32	function(const ImVec4 in_);
	alias da_ig_ColorConvertRGBtoHSV		= void function(float r, float g, float b, float* out_h, float* out_s, float* out_v);
	alias da_ig_ColorConvertHSVtoRGB		= void function(float h, float s, float v, float* out_r, float* out_g, float* out_b);

	alias da_ig_GetVersion					= const char*		function();
	alias da_ig_GetInternalState			= void*			function();
	alias da_ig_GetInternalStateSize		= size_t			function();
	alias da_ig_SetInternalState			= void				function(void* state, bool construct = false);
}

//TODO: rework
extern(C) @nogc nothrow
{
	alias void function(ImFontAtlas* atlas,ubyte** out_pixels,int* out_width,int* out_height,int* out_bytes_per_pixel) da_ImFontAtlas_GetTexDataAsRGBA32;
    alias void function(ImFontAtlas* atlas, void* id) da_ImFontAtlas_SetTexID;
	alias int function(ImDrawList* list) da_ImDrawList_GetVertexBufferSize;
	alias ImDrawVert* function(ImDrawList* list, int n) da_ImDrawList_GetVertexPtr;
	alias int function(ImDrawList* list) da_ImDrawList_GetCmdSize;
	alias ImDrawCmd* function(ImDrawList* list, int n) da_ImDrawList_GetCmdPtr;
    alias void function(ushort c) da_ImGuiIO_AddInputCharacter;
}

__gshared
{
	da_ig_GetIO ig_GetIO;
	da_ig_GetStyle ig_GetStyle;
	da_ig_NewFrame ig_NewFrame;
	da_ig_Render ig_Render;
	da_ig_Shutdown ig_Shutdown;
	da_ig_ShowUserGuide ig_ShowUserGuide;
	da_ig_ShowStyleEditor ig_ShowStyleEditor;
	da_ig_ShowTestWindow ig_ShowTestWindow;
	da_ig_ShowMetricsWindow ig_ShowMetricsWindow;

	da_ig_Begin ig_Begin;
	da_ig_Begin2 ig_Begin2;
	da_ig_End ig_End;
	da_ig_BeginChild ig_BeginChild;
	da_ig_BeginChild2 ig_BeginChild2;
	da_ig_EndChild ig_EndChild;
	da_ig_GetContentRegionMax ig_GetContentRegionMax;
	da_ig_GetWindowContentRegionMin ig_GetWindowContentRegionMin;
	da_ig_GetWindowContentRegionMax ig_GetWindowContentRegionMax;
	da_ig_GetWindowDrawList ig_GetWindowDrawList;
	da_ig_GetWindowFont ig_GetWindowFont;
	da_ig_GetWindowFontSize ig_GetWindowFontSize;
	da_ig_SetWindowFontScale ig_SetWindowFontScale;
	da_ig_GetWindowPos ig_GetWindowPos;
	da_ig_GetWindowSize ig_GetWindowSize;
	da_ig_GetWindowWidth ig_GetWindowWidth;
	da_ig_GetWindowCollapsed ig_GetWindowCollapsed;

	da_ig_SetNextWindowPos ig_SetNextWindowPos;
	da_ig_SetNextWindowSize ig_SetNextWindowSize;
	da_ig_SetNextWindowCollapsed ig_SetNextWindowCollapsed;
	da_ig_SetNextWindowFocus ig_SetNextWindowFocus;
	da_ig_SetWindowPos ig_SetWindowPos;
	da_ig_SetWindowSize ig_SetWindowSize;
	da_ig_SetWindowCollapsed ig_SetWindowCollapsed;
	da_ig_SetWindowFocus ig_SetWindowFocus;
	da_ig_SetWindowPos2 ig_SetWindowPos2;
	da_ig_SetWindowSize2 ig_SetWindowSize2;
	da_ig_SetWindowCollapsed2 ig_SetWindowCollapsed2;
	da_ig_SetWindowFocus2 ig_SetWindowFocus2;
	
	da_ig_GetScrollPosY ig_GetScrollPosY;
	da_ig_GetScrollMaxY ig_GetScrollMaxY;
	da_ig_SetScrollPosHere ig_SetScrollPosHere;
	da_ig_SetKeyboardFocusHere ig_SetKeyboardFocusHere;
	da_ig_SetStateStorage ig_SetStateStorage;
	da_ig_GetStateStorage ig_GetStateStorage;

	da_ig_PushFont ig_PushFont;
	da_ig_PopFont ig_PopFont;
	da_ig_PushStyleColor ig_PushStyleColor;
	da_ig_PopStyleColor ig_PopStyleColor;
	da_ig_PushStyleVar ig_PushStyleVar;
	da_ig_PushStyleVarVec ig_PushStyleVarVec;
	da_ig_PopStyleVar ig_PopStyleVar;

	da_ig_PushItemWidth ig_PushItemWidth;
	da_ig_PopItemWidth ig_PopItemWidth;
	da_ig_CalcItemWidth ig_CalcItemWidth;
	da_ig_PushAllowKeyboardFocus ig_PushAllowKeyboardFocus;
	da_ig_PopAllowKeyboardFocus ig_PopAllowKeyboardFocus;
	da_ig_PushTextWrapPos ig_PushTextWrapPos;
	da_ig_PopTextWrapPos ig_PopTextWrapPos;

	da_ig_SetTooltip ig_SetTooltip;
	da_ig_SetTooltipV ig_SetTooltipV;
	da_ig_BeginTooltip ig_BeginTooltip;
	da_ig_EndTooltip ig_EndTooltip;

	da_ig_BeginPopup ig_BeginPopup;
	da_ig_EndPopup ig_EndPopup;

	da_ig_BeginGroup ig_BeginGroup;
	da_ig_EndGroup ig_EndGroup;
	da_ig_Separator ig_Separator;
	da_ig_SameLine ig_SameLine;
	da_ig_Spacing ig_Spacing;
	da_ig_Indent ig_Indent;
	da_ig_Unindent ig_Unindent;
	da_ig_Columns ig_Columns;
	da_ig_NextColumn ig_NextColumn;
	da_ig_GetColumnIndex ig_GetColumnIndex;
	da_ig_GetColumnOffset ig_GetColumnOffset;
	da_ig_SetColumnOffset ig_SetColumnOffset;
	da_ig_GetColumnWidth ig_GetColumnWidth;
	da_ig_GetColumnsCount ig_GetColumnsCount;
	da_ig_GetCursorPos ig_GetCursorPos;
	da_ig_GetCursorPosX ig_GetCursorPosX;
	da_ig_GetCursorPosY ig_GetCursorPosY;
	da_ig_SetCursorPos ig_SetCursorPos;
	da_ig_SetCursorPosX ig_SetCursorPosX;
	da_ig_SetCursorPosY ig_SetCursorPosY;
	da_ig_GetCursorScreenPos ig_GetCursorScreenPos;
	da_ig_SetCursorScreenPos ig_SetCursorScreenPos;
	da_ig_AlignFirstTextHeightToWidgets ig_AlignFirstTextHeightToWidgets;
	da_ig_GetTextLineHeight ig_GetTextLineHeight;
	da_ig_GetTextLineHeightWithSpacing ig_GetTextLineHeightWithSpacing;

	da_ig_PushID ig_PushID;
	da_ig_PushID2 ig_PushID2;
	da_ig_PushID3 ig_PushID3;
	da_ig_PopID ig_PopID;
	da_ig_GetID ig_GetID;
	da_ig_GetID2 ig_GetID2;

	da_ig_Text ig_Text;
	da_ig_TextV ig_TextV;
	da_ig_TextColored ig_TextColored;
	da_ig_TextColoredV ig_TextColoredV;
	da_ig_TextWrapped ig_TextWrapped;
	da_ig_TextWrappedV ig_TextWrappedV;
	da_ig_TextUnformatted ig_TextUnformatted;
	da_ig_LabelText ig_LabelText;
	da_ig_LabelTextV ig_LabelTextV;
	da_ig_Bullet ig_Bullet;
	da_ig_BulletText ig_BulletText;
	da_ig_BulletTextV ig_BulletTextV;
	da_ig_Button ig_Button;
	da_ig_SmallButton ig_SmallButton;
	da_ig_InvisibleButton ig_InvisibleButton;
	da_ig_Image ig_Image;
	da_ig_ImageButton ig_ImageButton;
	da_ig_CollapsingHeader ig_CollapsingHeader;
	da_ig_Checkbox ig_Checkbox;
	da_ig_CheckboxFlags ig_CheckboxFlags;
	da_ig_RadioButton ig_RadioButton;
	da_ig_RadioButton2 ig_RadioButton2;
	da_ig_Combo ig_Combo;
	da_ig_Combo2 ig_Combo2;
	da_ig_Combo3 ig_Combo3;
	da_ig_ColorButton ig_ColorButton;
	da_ig_ColorEdit3 ig_ColorEdit3;
	da_ig_ColorEdit4 ig_ColorEdit4;
	da_ig_ColorEditMode ig_ColorEditMode;
	da_ig_PlotLines ig_PlotLines;
	da_ig_PlotLines2 ig_PlotLines2;
	da_ig_PlotHistogram ig_PlotHistogram;
	da_ig_PlotHistogram2 ig_PlotHistogram2;

	da_ig_SliderFloat ig_SliderFloat;
	da_ig_SliderFloat2 ig_SliderFloat2;
	da_ig_SliderFloat3 ig_SliderFloat3;
	da_ig_SliderFloat4 ig_SliderFloat4;
	da_ig_SliderAngle ig_SliderAngle;
	da_ig_SliderInt ig_SliderInt;
	da_ig_SliderInt2 ig_SliderInt2;
	da_ig_SliderInt3 ig_SliderInt3;
	da_ig_SliderInt4 ig_SliderInt4;
	da_ig_VSliderFloat ig_VSliderFloat;
	da_ig_VSliderInt ig_VSliderInt;

	da_ig_DragFloat ig_DragFloat;
	da_ig_DragInt ig_DragInt;

	da_ig_InputText ig_InputText;
	da_ig_InputFloat ig_InputFloat;
	da_ig_InputFloat2 ig_InputFloat2;
	da_ig_InputFloat3 ig_InputFloat3;
	da_ig_InputFloat4 ig_InputFloat4;
	da_ig_InputInt ig_InputInt;
	da_ig_InputInt2 ig_InputInt2;
	da_ig_InputInt3 ig_InputInt3;
	da_ig_InputInt4 ig_InputInt4;
			
	da_ig_TreeNode ig_TreeNode;
	da_ig_TreeNode2 ig_TreeNode2;
	da_ig_TreeNode3 ig_TreeNode3;
	da_ig_TreeNodeV ig_TreeNodeV;
	da_ig_TreeNodeV2 ig_TreeNodeV2;
	da_ig_TreePush ig_TreePush;
	da_ig_TreePush2 ig_TreePush2;
	da_ig_TreePop ig_TreePop;
	da_ig_SetNextTreeNodeOpened ig_SetNextTreeNodeOpened;

	da_ig_Selectable ig_Selectable;
	da_ig_Selectable2 ig_Selectable2;
	da_ig_ListBox ig_ListBox;
	da_ig_ListBox2 ig_ListBox2;
	da_ig_ListBoxHeader ig_ListBoxHeader;
	da_ig_ListBoxHeader2 ig_ListBoxHeader2;
	da_ig_ListBoxFooter ig_ListBoxFooter;

	da_ig_Value ig_Value;
	da_ig_Value2 ig_Value2;
	da_ig_Value3 ig_Value3;
	da_ig_Value4 ig_Value4;
	da_ig_Color ig_Color;
	da_ig_Color2 ig_Color2;

	da_ig_LogToTTY ig_LogToTTY;
	da_ig_LogToFile ig_LogToFile;
	da_ig_LogToClipboard ig_LogToClipboard;
	da_ig_LogFinish ig_LogFinish;
	da_ig_LogButtons ig_LogButtons;
	da_ig_LogText ig_LogText;

	da_ig_IsItemHovered ig_IsItemHovered;
	da_ig_IsItemHoveredRect ig_IsItemHoveredRect;
	da_ig_IsItemActive ig_IsItemActive;
	da_ig_IsAnyItemActive ig_IsAnyItemActive;
	da_ig_GetItemRectMin ig_GetItemRectMin;
	da_ig_GetItemRectMax ig_GetItemRectMax;
	da_ig_GetItemRectSize ig_GetItemRectSize;
	da_ig_IsWindowFocused ig_IsWindowFocused;
	da_ig_IsRootWindowFocused ig_IsRootWindowFocused;
	da_ig_IsRootWindowOrAnyChildFocused ig_IsRootWindowOrAnyChildFocused;
	da_ig_IsClipped ig_IsClipped;
	da_ig_IsKeyPressed ig_IsKeyPressed;
	da_ig_IsMouseClicked ig_IsMouseClicked;
	da_ig_IsMouseDoubleClicked ig_IsMouseDoubleClicked;
	da_ig_IsMouseHoveringWindow ig_IsMouseHoveringWindow;
	da_ig_IsMouseHoveringAnyWindow ig_IsMouseHoveringAnyWindow;
	da_ig_IsMouseHoveringRect ig_IsMouseHoveringRect;
	da_ig_IsMouseDragging ig_IsMouseDragging;
	da_ig_IsPosHoveringAnyWindow ig_IsPosHoveringAnyWindow;
	da_ig_GetMousePos ig_GetMousePos;
	da_ig_GetMouseDragDelta ig_GetMouseDragDelta;
	da_ig_GetMouseCursor ig_GetMouseCursor;
	da_ig_SetMouseCursor ig_SetMouseCursor;
	da_ig_GetTime ig_GetTime;
	da_ig_GetFrameCount ig_GetFrameCount;
	da_ig_GetStyleColName ig_GetStyleColName;
	da_ig_CalcItemRectClosestPoint ig_CalcItemRectClosestPoint;
	da_ig_CalcTextSize ig_CalcTextSize;
	da_ig_CalcListClipping ig_CalcListClipping;

	da_ig_BeginChildFrame ig_BeginChildFrame;
	da_ig_EndChildFrame ig_EndChildFrame;

	da_ig_ColorConvertFloat4ToU32 ig_ColorConvertFloat4ToU32;
	da_ig_ColorConvertRGBtoHSV ig_ColorConvertRGBtoHSV;
	da_ig_ColorConvertHSVtoRGB ig_ColorConvertHSVtoRGB;

	da_ig_GetVersion ig_GetVersion;
	da_ig_GetInternalState ig_GetInternalState;
	da_ig_GetInternalStateSize ig_GetInternalStateSize;
	da_ig_SetInternalState ig_SetInternalState;
}

//TODO: rework
__gshared
{
	da_ImFontAtlas_GetTexDataAsRGBA32 ImFontAtlas_GetTexDataAsRGBA32;
    da_ImFontAtlas_SetTexID ImFontAtlas_SetTexID;

	da_ImDrawList_GetVertexBufferSize ImDrawList_GetVertexBufferSize;
	da_ImDrawList_GetVertexPtr ImDrawList_GetVertexPtr;
	da_ImDrawList_GetCmdSize ImDrawList_GetCmdSize;
	da_ImDrawList_GetCmdPtr ImDrawList_GetCmdPtr;

    da_ImGuiIO_AddInputCharacter ImGuiIO_AddInputCharacter;
}


  

