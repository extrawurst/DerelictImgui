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
module derelict.imgui.types;

import derelict.util.system;

enum
{
	ImGuiKey_Tab,
	ImGuiKey_LeftArrow,
	ImGuiKey_RightArrow,
	ImGuiKey_UpArrow,
	ImGuiKey_DownArrow,
	ImGuiKey_Home,
	ImGuiKey_End,
	ImGuiKey_Delete,
	ImGuiKey_Backspace,
	ImGuiKey_Enter,
	ImGuiKey_Escape,
	ImGuiKey_A,         // for CTRL+A: select all
	ImGuiKey_C,         // for CTRL+C: copy
	ImGuiKey_V,         // for CTRL+V: paste
	ImGuiKey_X,         // for CTRL+X: cut
	ImGuiKey_Y,         // for CTRL+Y: redo
	ImGuiKey_Z,         // for CTRL+Z: undo
	ImGuiKey_COUNT
};

enum
{
    // Default: 0
    ImGuiWindowFlags_NoTitleBar             = 1 << 0,   // Disable title-bar
    ImGuiWindowFlags_NoResize               = 1 << 1,   // Disable user resizing with the lower-right grip
    ImGuiWindowFlags_NoMove                 = 1 << 2,   // Disable user moving the window
    ImGuiWindowFlags_NoScrollbar            = 1 << 3,   // Disable scrollbar (window can still scroll with mouse or programatically)
    ImGuiWindowFlags_NoScrollWithMouse      = 1 << 4,   // Disable user scrolling with mouse wheel
    ImGuiWindowFlags_NoCollapse             = 1 << 5,   // Disable user collapsing window by double-clicking on it
    ImGuiWindowFlags_AlwaysAutoResize       = 1 << 6,   // Resize every window to its content every frame
    ImGuiWindowFlags_ShowBorders            = 1 << 7,   // Show borders around windows and items
    ImGuiWindowFlags_NoSavedSettings        = 1 << 8,   // Never load/save settings in .ini file
    ImGuiWindowFlags_MenuBar                = 1 << 9,   // Has a menubar
    // [Internal]
    ImGuiWindowFlags_ChildWindow            = 1 << 20,  // Don't use! For internal use by BeginChild()
    ImGuiWindowFlags_ChildWindowAutoFitX    = 1 << 21,  // Don't use! For internal use by BeginChild()
    ImGuiWindowFlags_ChildWindowAutoFitY    = 1 << 22,  // Don't use! For internal use by BeginChild()
    ImGuiWindowFlags_ComboBox               = 1 << 23,  // Don't use! For internal use by ComboBox()
    ImGuiWindowFlags_Tooltip                = 1 << 24,  // Don't use! For internal use by BeginTooltip()
    ImGuiWindowFlags_Popup                  = 1 << 25,  // Don't use! For internal use by BeginPopup()
    ImGuiWindowFlags_ChildMenu              = 1 << 26   // Don't use! For internal use by BeginMenu()
}

enum
{
    // Default: 0
    ImGuiInputTextFlags_CharsDecimal        = 1 << 0,   // Allow 0123456789.+-*/
    ImGuiInputTextFlags_CharsHexadecimal    = 1 << 1,   // Allow 0123456789ABCDEFabcdef
    ImGuiInputTextFlags_CharsUppercase      = 1 << 2,   // Turn a..z into A..Z
    ImGuiInputTextFlags_CharsNoBlank        = 1 << 3,   // Filter out spaces, tabs
    ImGuiInputTextFlags_AutoSelectAll       = 1 << 4,   // Select entire text when first taking mouse focus
    ImGuiInputTextFlags_EnterReturnsTrue    = 1 << 5,   // Return 'true' when Enter is pressed (as opposed to when the value was modified)
    ImGuiInputTextFlags_CallbackCompletion  = 1 << 6,   // Call user function on pressing TAB (for completion handling)
    ImGuiInputTextFlags_CallbackHistory     = 1 << 7,   // Call user function on pressing Up/Down arrows (for history handling)
    ImGuiInputTextFlags_CallbackAlways      = 1 << 8,   // Call user function every time
    ImGuiInputTextFlags_CallbackCharFilter  = 1 << 9    // Call user function to filter character. Modify data->EventChar to replace/filter input, or return 1 to discard character.
}

