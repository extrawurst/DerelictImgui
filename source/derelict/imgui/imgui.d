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
module derelict.imgui.imgui;

public
{
	import derelict.imgui.types;
	import derelict.imgui.funcs;
}

private
{
    import derelict.util.loader;

    version(darwin)
        version = MacOSX;
    version(OSX)
        version = MacOSX;
}

private
{
    import derelict.util.loader;
    import derelict.util.system;

    static if(Derelict_OS_Windows)
        enum libNames = "cimgui.dll";    
    else static if (Derelict_OS_Mac)
        enum libNames = "cimgui.dylib";
    else static if (Derelict_OS_Linux)
		enum libNames = "cimgui.so";
    else
        static assert(0, "Need to implement imgui libNames for this operating system.");
}

class DerelictImguiLoader : SharedLibLoader
{

    protected
    {
        override void loadSymbols()
        {
			{
				//search: (ig_\S+)
				//replace: bindFunc\(cast\(void**\)&$1, "$1"\);
			
				bindFunc(cast(void**)&ig_GetIO, "ig_GetIO");
				bindFunc(cast(void**)&ig_GetStyle, "ig_GetStyle");
				bindFunc(cast(void**)&ig_NewFrame, "ig_NewFrame");
				bindFunc(cast(void**)&ig_Render, "ig_Render");
				bindFunc(cast(void**)&ig_Shutdown, "ig_Shutdown");
				bindFunc(cast(void**)&ig_ShowUserGuide, "ig_ShowUserGuide");
				bindFunc(cast(void**)&ig_ShowStyleEditor, "ig_ShowStyleEditor");
				bindFunc(cast(void**)&ig_ShowTestWindow, "ig_ShowTestWindow");
				bindFunc(cast(void**)&ig_ShowMetricsWindow, "ig_ShowMetricsWindow");

				// Window
				bindFunc(cast(void**)&ig_Begin, "ig_Begin");
				bindFunc(cast(void**)&ig_Begin2, "ig_Begin2");
				bindFunc(cast(void**)&ig_End, "ig_End");
				bindFunc(cast(void**)&ig_BeginChild, "ig_BeginChild");
				bindFunc(cast(void**)&ig_BeginChild2, "ig_BeginChild2");
				bindFunc(cast(void**)&ig_EndChild, "ig_EndChild");
				bindFunc(cast(void**)&ig_GetContentRegionMax, "ig_GetContentRegionMax");
				bindFunc(cast(void**)&ig_GetWindowContentRegionMin, "ig_GetWindowContentRegionMin");
				bindFunc(cast(void**)&ig_GetWindowContentRegionMax, "ig_GetWindowContentRegionMax");
				bindFunc(cast(void**)&ig_GetWindowDrawList, "ig_GetWindowDrawList");
				bindFunc(cast(void**)&ig_GetWindowFont, "ig_GetWindowFont");
				bindFunc(cast(void**)&ig_GetWindowFontSize, "ig_GetWindowFontSize");
				bindFunc(cast(void**)&ig_SetWindowFontScale, "ig_SetWindowFontScale");
				bindFunc(cast(void**)&ig_GetWindowPos, "ig_GetWindowPos");
				bindFunc(cast(void**)&ig_GetWindowSize, "ig_GetWindowSize");
				bindFunc(cast(void**)&ig_GetWindowWidth, "ig_GetWindowWidth");
				bindFunc(cast(void**)&ig_GetWindowCollapsed, "ig_GetWindowCollapsed");

				bindFunc(cast(void**)&ig_SetNextWindowPos, "ig_SetNextWindowPos");
				bindFunc(cast(void**)&ig_SetNextWindowSize, "ig_SetNextWindowSize");
				bindFunc(cast(void**)&ig_SetNextWindowCollapsed, "ig_SetNextWindowCollapsed");
				bindFunc(cast(void**)&ig_SetNextWindowFocus, "ig_SetNextWindowFocus");
				bindFunc(cast(void**)&ig_SetWindowPos, "ig_SetWindowPos");
				bindFunc(cast(void**)&ig_SetWindowSize, "ig_SetWindowSize");
				bindFunc(cast(void**)&ig_SetWindowCollapsed, "ig_SetWindowCollapsed");
				bindFunc(cast(void**)&ig_SetWindowFocus, "ig_SetWindowFocus");
				bindFunc(cast(void**)&ig_SetWindowPos2, "ig_SetWindowPos2");
				bindFunc(cast(void**)&ig_SetWindowSize2, "ig_SetWindowSize2");
				bindFunc(cast(void**)&ig_SetWindowCollapsed2, "ig_SetWindowCollapsed2");
				bindFunc(cast(void**)&ig_SetWindowFocus2, "ig_SetWindowFocus2");
				
				bindFunc(cast(void**)&ig_GetScrollPosY, "ig_GetScrollPosY");
				bindFunc(cast(void**)&ig_GetScrollMaxY, "ig_GetScrollMaxY");
				bindFunc(cast(void**)&ig_SetScrollPosHere, "ig_SetScrollPosHere");
				bindFunc(cast(void**)&ig_SetKeyboardFocusHere, "ig_SetKeyboardFocusHere");
				bindFunc(cast(void**)&ig_SetStateStorage, "ig_SetStateStorage");
				bindFunc(cast(void**)&ig_GetStateStorage, "ig_GetStateStorage");

				bindFunc(cast(void**)&ig_PushFont, "ig_PushFont");
				bindFunc(cast(void**)&ig_PopFont, "ig_PopFont");
				bindFunc(cast(void**)&ig_PushStyleColor, "ig_PushStyleColor");
				bindFunc(cast(void**)&ig_PopStyleColor, "ig_PopStyleColor");
				bindFunc(cast(void**)&ig_PushStyleVar, "ig_PushStyleVar");
				bindFunc(cast(void**)&ig_PushStyleVarVec, "ig_PushStyleVarVec");
				bindFunc(cast(void**)&ig_PopStyleVar, "ig_PopStyleVar");

				bindFunc(cast(void**)&ig_PushItemWidth, "ig_PushItemWidth");
				bindFunc(cast(void**)&ig_PopItemWidth, "ig_PopItemWidth");
				bindFunc(cast(void**)&ig_CalcItemWidth, "ig_CalcItemWidth");
				bindFunc(cast(void**)&ig_PushAllowKeyboardFocus, "ig_PushAllowKeyboardFocus");
				bindFunc(cast(void**)&ig_PopAllowKeyboardFocus, "ig_PopAllowKeyboardFocus");
				bindFunc(cast(void**)&ig_PushTextWrapPos, "ig_PushTextWrapPos");
				bindFunc(cast(void**)&ig_PopTextWrapPos, "ig_PopTextWrapPos");

				bindFunc(cast(void**)&ig_SetTooltip, "ig_SetTooltip");
				bindFunc(cast(void**)&ig_SetTooltipV, "ig_SetTooltipV");
				bindFunc(cast(void**)&ig_BeginTooltip, "ig_BeginTooltip");
				bindFunc(cast(void**)&ig_EndTooltip, "ig_EndTooltip");

				bindFunc(cast(void**)&ig_BeginPopup, "ig_BeginPopup");
				bindFunc(cast(void**)&ig_EndPopup, "ig_EndPopup");

				bindFunc(cast(void**)&ig_BeginGroup, "ig_BeginGroup");
				bindFunc(cast(void**)&ig_EndGroup, "ig_EndGroup");
				bindFunc(cast(void**)&ig_Separator, "ig_Separator");
				bindFunc(cast(void**)&ig_SameLine, "ig_SameLine");
				bindFunc(cast(void**)&ig_Spacing, "ig_Spacing");
				bindFunc(cast(void**)&ig_Indent, "ig_Indent");
				bindFunc(cast(void**)&ig_Unindent, "ig_Unindent");
				bindFunc(cast(void**)&ig_Columns, "ig_Columns");
				bindFunc(cast(void**)&ig_NextColumn, "ig_NextColumn");
				bindFunc(cast(void**)&ig_GetColumnIndex, "ig_GetColumnIndex");
				bindFunc(cast(void**)&ig_GetColumnOffset, "ig_GetColumnOffset");
				bindFunc(cast(void**)&ig_SetColumnOffset, "ig_SetColumnOffset");
				bindFunc(cast(void**)&ig_GetColumnWidth, "ig_GetColumnWidth");
				bindFunc(cast(void**)&ig_GetColumnsCount, "ig_GetColumnsCount");
				bindFunc(cast(void**)&ig_GetCursorPos, "ig_GetCursorPos");
				bindFunc(cast(void**)&ig_GetCursorPosX, "ig_GetCursorPosX");
				bindFunc(cast(void**)&ig_GetCursorPosY, "ig_GetCursorPosY");
				bindFunc(cast(void**)&ig_SetCursorPos, "ig_SetCursorPos");
				bindFunc(cast(void**)&ig_SetCursorPosX, "ig_SetCursorPosX");
				bindFunc(cast(void**)&ig_SetCursorPosY, "ig_SetCursorPosY");
				bindFunc(cast(void**)&ig_GetCursorScreenPos, "ig_GetCursorScreenPos");
				bindFunc(cast(void**)&ig_SetCursorScreenPos, "ig_SetCursorScreenPos");
				bindFunc(cast(void**)&ig_AlignFirstTextHeightToWidgets, "ig_AlignFirstTextHeightToWidgets");
				bindFunc(cast(void**)&ig_GetTextLineHeight, "ig_GetTextLineHeight");
				bindFunc(cast(void**)&ig_GetTextLineHeightWithSpacing, "ig_GetTextLineHeightWithSpacing");

				bindFunc(cast(void**)&ig_PushID, "ig_PushID");
				bindFunc(cast(void**)&ig_PushID2, "ig_PushID2");
				bindFunc(cast(void**)&ig_PushID3, "ig_PushID3");
				bindFunc(cast(void**)&ig_PopID, "ig_PopID");
				bindFunc(cast(void**)&ig_GetID, "ig_GetID");
				bindFunc(cast(void**)&ig_GetID2, "ig_GetID2");

				bindFunc(cast(void**)&ig_Text, "ig_Text");
				bindFunc(cast(void**)&ig_TextV, "ig_TextV");
				bindFunc(cast(void**)&ig_TextColored, "ig_TextColored");
				bindFunc(cast(void**)&ig_TextColoredV, "ig_TextColoredV");
				bindFunc(cast(void**)&ig_TextWrapped, "ig_TextWrapped");
				bindFunc(cast(void**)&ig_TextWrappedV, "ig_TextWrappedV");
				bindFunc(cast(void**)&ig_TextUnformatted, "ig_TextUnformatted");
				bindFunc(cast(void**)&ig_LabelText, "ig_LabelText");
				bindFunc(cast(void**)&ig_LabelTextV, "ig_LabelTextV");
				bindFunc(cast(void**)&ig_Bullet, "ig_Bullet");
				bindFunc(cast(void**)&ig_BulletText, "ig_BulletText");
				bindFunc(cast(void**)&ig_BulletTextV, "ig_BulletTextV");
				bindFunc(cast(void**)&ig_Button, "ig_Button");
				bindFunc(cast(void**)&ig_SmallButton, "ig_SmallButton");
				bindFunc(cast(void**)&ig_InvisibleButton, "ig_InvisibleButton");
				bindFunc(cast(void**)&ig_Image, "ig_Image");
				bindFunc(cast(void**)&ig_ImageButton, "ig_ImageButton");
				bindFunc(cast(void**)&ig_CollapsingHeader, "ig_CollapsingHeader");
				bindFunc(cast(void**)&ig_Checkbox, "ig_Checkbox");
				bindFunc(cast(void**)&ig_CheckboxFlags, "ig_CheckboxFlags");
				bindFunc(cast(void**)&ig_RadioButton, "ig_RadioButton");
				bindFunc(cast(void**)&ig_RadioButton2, "ig_RadioButton2");
				bindFunc(cast(void**)&ig_Combo, "ig_Combo");
				bindFunc(cast(void**)&ig_Combo2, "ig_Combo2");
				bindFunc(cast(void**)&ig_Combo3, "ig_Combo3");
				bindFunc(cast(void**)&ig_ColorButton, "ig_ColorButton");
				bindFunc(cast(void**)&ig_ColorEdit3, "ig_ColorEdit3");
				bindFunc(cast(void**)&ig_ColorEdit4, "ig_ColorEdit4");
				bindFunc(cast(void**)&ig_ColorEditMode, "ig_ColorEditMode");
				bindFunc(cast(void**)&ig_PlotLines, "ig_PlotLines");
				bindFunc(cast(void**)&ig_PlotLines2, "ig_PlotLines2");
				bindFunc(cast(void**)&ig_PlotHistogram, "ig_PlotHistogram");
				bindFunc(cast(void**)&ig_PlotHistogram2, "ig_PlotHistogram2");

				bindFunc(cast(void**)&ig_SliderFloat, "ig_SliderFloat");
				bindFunc(cast(void**)&ig_SliderFloat2, "ig_SliderFloat2");
				bindFunc(cast(void**)&ig_SliderFloat3, "ig_SliderFloat3");
				bindFunc(cast(void**)&ig_SliderFloat4, "ig_SliderFloat4");
				bindFunc(cast(void**)&ig_SliderAngle, "ig_SliderAngle");
				bindFunc(cast(void**)&ig_SliderInt, "ig_SliderInt");
				bindFunc(cast(void**)&ig_SliderInt2, "ig_SliderInt2");
				bindFunc(cast(void**)&ig_SliderInt3, "ig_SliderInt3");
				bindFunc(cast(void**)&ig_SliderInt4, "ig_SliderInt4");
				bindFunc(cast(void**)&ig_VSliderFloat, "ig_VSliderFloat");
				bindFunc(cast(void**)&ig_VSliderInt, "ig_VSliderInt");

				bindFunc(cast(void**)&ig_DragFloat, "ig_DragFloat");
				bindFunc(cast(void**)&ig_DragInt, "ig_DragInt");

				bindFunc(cast(void**)&ig_InputText, "ig_InputText");
				bindFunc(cast(void**)&ig_InputFloat, "ig_InputFloat");
				bindFunc(cast(void**)&ig_InputFloat2, "ig_InputFloat2");
				bindFunc(cast(void**)&ig_InputFloat3, "ig_InputFloat3");
				bindFunc(cast(void**)&ig_InputFloat4, "ig_InputFloat4");
				bindFunc(cast(void**)&ig_InputInt, "ig_InputInt");
				bindFunc(cast(void**)&ig_InputInt2, "ig_InputInt2");
				bindFunc(cast(void**)&ig_InputInt3, "ig_InputInt3");
				bindFunc(cast(void**)&ig_InputInt4, "ig_InputInt4");
			
				bindFunc(cast(void**)&ig_TreeNode, "ig_TreeNode");
				bindFunc(cast(void**)&ig_TreeNode2, "ig_TreeNode2");
				bindFunc(cast(void**)&ig_TreeNode3, "ig_TreeNode3");
				bindFunc(cast(void**)&ig_TreeNodeV, "ig_TreeNodeV");
				bindFunc(cast(void**)&ig_TreeNodeV2, "ig_TreeNodeV2");
				bindFunc(cast(void**)&ig_TreePush, "ig_TreePush");
				bindFunc(cast(void**)&ig_TreePush2, "ig_TreePush2");
				bindFunc(cast(void**)&ig_TreePop, "ig_TreePop");
				bindFunc(cast(void**)&ig_SetNextTreeNodeOpened, "ig_SetNextTreeNodeOpened");

				bindFunc(cast(void**)&ig_Selectable, "ig_Selectable");
				bindFunc(cast(void**)&ig_Selectable2, "ig_Selectable2");
				bindFunc(cast(void**)&ig_ListBox, "ig_ListBox");
				bindFunc(cast(void**)&ig_ListBox2, "ig_ListBox2");
				bindFunc(cast(void**)&ig_ListBoxHeader, "ig_ListBoxHeader");
				bindFunc(cast(void**)&ig_ListBoxHeader2, "ig_ListBoxHeader2");
				bindFunc(cast(void**)&ig_ListBoxFooter, "ig_ListBoxFooter");

				bindFunc(cast(void**)&ig_Value, "ig_Value");
				bindFunc(cast(void**)&ig_Value2, "ig_Value2");
				bindFunc(cast(void**)&ig_Value3, "ig_Value3");
				bindFunc(cast(void**)&ig_Value4, "ig_Value4");
				bindFunc(cast(void**)&ig_Color, "ig_Color");
				bindFunc(cast(void**)&ig_Color2, "ig_Color2");

				bindFunc(cast(void**)&ig_LogToTTY, "ig_LogToTTY");
				bindFunc(cast(void**)&ig_LogToFile, "ig_LogToFile");
				bindFunc(cast(void**)&ig_LogToClipboard, "ig_LogToClipboard");
				bindFunc(cast(void**)&ig_LogFinish, "ig_LogFinish");
				bindFunc(cast(void**)&ig_LogButtons, "ig_LogButtons");
				bindFunc(cast(void**)&ig_LogText, "ig_LogText");

				bindFunc(cast(void**)&ig_IsItemHovered, "ig_IsItemHovered");
				bindFunc(cast(void**)&ig_IsItemHoveredRect, "ig_IsItemHoveredRect");
				bindFunc(cast(void**)&ig_IsItemActive, "ig_IsItemActive");
				bindFunc(cast(void**)&ig_IsAnyItemActive, "ig_IsAnyItemActive");
				bindFunc(cast(void**)&ig_GetItemRectMin, "ig_GetItemRectMin");
				bindFunc(cast(void**)&ig_GetItemRectMax, "ig_GetItemRectMax");
				bindFunc(cast(void**)&ig_GetItemRectSize, "ig_GetItemRectSize");
				bindFunc(cast(void**)&ig_IsWindowFocused, "ig_IsWindowFocused");
				bindFunc(cast(void**)&ig_IsRootWindowFocused, "ig_IsRootWindowFocused");
				bindFunc(cast(void**)&ig_IsRootWindowOrAnyChildFocused, "ig_IsRootWindowOrAnyChildFocused");
				bindFunc(cast(void**)&ig_IsClipped, "ig_IsClipped");
				bindFunc(cast(void**)&ig_IsKeyPressed, "ig_IsKeyPressed");
				bindFunc(cast(void**)&ig_IsMouseClicked, "ig_IsMouseClicked");
				bindFunc(cast(void**)&ig_IsMouseDoubleClicked, "ig_IsMouseDoubleClicked");
				bindFunc(cast(void**)&ig_IsMouseHoveringWindow, "ig_IsMouseHoveringWindow");
				bindFunc(cast(void**)&ig_IsMouseHoveringAnyWindow, "ig_IsMouseHoveringAnyWindow");
				bindFunc(cast(void**)&ig_IsMouseHoveringRect, "ig_IsMouseHoveringRect");
				bindFunc(cast(void**)&ig_IsMouseDragging, "ig_IsMouseDragging");
				bindFunc(cast(void**)&ig_IsPosHoveringAnyWindow, "ig_IsPosHoveringAnyWindow");
				bindFunc(cast(void**)&ig_GetMousePos, "ig_GetMousePos");
				bindFunc(cast(void**)&ig_GetMouseDragDelta, "ig_GetMouseDragDelta");
				bindFunc(cast(void**)&ig_GetMouseCursor, "ig_GetMouseCursor");
				bindFunc(cast(void**)&ig_SetMouseCursor, "ig_SetMouseCursor");
				bindFunc(cast(void**)&ig_GetTime, "ig_GetTime");
				bindFunc(cast(void**)&ig_GetFrameCount, "ig_GetFrameCount");
				bindFunc(cast(void**)&ig_GetStyleColName, "ig_GetStyleColName");
				bindFunc(cast(void**)&ig_CalcItemRectClosestPoint, "ig_CalcItemRectClosestPoint");
				bindFunc(cast(void**)&ig_CalcTextSize, "ig_CalcTextSize");
				bindFunc(cast(void**)&ig_CalcListClipping, "ig_CalcListClipping");

				bindFunc(cast(void**)&ig_BeginChildFrame, "ig_BeginChildFrame");
				bindFunc(cast(void**)&ig_EndChildFrame, "ig_EndChildFrame");

				bindFunc(cast(void**)&ig_ColorConvertFloat4ToU32, "ig_ColorConvertFloat4ToU32");
				bindFunc(cast(void**)&ig_ColorConvertRGBtoHSV, "ig_ColorConvertRGBtoHSV");
				bindFunc(cast(void**)&ig_ColorConvertHSVtoRGB, "ig_ColorConvertHSVtoRGB");

				bindFunc(cast(void**)&ig_GetVersion, "ig_GetVersion");
				bindFunc(cast(void**)&ig_GetInternalState, "ig_GetInternalState");
				bindFunc(cast(void**)&ig_GetInternalStateSize, "ig_GetInternalStateSize");
				bindFunc(cast(void**)&ig_SetInternalState, "ig_SetInternalState");
			}

			bindFunc(cast(void**)&ImFontAtlas_GetTexDataAsRGBA32, "ImFontAtlas_GetTexDataAsRGBA32");
            bindFunc(cast(void**)&ImFontAtlas_SetTexID, "ImFontAtlas_SetTexID");
			bindFunc(cast(void**)&ImDrawList_GetVertexBufferSize, "ImDrawList_GetVertexBufferSize");
			bindFunc(cast(void**)&ImDrawList_GetVertexPtr, "ImDrawList_GetVertexPtr");
			bindFunc(cast(void**)&ImDrawList_GetCmdSize, "ImDrawList_GetCmdSize");
			bindFunc(cast(void**)&ImDrawList_GetCmdPtr, "ImDrawList_GetCmdPtr");
            bindFunc(cast(void**)&ImGuiIO_AddInputCharacter, "ImGuiIO_AddInputCharacter");
        }
    }

    public
    {
        this()
        {
            super(libNames);
        }
    }
}

__gshared DerelictImguiLoader DerelictImgui;

shared static this()
{
	DerelictImgui = new DerelictImguiLoader();
}
