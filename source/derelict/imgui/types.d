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

// User fill ImGuiIO.KeyMap[] array with indices into the ImGuiIO.KeysDown[512] array
enum ImGuiKey_:int
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
    // [Internal]
    ImGuiWindowFlags_ChildWindow            = 1 << 9,   // For internal use by BeginChild()
    ImGuiWindowFlags_ChildWindowAutoFitX    = 1 << 10,  // For internal use by BeginChild()
    ImGuiWindowFlags_ChildWindowAutoFitY    = 1 << 11,  // For internal use by BeginChild()
    ImGuiWindowFlags_ComboBox               = 1 << 12,  // For internal use by ComboBox()
    ImGuiWindowFlags_Tooltip                = 1 << 13,  // For internal use by BeginTooltip()
    ImGuiWindowFlags_Popup                  = 1 << 14   // For internal use by BeginPopup()
};

enum
{
    ImGuiSetCond_Always        = 1 << 0, // Set the variable
    ImGuiSetCond_Once          = 1 << 1, // Only set the variable on the first call per runtime session
    ImGuiSetCond_FirstUseEver  = 1 << 2  // Only set the variable if the window doesn't exist in the .ini file
};

enum ImGuiCol_
{
    ImGuiCol_Text,
    ImGuiCol_WindowBg,
    ImGuiCol_ChildWindowBg,
    ImGuiCol_Border,
    ImGuiCol_BorderShadow,
    ImGuiCol_FrameBg,               // Background of checkbox, radio button, plot, slider, text input
    ImGuiCol_FrameBgHovered,
    ImGuiCol_FrameBgActive,
    ImGuiCol_TitleBg,
    ImGuiCol_TitleBgCollapsed,
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
};

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
alias int ImGuiColorEditMode;     // enum ImGuiColorEditMode_
alias int ImGuiMouseCursor;       // enum ImGuiMouseCursor_
alias int ImGuiWindowFlags;       // enum ImGuiWindowFlags_
alias int ImGuiSetCond;           // enum ImGuiSetCond_
alias int ImGuiInputTextFlags;    // enum ImGuiInputTextFlags_
alias int function(ImGuiTextEditCallbackData *data) ImGuiTextEditCallback;

alias RenderDrawListFunc = extern(C) nothrow void function(ImDrawList** draw_lists, int count);
alias GetClipboardTextFunc = extern(C) nothrow const(char)* function();
alias SetClipboardTextFunc = extern(C) nothrow void function(const(char)*);
alias MemAllocFunc = extern(C) nothrow void* function(size_t);
alias MemFreeFunc = extern(C) nothrow void function(void*);
alias ImeSetInputScreenPosFunc = extern(C) nothrow void function(int,int);

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
	int[ImGuiKey_.ImGuiKey_COUNT]           KeyMap;   // <unset>              // Map of indices into the KeysDown[512] entries array
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
	int         MetricsVertices;            // Vertices processed during last call to Render()
	
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
    float       ChildWindowRounding;        // Radius of child window corners rounding. Set to 0.0f to have rectangular windows
    ImVec2      FramePadding;               // Padding within a framed rectangle (used by most widgets)
    float       FrameRounding;              // Radius of frame corners rounding. Set to 0.0f to have rectangular frame (used by most widgets).
    ImVec2      ItemSpacing;                // Horizontal and vertical spacing between widgets/lines
    ImVec2      ItemInnerSpacing;           // Horizontal and vertical spacing between within elements of a composed widget (e.g. a slider and its label)
    ImVec2      TouchExtraPadding;          // Expand reactive bounding box for touch-based system where touch position is not accurate enough. Unfortunately we don't sort widgets so priority on overlap will always be given to the first widget. So don't grow this too much!
    ImVec2      AutoFitPadding;             // Extra space after auto-fit (double-clicking on resize grip)
    float       WindowFillAlphaDefault;     // Default alpha of window background, if not specified in ImGui::Begin()
    float       IndentSpacing;              // Horizontal indentation when e.g. entering a tree node
    float       ColumnsMinSpacing;          // Minimum horizontal spacing between two columns
    float       ScrollbarWidth;             // Width of the vertical scrollbar
    float       GrabMinSize;                // Minimum width/height of a slider or scrollbar grab
    ImVec2      DisplaySafeAreaPadding;     // Window positions are clamped to be visible within the display area. If you cannot see the edge of your screen (e.g. on a TV) increase the safe area padding.
    ImVec4[ImGuiCol_.ImGuiCol_COUNT]      Colors;
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