enum
{
    ImGuiSetCond_Always        = 1 << 0, // Set the variable
    ImGuiSetCond_Once          = 1 << 1, // Only set the variable on the first call per runtime session
    ImGuiSetCond_FirstUseEver  = 1 << 2, // Only set the variable if the window doesn't exist in the .ini file
    ImGuiSetCond_Appearing     = 1 << 3  // Only set the variable if the window is appearing after being inactive (or the first time)
}

enum
{
    ImGuiCol_Text,
    ImGuiCol_TextDisabled,
    ImGuiCol_WindowBg,
    ImGuiCol_ChildWindowBg,
    ImGuiCol_Border,
    ImGuiCol_BorderShadow,
    ImGuiCol_FrameBg,               // Background of checkbox, radio button, plot, slider, text input
    ImGuiCol_FrameBgHovered,
    ImGuiCol_FrameBgActive,
    ImGuiCol_TitleBg,
    ImGuiCol_TitleBgCollapsed,
    ImGuiCol_MenuBarBg,
    ImGuiCol_ScrollbarBg,
    ImGuiCol_ScrollbarGrab,
    ImGuiCol_ScrollbarGrabHovered,
    ImGuiCol_ScrollbarGrabActive,
    ImGuiCol_ComboBg,
    ImGuiCol_CheckMark,
    ImGuiCol_SliderGrab,
    ImGuiCol_SliderGrabActive,
    ImGuiCol_Button,
    ImGuiCol_ButtonHovered,
    ImGuiCol_ButtonActive,
    ImGuiCol_Header,
    ImGuiCol_HeaderHovered,
    ImGuiCol_HeaderActive,
    ImGuiCol_Column,
    ImGuiCol_ColumnHovered,
    ImGuiCol_ColumnActive,
    ImGuiCol_ResizeGrip,
    ImGuiCol_ResizeGripHovered,
    ImGuiCol_ResizeGripActive,
    ImGuiCol_CloseButton,
    ImGuiCol_CloseButtonHovered,
    ImGuiCol_CloseButtonActive,
    ImGuiCol_PlotLines,
    ImGuiCol_PlotLinesHovered,
    ImGuiCol_PlotHistogram,
    ImGuiCol_PlotHistogramHovered,
    ImGuiCol_TextSelectedBg,
    ImGuiCol_TooltipBg,
    ImGuiCol_COUNT
}

enum
{
	ImGuiStyleVar_Alpha,               // float
	ImGuiStyleVar_WindowPadding,       // ImVec2
	ImGuiStyleVar_WindowRounding,      // float
    ImGuiStyleVar_WindowMinSize,       // ImVec2
	ImGuiStyleVar_ChildWindowRounding, // float
	ImGuiStyleVar_FramePadding,        // ImVec2
	ImGuiStyleVar_FrameRounding,       // float
	ImGuiStyleVar_ItemSpacing,         // ImVec2
	ImGuiStyleVar_ItemInnerSpacing,    // ImVec2
	ImGuiStyleVar_IndentSpacing,       // float
	ImGuiStyleVar_GrabMinSize          // float
}

enum 
{
    ImGuiAlign_Left     = 1 << 0,
    ImGuiAlign_Center   = 1 << 1,
    ImGuiAlign_Right    = 1 << 2,
    ImGuiAlign_Top      = 1 << 3,
    ImGuiAlign_VCenter  = 1 << 4,
    ImGuiAlign_Default  = ImGuiAlign_Left | ImGuiAlign_Top,
}

enum
{
	ImGuiColorEditMode_UserSelect = -2,
	ImGuiColorEditMode_UserSelectShowButton = -1,
	ImGuiColorEditMode_RGB = 0,
	ImGuiColorEditMode_HSV = 1,
	ImGuiColorEditMode_HEX = 2
}

enum
{
	ImGuiMouseCursor_Arrow = 0,
	ImGuiMouseCursor_TextInput,         // When hovering over InputText, etc.
	ImGuiMouseCursor_Move,              // Unused
	ImGuiMouseCursor_ResizeNS,          // Unused
	ImGuiMouseCursor_ResizeEW,          // When hovering over a column
	ImGuiMouseCursor_ResizeNESW,        // Unused
	ImGuiMouseCursor_ResizeNWSE,        // When hovering over the bottom-right corner of a window
	ImGuiMouseCursor_Count_
}

