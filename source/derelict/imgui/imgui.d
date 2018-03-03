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

final class DerelictImguiLoader : SharedLibLoader
{
    protected
    {
        override void loadSymbols()
        {
            //search: (ig\S+)
            //replace: bindFunc\(cast\(void**\)&$1, "$1"\);

            bindFunc(cast(void**)&igGetIO, "igGetIO");
            bindFunc(cast(void**)&igGetStyle, "igGetStyle");
            bindFunc(cast(void**)&igGetDrawData, "igGetDrawData");
            bindFunc(cast(void**)&igNewFrame, "igNewFrame");
            bindFunc(cast(void**)&igRender, "igRender");
            bindFunc(cast(void**)&igShutdown, "igShutdown");
            bindFunc(cast(void**)&igShowDemoWindow, "igShowDemoWindow");
            bindFunc(cast(void**)&igShowMetricsWindow, "igShowMetricsWindow");
            bindFunc(cast(void**)&igShowStyleEditor, "igShowStyleEditor");
            bindFunc(cast(void**)&igShowStyleSelector, "igShowStyleSelector");
            bindFunc(cast(void**)&igShowFontSelector, "igShowFontSelector");
            bindFunc(cast(void**)&igShowUserGuide, "igShowUserGuide");
            bindFunc(cast(void**)&igBegin, "igBegin");
            bindFunc(cast(void**)&igEnd, "igEnd");
            bindFunc(cast(void**)&igBeginChild, "igBeginChild");
            bindFunc(cast(void**)&igBeginChildEx, "igBeginChildEx");
            bindFunc(cast(void**)&igEndChild, "igEndChild");
            bindFunc(cast(void**)&igGetContentRegionMax, "igGetContentRegionMax");
            bindFunc(cast(void**)&igGetContentRegionAvail, "igGetContentRegionAvail");
            bindFunc(cast(void**)&igGetContentRegionAvailWidth, "igGetContentRegionAvailWidth");
            bindFunc(cast(void**)&igGetWindowContentRegionMin, "igGetWindowContentRegionMin");
            bindFunc(cast(void**)&igGetWindowContentRegionMax, "igGetWindowContentRegionMax");
            bindFunc(cast(void**)&igGetWindowContentRegionWidth, "igGetWindowContentRegionWidth");
            bindFunc(cast(void**)&igGetWindowDrawList, "igGetWindowDrawList");
            bindFunc(cast(void**)&igGetWindowPos, "igGetWindowPos");
            bindFunc(cast(void**)&igGetWindowSize, "igGetWindowSize");
            bindFunc(cast(void**)&igGetWindowWidth, "igGetWindowWidth");
            bindFunc(cast(void**)&igGetWindowHeight, "igGetWindowHeight");
            bindFunc(cast(void**)&igIsWindowCollapsed, "igIsWindowCollapsed");
            bindFunc(cast(void**)&igSetWindowFontScale, "igSetWindowFontScale");
            bindFunc(cast(void**)&igSetNextWindowPos, "igSetNextWindowPos");
            bindFunc(cast(void**)&igSetNextWindowSize, "igSetNextWindowSize");
            bindFunc(cast(void**)&igSetNextWindowSizeConstraints, "igSetNextWindowSizeConstraints");
            bindFunc(cast(void**)&igSetNextWindowContentSize, "igSetNextWindowContentSize");
            bindFunc(cast(void**)&igSetNextWindowCollapsed, "igSetNextWindowCollapsed");
            bindFunc(cast(void**)&igSetNextWindowFocus, "igSetNextWindowFocus");
            bindFunc(cast(void**)&igSetWindowPos, "igSetWindowPos");
            bindFunc(cast(void**)&igSetWindowSize, "igSetWindowSize");
            bindFunc(cast(void**)&igSetWindowCollapsed, "igSetWindowCollapsed");
            bindFunc(cast(void**)&igSetWindowFocus, "igSetWindowFocus");
            bindFunc(cast(void**)&igSetWindowPosByName, "igSetWindowPosByName");
            bindFunc(cast(void**)&igSetWindowSize2, "igSetWindowSize2");
            bindFunc(cast(void**)&igSetWindowCollapsed2, "igSetWindowCollapsed2");
            bindFunc(cast(void**)&igSetWindowFocus2, "igSetWindowFocus2");
            bindFunc(cast(void**)&igGetScrollX, "igGetScrollX");
            bindFunc(cast(void**)&igGetScrollY, "igGetScrollY");
            bindFunc(cast(void**)&igGetScrollMaxX, "igGetScrollMaxX");
            bindFunc(cast(void**)&igGetScrollMaxY, "igGetScrollMaxY");
            bindFunc(cast(void**)&igSetScrollX, "igSetScrollX");
            bindFunc(cast(void**)&igSetScrollY, "igSetScrollY");
            bindFunc(cast(void**)&igSetScrollHere, "igSetScrollHere");
            bindFunc(cast(void**)&igSetScrollFromPosY, "igSetScrollFromPosY");
            bindFunc(cast(void**)&igSetKeyboardFocusHere, "igSetKeyboardFocusHere");
            bindFunc(cast(void**)&igSetStateStorage, "igSetStateStorage");
            bindFunc(cast(void**)&igGetStateStorage, "igGetStateStorage");
            bindFunc(cast(void**)&igPushFont, "igPushFont");
            bindFunc(cast(void**)&igPopFont, "igPopFont");
            bindFunc(cast(void**)&igPushStyleColorU32, "igPushStyleColorU32");
            bindFunc(cast(void**)&igPushStyleColor, "igPushStyleColor");
            bindFunc(cast(void**)&igPopStyleColor, "igPopStyleColor");
            bindFunc(cast(void**)&igPushStyleVar, "igPushStyleVar");
            bindFunc(cast(void**)&igPushStyleVarVec, "igPushStyleVarVec");
            bindFunc(cast(void**)&igPopStyleVar, "igPopStyleVar");
            bindFunc(cast(void**)&igGetStyleColorVec4, "igGetStyleColorVec4");
            bindFunc(cast(void**)&igGetFont, "igGetFont");
            bindFunc(cast(void**)&igGetFontSize, "igGetFontSize");
            bindFunc(cast(void**)&igGetFontTexUvWhitePixel, "igGetFontTexUvWhitePixel");
            bindFunc(cast(void**)&igGetColorU32, "igGetColorU32");
            bindFunc(cast(void**)&igGetColorU32Vec, "igGetColorU32Vec");
            bindFunc(cast(void**)&igGetColorU32U32, "igGetColorU32U32");
            bindFunc(cast(void**)&igPushItemWidth, "igPushItemWidth");
            bindFunc(cast(void**)&igPopItemWidth, "igPopItemWidth");
            bindFunc(cast(void**)&igCalcItemWidth, "igCalcItemWidth");
            bindFunc(cast(void**)&igPushTextWrapPos, "igPushTextWrapPos");
            bindFunc(cast(void**)&igPopTextWrapPos, "igPopTextWrapPos");
            bindFunc(cast(void**)&igPushAllowKeyboardFocus, "igPushAllowKeyboardFocus");
            bindFunc(cast(void**)&igPopAllowKeyboardFocus, "igPopAllowKeyboardFocus");
            bindFunc(cast(void**)&igPushButtonRepeat, "igPushButtonRepeat");
            bindFunc(cast(void**)&igPopButtonRepeat, "igPopButtonRepeat");
            bindFunc(cast(void**)&igSeparator, "igSeparator");
            bindFunc(cast(void**)&igSameLine, "igSameLine");
            bindFunc(cast(void**)&igNewLine, "igNewLine");
            bindFunc(cast(void**)&igSpacing, "igSpacing");
            bindFunc(cast(void**)&igDummy, "igDummy");
            bindFunc(cast(void**)&igIndent, "igIndent");
            bindFunc(cast(void**)&igUnindent, "igUnindent");
            bindFunc(cast(void**)&igBeginGroup, "igBeginGroup");
            bindFunc(cast(void**)&igEndGroup, "igEndGroup");
            bindFunc(cast(void**)&igGetCursorPos, "igGetCursorPos");
            bindFunc(cast(void**)&igGetCursorPosX, "igGetCursorPosX");
            bindFunc(cast(void**)&igGetCursorPosY, "igGetCursorPosY");
            bindFunc(cast(void**)&igSetCursorPos, "igSetCursorPos");
            bindFunc(cast(void**)&igSetCursorPosX, "igSetCursorPosX");
            bindFunc(cast(void**)&igSetCursorPosY, "igSetCursorPosY");
            bindFunc(cast(void**)&igGetCursorStartPos, "igGetCursorStartPos");
            bindFunc(cast(void**)&igGetCursorScreenPos, "igGetCursorScreenPos");
            bindFunc(cast(void**)&igSetCursorScreenPos, "igSetCursorScreenPos");
            bindFunc(cast(void**)&igAlignTextToFramePadding, "igAlignTextToFramePadding");
            bindFunc(cast(void**)&igGetTextLineHeight, "igGetTextLineHeight");
            bindFunc(cast(void**)&igGetTextLineHeightWithSpacing, "igGetTextLineHeightWithSpacing");
            bindFunc(cast(void**)&igGetFrameHeightWithSpacing, "igGetFrameHeightWithSpacing");
            bindFunc(cast(void**)&igColumns, "igColumns");
            bindFunc(cast(void**)&igNextColumn, "igNextColumn");
            bindFunc(cast(void**)&igGetColumnIndex, "igGetColumnIndex");
            bindFunc(cast(void**)&igGetColumnWidth, "igGetColumnWidth");
            bindFunc(cast(void**)&igSetColumnWidth, "igSetColumnWidth");
            bindFunc(cast(void**)&igGetColumnOffset, "igGetColumnOffset");
            bindFunc(cast(void**)&igSetColumnOffset, "igSetColumnOffset");
            bindFunc(cast(void**)&igGetColumnsCount, "igGetColumnsCount");
            bindFunc(cast(void**)&igPushIDStr, "igPushIDStr");
            bindFunc(cast(void**)&igPushIDStrRange, "igPushIDStrRange");
            bindFunc(cast(void**)&igPushIDPtr, "igPushIDPtr");
            bindFunc(cast(void**)&igPushIDInt, "igPushIDInt");
            bindFunc(cast(void**)&igPopID, "igPopID");
            bindFunc(cast(void**)&igGetIDStr, "igGetIDStr");
            bindFunc(cast(void**)&igGetIDStrRange, "igGetIDStrRange");
            bindFunc(cast(void**)&igGetIDPtr, "igGetIDPtr");
            bindFunc(cast(void**)&igText, "igText");
            bindFunc(cast(void**)&igTextV, "igTextV");
            bindFunc(cast(void**)&igTextColored, "igTextColored");
            bindFunc(cast(void**)&igTextColoredV, "igTextColoredV");
            bindFunc(cast(void**)&igTextDisabled, "igTextDisabled");
            bindFunc(cast(void**)&igTextDisabledV, "igTextDisabledV");
            bindFunc(cast(void**)&igTextWrapped, "igTextWrapped");
            bindFunc(cast(void**)&igTextWrappedV, "igTextWrappedV");
            bindFunc(cast(void**)&igTextUnformatted, "igTextUnformatted");
            bindFunc(cast(void**)&igLabelText, "igLabelText");
            bindFunc(cast(void**)&igLabelTextV, "igLabelTextV");
            bindFunc(cast(void**)&igBullet, "igBullet");
            bindFunc(cast(void**)&igBulletText, "igBulletText");
            bindFunc(cast(void**)&igBulletTextV, "igBulletTextV");
            bindFunc(cast(void**)&igButton, "igButton");
            bindFunc(cast(void**)&igSmallButton, "igSmallButton");
            bindFunc(cast(void**)&igInvisibleButton, "igInvisibleButton");
            bindFunc(cast(void**)&igImage, "igImage");
            bindFunc(cast(void**)&igImageButton, "igImageButton");
            bindFunc(cast(void**)&igCheckbox, "igCheckbox");
            bindFunc(cast(void**)&igCheckboxFlags, "igCheckboxFlags");
            bindFunc(cast(void**)&igRadioButtonBool, "igRadioButtonBool");
            bindFunc(cast(void**)&igRadioButton, "igRadioButton");
            bindFunc(cast(void**)&igCombo, "igCombo");
            bindFunc(cast(void**)&igCombo2, "igCombo2");
            bindFunc(cast(void**)&igCombo3, "igCombo3");
            bindFunc(cast(void**)&igPlotLines, "igPlotLines");
            bindFunc(cast(void**)&igPlotLines2, "igPlotLines2");
            bindFunc(cast(void**)&igPlotHistogram, "igPlotHistogram");
            bindFunc(cast(void**)&igPlotHistogram2, "igPlotHistogram2");
            bindFunc(cast(void**)&igProgressBar, "igProgressBar");
            bindFunc(cast(void**)&igDragFloat, "igDragFloat");
            bindFunc(cast(void**)&igDragFloat2, "igDragFloat2");
            bindFunc(cast(void**)&igDragFloat3, "igDragFloat3");
            bindFunc(cast(void**)&igDragFloat4, "igDragFloat4");
            bindFunc(cast(void**)&igDragFloatRange2, "igDragFloatRange2");
            bindFunc(cast(void**)&igDragInt, "igDragInt");
            bindFunc(cast(void**)&igDragInt2, "igDragInt2");
            bindFunc(cast(void**)&igDragInt3, "igDragInt3");
            bindFunc(cast(void**)&igDragInt4, "igDragInt4");
            bindFunc(cast(void**)&igDragIntRange2, "igDragIntRange2");
            bindFunc(cast(void**)&igInputText, "igInputText");
            bindFunc(cast(void**)&igInputTextMultiline, "igInputTextMultiline");
            bindFunc(cast(void**)&igInputFloat, "igInputFloat");
            bindFunc(cast(void**)&igInputFloat2, "igInputFloat2");
            bindFunc(cast(void**)&igInputFloat3, "igInputFloat3");
            bindFunc(cast(void**)&igInputFloat4, "igInputFloat4");
            bindFunc(cast(void**)&igInputInt, "igInputInt");
            bindFunc(cast(void**)&igInputInt2, "igInputInt2");
            bindFunc(cast(void**)&igInputInt3, "igInputInt3");
            bindFunc(cast(void**)&igInputInt4, "igInputInt4");
            bindFunc(cast(void**)&igSliderFloat, "igSliderFloat");
            bindFunc(cast(void**)&igSliderFloat2, "igSliderFloat2");
            bindFunc(cast(void**)&igSliderFloat3, "igSliderFloat3");
            bindFunc(cast(void**)&igSliderFloat4, "igSliderFloat4");
            bindFunc(cast(void**)&igSliderAngle, "igSliderAngle");
            bindFunc(cast(void**)&igSliderInt, "igSliderInt");
            bindFunc(cast(void**)&igSliderInt2, "igSliderInt2");
            bindFunc(cast(void**)&igSliderInt3, "igSliderInt3");
            bindFunc(cast(void**)&igSliderInt4, "igSliderInt4");
            bindFunc(cast(void**)&igVSliderFloat, "igVSliderFloat");
            bindFunc(cast(void**)&igVSliderInt, "igVSliderInt");
            bindFunc(cast(void**)&igColorEdit3, "igColorEdit3");
            bindFunc(cast(void**)&igColorEdit4, "igColorEdit4");
            bindFunc(cast(void**)&igColorPicker3, "igColorPicker3");
            bindFunc(cast(void**)&igColorPicker4, "igColorPicker4");
            bindFunc(cast(void**)&igColorButton, "igColorButton");
            bindFunc(cast(void**)&igSetColorEditOptions, "igSetColorEditOptions");
            bindFunc(cast(void**)&igTreeNode, "igTreeNode");
            bindFunc(cast(void**)&igTreeNodeStr, "igTreeNodeStr");
            bindFunc(cast(void**)&igTreeNodePtr, "igTreeNodePtr");
            bindFunc(cast(void**)&igTreeNodeStrV, "igTreeNodeStrV");
            bindFunc(cast(void**)&igTreeNodePtrV, "igTreeNodePtrV");
            bindFunc(cast(void**)&igTreeNodeEx, "igTreeNodeEx");
            bindFunc(cast(void**)&igTreeNodeExStr, "igTreeNodeExStr");
            bindFunc(cast(void**)&igTreeNodeExPtr, "igTreeNodeExPtr");
            bindFunc(cast(void**)&igTreeNodeExV, "igTreeNodeExV");
            bindFunc(cast(void**)&igTreeNodeExVPtr, "igTreeNodeExVPtr");
            bindFunc(cast(void**)&igTreePushStr, "igTreePushStr");
            bindFunc(cast(void**)&igTreePushPtr, "igTreePushPtr");
            bindFunc(cast(void**)&igTreePop, "igTreePop");
            bindFunc(cast(void**)&igTreeAdvanceToLabelPos, "igTreeAdvanceToLabelPos");
            bindFunc(cast(void**)&igGetTreeNodeToLabelSpacing, "igGetTreeNodeToLabelSpacing");
            bindFunc(cast(void**)&igSetNextTreeNodeOpen, "igSetNextTreeNodeOpen");
            bindFunc(cast(void**)&igCollapsingHeader, "igCollapsingHeader");
            bindFunc(cast(void**)&igCollapsingHeaderEx, "igCollapsingHeaderEx");
            bindFunc(cast(void**)&igSelectable, "igSelectable");
            bindFunc(cast(void**)&igSelectableEx, "igSelectableEx");
            bindFunc(cast(void**)&igListBox, "igListBox");
            bindFunc(cast(void**)&igListBox2, "igListBox2");
            bindFunc(cast(void**)&igListBoxHeader, "igListBoxHeader");
            bindFunc(cast(void**)&igListBoxHeader2, "igListBoxHeader2");
            bindFunc(cast(void**)&igListBoxFooter, "igListBoxFooter");
            bindFunc(cast(void**)&igValueBool, "igValueBool");
            bindFunc(cast(void**)&igValueInt, "igValueInt");
            bindFunc(cast(void**)&igValueUInt, "igValueUInt");
            bindFunc(cast(void**)&igValueFloat, "igValueFloat");
            bindFunc(cast(void**)&igSetTooltip, "igSetTooltip");
            bindFunc(cast(void**)&igSetTooltipV, "igSetTooltipV");
            bindFunc(cast(void**)&igBeginTooltip, "igBeginTooltip");
            bindFunc(cast(void**)&igEndTooltip, "igEndTooltip");
            bindFunc(cast(void**)&igBeginMainMenuBar, "igBeginMainMenuBar");
            bindFunc(cast(void**)&igEndMainMenuBar, "igEndMainMenuBar");
            bindFunc(cast(void**)&igBeginMenuBar, "igBeginMenuBar");
            bindFunc(cast(void**)&igEndMenuBar, "igEndMenuBar");
            bindFunc(cast(void**)&igBeginMenu, "igBeginMenu");
            bindFunc(cast(void**)&igEndMenu, "igEndMenu");
            bindFunc(cast(void**)&igMenuItem, "igMenuItem");
            bindFunc(cast(void**)&igMenuItemPtr, "igMenuItemPtr");
            bindFunc(cast(void**)&igOpenPopup, "igOpenPopup");
            bindFunc(cast(void**)&igBeginPopup, "igBeginPopup");
            bindFunc(cast(void**)&igBeginPopupModal, "igBeginPopupModal");
            bindFunc(cast(void**)&igBeginPopupContextItem, "igBeginPopupContextItem");
            bindFunc(cast(void**)&igBeginPopupContextWindow, "igBeginPopupContextWindow");
            bindFunc(cast(void**)&igBeginPopupContextVoid, "igBeginPopupContextVoid");
            bindFunc(cast(void**)&igEndPopup, "igEndPopup");
            bindFunc(cast(void**)&igIsPopupOpen, "igIsPopupOpen");
            bindFunc(cast(void**)&igCloseCurrentPopup, "igCloseCurrentPopup");
            bindFunc(cast(void**)&igLogToTTY, "igLogToTTY");
            bindFunc(cast(void**)&igLogToFile, "igLogToFile");
            bindFunc(cast(void**)&igLogToClipboard, "igLogToClipboard");
            bindFunc(cast(void**)&igLogFinish, "igLogFinish");
            bindFunc(cast(void**)&igLogButtons, "igLogButtons");
            bindFunc(cast(void**)&igLogText, "igLogText");
            bindFunc(cast(void**)&igPushClipRect, "igPushClipRect");
            bindFunc(cast(void**)&igPopClipRect, "igPopClipRect");
            bindFunc(cast(void**)&igIsItemHovered, "igIsItemHovered");
            bindFunc(cast(void**)&igIsItemActive, "igIsItemActive");
            bindFunc(cast(void**)&igIsItemClicked, "igIsItemClicked");
            bindFunc(cast(void**)&igIsItemVisible, "igIsItemVisible");
            bindFunc(cast(void**)&igIsAnyItemHovered, "igIsAnyItemHovered");
            bindFunc(cast(void**)&igIsAnyItemActive, "igIsAnyItemActive");
            bindFunc(cast(void**)&igGetItemRectMin, "igGetItemRectMin");
            bindFunc(cast(void**)&igGetItemRectMax, "igGetItemRectMax");
            bindFunc(cast(void**)&igGetItemRectSize, "igGetItemRectSize");
            bindFunc(cast(void**)&igSetItemAllowOverlap, "igSetItemAllowOverlap");
            bindFunc(cast(void**)&igIsWindowFocused, "igIsWindowFocused");
            bindFunc(cast(void**)&igIsWindowHovered, "igIsWindowHovered");
            bindFunc(cast(void**)&igIsAnyWindowHovered, "igIsAnyWindowHovered");
            bindFunc(cast(void**)&igIsRectVisible, "igIsRectVisible");
            bindFunc(cast(void**)&igIsRectVisible2, "igIsRectVisible2");
            bindFunc(cast(void**)&igGetTime, "igGetTime");
            bindFunc(cast(void**)&igGetFrameCount, "igGetFrameCount");
            bindFunc(cast(void**)&igGetStyleColorName, "igGetStyleColorName");
            bindFunc(cast(void**)&igCalcItemRectClosestPoint, "igCalcItemRectClosestPoint");
            bindFunc(cast(void**)&igCalcTextSize, "igCalcTextSize");
            bindFunc(cast(void**)&igCalcListClipping, "igCalcListClipping");
            bindFunc(cast(void**)&igBeginChildFrame, "igBeginChildFrame");
            bindFunc(cast(void**)&igEndChildFrame, "igEndChildFrame");
            bindFunc(cast(void**)&igColorConvertU32ToFloat4, "igColorConvertU32ToFloat4");
            bindFunc(cast(void**)&igColorConvertFloat4ToU32, "igColorConvertFloat4ToU32");
            bindFunc(cast(void**)&igColorConvertRGBtoHSV, "igColorConvertRGBtoHSV");
            bindFunc(cast(void**)&igColorConvertHSVtoRGB, "igColorConvertHSVtoRGB");
            bindFunc(cast(void**)&igGetKeyIndex, "igGetKeyIndex");
            bindFunc(cast(void**)&igIsKeyDown, "igIsKeyDown");
            bindFunc(cast(void**)&igIsKeyPressed, "igIsKeyPressed");
            bindFunc(cast(void**)&igIsKeyReleased, "igIsKeyReleased");
            bindFunc(cast(void**)&igIsMouseDown, "igIsMouseDown");
            bindFunc(cast(void**)&igIsMouseClicked, "igIsMouseClicked");
            bindFunc(cast(void**)&igIsMouseDoubleClicked, "igIsMouseDoubleClicked");
            bindFunc(cast(void**)&igIsMouseReleased, "igIsMouseReleased");
            bindFunc(cast(void**)&igIsMouseDragging, "igIsMouseDragging");
            bindFunc(cast(void**)&igIsMouseHoveringRect, "igIsMouseHoveringRect");
            bindFunc(cast(void**)&igIsMousePosValid, "igIsMousePosValid");
            bindFunc(cast(void**)&igGetMousePos, "igGetMousePos");
            bindFunc(cast(void**)&igGetMousePosOnOpeningCurrentPopup, "igGetMousePosOnOpeningCurrentPopup");
            bindFunc(cast(void**)&igGetMouseDragDelta, "igGetMouseDragDelta");
            bindFunc(cast(void**)&igResetMouseDragDelta, "igResetMouseDragDelta");
            bindFunc(cast(void**)&igGetMouseCursor, "igGetMouseCursor");
            bindFunc(cast(void**)&igSetMouseCursor, "igSetMouseCursor");
            bindFunc(cast(void**)&igCaptureKeyboardFromApp, "igCaptureKeyboardFromApp");
            bindFunc(cast(void**)&igCaptureMouseFromApp, "igCaptureMouseFromApp");

            bindFunc(cast(void**)&igMemAlloc, "igMemAlloc");
            bindFunc(cast(void**)&igMemFree, "igMemFree");
            bindFunc(cast(void**)&igGetClipboardText, "igGetClipboardText");
            bindFunc(cast(void**)&igSetClipboardText, "igSetClipboardText");

            bindFunc(cast(void**)&igGetVersion, "igGetVersion");
            bindFunc(cast(void**)&igCreateContext, "igCreateContext");
            bindFunc(cast(void**)&igDestroyContext, "igDestroyContext");
            bindFunc(cast(void**)&igGetCurrentContext, "igGetCurrentContext");
            bindFunc(cast(void**)&igSetCurrentContext, "igSetCurrentContext");

            bindFunc(cast(void**)&ImGuiIO_AddInputCharacter, "ImGuiIO_AddInputCharacter");
            bindFunc(cast(void**)&ImGuiIO_AddInputCharactersUTF8, "ImGuiIO_AddInputCharactersUTF8");
            bindFunc(cast(void**)&ImGuiIO_ClearInputCharacters, "ImGuiIO_ClearInputCharacters");
            bindFunc(cast(void**)&ImGuiTextFilter_Create, "ImGuiTextFilter_Create");
            bindFunc(cast(void**)&ImGuiTextFilter_Destroy, "ImGuiTextFilter_Destroy");
            bindFunc(cast(void**)&ImGuiTextFilter_Clear, "ImGuiTextFilter_Clear");
            bindFunc(cast(void**)&ImGuiTextFilter_Draw, "ImGuiTextFilter_Draw");
            bindFunc(cast(void**)&ImGuiTextFilter_PassFilter, "ImGuiTextFilter_PassFilter");
            bindFunc(cast(void**)&ImGuiTextFilter_IsActive, "ImGuiTextFilter_IsActive");
            bindFunc(cast(void**)&ImGuiTextFilter_Build, "ImGuiTextFilter_Build");
            bindFunc(cast(void**)&ImGuiTextFilter_GetInputBuf, "ImGuiTextFilter_GetInputBuf");
            bindFunc(cast(void**)&ImGuiTextBuffer_Create, "ImGuiTextBuffer_Create");
            bindFunc(cast(void**)&ImGuiTextBuffer_Destroy, "ImGuiTextBuffer_Destroy");
            bindFunc(cast(void**)&ImGuiTextBuffer_index, "ImGuiTextBuffer_index");
            bindFunc(cast(void**)&ImGuiTextBuffer_begin, "ImGuiTextBuffer_begin");
            bindFunc(cast(void**)&ImGuiTextBuffer_end, "ImGuiTextBuffer_end");
            bindFunc(cast(void**)&ImGuiTextBuffer_size, "ImGuiTextBuffer_size");
            bindFunc(cast(void**)&ImGuiTextBuffer_empty, "ImGuiTextBuffer_empty");
            bindFunc(cast(void**)&ImGuiTextBuffer_clear, "ImGuiTextBuffer_clear");
            bindFunc(cast(void**)&ImGuiTextBuffer_c_str, "ImGuiTextBuffer_c_str");
            bindFunc(cast(void**)&ImGuiTextBuffer_appendf, "ImGuiTextBuffer_appendf");
            bindFunc(cast(void**)&ImGuiTextBuffer_appendfv, "ImGuiTextBuffer_appendfv");
            bindFunc(cast(void**)&ImGuiStorage_Create, "ImGuiStorage_Create");
            bindFunc(cast(void**)&ImGuiStorage_Destroy, "ImGuiStorage_Destroy");
            bindFunc(cast(void**)&ImGuiStorage_Clear, "ImGuiStorage_Clear");
            bindFunc(cast(void**)&ImGuiStorage_GetInt, "ImGuiStorage_GetInt");
            bindFunc(cast(void**)&ImGuiStorage_SetInt, "ImGuiStorage_SetInt");
            bindFunc(cast(void**)&ImGuiStorage_GetBool, "ImGuiStorage_GetBool");
            bindFunc(cast(void**)&ImGuiStorage_SetBool, "ImGuiStorage_SetBool");
            bindFunc(cast(void**)&ImGuiStorage_GetFloat, "ImGuiStorage_GetFloat");
            bindFunc(cast(void**)&ImGuiStorage_SetFloat, "ImGuiStorage_SetFloat");
            bindFunc(cast(void**)&ImGuiStorage_GetVoidPtr, "ImGuiStorage_GetVoidPtr");
            bindFunc(cast(void**)&ImGuiStorage_SetVoidPtr, "ImGuiStorage_SetVoidPtr");
            bindFunc(cast(void**)&ImGuiStorage_GetIntRef, "ImGuiStorage_GetIntRef");
            bindFunc(cast(void**)&ImGuiStorage_GetBoolRef, "ImGuiStorage_GetBoolRef");
            bindFunc(cast(void**)&ImGuiStorage_GetFloatRef, "ImGuiStorage_GetFloatRef");
            bindFunc(cast(void**)&ImGuiStorage_GetVoidPtrRef, "ImGuiStorage_GetVoidPtrRef");
            bindFunc(cast(void**)&ImGuiStorage_SetAllInt, "ImGuiStorage_SetAllInt");
            bindFunc(cast(void**)&ImGuiTextEditCallbackData_DeleteChars, "ImGuiTextEditCallbackData_DeleteChars");
            bindFunc(cast(void**)&ImGuiTextEditCallbackData_InsertChars, "ImGuiTextEditCallbackData_InsertChars");
            bindFunc(cast(void**)&ImGuiTextEditCallbackData_HasSelection, "ImGuiTextEditCallbackData_HasSelection");
            bindFunc(cast(void**)&ImGuiListClipper_Begin, "ImGuiListClipper_Begin");
            bindFunc(cast(void**)&ImGuiListClipper_End, "ImGuiListClipper_End");
            bindFunc(cast(void**)&ImGuiListClipper_Step, "ImGuiListClipper_Step");
            bindFunc(cast(void**)&ImGuiListClipper_GetDisplayStart, "ImGuiListClipper_GetDisplayStart");
            bindFunc(cast(void**)&ImGuiListClipper_GetDisplayEnd, "ImGuiListClipper_GetDisplayEnd");
            bindFunc(cast(void**)&ImDrawList_GetVertexBufferSize, "ImDrawList_GetVertexBufferSize");
            bindFunc(cast(void**)&ImDrawList_GetVertexPtr, "ImDrawList_GetVertexPtr");
            bindFunc(cast(void**)&ImDrawList_GetIndexBufferSize, "ImDrawList_GetIndexBufferSize");
            bindFunc(cast(void**)&ImDrawList_GetIndexPtr, "ImDrawList_GetIndexPtr");
            bindFunc(cast(void**)&ImDrawList_GetCmdSize, "ImDrawList_GetCmdSize");
            bindFunc(cast(void**)&ImDrawList_GetCmdPtr, "ImDrawList_GetCmdPtr");
            bindFunc(cast(void**)&ImDrawList_Clear, "ImDrawList_Clear");
            bindFunc(cast(void**)&ImDrawList_ClearFreeMemory, "ImDrawList_ClearFreeMemory");
            bindFunc(cast(void**)&ImDrawList_PushClipRect, "ImDrawList_PushClipRect");
            bindFunc(cast(void**)&ImDrawList_PushClipRectFullScreen, "ImDrawList_PushClipRectFullScreen");
            bindFunc(cast(void**)&ImDrawList_PopClipRect, "ImDrawList_PopClipRect");
            bindFunc(cast(void**)&ImDrawList_PushTextureID, "ImDrawList_PushTextureID");
            bindFunc(cast(void**)&ImDrawList_PopTextureID, "ImDrawList_PopTextureID");
            bindFunc(cast(void**)&ImDrawList_GetClipRectMin, "ImDrawList_GetClipRectMin");
            bindFunc(cast(void**)&ImDrawList_GetClipRectMax, "ImDrawList_GetClipRectMax");
            bindFunc(cast(void**)&ImDrawList_AddLine, "ImDrawList_AddLine");
            bindFunc(cast(void**)&ImDrawList_AddRect, "ImDrawList_AddRect");
            bindFunc(cast(void**)&ImDrawList_AddRectFilled, "ImDrawList_AddRectFilled");
            bindFunc(cast(void**)&ImDrawList_AddRectFilledMultiColor, "ImDrawList_AddRectFilledMultiColor");
            bindFunc(cast(void**)&ImDrawList_AddQuad, "ImDrawList_AddQuad");
            bindFunc(cast(void**)&ImDrawList_AddQuadFilled, "ImDrawList_AddQuadFilled");
            bindFunc(cast(void**)&ImDrawList_AddTriangle, "ImDrawList_AddTriangle");
            bindFunc(cast(void**)&ImDrawList_AddTriangleFilled, "ImDrawList_AddTriangleFilled");
            bindFunc(cast(void**)&ImDrawList_AddCircle, "ImDrawList_AddCircle");
            bindFunc(cast(void**)&ImDrawList_AddCircleFilled, "ImDrawList_AddCircleFilled");
            bindFunc(cast(void**)&ImDrawList_AddText, "ImDrawList_AddText");
            bindFunc(cast(void**)&ImDrawList_AddTextExt, "ImDrawList_AddTextExt");
            bindFunc(cast(void**)&ImDrawList_AddImage, "ImDrawList_AddImage");
            bindFunc(cast(void**)&ImDrawList_AddImageQuad, "ImDrawList_AddImageQuad");
            bindFunc(cast(void**)&ImDrawList_AddPolyline, "ImDrawList_AddPolyline");
            bindFunc(cast(void**)&ImDrawList_AddConvexPolyFilled, "ImDrawList_AddConvexPolyFilled");
            bindFunc(cast(void**)&ImDrawList_AddBezierCurve, "ImDrawList_AddBezierCurve");
            bindFunc(cast(void**)&ImDrawList_PathClear, "ImDrawList_PathClear");
            bindFunc(cast(void**)&ImDrawList_PathLineTo, "ImDrawList_PathLineTo");
            bindFunc(cast(void**)&ImDrawList_PathLineToMergeDuplicate, "ImDrawList_PathLineToMergeDuplicate");
            bindFunc(cast(void**)&ImDrawList_PathFillConvex, "ImDrawList_PathFillConvex");
            bindFunc(cast(void**)&ImDrawList_PathStroke, "ImDrawList_PathStroke");
            bindFunc(cast(void**)&ImDrawList_PathArcTo, "ImDrawList_PathArcTo");
            bindFunc(cast(void**)&ImDrawList_PathArcToFast, "ImDrawList_PathArcToFast");
            bindFunc(cast(void**)&ImDrawList_PathBezierCurveTo, "ImDrawList_PathBezierCurveTo");
            bindFunc(cast(void**)&ImDrawList_PathRect, "ImDrawList_PathRect");
            bindFunc(cast(void**)&ImDrawList_ChannelsSplit, "ImDrawList_ChannelsSplit");
            bindFunc(cast(void**)&ImDrawList_ChannelsMerge, "ImDrawList_ChannelsMerge");
            bindFunc(cast(void**)&ImDrawList_ChannelsSetCurrent, "ImDrawList_ChannelsSetCurrent");
            bindFunc(cast(void**)&ImDrawList_AddCallback, "ImDrawList_AddCallback");
            bindFunc(cast(void**)&ImDrawList_AddDrawCmd, "ImDrawList_AddDrawCmd");
            bindFunc(cast(void**)&ImDrawList_PrimReserve, "ImDrawList_PrimReserve");
            bindFunc(cast(void**)&ImDrawList_PrimRect, "ImDrawList_PrimRect");
            bindFunc(cast(void**)&ImDrawList_PrimRectUV, "ImDrawList_PrimRectUV");
            bindFunc(cast(void**)&ImDrawList_PrimQuadUV, "ImDrawList_PrimQuadUV");
            bindFunc(cast(void**)&ImDrawList_PrimVtx, "ImDrawList_PrimVtx");
            bindFunc(cast(void**)&ImDrawList_PrimWriteVtx, "ImDrawList_PrimWriteVtx");
            bindFunc(cast(void**)&ImDrawList_PrimWriteIdx, "ImDrawList_PrimWriteIdx");
            bindFunc(cast(void**)&ImDrawList_UpdateClipRect, "ImDrawList_UpdateClipRect");
            bindFunc(cast(void**)&ImDrawList_UpdateTextureID, "ImDrawList_UpdateTextureID");
            bindFunc(cast(void**)&ImDrawData_DeIndexAllBuffers, "ImDrawData_DeIndexAllBuffers");
            bindFunc(cast(void**)&ImDrawData_ScaleClipRects, "ImDrawData_ScaleClipRects");
            bindFunc(cast(void**)&ImFontAtlas_AddFont, "ImFontAtlas_AddFont");
            bindFunc(cast(void**)&ImFontAtlas_AddFontDefault, "ImFontAtlas_AddFontDefault");
            bindFunc(cast(void**)&ImFontAtlas_AddFontFromFileTTF, "ImFontAtlas_AddFontFromFileTTF");
            bindFunc(cast(void**)&ImFontAtlas_AddFontFromMemoryTTF, "ImFontAtlas_AddFontFromMemoryTTF");
            bindFunc(cast(void**)&ImFontAtlas_AddFontFromMemoryCompressedTTF, "ImFontAtlas_AddFontFromMemoryCompressedTTF");
            bindFunc(cast(void**)&ImFontAtlas_AddFontFromMemoryCompressedBase85TTF, "ImFontAtlas_AddFontFromMemoryCompressedBase85TTF");
            bindFunc(cast(void**)&ImFontAtlas_ClearTexData, "ImFontAtlas_ClearTexData");
            bindFunc(cast(void**)&ImFontAtlas_ClearInputData, "ImFontAtlas_ClearInputData");
            bindFunc(cast(void**)&ImFontAtlas_ClearFonts, "ImFontAtlas_ClearFonts");
            bindFunc(cast(void**)&ImFontAtlas_Clear, "ImFontAtlas_Clear");
            bindFunc(cast(void**)&ImFontAtlas_GetTexDataAsAlpha8, "ImFontAtlas_GetTexDataAsAlpha8");
            bindFunc(cast(void**)&ImFontAtlas_GetTexDataAsRGBA32, "ImFontAtlas_GetTexDataAsRGBA32");
            bindFunc(cast(void**)&ImFontAtlas_SetTexID, "ImFontAtlas_SetTexID");
            bindFunc(cast(void**)&ImFontAtlas_GetGlyphRangesDefault, "ImFontAtlas_GetGlyphRangesDefault");
            bindFunc(cast(void**)&ImFontAtlas_GetGlyphRangesKorean, "ImFontAtlas_GetGlyphRangesKorean");
            bindFunc(cast(void**)&ImFontAtlas_GetGlyphRangesJapanese, "ImFontAtlas_GetGlyphRangesJapanese");
            bindFunc(cast(void**)&ImFontAtlas_GetGlyphRangesChinese, "ImFontAtlas_GetGlyphRangesChinese");
            bindFunc(cast(void**)&ImFontAtlas_GetGlyphRangesCyrillic, "ImFontAtlas_GetGlyphRangesCyrillic");
            bindFunc(cast(void**)&ImFontAtlas_GetGlyphRangesThai, "ImFontAtlas_GetGlyphRangesThai");
            bindFunc(cast(void**)&ImFontAtlas_GetTexID, "ImFontAtlas_GetTexID");
            bindFunc(cast(void**)&ImFontAtlas_GetTexPixelsAlpha8, "ImFontAtlas_GetTexPixelsAlpha8");
            bindFunc(cast(void**)&ImFontAtlas_GetTexPixelsRGBA32, "ImFontAtlas_GetTexPixelsRGBA32");
            bindFunc(cast(void**)&ImFontAtlas_GetTexWidth, "ImFontAtlas_GetTexWidth");
            bindFunc(cast(void**)&ImFontAtlas_GetTexHeight, "ImFontAtlas_GetTexHeight");
            bindFunc(cast(void**)&ImFontAtlas_GetTexDesiredWidth, "ImFontAtlas_GetTexDesiredWidth");
            bindFunc(cast(void**)&ImFontAtlas_SetTexDesiredWidth, "ImFontAtlas_SetTexDesiredWidth");
            bindFunc(cast(void**)&ImFontAtlas_GetTexGlyphPadding, "ImFontAtlas_GetTexGlyphPadding");
            bindFunc(cast(void**)&ImFontAtlas_SetTexGlyphPadding, "ImFontAtlas_SetTexGlyphPadding");
            bindFunc(cast(void**)&ImFontAtlas_GetTexUvWhitePixel, "ImFontAtlas_GetTexUvWhitePixel");
            bindFunc(cast(void**)&ImFontAtlas_Fonts_size, "ImFontAtlas_Fonts_size");
            bindFunc(cast(void**)&ImFontAtlas_Fonts_index, "ImFontAtlas_Fonts_index");
            bindFunc(cast(void**)&ImFont_GetFontSize, "ImFont_GetFontSize");
            bindFunc(cast(void**)&ImFont_SetFontSize, "ImFont_SetFontSize");
            bindFunc(cast(void**)&ImFont_GetScale, "ImFont_GetScale");
            bindFunc(cast(void**)&ImFont_SetScale, "ImFont_SetScale");
            bindFunc(cast(void**)&ImFont_GetDisplayOffset, "ImFont_GetDisplayOffset");
            bindFunc(cast(void**)&ImFont_GetFallbackGlyph, "ImFont_GetFallbackGlyph");
            bindFunc(cast(void**)&ImFont_SetFallbackGlyph, "ImFont_SetFallbackGlyph");
            bindFunc(cast(void**)&ImFont_GetFallbackAdvanceX, "ImFont_GetFallbackAdvanceX");
            bindFunc(cast(void**)&ImFont_GetFallbackChar, "ImFont_GetFallbackChar");
            bindFunc(cast(void**)&ImFont_GetConfigDataCount, "ImFont_GetConfigDataCount");
            bindFunc(cast(void**)&ImFont_GetConfigData, "ImFont_GetConfigData");
            bindFunc(cast(void**)&ImFont_GetContainerAtlas, "ImFont_GetContainerAtlas");
            bindFunc(cast(void**)&ImFont_GetAscent, "ImFont_GetAscent");
            bindFunc(cast(void**)&ImFont_GetDescent, "ImFont_GetDescent");
            bindFunc(cast(void**)&ImFont_GetMetricsTotalSurface, "ImFont_GetMetricsTotalSurface");
            bindFunc(cast(void**)&ImFont_ClearOutputData, "ImFont_ClearOutputData");
            bindFunc(cast(void**)&ImFont_BuildLookupTable, "ImFont_BuildLookupTable");
            bindFunc(cast(void**)&ImFont_FindGlyph, "ImFont_FindGlyph");
            bindFunc(cast(void**)&ImFont_SetFallbackChar, "ImFont_SetFallbackChar");
            bindFunc(cast(void**)&ImFont_GetCharAdvance, "ImFont_GetCharAdvance");
            bindFunc(cast(void**)&ImFont_IsLoaded, "ImFont_IsLoaded");
            bindFunc(cast(void**)&ImFont_CalcTextSizeA, "ImFont_CalcTextSizeA");
            bindFunc(cast(void**)&ImFont_CalcWordWrapPositionA, "ImFont_CalcWordWrapPositionA");
            bindFunc(cast(void**)&ImFont_RenderChar, "ImFont_RenderChar");
            bindFunc(cast(void**)&ImFont_RenderText, "ImFont_RenderText");
            bindFunc(cast(void**)&ImFont_Glyphs_size, "ImFont_Glyphs_size");
            bindFunc(cast(void**)&ImFont_Glyphs_index, "ImFont_Glyphs_index");
            bindFunc(cast(void**)&ImFont_IndexXAdvance_size, "ImFont_IndexXAdvance_size");
            bindFunc(cast(void**)&ImFont_IndexXAdvance_index, "ImFont_IndexXAdvance_index");
            bindFunc(cast(void**)&ImFont_IndexLookup_size, "ImFont_IndexLookup_size");
            bindFunc(cast(void**)&ImFont_IndexLookup_index, "ImFont_IndexLookup_index");
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