align(1) struct ImVec2
{
	float x=0;
	float y=0;
}

align(1) struct ImVec4
{
	float x=0;
	float y=0;
	float z=0;
	float w=0;
}

struct ImFont{}
struct ImFontAtlas{}
struct ImDrawList{}
struct ImGuiStorage{}

alias uint ImU32;
alias ushort ImWchar;     // character for display
alias void* ImTextureID;          // user data to refer to a texture (e.g. store your texture handle/id)
alias ImU32 ImGuiID;              // unique ID used by widgets (typically hashed from a stack of string)
alias int ImGuiCol;               // enum ImGuiCol_
alias int ImGuiStyleVar;          // enum ImGuiStyleVar_
alias int ImGuiKey;               // enum ImGuiKey_
alias int ImGuiAlign;             // enum ImGuiAlign_
alias int ImGuiColorEditMode;     // enum ImGuiColorEditMode_
alias int ImGuiMouseCursor;       // enum ImGuiMouseCursor_
alias int ImGuiWindowFlags;       // enum ImGuiWindowFlags_
alias int ImGuiSetCond;           // enum ImGuiSetCond_
alias int ImGuiInputTextFlags;    // enum ImGuiInputTextFlags_
alias int function(ImGuiTextEditCallbackData *data) ImGuiTextEditCallback;

extern(C) nothrow {
    alias RenderDrawListFunc = void function(ImDrawList** draw_lists, int count);
    alias GetClipboardTextFunc = const(char)* function();
    alias SetClipboardTextFunc = void function(const(char)*);
    alias MemAllocFunc = void* function(size_t);
    alias MemFreeFunc = void function(void*);
    alias ImeSetInputScreenPosFunc = void function(int,int);
}

// Shared state of InputText(), passed to callback when a ImGuiInputTextFlags_Callback* flag is used.
align(1) struct ImGuiTextEditCallbackData
{
    ImGuiInputTextFlags EventFlag;      // One of ImGuiInputTextFlags_Callback* // Read-only
    ImGuiInputTextFlags Flags;          // What user passed to InputText()      // Read-only
    void*               UserData;       // What user passed to InputText()      // Read-only

    // CharFilter event:
    ImWchar             EventChar;      // Character input                      // Read-write (replace character or set to zero)

    // Completion,History,Always events:
    ImGuiKey            EventKey;       // Key pressed (Up/Down/TAB)            // Read-only
    char*               Buf;            // Current text                         // Read-write (pointed data only)
    size_t              BufSize;        //                                      // Read-only
    bool                BufDirty;       // Set if you modify Buf directly       // Write
    int                 CursorPos;      //                                      // Read-write
    int                 SelectionStart; //                                      // Read-write (== to SelectionEnd when no selection)
    int                 SelectionEnd;   //                                      // Read-write

    // NB: calling those function loses selection.
    //void DeleteChars(int pos, int bytes_count);
    //void InsertChars(int pos, const char* text, const char* text_end = NULL);
};

align(1) struct ImGuiIO
{
	ImVec2        DisplaySize;              // <unset>              // Display size, in pixels. For clamping windows positions.
	float         DeltaTime;                // = 1.0f/60.0f         // Time elapsed since last frame, in seconds.
	float         IniSavingRate;            // = 5.0f               // Maximum time between saving positions/sizes to .ini file, in seconds.
	const char*   IniFilename;              // = "imgui.ini"        // Path to .ini file. NULL to disable .ini saving.
	const char*   LogFilename;              // = "imgui_log.txt"    // Path to .log file (default parameter to ImGui::LogToFile when no file is specified).
	float         MouseDoubleClickTime;     // = 0.30f              // Time for a double-click, in seconds.
	float         MouseDoubleClickMaxDist;  // = 6.0f               // Distance threshold to stay in to validate a double-click, in pixels.
	float         MouseDragThreshold;       // = 6.0f               // Distance threshold before considering we are dragging
	int[ImGuiKey_COUNT]           KeyMap;   // <unset>              // Map of indices into the KeysDown[512] entries array
    float         KeyRepeatDelay;           // = 0.250f             // When holding a key/button, time before it starts repeating, in seconds. (for actions where 'repeat' is active)
    float         KeyRepeatRate;            // = 0.020f             // When holding a key/button, rate at which it repeats, in seconds.
	void*         UserData;                 // = NULL               // Store your own data for retrieval by callbacks.
	
	ImFontAtlas*  Fonts;                    // <auto>               // Load and assemble one or more fonts into a single tightly packed texture. Output to Fonts array.
	float         FontGlobalScale;          // = 1.0f               // Global scale all fonts
	bool          FontAllowUserScaling;     // = false              // Allow user scaling text of individual window with CTRL+Wheel.
	ImVec2        DisplayVisibleMin;        // <unset> (0.0f,0.0f)  // If you use DisplaySize as a virtual space larger than your screen, set DisplayVisibleMin/Max to the visible area.
	ImVec2        DisplayVisibleMax;        // <unset> (0.0f,0.0f)  // If the values are the same, we defaults to Min=(0.0f) and Max=DisplaySize
	
	//------------------------------------------------------------------
	// User Functions
	//------------------------------------------------------------------
	
	// REQUIRED: rendering function. 
	// See example code if you are unsure of how to implement this.
    RenderDrawListFunc RenderDrawListsFn;
	
	// Optional: access OS clipboard
	// (default to use native Win32 clipboard on Windows, otherwise uses a private clipboard. Override to access OS clipboard on other architectures)
    GetClipboardTextFunc GetClipboardTextFn;
    SetClipboardTextFunc SetClipboardTextFn;
	
	// Optional: override memory allocations. MemFreeFn() may be called with a NULL pointer.
	// (default to posix malloc/free)
	MemAllocFunc MemAllocFn;
    MemFreeFunc MemFreeFn;
	
	// Optional: notify OS Input Method Editor of the screen position of your cursor for text input position (e.g. when using Japanese/Chinese IME in Windows)
	// (default to use native imm32 api on Windows)
    ImeSetInputScreenPosFunc ImeSetInputScreenPosFn;
	void*       ImeWindowHandle;            // (Windows) Set this to your HWND to get automatic IME cursor positioning.
	
	//------------------------------------------------------------------
	// Input - Fill before calling NewFrame()
	//------------------------------------------------------------------

	ImVec2      	MousePos;                   // Mouse position, in pixels (set to -1,-1 if no mouse / on another screen, etc.)
	bool[5]     	MouseDown;        		    // Mouse buttons. ImGui itself only uses button 0 (left button). Others buttons allows to track if mouse is being used by your application + available to user as a convenience via IsMouse** API.
	float       	MouseWheel;                 // Mouse wheel: 1 unit scrolls about 5 lines text. 
	bool        	MouseDrawCursor;            // Request ImGui to draw a mouse cursor for you (if you are on a platform without a mouse cursor).
	bool        	KeyCtrl;                    // Keyboard modifier pressed: Control
	bool        	KeyShift;                   // Keyboard modifier pressed: Shift
	bool        	KeyAlt;                     // Keyboard modifier pressed: Alt
	bool[512]   	KeysDown;              // Keyboard keys that are pressed (in whatever storage order you naturally have access to keyboard data)
	ImWchar[16+1]   InputCharacters;      // List of characters input (translated by user from keypress+keyboard state). Fill using AddInputCharacter() helper.
	
	//------------------------------------------------------------------
	// Output - Retrieve after calling NewFrame(), you can use them to discard inputs or hide them from the rest of your application
	//------------------------------------------------------------------
	
	bool        WantCaptureMouse;           // Mouse is hovering a window or widget is active (= ImGui will use your mouse input)
	bool        WantCaptureKeyboard;        // Widget is active (= ImGui will use your keyboard input)
	float       Framerate;                  // Framerate estimation, in frame per second. Rolling average estimation based on IO.DeltaTime over 120 frames
    int         MetricsAllocs;              // Number of active memory allocations
    int         MetricsRenderVertices;      // Vertices processed during last call to Render()
    int         MetricsActiveWindows;       // Number of visible windows (exclude child windows)
	
	//------------------------------------------------------------------
	// [Internal] ImGui will maintain those fields for you
	//------------------------------------------------------------------
	
	ImVec2      MousePosPrev;               // Previous mouse position
	ImVec2      MouseDelta;                 // Mouse delta. Note that this is zero if either current or previous position are negative to allow mouse enabling/disabling.
	bool[5]     MouseClicked;            // Mouse button went from !Down to Down
	ImVec2[5]   MouseClickedPos;         // Position at time of clicking
	float[5]    MouseClickedTime;        // Time of last click (used to figure out double-click)
	bool[5]     MouseDoubleClicked;      // Has mouse button been double-clicked?
	bool[5]     MouseDownOwned;          // Track if button was clicked inside a window. We don't request mouse capture from the application if click started outside ImGui bounds.
	float[5]    MouseDownTime;           // Time the mouse button has been down
	float[5]    MouseDragMaxDistanceSqr; // Squared maximum distance of how much mouse has traveled from the click point
	float[512]  KeysDownTime;          // Time the keyboard key has been down
}

align(1) struct ImGuiStyle
{
    float       Alpha;                      // Global alpha applies to everything in ImGui
    ImVec2      WindowPadding;              // Padding within a window
    ImVec2      WindowMinSize;              // Minimum window size
    float       WindowRounding;             // Radius of window corners rounding. Set to 0.0f to have rectangular windows
    ImGuiAlign  WindowTitleAlign;           // Alignment for title bar text
    float       ChildWindowRounding;        // Radius of child window corners rounding. Set to 0.0f to have rectangular windows
    ImVec2      FramePadding;               // Padding within a framed rectangle (used by most widgets)
    float       FrameRounding;              // Radius of frame corners rounding. Set to 0.0f to have rectangular frame (used by most widgets).
    ImVec2      ItemSpacing;                // Horizontal and vertical spacing between widgets/lines
    ImVec2      ItemInnerSpacing;           // Horizontal and vertical spacing between within elements of a composed widget (e.g. a slider and its label)
    ImVec2      TouchExtraPadding;          // Expand reactive bounding box for touch-based system where touch position is not accurate enough. Unfortunately we don't sort widgets so priority on overlap will always be given to the first widget. So don't grow this too much!
    float       WindowFillAlphaDefault;     // Default alpha of window background, if not specified in ImGui::Begin()
    float       IndentSpacing;              // Horizontal indentation when e.g. entering a tree node
    float       ColumnsMinSpacing;          // Minimum horizontal spacing between two columns
    float       ScrollbarWidth;             // Width of the vertical scrollbar
    float       ScrollbarRounding;          // Radius of grab corners for scrollbar
    float       GrabMinSize;                // Minimum width/height of a grab box for slider/scrollbar
    ImVec2      DisplayWindowPadding;       // Window positions are clamped to be visible within the display area by at least this amount. Only covers regular windows.
    ImVec2      DisplaySafeAreaPadding;     // If you cannot see the edge of your screen (e.g. on a TV) increase the safe area padding. Covers popups/tooltips as well regular windows.
    ImVec4[ImGuiCol_COUNT]      Colors;
};

align(1) struct ImDrawVert
{
	ImVec2  pos;
	ImVec2  uv;
	ImU32   col;
};

alias ImDrawCallback = void function(const ImDrawList* parent_list, const ImDrawCmd* cmd) nothrow;

align(1) struct ImDrawCmd
{
	uint            vtx_count;                  // Number of vertices (multiple of 3) to be drawn as triangles. The vertices are stored in the callee ImDrawList's vtx_buffer[] array.
	ImVec4          clip_rect;                  // Clipping rectangle (x1, y1, x2, y2)
	ImTextureID     texture_id;                 // User-provided texture ID. Set by user in ImfontAtlas::SetTexID() for fonts or passed to Image*() functions. Ignore if never using images or multiple fonts atlas.
	ImDrawCallback  user_callback;              // If != NULL, call the function instead of rendering the vertices. vtx_count will be 0. clip_rect and texture_id will be set normally.
	void*           user_callback_data;         // The draw callback code can access this.
};