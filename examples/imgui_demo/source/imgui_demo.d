module imgui_demo;

// dear imgui, v1.51
// (demo code)

// Message to the person tempted to delete this file when integrating ImGui into their code base:
// Don't do it! Do NOT remove this file from your project! It is useful reference code that you and other users will want to refer to.
// Everything in this file will be stripped out by the linker if you don't call igShowTestWindow().
// During development, you can call igShowTestWindow() in your code to learn about various features of ImGui. Have it wired in a debug menu!
// Removing this file from your project is hindering access to documentation for everyone in your team, likely leading you to poorer usage of the library.
// Note that you can #define IMGUI_DISABLE_TEST_WINDOWS in imconfig.h for the same effect.
// If you want to link core ImGui in your public builds but not those test windows, #define IMGUI_DISABLE_TEST_WINDOWS in imconfig.h and those functions will be empty.
// For any other case, if you have ImGui available you probably want this to be available for reference and execution.
// Thank you,
// -Your beloved friend, imgui_demo.cpp (that you won't delete)

// Message to beginner C/C++ programmer about the meaning of 'static': in this demo code, we frequently we use 'static' variables inside functions. 
// We do this as a way to gather code and data in the same place, make the demo code faster to read, faster to write, and smaller. A static variable persist across calls, 
// so it is essentially like a global variable but declared inside the scope of the function.
// It also happens to be a convenient way of storing simple UI related information as long as your function doesn't need to be reentrant or used in threads.
// This may be a pattern you want to use in your code (simple is beautiful!), but most of the real data you would be editing is likely to be stored outside your function.

import derelict.imgui.imgui;

import std.string;
import std.conv : to;
import std.algorithm : max;
import std.algorithm.mutation : remove;
import std.math : isNaN;
import std.uni : icmp;
import core.stdc.stdint : intptr_t;
import core.stdc.string : memset, strchr, strcpy, strncmp, memcmp, memcpy, strlen, strstr;
import core.stdc.float_ : FLT_MAX;
import core.stdc.stdlib : rand;
import core.stdc.ctype : toupper;
import core.stdc.stdio : printf, snprintf, sprintf;
import core.stdc.math : cosf, sinf, sqrtf;
import core.stdc.stdarg : va_list, va_end, va_start;
import core.vararg;

// Play it nice with Windows users. Notepad in 2015 still doesn't display text data with Unix-style \n.
version(Windows) {
    enum IM_NEWLINE = "\r\n";
} else {
    enum IM_NEWLINE = "\n";
}

size_t IM_ARRAYSIZE(T)(T _ARR) { return _ARR.length; }
alias IM_MAX = max;

//-----------------------------------------------------------------------------
// DEMO CODE
//-----------------------------------------------------------------------------

void ShowHelpMarker(string desc)
{
    igTextDisabled("(?)");
    if (igIsItemHovered())
    {
        igBeginTooltip();
        igPushTextWrapPos(450.0f);
        igTextUnformatted(desc.ptr, desc.ptr + desc.length);
        igPopTextWrapPos();
        igEndTooltip();
    }
}

void igShowUserGuide()
{
    igBulletText("Double-click on title bar to collapse window.");
    igBulletText("Click and drag on lower right corner to resize window.");
    igBulletText("Click and drag on any empty space to move window.");
    igBulletText("Mouse Wheel to scroll.");
    if (igGetIO().FontAllowUserScaling)
        igBulletText("CTRL+Mouse Wheel to zoom window contents.");
    igBulletText("TAB/SHIFT+TAB to cycle through keyboard editable fields.");
    igBulletText("CTRL+Click on a slider or drag box to input text.");
    igBulletText(
        "While editing text:\n" ~
        "- Hold SHIFT or use mouse to select text\n" ~
        "- CTRL+Left/Right to word jump\n" ~
        "- CTRL+A or double-click to select all\n" ~
        "- CTRL+X,CTRL+C,CTRL+V clipboard\n" ~
        "- CTRL+Z,CTRL+Y undo/redo\n" ~
        "- ESCAPE to revert\n" ~
        "- You can apply arithmetic operators +,*,/ on numerical values.\n" ~
        "  Use +- to subtract.\n");
}

// Demonstrate most ImGui features (big function!)
void igShowTestWindow(bool* p_open)
{
    // Examples apps
    static bool show_app_main_menu_bar = false;
    static bool show_app_console = false;
    static bool show_app_log = false;
    static bool show_app_layout = false;
    static bool show_app_property_editor = false;
    static bool show_app_long_text = false;
    static bool show_app_auto_resize = false;
    static bool show_app_constrained_resize = false;
    static bool show_app_fixed_overlay = false;
    static bool show_app_manipulating_window_title = false;
    static bool show_app_custom_rendering = false;
    static bool show_app_style_editor = false;

    static bool show_app_metrics = false;
    static bool show_app_about = false;

    if (show_app_main_menu_bar) ShowExampleAppMainMenuBar();
    if (show_app_console) ShowExampleAppConsole(&show_app_console);
    if (show_app_log) ShowExampleAppLog(&show_app_log);
    if (show_app_layout) ShowExampleAppLayout(&show_app_layout);
    if (show_app_property_editor) ShowExampleAppPropertyEditor(&show_app_property_editor);
    if (show_app_long_text) ShowExampleAppLongText(&show_app_long_text);
    if (show_app_auto_resize) ShowExampleAppAutoResize(&show_app_auto_resize);
    if (show_app_constrained_resize) ShowExampleAppConstrainedResize(&show_app_constrained_resize);
    if (show_app_fixed_overlay) ShowExampleAppFixedOverlay(&show_app_fixed_overlay);
    if (show_app_manipulating_window_title) ShowExampleAppManipulatingWindowTitle(&show_app_manipulating_window_title);
    if (show_app_custom_rendering) ShowExampleAppCustomRendering(&show_app_custom_rendering);

    if (show_app_metrics) igShowMetricsWindow(&show_app_metrics);
    if (show_app_style_editor) { igBegin("Style Editor", &show_app_style_editor); igShowStyleEditor(); igEnd(); }
    if (show_app_about)
    {
        igBegin("About ImGui", &show_app_about, ImGuiWindowFlags_AlwaysAutoResize);
        igText("dear imgui, %s", igGetVersion());
        igSeparator();
        igText("By Omar Cornut and all github contributors.");
        igText("ImGui is licensed under the MIT License, see LICENSE for more information.");
        igEnd();
    }

    static bool no_titlebar = false;
    static bool no_border = true;
    static bool no_resize = false;
    static bool no_move = false;
    static bool no_scrollbar = false;
    static bool no_collapse = false;
    static bool no_menu = false;

    // Demonstrate the various window flags. Typically you would just use the default.
    ImGuiWindowFlags window_flags = 0;
    if (no_titlebar)  window_flags |= ImGuiWindowFlags_NoTitleBar;
    if (!no_border)   window_flags |= ImGuiWindowFlags_ShowBorders;
    if (no_resize)    window_flags |= ImGuiWindowFlags_NoResize;
    if (no_move)      window_flags |= ImGuiWindowFlags_NoMove;
    if (no_scrollbar) window_flags |= ImGuiWindowFlags_NoScrollbar;
    if (no_collapse)  window_flags |= ImGuiWindowFlags_NoCollapse;
    if (!no_menu)     window_flags |= ImGuiWindowFlags_MenuBar;
    igSetNextWindowSize(ImVec2(550,680), ImGuiCond_FirstUseEver);
    if (!igBegin("[D]ImGui Demo", p_open, window_flags))
    {
        // Early out if the window is collapsed, as an optimization.
        igEnd();
        return;
    }

    //igPushItemWidth(igGetWindowWidth() * 0.65f);    // 2/3 of the space for widget and 1/3 for labels
    igPushItemWidth(-140);                                 // Right align, keep 140 pixels for labels

    igText("dear imgui says hello. (%s)", igGetVersion());

    // Menu
    if (igBeginMenuBar())
    {
        if (igBeginMenu("Menu"))
        {
            ShowExampleMenuFile();
            igEndMenu();
        }
        if (igBeginMenu("Examples"))
        {
            igMenuItemPtr("Main menu bar", null, &show_app_main_menu_bar);
            igMenuItemPtr("Console", null, &show_app_console);
            igMenuItemPtr("Log", null, &show_app_log);
            igMenuItemPtr("Simple layout", null, &show_app_layout);
            igMenuItemPtr("Property editor", null, &show_app_property_editor);
            igMenuItemPtr("Long text display", null, &show_app_long_text);
            igMenuItemPtr("Auto-resizing window", null, &show_app_auto_resize);
            igMenuItemPtr("Constrained-resizing window", null, &show_app_constrained_resize);
            igMenuItemPtr("Simple overlay", null, &show_app_fixed_overlay);
            igMenuItemPtr("Manipulating window title", null, &show_app_manipulating_window_title);
            igMenuItemPtr("Custom rendering", null, &show_app_custom_rendering);
            igEndMenu();
        }
        if (igBeginMenu("Help"))
        {
            igMenuItemPtr("Metrics", null, &show_app_metrics);
            igMenuItemPtr("Style Editor", null, &show_app_style_editor);
            igMenuItemPtr("About ImGui", null, &show_app_about);
            igEndMenu();
        }
        igEndMenuBar();
    }

    igSpacing();
    if (igCollapsingHeader("Help"))
    {
        igTextWrapped("This window is being created by the ShowTestWindow() function. Please refer to the code for programming reference.\n\nUser Guide:");
        igShowUserGuide();
    }

    if (igCollapsingHeader("Window options"))
    {
        igCheckbox("No titlebar", &no_titlebar); igSameLine(150);
        igCheckbox("No border", &no_border); igSameLine(300);
        igCheckbox("No resize", &no_resize);
        igCheckbox("No move", &no_move); igSameLine(150);
        igCheckbox("No scrollbar", &no_scrollbar); igSameLine(300);
        igCheckbox("No collapse", &no_collapse);
        igCheckbox("No menu", &no_menu);

        if (igTreeNode("Style"))
        {
            igShowStyleEditor();
            igTreePop();
        }

        if (igTreeNode("Logging"))
        {
            igTextWrapped("The logging API redirects all text output so you can easily capture the content of a window or a block. Tree nodes can be automatically expanded. You can also call igLogText() to output directly to the log without a visual output.");
            igLogButtons();
            igTreePop();
        }
    }

    if (igCollapsingHeader("Widgets"))
    {

        if (igTreeNode("Basic"))
        {
            static int clicked = 0;
            if (igButton("Button")) 
                clicked++;
            if (clicked & 1)
            {
                igSameLine();
                igText("Thanks for clicking me!");
            }

            static bool check = true;
            igCheckbox("checkbox", &check);

            static int e = 0;
            igRadioButton("radio a", &e, 0); igSameLine();
            igRadioButton("radio b", &e, 1); igSameLine();
            igRadioButton("radio c", &e, 2);

            // Color buttons, demonstrate using PushID() to add unique identifier in the ID stack, and changing style.
            for (int i = 0; i < 7; i++)
            {
                if (i > 0) igSameLine();
                igPushIDInt(i);
                igPushStyleColor(ImGuiCol_Button, ImColor.HSV(i/7.0f, 0.6f, 0.6f).asImVec4);
                igPushStyleColor(ImGuiCol_ButtonHovered, ImColor.HSV(i/7.0f, 0.7f, 0.7f).asImVec4);
                igPushStyleColor(ImGuiCol_ButtonActive, ImColor.HSV(i/7.0f, 0.8f, 0.8f).asImVec4);
                igButton("Click");
                igPopStyleColor(3);
                igPopID();
            }

            igText("Hover over me");
            if (igIsItemHovered())
                igSetTooltip("I am a tooltip");

            igSameLine();
            igText("- or me");
            if (igIsItemHovered())
            {
                igBeginTooltip();
                igText("I am a fancy tooltip");
                static float[] arr = [ 0.6f, 0.1f, 1.0f, 0.5f, 0.92f, 0.1f, 0.2f ];
                igPlotLines("Curve", arr.ptr, IM_ARRAYSIZE(arr));
                igEndTooltip();
            }

            // Testing ImGuiOnceUponAFrame helper.
            //static ImGuiOnceUponAFrame once;
            //for (int i = 0; i < 5; i++)
            //    if (once)
            //        igText("This will be displayed only once.");

            igSeparator();

            igLabelText("label", "Value");

            static int item = 1;
            igCombo2("combo", &item, "aaaa\0bbbb\0cccc\0dddd\0eeee\0\0");   // Combo using values packed in a single constant string (for really quick combo)

            const(char)*[] items = [ "AAAA", "BBBB", "CCCC", "DDDD", "EEEE", "FFFF", "GGGG", "HHHH", "IIII", "JJJJ", "KKKK" ];
            static int item2 = -1;
            igCombo("combo scroll", &item2, items.ptr, IM_ARRAYSIZE(items));   // Combo using proper array. You can also pass a callback to retrieve array value, no need to create/copy an array just for that.

            {
                static char[128] str0 = "Hello, world!";
                static int i0=123;
                static float f0=0.001f;
                igInputText("input text", str0.ptr, IM_ARRAYSIZE(str0));
                igSameLine(); ShowHelpMarker("Hold SHIFT or use mouse to select text.\n" ~ "CTRL+Left/Right to word jump.\n" ~ "CTRL+A or double-click to select all.\n" ~ "CTRL+X,CTRL+C,CTRL+V clipboard.\n" ~ "CTRL+Z,CTRL+Y undo/redo.\n" ~ "ESCAPE to revert.\n");

                igInputInt("input int", &i0);
                igSameLine(); ShowHelpMarker("You can apply arithmetic operators +,*,/ on numerical values.\n  e.g. [ 100 ], input \'*2\', result becomes [ 200 ]\nUse +- to subtract.\n");

                igInputFloat("input float", &f0, 0.01f, 1.0f);

                static float[4] vec4a = [ 0.10f, 0.20f, 0.30f, 0.44f ];
                igInputFloat3("input float3", vec4a[0..3]);
            }

            {
                static int i1=50, i2=42;
                igDragInt("drag int", &i1, 1);
                igSameLine(); ShowHelpMarker("Click and drag to edit value.\nHold SHIFT/ALT for faster/slower edit.\nDouble-click or CTRL+click to input value.");

                igDragInt("drag int 0..100", &i2, 1, 0, 100, "%.0f%%");

                static float f1=1.00f, f2=0.0067f;
                igDragFloat("drag float", &f1, 0.005f);
                igDragFloat("drag small float", &f2, 0.0001f, 0.0f, 0.0f, "%.06f ns");
            }

            {
                static int i3=0;
                igSliderInt("slider int", &i3, -1, 3);
                igSameLine(); ShowHelpMarker("CTRL+click to input value.");

                static float f3=0.123f, f4=0.0f;
                igSliderFloat("slider float", &f3, 0.0f, 1.0f, "ratio = %.3f");
                igSliderFloat("slider log float", &f4, -10.0f, 10.0f, "%.4f", 3.0f);
                static float angle = 0.0f;
                igSliderAngle("slider angle", &angle);
            }

            static float[3] col1 = [ 1.0f,0.0f,0.2f ];
            static float[4] col2 = [ 0.4f,0.7f,0.0f,0.5f ];
            igColorEdit3("color 1", col1);
            igSameLine(); ShowHelpMarker("Click on the colored square to open a color picker.\nRight-click on the colored square to show options.\nCTRL+click on individual component to input value.\n");

            igColorEdit4("color 2", col2);

            const(char)*[] listbox_items = [ "Apple", "Banana", "Cherry", "Kiwi", "Mango", "Orange", "Pineapple", "Strawberry", "Watermelon" ];
            static int listbox_item_current = 1;
            igListBox("listbox\n(single select)", &listbox_item_current, listbox_items.ptr, IM_ARRAYSIZE(listbox_items), 4);

            //static int listbox_item_current2 = 2;
            //igPushItemWidth(-1);
            //igListBox("##listbox2", &listbox_item_current2, listbox_items, IM_ARRAYSIZE(listbox_items), 4);
            //igPopItemWidth();

            igTreePop();
        }

        if (igTreeNode("Trees"))
        {
            if (igTreeNode("Basic trees"))
            {
                for (int i = 0; i < 5; i++)
                    if (igTreeNodePtr(cast(void*)cast(intptr_t)i, "Child %d", i))
                    {
                        igText("blah blah");
                        igSameLine(); 
                        if (igSmallButton("print")) printf("Child %d pressed", i);
                        igTreePop();
                    }
                igTreePop();
            }

            if (igTreeNode("Advanced, with Selectable nodes"))
            {
                ShowHelpMarker("This is a more standard looking tree with selectable nodes.\nClick to select, CTRL+Click to toggle, click on arrows or double-click to open.");
                static bool align_label_with_current_x_position = false;
                igCheckbox("Align label with current X position)", &align_label_with_current_x_position);
                igText("Hello!");
                if (align_label_with_current_x_position)
                    igUnindent(igGetTreeNodeToLabelSpacing());

                static int selection_mask = (1 << 2); // Dumb representation of what may be user-side selection state. You may carry selection state inside or outside your objects in whatever format you see fit.
                int node_clicked = -1;                // Temporary storage of what node we have clicked to process selection at the end of the loop. May be a pointer to your own node type, etc.
                igPushStyleVar(ImGuiStyleVar_IndentSpacing, igGetFontSize()*3); // Increase spacing to differentiate leaves from expanded contents.
                for (int i = 0; i < 6; i++)
                {
                    // Disable the default open on single-click behavior and pass in Selected flag according to our selection state.
                    ImGuiTreeNodeFlags node_flags = ImGuiTreeNodeFlags_OpenOnArrow | ImGuiTreeNodeFlags_OpenOnDoubleClick | ((selection_mask & (1 << i)) ? ImGuiTreeNodeFlags_Selected : 0);
                    if (i < 3)
                    {
                        // Node
                        bool node_open = igTreeNodeExPtr(cast(void*)cast(intptr_t)i, node_flags, "Selectable Node %d", i);
                        if (igIsItemClicked()) 
                            node_clicked = i;
                        if (node_open)
                        {
                            igText("Blah blah\nBlah Blah");
                            igTreePop();
                        }
                    }
                    else
                    {
                        // Leaf: The only reason we have a TreeNode at all is to allow selection of the leaf. Otherwise we can use BulletText() or TreeAdvanceToLabelPos()+Text().
                        igTreeNodeExPtr(cast(void*)cast(intptr_t)i, node_flags | ImGuiTreeNodeFlags_Leaf | ImGuiTreeNodeFlags_NoTreePushOnOpen, "Selectable Leaf %d", i);
                        if (igIsItemClicked()) 
                            node_clicked = i;
                    }
                }
                if (node_clicked != -1)
                {
                    // Update selection state. Process outside of tree loop to avoid visual inconsistencies during the clicking-frame.
                    if (igGetIO().KeyCtrl)
                        selection_mask ^= (1 << node_clicked);          // CTRL+click to toggle
                    else //if (!(selection_mask & (1 << node_clicked))) // Depending on selection behavior you want, this commented bit preserve selection when clicking on item that is part of the selection
                        selection_mask = (1 << node_clicked);           // Click to single-select
                }
                igPopStyleVar();
                if (align_label_with_current_x_position)
                    igIndent(igGetTreeNodeToLabelSpacing());
                igTreePop();
            }
            igTreePop();
        }

        if (igTreeNode("Collapsing Headers"))
        {
            static bool closable_group = true;
            if (igCollapsingHeader("Header"))
            {
                igCheckbox("Enable extra group", &closable_group);
                for (int i = 0; i < 5; i++)
                    igText("Some content %d", i);
            }
            if (igCollapsingHeaderEx("Header with a close button", &closable_group))
            {
                for (int i = 0; i < 5; i++)
                    igText("More content %d", i);
            }
            igTreePop();
        }

        if (igTreeNode("Bullets"))
        {
            igBulletText("Bullet point 1");
            igBulletText("Bullet point 2\nOn multiple lines");
            igBullet(); igText("Bullet point 3 (two calls)");
            igBullet(); igSmallButton("Button");
            igTreePop();
        }

        if (igTreeNode("Text"))
        {
            if (igTreeNode("Colored Text"))
            {
                // Using shortcut. You can use PushStyleColor()/PopStyleColor() for more flexibility.
                igTextColored(ImVec4(1.0f,0.0f,1.0f,1.0f), "Pink");
                igTextColored(ImVec4(1.0f,1.0f,0.0f,1.0f), "Yellow");
                igTextDisabled("Disabled");
                igSameLine(); ShowHelpMarker("The TextDisabled color is stored in ImGuiStyle.");
                igTreePop();
            }

            if (igTreeNode("Word Wrapping"))
            {
                // Using shortcut. You can use PushTextWrapPos()/PopTextWrapPos() for more flexibility.
                igTextWrapped("This text should automatically wrap on the edge of the window. The current implementation for text wrapping follows simple rules suitable for English and possibly other languages.");
                igSpacing();

                static float wrap_width = 200.0f;
                igSliderFloat("Wrap width", &wrap_width, -20, 600, "%.0f");

                igText("Test paragraph 1:");
                ImVec2 pos;
                igGetCursorScreenPos(&pos);
                igGetWindowDrawList().ImDrawList_AddRectFilled(ImVec2(pos.x + wrap_width, pos.y), ImVec2(pos.x + wrap_width + 10, pos.y + igGetTextLineHeight()), IM_COL32(255,0,255,255));
                ImVec2 pos2;
                igGetCursorPos(&pos2);
                igPushTextWrapPos(pos2.x + wrap_width);
                igText("The lazy dog is a good dog. This paragraph is made to fit within %.0f pixels. Testing a 1 character word. The quick brown fox jumps over the lazy dog.", wrap_width);
                ImVec2 pos3;
                igGetItemRectMin(&pos3);
                ImVec2 pos4;
                igGetItemRectMax(&pos4);
                igGetWindowDrawList().ImDrawList_AddRect(pos3, pos4, IM_COL32(255,255,0,255));
                igPopTextWrapPos();

                igText("Test paragraph 2:");
                igGetCursorScreenPos(&pos);
                igGetWindowDrawList().ImDrawList_AddRectFilled(ImVec2(pos.x + wrap_width, pos.y), ImVec2(pos.x + wrap_width + 10, pos.y + igGetTextLineHeight()), IM_COL32(255,0,255,255));
                igGetCursorPos(&pos2);
                igPushTextWrapPos(pos2.x + wrap_width);
                igText("aaaaaaaa bbbbbbbb, c cccccccc,dddddddd. d eeeeeeee   ffffffff. gggggggg!hhhhhhhh");
                igGetItemRectMin(&pos3);
                igGetItemRectMax(&pos4);
                igGetWindowDrawList().ImDrawList_AddRect(pos3, pos4, IM_COL32(255,255,0,255));
                igPopTextWrapPos();

                igTreePop();
            }

            if (igTreeNode("UTF-8 Text"))
            {
                // UTF-8 test with Japanese characters
                // (needs a suitable font, try Arial Unicode or M+ fonts http://mplus-fonts.sourceforge.jp/mplus-outline-fonts/index-en.html)
                // - From C++11 you can use the u8"my text" syntax to encode literal strings as UTF-8
                // - For earlier compiler, you may be able to encode your sources as UTF-8 (e.g. Visual Studio save your file as 'UTF-8 without signature')
                // - HOWEVER, FOR THIS DEMO FILE, BECAUSE WE WANT TO SUPPORT COMPILER, WE ARE *NOT* INCLUDING RAW UTF-8 CHARACTERS IN THIS SOURCE FILE.
                //   Instead we are encoding a few string with hexadecimal constants. Don't do this in your application!
                // Note that characters values are preserved even by InputText() if the font cannot be displayed, so you can safely copy & paste garbled characters into another application.
                igTextWrapped("CJK text will only appears if the font was loaded with the appropriate CJK character ranges. Call io.Font.LoadFromFileTTF() manually to load extra character ranges.");
                igText("Hiragana: \xe3\x81\x8b\xe3\x81\x8d\xe3\x81\x8f\xe3\x81\x91\xe3\x81\x93 (kakikukeko)");
                igText("Kanjis: \xe6\x97\xa5\xe6\x9c\xac\xe8\xaa\x9e (nihongo)");
                static char[32] buf = "\xe6\x97\xa5\xe6\x9c\xac\xe8\xaa\x9e"; // "nihongo"
                igInputText("UTF-8 input", buf.ptr, IM_ARRAYSIZE(buf));
                igTreePop();
            }
            igTreePop();
        }

        if (igTreeNode("Images"))
        {
            igTextWrapped("Below we are displaying the font texture (which is the only texture we have access to in this demo). Use the 'ImTextureID' type as storage to pass pointers or identifier to your own texture data. Hover the texture for a zoomed view!");
            ImVec2 tex_screen_pos;
            igGetCursorScreenPos(&tex_screen_pos);
            float tex_w = cast(float)igGetIO().Fonts.ImFontAtlas_GetTexWidth;
            float tex_h = cast(float)igGetIO().Fonts.ImFontAtlas_GetTexHeight;
            ImTextureID tex_id = igGetIO().Fonts.ImFontAtlas_GetTexID;
            igText("%.0fx%.0f", tex_w, tex_h);
            igImage(tex_id, ImVec2(tex_w, tex_h), ImVec2(0,0), ImVec2(1,1), ImColor(255,255,255,255), ImColor(255,255,255,128));
            if (igIsItemHovered())
            {
                igBeginTooltip();
                float focus_sz = 32.0f;
                ImVec2 pos;
                igGetMousePos(&pos);
                float focus_x = pos.x - tex_screen_pos.x - focus_sz * 0.5f; if (focus_x < 0.0f) focus_x = 0.0f; else if (focus_x > tex_w - focus_sz) focus_x = tex_w - focus_sz;
                float focus_y = pos.y - tex_screen_pos.y - focus_sz * 0.5f; if (focus_y < 0.0f) focus_y = 0.0f; else if (focus_y > tex_h - focus_sz) focus_y = tex_h - focus_sz;
                igText("Min: (%.2f, %.2f)", focus_x, focus_y);
                igText("Max: (%.2f, %.2f)", focus_x + focus_sz, focus_y + focus_sz);
                ImVec2 uv0 = ImVec2((focus_x) / tex_w, (focus_y) / tex_h);
                ImVec2 uv1 = ImVec2((focus_x + focus_sz) / tex_w, (focus_y + focus_sz) / tex_h);
                igImage(tex_id, ImVec2(128,128), uv0, uv1, ImColor(255,255,255,255), ImColor(255,255,255,128));
                igEndTooltip();
            }
            igTextWrapped("And now some textured buttons..");
            static int pressed_count = 0;
            for (int i = 0; i < 8; i++)
            {
                igPushIDInt(i);
                int frame_padding = -1 + i;     // -1 = uses default padding
                if (igImageButton(tex_id, ImVec2(32,32), ImVec2(0,0), ImVec2(32.0f/tex_w,32/tex_h), frame_padding, ImColor(0,0,0,255)))
                    pressed_count += 1;
                igPopID();
                igSameLine();
            }
            igNewLine();
            igText("Pressed %d times.", pressed_count);
            igTreePop();
        }

        if (igTreeNode("Selectables"))
        {
            if (igTreeNode("Basic"))
            {
                static bool[4] selected = [ false, true, false, false ];
                igSelectableEx("1. I am selectable", &selected[0]);
                igSelectableEx("2. I am selectable", &selected[1]);
                igText("3. I am not selectable");
                igSelectableEx("4. I am selectable", &selected[2]);
                if (igSelectable("5. I am double clickable", selected[3], ImGuiSelectableFlags_AllowDoubleClick))
                    if (igIsMouseDoubleClicked(0))
                        selected[3] = !selected[3];
                igTreePop();
            }
            if (igTreeNode("Rendering more text into the same block"))
            {
                static bool[3] selected2 = [ false, false, false ];
                igSelectableEx("main.c", &selected2[0]);    igSameLine(300); igText(" 2,345 bytes");
                igSelectableEx("Hello.cpp", &selected2[1]); igSameLine(300); igText("12,345 bytes");
                igSelectableEx("Hello.h", &selected2[2]);   igSameLine(300); igText(" 2,345 bytes");
                igTreePop();
            }
            if (igTreeNode("In columns"))
            {
                igColumns(3, null, false);
                static bool[16] selected3 = 0;
                for (int i = 0; i < 16; i++)
                {
                    char[32] label; sprintf(label.ptr, "Item %d", i);
                    if (igSelectableEx(label.ptr, &selected3[i])) {}
                    igNextColumn();
                }
                igColumns(1);
                igTreePop();
            }
            if (igTreeNode("Grid"))
            {
                static bool[16] selected4 = [ true, false, false, false, false, true, false, false, false, false, true, false, false, false, false, true ];
                for (int i = 0; i < 16; i++)
                {
                    igPushIDInt(i);
                    if (igSelectableEx("Sailor", &selected4[i], 0, ImVec2(50,50)))
                    {
                        int x = i % 4, y = i / 4;
                        if (x > 0) selected4[i - 1] ^= 1;
                        if (x < 3) selected4[i + 1] ^= 1;
                        if (y > 0) selected4[i - 4] ^= 1;
                        if (y < 3) selected4[i + 4] ^= 1;
                    }
                    if ((i % 4) < 3) igSameLine();
                    igPopID();
                }
                igTreePop();
            }
            igTreePop();
        }

        if (igTreeNode("Filtered Text Input"))
        {
            static char[64] buf1 = ""; igInputText("default", buf1.ptr, 64);
            static char[64] buf2 = ""; igInputText("decimal", buf2.ptr, 64, ImGuiInputTextFlags_CharsDecimal);
            static char[64] buf3 = ""; igInputText("hexadecimal", buf3.ptr, 64, ImGuiInputTextFlags_CharsHexadecimal | ImGuiInputTextFlags_CharsUppercase);
            static char[64] buf4 = ""; igInputText("uppercase", buf4.ptr, 64, ImGuiInputTextFlags_CharsUppercase);
            static char[64] buf5 = ""; igInputText("no blank", buf5.ptr, 64, ImGuiInputTextFlags_CharsNoBlank);
            struct TextFilters {
                extern(C) nothrow static int FilterImGuiLetters(ImGuiTextEditCallbackData* data) {
                    if (data.EventChar < 256 && strchr("imgui", cast(char)data.EventChar))
                        return 0;
                    return 1; 
                } 
            }
            static char[64] buf6 = ""; igInputText("\"imgui\" letters", buf6.ptr, 64, ImGuiInputTextFlags_CallbackCharFilter, &TextFilters.FilterImGuiLetters);

            igText("Password input");
            static char[64] bufpass = "password123";
            igInputText("password", bufpass.ptr, 64, ImGuiInputTextFlags_Password | ImGuiInputTextFlags_CharsNoBlank);
            igSameLine(); ShowHelpMarker("Display all characters as '*'.\nDisable clipboard cut and copy.\nDisable logging.\n");
            igInputText("password (clear)", bufpass.ptr, 64, ImGuiInputTextFlags_CharsNoBlank);

            igTreePop();
        }

        if (igTreeNode("Multi-line Text Input"))
        {
            static bool read_only = false;
            static char[1024*16] text =
                "/*\n" ~
                " The Pentium F00F bug, shorthand for F0 0F C7 C8,\n" ~
                " the hexadecimal encoding of one offending instruction,\n" ~
                " more formally, the invalid operand with locked CMPXCHG8B\n" ~
                " instruction bug, is a design flaw in the majority of\n" ~
                " Intel Pentium, Pentium MMX, and Pentium OverDrive\n" ~
                " processors (all in the P5 microarchitecture).\n" ~
                "*/\n\n" ~
                "label:\n" ~
                "\tlock cmpxchg8b eax\n";

            igPushStyleVarVec(ImGuiStyleVar_FramePadding, ImVec2(0,0));
            igCheckbox("Read-only", &read_only);
            igPopStyleVar();
            igInputTextMultiline("##source", text.ptr, IM_ARRAYSIZE(text), ImVec2(-1.0f, igGetTextLineHeight() * 16), ImGuiInputTextFlags_AllowTabInput | (read_only ? ImGuiInputTextFlags_ReadOnly : 0));
            igTreePop();
        }


        if (igTreeNode("Plots widgets"))
        {
            static bool animate = true;
            igCheckbox("Animate", &animate);

            static float[] arr2 = [ 0.6f, 0.1f, 1.0f, 0.5f, 0.92f, 0.1f, 0.2f ];
            igPlotLines("Frame Times", arr2.ptr, IM_ARRAYSIZE(arr2));

            // Create a dummy array of contiguous float values to plot
            // Tip: If your float aren't contiguous but part of a structure, you can pass a pointer to your first float and the sizeof() of your structure in the Stride parameter.
            static float[90] values = 0;
            static int values_offset = 0;
            static float refresh_time = 0.0f;
            if (!animate || refresh_time == 0.0f)
                refresh_time = igGetTime();
            while (refresh_time < igGetTime()) // Create dummy data at fixed 60 hz rate for the demo
            {
                static float phase = 0.0f;
                values[values_offset] = cosf(phase);
                values_offset = (values_offset+1) % IM_ARRAYSIZE(values);
                phase += 0.10f*values_offset;
                refresh_time += 1.0f/60.0f;
            }
            igPlotLines("Lines", values.ptr, IM_ARRAYSIZE(values), values_offset, "avg 0.0", -1.0f, 1.0f, ImVec2(0,80));
            igPlotHistogram("Histogram", arr2.ptr, IM_ARRAYSIZE(arr2), 0, null, 0.0f, 1.0f, ImVec2(0,80));

            // Use functions to generate output
            // FIXME: This is rather awkward because current plot API only pass in indices. We probably want an API passing floats and user provide sample rate/count.
            extern (C) nothrow struct Funcs
            {
                static float Sin(void*, int i) { return sinf(i * 0.1f); }
                static float Saw(void*, int i) { return (i & 1) ? 1.0f : -1.0f; }
            }
            static int func_type = 0, display_count = 70;
            igSeparator();
            igPushItemWidth(100); igCombo2("func", &func_type, "Sin\0Saw\0"); igPopItemWidth();
            igSameLine();
            igSliderInt("Sample count", &display_count, 1, 400);
            auto func = (func_type == 0) ? &Funcs.Sin : &Funcs.Saw;
            igPlotLines2("Lines", func, null, display_count, 0, null, -1.0f, 1.0f, ImVec2(0,80));
            igPlotHistogram2("Histogram", func, null, display_count, 0, null, -1.0f, 1.0f, ImVec2(0,80));
            igSeparator();

            // Animate a simple progress bar
            static float progress = 0.0f, progress_dir = 1.0f;
            if (animate)
            {
                progress += progress_dir * 0.4f * igGetIO().DeltaTime;
                if (progress >= +1.1f) { progress = +1.1f; progress_dir *= -1.0f; }
                if (progress <= -0.1f) { progress = -0.1f; progress_dir *= -1.0f; }
            }

            // Typically we would use ImVec2(-1.0f,0.0f) to use all available width, or ImVec2(width,0.0f) for a specified width. ImVec2(0.0f,0.0f) uses ItemWidth.
            auto size_arg = ImVec2(0.0f, 0.0f);
            igProgressBar(progress, &size_arg);
            igSameLine(0.0f, igGetStyle().ItemInnerSpacing.x);
            igText("Progress Bar");

            float progress_saturated = (progress < 0.0f) ? 0.0f : (progress > 1.0f) ? 1.0f : progress;
            char[32] buf;
            sprintf(buf.ptr, "%d/%d", cast(int)(progress_saturated*1753), 1753);
            igProgressBar(progress, &size_arg, buf.ptr);
            igTreePop();
        }

        if (igTreeNode("Color/Picker Widgets"))
        {
            static ImVec4 color = ImColor(114, 144, 154, 200);

            static bool hdr = false;
            static bool alpha_preview = true;
            static bool alpha_half_preview = false;
            static bool options_menu = true;
            igCheckbox("With HDR", &hdr); igSameLine(); ShowHelpMarker("Currently all this does is to lift the 0..1 limits on dragging widgets.");
            igCheckbox("With Alpha Preview", &alpha_preview);
            igCheckbox("With Half Alpha Preview", &alpha_half_preview);
            igCheckbox("With Options Menu", &options_menu); igSameLine(); ShowHelpMarker("Right-click on the individual color widget to show options.");
            int misc_flags = (hdr ? ImGuiColorEditFlags_HDR : 0) | (alpha_half_preview ? ImGuiColorEditFlags_AlphaPreviewHalf : (alpha_preview ? ImGuiColorEditFlags_AlphaPreview : 0)) | (options_menu ? 0 : ImGuiColorEditFlags_NoOptions);

            igText("Color widget:");
            igSameLine(); ShowHelpMarker("Click on the colored square to open a color picker.\nCTRL+click on individual component to input value.\n");
            igColorEdit3("MyColor##1", (&color.x)[0..3], misc_flags);

            igText("Color widget HSV with Alpha:");
            igColorEdit4("MyColor##2", (&color.x)[0..4], ImGuiColorEditFlags_HSV | misc_flags);

            igText("Color widget with Float Display:");
            igColorEdit4("MyColor##2f", (&color.x)[0..4], ImGuiColorEditFlags_Float | misc_flags);

            igText("Color button with Picker:");
            igSameLine(); ShowHelpMarker("With the ImGuiColorEditFlags_NoInputs flag you can hide all the slider/text inputs.\nWith the ImGuiColorEditFlags_NoLabel flag you can pass a non-empty label which will only be used for the tooltip and picker popup.");
            igColorEdit4("MyColor##3", (&color.x)[0..4], ImGuiColorEditFlags_NoInputs | ImGuiColorEditFlags_NoLabel | misc_flags);

            igText("Color button with Custom Picker Popup:");
            static bool saved_palette_inited = false;
            static ImVec4[32] saved_palette;
            static ImVec4 backup_color;
            if (!saved_palette_inited)
                for (int n = 0; n < IM_ARRAYSIZE(saved_palette); n++)
                    igColorConvertHSVtoRGB(n / 31.0f, 0.8f, 0.8f, &saved_palette[n].x, &saved_palette[n].y, &saved_palette[n].z);
            bool open_popup = igColorButton("MyColor##3b", color, misc_flags);
            igSameLine();
            open_popup |= igButton("Palette");
            if (open_popup)
            {
                igOpenPopup("mypicker");
                backup_color = color;
            }
            if (igBeginPopup("mypicker"))
            {
                // FIXME: Adding a drag and drop example here would be perfect!
                igText("MY CUSTOM COLOR PICKER WITH AN AMAZING PALETTE!");
                igSeparator();
                igColorPicker4("##picker", (&color.x)[0..4], misc_flags | ImGuiColorEditFlags_NoSidePreview | ImGuiColorEditFlags_NoSmallPreview);
                igSameLine();
                igBeginGroup();
                igText("Current");
                igColorButton("##current", color, ImGuiColorEditFlags_NoPicker | ImGuiColorEditFlags_AlphaPreviewHalf, ImVec2(60,40));
                igText("Previous");
                if (igColorButton("##previous", backup_color, ImGuiColorEditFlags_NoPicker | ImGuiColorEditFlags_AlphaPreviewHalf, ImVec2(60,40)))
                    color = backup_color;
                igSeparator();
                igText("Palette");
                for (int n = 0; n < IM_ARRAYSIZE(saved_palette); n++)
                {
                    igPushIDInt(n);
                    if ((n % 8) != 0)
                        igSameLine(0.0f, igGetStyle().ItemSpacing.y);
                    if (igColorButton("##palette", saved_palette[n], ImGuiColorEditFlags_NoPicker | ImGuiColorEditFlags_NoTooltip, ImVec2(20,20)))
                        color = ImVec4(saved_palette[n].x, saved_palette[n].y, saved_palette[n].z, color.w); // Preserve alpha!
                    igPopID();
                }
                igEndGroup();
                igEndPopup();
            }

            igText("Color button only:");
            igColorButton("MyColor##3b", color, misc_flags, ImVec2(80,80));

            igText("Color picker:");
            static bool alpha = true;
            static bool alpha_bar = true;
            static bool side_preview = true;
            static bool ref_color = false;
            static ImVec4 ref_color_v = ImVec4(1.0f,0.0f,1.0f,0.5f);
            static int inputs_mode = 2;
            static int picker_mode = 0;
            igCheckbox("With Alpha", &alpha);
            igCheckbox("With Alpha Bar", &alpha_bar);
            igCheckbox("With Side Preview", &side_preview);
            if (side_preview)
            {
                igSameLine();
                igCheckbox("With Ref Color", &ref_color);
                if (ref_color)
                {
                    igSameLine();
                    igColorEdit4("##RefColor", (&ref_color_v.x)[0..4], ImGuiColorEditFlags_NoInputs | misc_flags);
                }
            }
            igCombo2("Inputs Mode", &inputs_mode, "All Inputs\0No Inputs\0RGB Input\0HSV Input\0HEX Input\0");
            igCombo2("Picker Mode", &picker_mode, "Auto/Current\0Hue bar + SV rect\0Hue wheel + SV triangle\0");
            igSameLine(); ShowHelpMarker("User can right-click the picker to change mode.");
            ImGuiColorEditFlags flags = misc_flags;
            if (!alpha) flags |= ImGuiColorEditFlags_NoAlpha; // This is by default if you call ColorPicker3() instead of ColorPicker4()
            if (alpha_bar) flags |= ImGuiColorEditFlags_AlphaBar;
            if (!side_preview) flags |= ImGuiColorEditFlags_NoSidePreview;
            if (picker_mode == 1) flags |= ImGuiColorEditFlags_PickerHueBar;
            if (picker_mode == 2) flags |= ImGuiColorEditFlags_PickerHueWheel;
            if (inputs_mode == 1) flags |= ImGuiColorEditFlags_NoInputs;
            if (inputs_mode == 2) flags |= ImGuiColorEditFlags_RGB;
            if (inputs_mode == 3) flags |= ImGuiColorEditFlags_HSV;
            if (inputs_mode == 4) flags |= ImGuiColorEditFlags_HEX;
            igColorPicker4("MyColor##4", (&color.x)[0..4], flags, ref_color ? &ref_color_v.x : null);

            igText("Programmatically set defaults/options:");
            igSameLine(); ShowHelpMarker("SetColorEditOptions() is designed to allow you to set boot-time default.\nWe don't have Push/Pop functions because you can force options on a per-widget basis if needed, and the user can change non-forced ones with the options menu.\nWe don't have a getter to avoid encouraging you to persistently save values that aren't forward-compatible.");
            if (igButton("Uint8 + HSV"))
                igSetColorEditOptions(ImGuiColorEditFlags_Uint8 | ImGuiColorEditFlags_HSV);
            igSameLine();
            if (igButton("Float + HDR"))
                igSetColorEditOptions(ImGuiColorEditFlags_Float | ImGuiColorEditFlags_RGB);

            igTreePop();
        }

        if (igTreeNode("Range Widgets"))
        {
            static float begin = 10, end = 90;
            static int begin_i = 100, end_i = 1000;
            igDragFloatRange2("range", &begin, &end, 0.25f, 0.0f, 100.0f, "Min: %.1f %%", "Max: %.1f %%");
            igDragIntRange2("range int (no bounds)", &begin_i, &end_i, 5, 0, 0, "Min: %.0f units", "Max: %.0f units");
            igTreePop();
        }

        if (igTreeNode("Multi-component Widgets"))
        {
            static float[4] vec4f = [ 0.10f, 0.20f, 0.30f, 0.44f ];
            static int[4] vec4i = [ 1, 5, 100, 255 ];

            igInputFloat2("input float2", vec4f[0..2]);
            igDragFloat2("drag float2", vec4f[0..2], 0.01f, 0.0f, 1.0f);
            igSliderFloat2("slider float2", vec4f[0..2], 0.0f, 1.0f);
            igDragInt2("drag int2", vec4i[0..2], 1, 0, 255);
            igInputInt2("input int2", vec4i[0..2]);
            igSliderInt2("slider int2", vec4i[0..2], 0, 255);
            igSpacing();

            igInputFloat3("input float3", vec4f[0..3]);
            igDragFloat3("drag float3", vec4f[0..3], 0.01f, 0.0f, 1.0f);
            igSliderFloat3("slider float3", vec4f[0..3], 0.0f, 1.0f);
            igDragInt3("drag int3", vec4i[0..3], 1, 0, 255);
            igInputInt3("input int3", vec4i[0..3]);
            igSliderInt3("slider int3", vec4i[0..3], 0, 255);
            igSpacing();

            igInputFloat4("input float4", vec4f);
            igDragFloat4("drag float4", vec4f, 0.01f, 0.0f, 1.0f);
            igSliderFloat4("slider float4", vec4f, 0.0f, 1.0f);
            igInputInt4("input int4", vec4i);
            igDragInt4("drag int4", vec4i, 1, 0, 255);
            igSliderInt4("slider int4", vec4i, 0, 255);

            igTreePop();
        }

        if (igTreeNode("Vertical Sliders"))
        {
            const float spacing = 4;
            igPushStyleVarVec(ImGuiStyleVar_ItemSpacing, ImVec2(spacing, spacing));

            static int int_value = 0;
            igVSliderInt("##int", ImVec2(18,160), &int_value, 0, 5);
            igSameLine();

            static float[7] values2 = [ 0.0f, 0.60f, 0.35f, 0.9f, 0.70f, 0.20f, 0.0f ];
            igPushIDStr("set1");
            for (int i = 0; i < 7; i++)
            {
                if (i > 0) igSameLine();
                igPushIDInt(i);
                igPushStyleColor(ImGuiCol_FrameBg, ImColor.HSV(i/7.0f, 0.5f, 0.5f).asImVec4);
                igPushStyleColor(ImGuiCol_FrameBgHovered, ImColor.HSV(i/7.0f, 0.6f, 0.5f).asImVec4);
                igPushStyleColor(ImGuiCol_FrameBgActive, ImColor.HSV(i/7.0f, 0.7f, 0.5f).asImVec4);
                igPushStyleColor(ImGuiCol_SliderGrab, ImColor.HSV(i/7.0f, 0.9f, 0.9f).asImVec4);
                igVSliderFloat("##v", ImVec2(18,160), &values2[i], 0.0f, 1.0f, "");
                if (igIsItemActive() || igIsItemHovered())
                    igSetTooltip("%.3f", values2[i]);
                igPopStyleColor(4);
                igPopID();
            }
            igPopID();

            igSameLine();
            igPushIDStr("set2");
            static float[4] values3 = [ 0.20f, 0.80f, 0.40f, 0.25f ];
            const int rows = 3;
            const ImVec2 small_slider_size = ImVec2(18, (160.0f-(rows-1)*spacing)/rows);
            for (int nx = 0; nx < 4; nx++)
            {
                if (nx > 0) igSameLine();
                igBeginGroup();
                for (int ny = 0; ny < rows; ny++)
                {
                    igPushIDInt(nx*rows+ny);
                    igVSliderFloat("##v", small_slider_size, &values3[nx], 0.0f, 1.0f, "");
                    if (igIsItemActive() || igIsItemHovered())
                        igSetTooltip("%.3f", values3[nx]);
                    igPopID();
                }
                igEndGroup();
            }
            igPopID();

            igSameLine();
            igPushIDStr("set3");
            for (int i = 0; i < 4; i++)
            {
                if (i > 0) igSameLine();
                igPushIDInt(i);
                igPushStyleVar(ImGuiStyleVar_GrabMinSize, 40);
                igVSliderFloat("##v", ImVec2(40,160), &values2[i], 0.0f, 1.0f, "%.2f\nsec");
                igPopStyleVar();
                igPopID();
            }
            igPopID();
            igPopStyleVar();
            igTreePop();
        }
    }

    if (igCollapsingHeader("Layout"))
    {
        if (igTreeNode("Child regions"))
        {
            igText("Without border");
            static int line = 50;
            bool goto_line = igButton("Goto");
            igSameLine();
            igPushItemWidth(100);
            goto_line |= igInputInt("##Line", &line, 0, 0, ImGuiInputTextFlags_EnterReturnsTrue);
            igPopItemWidth();
            igBeginChild("Sub1", ImVec2(igGetWindowContentRegionWidth() * 0.5f,300), false, ImGuiWindowFlags_HorizontalScrollbar);
            for (int i = 0; i < 100; i++)
            {
                igText("%04d: scrollable region", i);
                if (goto_line && line == i)
                    igSetScrollHere();
            }
            if (goto_line && line >= 100)
                igSetScrollHere();
            igEndChild();

            igSameLine();

            igPushStyleVar(ImGuiStyleVar_ChildWindowRounding, 5.0f);
            igBeginChild("Sub2", ImVec2(0,300), true);
            igText("With border");
            igColumns(2);
            for (int i = 0; i < 100; i++)
            {
                if (i == 50)
                    igNextColumn();
                char[32] buf;
                sprintf(buf.ptr, "%08x", i*5731);
                igButton(buf.ptr, ImVec2(-1.0f, 0.0f));
            }
            igEndChild();
            igPopStyleVar();

            igTreePop();
        }

        if (igTreeNode("Widgets Width"))
        {
            static float f = 0.0f;
            igText("PushItemWidth(100)");
            igSameLine(); ShowHelpMarker("Fixed width.");
            igPushItemWidth(100);
            igDragFloat("float##1", &f);
            igPopItemWidth();

            igText("PushItemWidth(GetWindowWidth() * 0.5f)");
            igSameLine(); ShowHelpMarker("Half of window width.");
            igPushItemWidth(igGetWindowWidth() * 0.5f);
            igDragFloat("float##2", &f);
            igPopItemWidth();

            igText("PushItemWidth(GetContentRegionAvailWidth() * 0.5f)");
            igSameLine(); ShowHelpMarker("Half of available width.\n(~ right-cursor_pos)\n(works within a column set)");
            igPushItemWidth(igGetContentRegionAvailWidth() * 0.5f);
            igDragFloat("float##3", &f);
            igPopItemWidth();

            igText("PushItemWidth(-100)");
            igSameLine(); ShowHelpMarker("Align to right edge minus 100");
            igPushItemWidth(-100);
            igDragFloat("float##4", &f);
            igPopItemWidth();

            igText("PushItemWidth(-1)");
            igSameLine(); ShowHelpMarker("Align to right edge");
            igPushItemWidth(-1);
            igDragFloat("float##5", &f);
            igPopItemWidth();

            igTreePop();
        }

        if (igTreeNode("Basic Horizontal Layout"))
        {
            igTextWrapped("(Use igSameLine() to keep adding items to the right of the preceding item)");

            // Text
            igText("Two items: Hello"); igSameLine();
            igTextColored(ImVec4(1,1,0,1), "Sailor");

            // Adjust spacing
            igText("More spacing: Hello"); igSameLine(0, 20);
            igTextColored(ImVec4(1,1,0,1), "Sailor");

            // Button
            igAlignFirstTextHeightToWidgets();
            igText("Normal buttons"); igSameLine();
            igButton("Banana"); igSameLine();
            igButton("Apple"); igSameLine();
            igButton("Corniflower");

            // Button
            igText("Small buttons"); igSameLine();
            igSmallButton("Like this one"); igSameLine();
            igText("can fit within a text block.");

            // Aligned to arbitrary position. Easy/cheap column.
            igText("Aligned");
            igSameLine(150); igText("x=150");
            igSameLine(300); igText("x=300");
            igText("Aligned");
            igSameLine(150); igSmallButton("x=150");
            igSameLine(300); igSmallButton("x=300");

            // Checkbox
            static bool c1=false,c2=false,c3=false,c4=false;
            igCheckbox("My", &c1); igSameLine();
            igCheckbox("Tailor", &c2); igSameLine();
            igCheckbox("Is", &c3); igSameLine();
            igCheckbox("Rich", &c4);

            // Various
            static float f5=1.0f, f6=2.0f, f7=3.0f;
            igPushItemWidth(80);
            const(char)*[] items = [ "AAAA", "BBBB", "CCCC", "DDDD" ];
            static int item3 = -1;
            igCombo("Combo", &item3, items.ptr, IM_ARRAYSIZE(items)); igSameLine();
            igSliderFloat("X", &f5, 0.0f,5.0f); igSameLine();
            igSliderFloat("Y", &f6, 0.0f,5.0f); igSameLine();
            igSliderFloat("Z", &f7, 0.0f,5.0f);
            igPopItemWidth();

            igPushItemWidth(80);
            igText("Lists:");
            static int[4] selection = [ 0, 1, 2, 3 ];
            for (int i = 0; i < 4; i++)
            {
                if (i > 0) igSameLine();
                igPushIDInt(i);
                igListBox("", &selection[i], items.ptr, IM_ARRAYSIZE(items));
                igPopID();
                //if (igIsItemHovered()) igSetTooltip("ListBox %d hovered", i);
            }
            igPopItemWidth();

            // Dummy
            ImVec2 sz = ImVec2(30,30);
            igButton("A", sz); igSameLine();
            igDummy(&sz); igSameLine();
            igButton("B", sz);

            igTreePop();
        }

        if (igTreeNode("Groups"))
        {
            igTextWrapped("(Using igBeginGroup()/EndGroup() to layout items. BeginGroup() basically locks the horizontal position. EndGroup() bundles the whole group so that you can use functions such as IsItemHovered() on it.)");
            igBeginGroup();
            {
                igBeginGroup();
                igButton("AAA");
                igSameLine();
                igButton("BBB");
                igSameLine();
                igBeginGroup();
                igButton("CCC");
                igButton("DDD");
                igEndGroup();
                if (igIsItemHovered())
                    igSetTooltip("Group hovered");
                igSameLine();
                igButton("EEE");
                igEndGroup();
            }
            // Capture the group size and create widgets using the same size
            ImVec2 size;
            igGetItemRectSize(&size);
            const float[5] values = [ 0.5f, 0.20f, 0.80f, 0.60f, 0.25f ];
            igPlotHistogram("##values", values.ptr, IM_ARRAYSIZE(values), 0, null, 0.0f, 1.0f, size);

            igButton("ACTION", ImVec2((size.x - igGetStyle().ItemSpacing.x)*0.5f,size.y));
            igSameLine();
            igButton("REACTION", ImVec2((size.x - igGetStyle().ItemSpacing.x)*0.5f,size.y));
            igEndGroup();
            igSameLine();

            igButton("LEVERAGE\nBUZZWORD", size);
            igSameLine();

            igListBoxHeader("List", size);
            igSelectable("Selected", true);
            igSelectable("Not Selected", false);
            igListBoxFooter();

            igTreePop();
        }

        if (igTreeNode("Text Baseline Alignment"))
        {
            igTextWrapped("(This is testing the vertical alignment that occurs on text to keep it at the same baseline as widgets. Lines only composed of text or \"small\" widgets fit in less vertical spaces than lines with normal widgets)");

            igText("One\nTwo\nThree"); igSameLine();
            igText("Hello\nWorld"); igSameLine();
            igText("Banana");

            igText("Banana"); igSameLine();
            igText("Hello\nWorld"); igSameLine();
            igText("One\nTwo\nThree");

            igButton("HOP##1"); igSameLine();
            igText("Banana"); igSameLine();
            igText("Hello\nWorld"); igSameLine();
            igText("Banana");

            igButton("HOP##2"); igSameLine();
            igText("Hello\nWorld"); igSameLine();
            igText("Banana");

            igButton("TEST##1"); igSameLine();
            igText("TEST"); igSameLine();
            igSmallButton("TEST##2");

            igAlignFirstTextHeightToWidgets(); // If your line starts with text, call this to align it to upcoming widgets.
            igText("Text aligned to Widget"); igSameLine();
            igButton("Widget##1"); igSameLine();
            igText("Widget"); igSameLine();
            igSmallButton("Widget##2");

            // Tree
            const float spacing = igGetStyle().ItemInnerSpacing.x;
            igButton("Button##1");
            igSameLine(0.0f, spacing);
            if (igTreeNode("Node##1")) { for (int i = 0; i < 6; i++) igBulletText("Item %d..", i); igTreePop(); }    // Dummy tree data

            igAlignFirstTextHeightToWidgets();         // Vertically align text node a bit lower so it'll be vertically centered with upcoming widget. Otherwise you can use SmallButton (smaller fit).
            bool node_open = igTreeNode("Node##2");  // Common mistake to avoid: if we want to SameLine after TreeNode we need to do it before we add child content.
            igSameLine(0.0f, spacing); igButton("Button##2");
            if (node_open) { for (int i = 0; i < 6; i++) igBulletText("Item %d..", i); igTreePop(); }   // Dummy tree data

            // Bullet
            igButton("Button##3");
            igSameLine(0.0f, spacing);
            igBulletText("Bullet text");

            igAlignFirstTextHeightToWidgets();
            igBulletText("Node");
            igSameLine(0.0f, spacing); igButton("Button##4");

            igTreePop();
        }

        if (igTreeNode("Scrolling"))
        {
            igTextWrapped("(Use SetScrollHere() or SetScrollFromPosY() to scroll to a given position.)");
            static bool track = true;
            static int track_line = 50, scroll_to_px = 200;
            igCheckbox("Track", &track);
            igPushItemWidth(100);
            igSameLine(130); track |= igDragInt("##line", &track_line, 0.25f, 0, 99, "Line = %.0f");
            bool scroll_to = igButton("Scroll To Pos");
            igSameLine(130); scroll_to |= igDragInt("##pos_y", &scroll_to_px, 1.00f, 0, 9999, "Y = %.0f px");
            igPopItemWidth();
            if (scroll_to) track = false;

            for (int i = 0; i < 5; i++)
            {
                if (i > 0) igSameLine();
                igBeginGroup();
                igText("%s", (i == 0 ? "Top" : i == 1 ? "25%" : i == 2 ? "Center" : i == 3 ? "75%" : "Bottom").ptr);
                igBeginChildEx(igGetIdPtr(cast(void*)cast(intptr_t)i), ImVec2(igGetWindowWidth() * 0.17f, 200.0f), true);
                if (scroll_to) {
                    ImVec2 pos;
                    igGetCursorStartPos(&pos);
                    igSetScrollFromPosY(pos.y + scroll_to_px, i * 0.25f);
                }
                for (int line = 0; line < 100; line++)
                {
                    if (track && line == track_line)
                    {
                        igTextColored(ImColor(255,255,0), "Line %d", line);
                        igSetScrollHere(i * 0.25f); // 0.0f:top, 0.5f:center, 1.0f:bottom
                    }
                    else
                    {
                        igText("Line %d", line);
                    }
                }
                float scroll_y = igGetScrollY(), scroll_max_y = igGetScrollMaxY();
                igEndChild();
                igText("%.0f/%0.f", scroll_y, scroll_max_y);
                igEndGroup();
            }
            igTreePop();
        }

        if (igTreeNode("Horizontal Scrolling"))
        {
            igBullet(); igTextWrapped("Horizontal scrolling for a window has to be enabled explicitly via the ImGuiWindowFlags_HorizontalScrollbar flag.");
            igBullet(); igTextWrapped("You may want to explicitly specify content width by calling SetNextWindowContentWidth() before Begin().");
            static int lines = 7;
            igSliderInt("Lines", &lines, 1, 15);
            igPushStyleVar(ImGuiStyleVar_FrameRounding, 3.0f);
            igPushStyleVarVec(ImGuiStyleVar_FramePadding, ImVec2(2.0f, 1.0f));
            igBeginChild("scrolling", ImVec2(0, igGetItemsLineHeightWithSpacing()*7 + 30), true, ImGuiWindowFlags_HorizontalScrollbar);
            for (int line = 0; line < lines; line++)
            {
                // Display random stuff (for the sake of this trivial demo we are using basic Button+SameLine. If you want to create your own time line for a real application you may be better off 
                // manipulating the cursor position yourself, aka using SetCursorPos/SetCursorScreenPos to position the widgets yourself. You may also want to use the lower-level ImDrawList API)
                int num_buttons = 10 + ((line & 1) ? line * 9 : line * 3);
                for (int n = 0; n < num_buttons; n++)
                {
                    if (n > 0) igSameLine();
                    igPushIDInt(n + line * 1000);
                    char[16] num_buf;
                    const(char)* label = ((!(n%15)) ? "FizzBuzz" : (!(n%3)) ? "Fizz" : (!(n%5)) ? "Buzz" : format("%d\0", n)).ptr;
                    float hue = n*0.05f;
                    igPushStyleColor(ImGuiCol_Button, ImColor.HSV(hue, 0.6f, 0.6f).asImVec4);
                    igPushStyleColor(ImGuiCol_ButtonHovered, ImColor.HSV(hue, 0.7f, 0.7f).asImVec4);
                    igPushStyleColor(ImGuiCol_ButtonActive, ImColor.HSV(hue, 0.8f, 0.8f).asImVec4);
                    igButton(label, ImVec2(40.0f + sinf(cast(float)(line + n)) * 20.0f, 0.0f));
                    igPopStyleColor(3);
                    igPopID();
                }
            }
            float scroll_x = igGetScrollX(), scroll_max_x = igGetScrollMaxX();
            igEndChild();
            igPopStyleVar(2);
            float scroll_x_delta = 0.0f;
            igSmallButton("<<"); if (igIsItemActive()) scroll_x_delta = -igGetIO().DeltaTime * 1000.0f; igSameLine(); 
            igText("Scroll from code"); igSameLine();
            igSmallButton(">>"); if (igIsItemActive()) scroll_x_delta = +igGetIO().DeltaTime * 1000.0f; igSameLine(); 
            igText("%.0f/%.0f", scroll_x, scroll_max_x);
            if (scroll_x_delta != 0.0f)
            {
                igBeginChild("scrolling"); // Demonstrate a trick: you can use Begin to set yourself in the context of another window (here we are already out of your child window)
                igSetScrollX(igGetScrollX() + scroll_x_delta);
                igEnd();
            }
            igTreePop();
        }

        if (igTreeNode("Clipping"))
        {
            static ImVec2 size = ImVec2(100, 100), offset = ImVec2(50, 20);
            igTextWrapped("On a per-widget basis we are occasionally clipping text CPU-side if it won't fit in its frame. Otherwise we are doing coarser clipping + passing a scissor rectangle to the renderer. The system is designed to try minimizing both execution and CPU/GPU rendering cost.");
            igDragFloat2("size", (&size.x)[0..2], 0.5f, 0.0f, 200.0f, "%.0f");
            igTextWrapped("(Click and drag)");
            ImVec2 pos;
            igGetCursorScreenPos(&pos);
            ImVec4 clip_rect = ImVec4(pos.x, pos.y, pos.x+size.x, pos.y+size.y);
            igInvisibleButton("##dummy", size);
            if (igIsItemActive() && igIsMouseDragging()) { offset.x += igGetIO().MouseDelta.x; offset.y += igGetIO().MouseDelta.y; }
            igGetWindowDrawList().ImDrawList_AddRectFilled(pos, ImVec2(pos.x+size.x,pos.y+size.y), ImColor(90,90,120,255).asImU32);
            igGetWindowDrawList().ImDrawList_AddTextExt(igGetFont(), igGetFontSize()*2.0f, ImVec2(pos.x+offset.x,pos.y+offset.y), ImColor(255,255,255,255).asImU32, "Line 1 hello\nLine 2 clip me!", null, 0.0f, &clip_rect);
            igTreePop();
        }
    }

    if (igCollapsingHeader("Popups & Modal windows"))
    {
        if (igTreeNode("Popups"))
        {
            igTextWrapped("When a popup is active, it inhibits interacting with windows that are behind the popup. Clicking outside the popup closes it.");

            static int selected_fish = -1;
            const(char)*[] names = [ "Bream", "Haddock", "Mackerel", "Pollock", "Tilefish" ];
            static bool[] toggles = [ true, false, false, false, false ];

            // Simple selection popup
            // (If you want to show the current selection inside the Button itself, you may want to build a string using the "###" operator to preserve a constant ID with a variable label)
            if (igButton("Select.."))
                igOpenPopup("select");
            igSameLine();
            igText(selected_fish == -1 ? "<None>" : names[selected_fish]);
            if (igBeginPopup("select"))
            {
                igText("Aquarium");
                igSeparator();
                for (int i = 0; i < IM_ARRAYSIZE(names); i++)
                    if (igSelectable(names[i]))
                        selected_fish = i;
                igEndPopup();
            }

            // Showing a menu with toggles
            if (igButton("Toggle.."))
                igOpenPopup("toggle");
            if (igBeginPopup("toggle"))
            {
                for (int i = 0; i < IM_ARRAYSIZE(names); i++)
                    igMenuItemPtr(names[i], "", &toggles[i]);
                if (igBeginMenu("Sub-menu"))
                {
                    igMenuItem("Click me");
                    igEndMenu();
                }

                igSeparator();
                igText("Tooltip here");
                if (igIsItemHovered())
                    igSetTooltip("I am a tooltip over a popup");

                if (igButton("Stacked Popup"))
                    igOpenPopup("another popup");
                if (igBeginPopup("another popup"))
                {
                    for (int i = 0; i < IM_ARRAYSIZE(names); i++)
                        igMenuItemPtr(names[i], "", &toggles[i]);
                    if (igBeginMenu("Sub-menu"))
                    {
                        igMenuItem("Click me");
                        igEndMenu();
                    }
                    igEndPopup();
                }
                igEndPopup();
            }

            if (igButton("Popup Menu.."))
                igOpenPopup("FilePopup");
            if (igBeginPopup("FilePopup"))
            {
                ShowExampleMenuFile();
                igEndPopup();
            }

            igSpacing();
            igTextWrapped("Below we are testing adding menu items to a regular window. It's rather unusual but should work!");
            igSeparator();
            // NB: As a quirk in this very specific example, we want to differentiate the parent of this menu from the parent of the various popup menus above.
            // To do so we are encloding the items in a PushID()/PopID() block to make them two different menusets. If we don't, opening any popup above and hovering our menu here
            // would open it. This is because once a menu is active, we allow to switch to a sibling menu by just hovering on it, which is the desired behavior for regular menus.
            igPushIDStr("foo");
            igMenuItem("Menu item", "CTRL+M");
            if (igBeginMenu("Menu inside a regular window"))
            {
                ShowExampleMenuFile();
                igEndMenu();
            }
            igPopID();
            igSeparator();

            igTreePop();
        }

        if (igTreeNode("Context menus"))
        {
            static float value = 0.5f;
            igText("Value = %.3f (<-- right-click here)", value);
            if (igBeginPopupContextItem("item context menu"))
            {
                if (igSelectable("Set to zero")) value = 0.0f;
                if (igSelectable("Set to PI")) value = 3.1415f;
                igDragFloat("Value", &value, 0.1f, 0.0f, 0.0f);
                igEndPopup();
            }

            static char[32] name = "Label1";
            char[64] buf; sprintf(buf.ptr, "Button: %s###Button", name.ptr); // ### operator override ID ignoring the preceeding label
            igButton(buf.ptr);
            if (igBeginPopupContextItem("rename context menu"))
            {
                igText("Edit name:");
                igInputText("##edit", name.ptr, IM_ARRAYSIZE(name));
                if (igButton("Close"))
                    igCloseCurrentPopup();
                igEndPopup();
            }
            igSameLine(); igText("(<-- right-click here)");

            igTreePop();
        }

        if (igTreeNode("Modals"))
        {
            igTextWrapped("Modal windows are like popups but the user cannot close them by clicking outside the window.");

            if (igButton("Delete.."))
                igOpenPopup("Delete?");
            if (igBeginPopupModal("Delete?", null, ImGuiWindowFlags_AlwaysAutoResize))
            {
                igText("All those beautiful files will be deleted.\nThis operation cannot be undone!\n\n");
                igSeparator();

                //static int dummy_i = 0;
                //igCombo("Combo", &dummy_i, "Delete\0Delete harder\0");

                static bool dont_ask_me_next_time = false;
                igPushStyleVarVec(ImGuiStyleVar_FramePadding, ImVec2(0,0));
                igCheckbox("Don't ask me next time", &dont_ask_me_next_time);
                igPopStyleVar();

                if (igButton("OK", ImVec2(120,0))) { igCloseCurrentPopup(); }
                igSameLine();
                if (igButton("Cancel", ImVec2(120,0))) { igCloseCurrentPopup(); }
                igEndPopup();
            }

            if (igButton("Stacked modals.."))
                igOpenPopup("Stacked 1");
            if (igBeginPopupModal("Stacked 1"))
            {
                igText("Hello from Stacked The First\nUsing style.Colors[ImGuiCol_ModalWindowDarkening] for darkening.");
                static int item4 = 1;
                igCombo2("Combo", &item4, "aaaa\0bbbb\0cccc\0dddd\0eeee\0\0");

                if (igButton("Add another modal.."))
                    igOpenPopup("Stacked 2");
                if (igBeginPopupModal("Stacked 2"))
                {
                    igText("Hello from Stacked The Second");
                    if (igButton("Close"))
                        igCloseCurrentPopup();
                    igEndPopup();
                }

                if (igButton("Close"))
                    igCloseCurrentPopup();
                igEndPopup();
            }

            igTreePop();
        }
    }

    if (igCollapsingHeader("Columns"))
    {
        igPushIDStr("Columns");

        // Basic columns
        if (igTreeNode("Basic"))
        {
            igText("Without border:");
            igColumns(3, "mycolumns3", false);  // 3-ways, no border
            igSeparator();
            for (int n = 0; n < 14; n++)
            {
                char[32] label;
                sprintf(label.ptr, "Item %d", n);
                if (igSelectable(label.ptr)) {}
                //if (igButton(label, ImVec2(-1,0))) {}
                igNextColumn();
            }
            igColumns(1);
            igSeparator();

            igText("With border:");
            igColumns(4, "mycolumns"); // 4-ways, with border
            igSeparator();
            igText("ID"); igNextColumn();
            igText("Name"); igNextColumn();
            igText("Path"); igNextColumn();
            igText("Flags"); igNextColumn();
            igSeparator();
            const(char)*[3] names = [ "One", "Two", "Three" ];
            const(char)*[3] paths = [ "/path/one", "/path/two", "/path/three" ];
            static int selected5 = -1;
            for (int i = 0; i < 3; i++)
            {
                char[32] label;
                sprintf(label.ptr, "%04d", i);
                if (igSelectable(label.ptr, selected5 == i, ImGuiSelectableFlags_SpanAllColumns))
                    selected5 = i;
                igNextColumn();
                igText(names[i]); igNextColumn();
                igText(paths[i]); igNextColumn();
                igText("...."); igNextColumn();
            }
            igColumns(1);
            igSeparator();
            igTreePop();
        }

        // Create multiple items in a same cell before switching to next column
        if (igTreeNode("Mixed items"))
        {
            igColumns(3, "mixed");
            igSeparator();

            igText("Hello");
            igButton("Banana");
            igNextColumn();

            igText("ImGui");
            igButton("Apple");
            static float foo = 1.0f;
            igInputFloat("red", &foo, 0.05f, 0, 3);
            igText("An extra line here.");
            igNextColumn();

            igText("Sailor");
            igButton("Corniflower");
            static float bar = 1.0f;
            igInputFloat("blue", &bar, 0.05f, 0, 3);
            igNextColumn();

            if (igCollapsingHeader("Category A")) igText("Blah blah blah"); igNextColumn();
            if (igCollapsingHeader("Category B")) igText("Blah blah blah"); igNextColumn();
            if (igCollapsingHeader("Category C")) igText("Blah blah blah"); igNextColumn();
            igColumns(1);
            igSeparator();
            igTreePop();
        }

        // Word wrapping
        if (igTreeNode("Word-wrapping"))
        {
            igColumns(2, "word-wrapping");
            igSeparator();
            igTextWrapped("The quick brown fox jumps over the lazy dog.");
            igTextWrapped("Hello Left");
            igNextColumn();
            igTextWrapped("The quick brown fox jumps over the lazy dog.");
            igTextWrapped("Hello Right");
            igColumns(1);
            igSeparator();
            igTreePop();
        }

        if (igTreeNode("Borders"))
        {
            // NB: Future columns API should allow automatic horizontal borders.
            static bool h_borders = true;
            static bool v_borders = true;
            igCheckbox("horizontal", &h_borders);
            igSameLine();
            igCheckbox("vertical", &v_borders);
            igColumns(4, null, v_borders);
            for (int i = 0; i < 4*3; i++)
            {
                if (h_borders && igGetColumnIndex() == 0)
                    igSeparator();
                igText("%c%c%c", 'a'+i, 'a'+i, 'a'+i);
                igText("Width %.2f\nOffset %.2f", igGetColumnWidth(), igGetColumnOffset());
                igNextColumn();
            }
            igColumns(1);
            if (h_borders)
                igSeparator();
            igTreePop();
        }

        // Scrolling columns
        /*
        if (igTreeNode("Vertical Scrolling"))
        {
            igBeginChild("##header", ImVec2(0, igGetTextLineHeightWithSpacing()+igGetStyle().ItemSpacing.y));
            igColumns(3);
            igText("ID"); igNextColumn();
            igText("Name"); igNextColumn();
            igText("Path"); igNextColumn();
            igColumns(1);
            igSeparator();
            igEndChild();
            igBeginChild("##scrollingregion", ImVec2(0, 60));
            igColumns(3);
            for (int i = 0; i < 10; i++)
            {
                igText("%04d", i); igNextColumn();
                igText("Foobar"); igNextColumn();
                igText("/path/foobar/%04d/", i); igNextColumn();
            }
            igColumns(1);
            igEndChild();
            igTreePop();
        }
        */

        if (igTreeNode("Horizontal Scrolling"))
        {
            igSetNextWindowContentWidth(1500);
            igBeginChild("##scrollingregion", ImVec2(0, 120), false, ImGuiWindowFlags_HorizontalScrollbar);
            igColumns(10);
            for (int i = 0; i < 20; i++)
                for (int j = 0; j < 10; j++)
                {
                    igText("Line %d Column %d...", i, j);
                    igNextColumn();
                }
            igColumns(1);
            igEndChild();
            igTreePop();
        }

        bool node_open = igTreeNode("Tree within single cell");
        igSameLine(); ShowHelpMarker("NB: Tree node must be poped before ending the cell. There's no storage of state per-cell.");
        if (node_open)
        {
            igColumns(2, "tree items");
            igSeparator();
            if (igTreeNode("Hello")) { igBulletText("Sailor"); igTreePop(); } igNextColumn();
            if (igTreeNode("Bonjour")) { igBulletText("Marin"); igTreePop(); } igNextColumn();
            igColumns(1);
            igSeparator();
            igTreePop();
        }
        igPopID();
    }

    if (igCollapsingHeader("Filtering"))
    {
        static ImGuiTextFilterWrapper filter;
        igText("Filter usage:\n" ~
                    "  \"\"         display all lines\n" ~
                    "  \"xxx\"      display lines containing \"xxx\"\n" ~
                    "  \"xxx,yyy\"  display lines containing \"xxx\" or \"yyy\"\n" ~
                    "  \"-xxx\"     hide lines containing \"xxx\"");
        filter.Draw();
        const(char)*[] lines = [ "aaa1.c", "bbb1.c", "ccc1.c", "aaa2.cpp", "bbb2.cpp", "ccc2.cpp", "abc.h", "hello, world" ];
        for (int i = 0; i < IM_ARRAYSIZE(lines); i++)
            if (filter.PassFilter(lines[i]))
                igBulletText("%s", lines[i]);
    }

    if (igCollapsingHeader("Inputs & Focus"))
    {
        auto io = igGetIO();
        igCheckbox("io.MouseDrawCursor", &io.MouseDrawCursor);
        igSameLine(); ShowHelpMarker("Request ImGui to render a mouse cursor for you in software. Note that a mouse cursor rendered via regular GPU rendering will feel more laggy than hardware cursor, but will be more in sync with your other visuals.");

        igText("WantCaptureMouse: %d", io.WantCaptureMouse);
        igText("WantCaptureKeyboard: %d", io.WantCaptureKeyboard);
        igText("WantTextInput: %d", io.WantTextInput);

        if (igTreeNode("Keyboard & Mouse State"))
        {
            igText("Mouse pos: (%g, %g)", io.MousePos.x, io.MousePos.y);
            igText("Mouse down:");     for (int i = 0; i < IM_ARRAYSIZE(io.MouseDown); i++) if (io.MouseDownDuration[i] >= 0.0f)   { igSameLine(); igText("b%d (%.02f secs)", i, io.MouseDownDuration[i]); }
            igText("Mouse clicked:");  for (int i = 0; i < IM_ARRAYSIZE(io.MouseDown); i++) if (igIsMouseClicked(i))          { igSameLine(); igText("b%d", i); }
            igText("Mouse dbl-clicked:"); for (int i = 0; i < IM_ARRAYSIZE(io.MouseDown); i++) if (igIsMouseDoubleClicked(i)) { igSameLine(); igText("b%d", i); }
            igText("Mouse released:"); for (int i = 0; i < IM_ARRAYSIZE(io.MouseDown); i++) if (igIsMouseReleased(i))         { igSameLine(); igText("b%d", i); }
            igText("Mouse wheel: %.1f", io.MouseWheel);

            igText("Keys down:");      for (int i = 0; i < IM_ARRAYSIZE(io.KeysDown); i++) if (io.KeysDownDuration[i] >= 0.0f)     { igSameLine(); igText("%d (%.02f secs)", i, io.KeysDownDuration[i]); }
            igText("Keys pressed:");   for (int i = 0; i < IM_ARRAYSIZE(io.KeysDown); i++) if (igIsKeyPressed(i))             { igSameLine(); igText("%d", i); }
            igText("Keys release:");   for (int i = 0; i < IM_ARRAYSIZE(io.KeysDown); i++) if (igIsKeyReleased(i))            { igSameLine(); igText("%d", i); }
            igText("Keys mods: %s%s%s%s", (io.KeyCtrl ? "CTRL " : "").ptr, (io.KeyShift ? "SHIFT " : "").ptr, (io.KeyAlt ? "ALT " : "").ptr, (io.KeySuper ? "SUPER " : "").ptr);


            igButton("Hovering me sets the\nkeyboard capture flag");
            if (igIsItemHovered())
                igCaptureKeyboardFromApp(true);
            igSameLine();
            igButton("Holding me clears the\nthe keyboard capture flag");
            if (igIsItemActive())
                igCaptureKeyboardFromApp(false);

            igTreePop();
        }

        if (igTreeNode("Tabbing"))
        {
            igText("Use TAB/SHIFT+TAB to cycle through keyboard editable fields.");
            static char[32] buf7 = "dummy";
            igInputText("1", buf7.ptr, IM_ARRAYSIZE(buf7));
            igInputText("2", buf7.ptr, IM_ARRAYSIZE(buf7));
            igInputText("3", buf7.ptr, IM_ARRAYSIZE(buf7));
            igPushAllowKeyboardFocus(false);
            igInputText("4 (tab skip)", buf7.ptr, IM_ARRAYSIZE(buf7));
            //igSameLine(); ShowHelperMarker("Use igPushAllowKeyboardFocus(bool)\nto disable tabbing through certain widgets.");
            igPopAllowKeyboardFocus();
            igInputText("5", buf7.ptr, IM_ARRAYSIZE(buf7));
            igTreePop();
        }

        if (igTreeNode("Focus from code"))
        {
            bool focus_1 = igButton("Focus on 1"); igSameLine();
            bool focus_2 = igButton("Focus on 2"); igSameLine();
            bool focus_3 = igButton("Focus on 3");
            int has_focus = 0;
            static char[128] buf8 = "click on a button to set focus";

            if (focus_1) igSetKeyboardFocusHere();
            igInputText("1", buf8.ptr, IM_ARRAYSIZE(buf8));
            if (igIsItemActive()) has_focus = 1;

            if (focus_2) igSetKeyboardFocusHere();
            igInputText("2", buf8.ptr, IM_ARRAYSIZE(buf8));
            if (igIsItemActive()) has_focus = 2;

            igPushAllowKeyboardFocus(false);
            if (focus_3) igSetKeyboardFocusHere();
            igInputText("3 (tab skip)", buf8.ptr, IM_ARRAYSIZE(buf8));
            if (igIsItemActive()) has_focus = 3;
            igPopAllowKeyboardFocus();
            if (has_focus)
                igText("Item with focus: %d", has_focus);
            else
                igText("Item with focus: <none>");
            igTextWrapped("Cursor & selection are preserved when refocusing last used item in code.");
            igTreePop();
        }

        if (igTreeNode("Dragging"))
        {
            igTextWrapped("You can use igGetMouseDragDelta(0) to query for the dragged amount on any widget.");
            igButton("Drag Me");
            if (igIsItemActive())
            {
                // Draw a line between the button and the mouse cursor
                ImDrawList* draw_list = igGetWindowDrawList();
                draw_list.ImDrawList_PushClipRectFullScreen();
                ImVec2 pos1;
                igCalcItemRectClosestPoint(&pos1, igGetIO().MousePos, true, -2.0f);
                draw_list.ImDrawList_AddLine(pos1, io.MousePos, ImColor(igGetStyle().Colors[ImGuiCol_Button]).asImU32, 4.0f);
                draw_list.ImDrawList_PopClipRect();
                ImVec2 value_raw;
                igGetMouseDragDelta(&value_raw, 0, 0.0f);
                ImVec2 value_with_lock_threshold;
                igGetMouseDragDelta(&value_with_lock_threshold, 0);
                ImVec2 mouse_delta = io.MouseDelta;
                igSameLine(); igText("Raw (%.1f, %.1f), WithLockThresold (%.1f, %.1f), MouseDelta (%.1f, %.1f)", value_raw.x, value_raw.y, value_with_lock_threshold.x, value_with_lock_threshold.y, mouse_delta.x, mouse_delta.y);
            }
            igTreePop();
        }

        if (igTreeNode("Mouse cursors"))
        {
            igText("Hover to see mouse cursors:");
            igSameLine(); ShowHelpMarker("Your application can render a different mouse cursor based on what igGetMouseCursor() returns. If software cursor rendering (io.MouseDrawCursor) is set ImGui will draw the right cursor for you, otherwise your backend needs to handle it.");
            for (int i = 0; i < ImGuiMouseCursor_Count_; i++)
            {
                char[32] label;
                sprintf(label.ptr, "Mouse cursor %d", i);
                igBullet(); igSelectable(label.ptr, false);
                if (igIsItemHovered())
                    igSetMouseCursor(i);
            }
            igTreePop();
        }
    }

    igEnd();
}

void igShowStyleEditor(ImGuiStyle* ref_ = null)
{
    ImGuiStyle* style = igGetStyle();

    // You can pass in a reference ImGuiStyle structure to compare to, revert to and save to (else it compares to the default style)
    const ImGuiStyle default_style; // Default style
    if (igButton("Revert Style"))
        *style = ref_ ? *ref_ : default_style;

    if (ref_)
    {
        igSameLine();
        if (igButton("Save Style"))
            *ref_ = *style;
    }

    igPushItemWidth(igGetWindowWidth() * 0.55f);

    if (igTreeNode("Rendering"))
    {
        igCheckbox("Anti-aliased lines", &style.AntiAliasedLines); igSameLine(); ShowHelpMarker("When disabling anti-aliasing lines, you'll probably want to disable borders in your style as well.");
        igCheckbox("Anti-aliased shapes", &style.AntiAliasedShapes);
        igPushItemWidth(100);
        igDragFloat("Curve Tessellation Tolerance", &style.CurveTessellationTol, 0.02f, 0.10f, FLT_MAX, null, 2.0f);
        if (style.CurveTessellationTol < 0.0f) style.CurveTessellationTol = 0.10f;
        igDragFloat("Global Alpha", &style.Alpha, 0.005f, 0.20f, 1.0f, "%.2f"); // Not exposing zero here so user doesn't "lose" the UI (zero alpha clips all widgets). But application code could have a toggle to switch between zero and non-zero.
        igPopItemWidth();
        igTreePop();
    }

    if (igTreeNode("Settings"))
    {
        igSliderFloat2("WindowPadding", (&style.WindowPadding.x)[0..2], 0.0f, 20.0f, "%.0f");
        igSliderFloat("WindowRounding", &style.WindowRounding, 0.0f, 16.0f, "%.0f");
        igSliderFloat("ChildWindowRounding", &style.ChildWindowRounding, 0.0f, 16.0f, "%.0f");
        igSliderFloat2("FramePadding", (&style.FramePadding.x)[0..2], 0.0f, 20.0f, "%.0f");
        igSliderFloat("FrameRounding", &style.FrameRounding, 0.0f, 16.0f, "%.0f");
        igSliderFloat2("ItemSpacing", (&style.ItemSpacing.x)[0..2], 0.0f, 20.0f, "%.0f");
        igSliderFloat2("ItemInnerSpacing", (&style.ItemInnerSpacing.x)[0..2], 0.0f, 20.0f, "%.0f");
        igSliderFloat2("TouchExtraPadding", (&style.TouchExtraPadding.x)[0..2], 0.0f, 10.0f, "%.0f");
        igSliderFloat("IndentSpacing", &style.IndentSpacing, 0.0f, 30.0f, "%.0f");
        igSliderFloat("ScrollbarSize", &style.ScrollbarSize, 1.0f, 20.0f, "%.0f");
        igSliderFloat("ScrollbarRounding", &style.ScrollbarRounding, 0.0f, 16.0f, "%.0f");
        igSliderFloat("GrabMinSize", &style.GrabMinSize, 1.0f, 20.0f, "%.0f");
        igSliderFloat("GrabRounding", &style.GrabRounding, 0.0f, 16.0f, "%.0f");
        igText("Alignment");
        igSliderFloat2("WindowTitleAlign", (&style.WindowTitleAlign.x)[0..2], 0.0f, 1.0f, "%.2f");
        igSliderFloat2("ButtonTextAlign", (&style.ButtonTextAlign.x)[0..2], 0.0f, 1.0f, "%.2f"); igSameLine(); ShowHelpMarker("Alignment applies when a button is larger than its text content.");
        igTreePop();
    }

    if (igTreeNode("Colors"))
    {
        static int output_dest = 0;
        static bool output_only_modified = false;
        if (igButton("Copy Colors"))
        {
            if (output_dest == 0)
                igLogToClipboard();
            else
                igLogToTTY();
            igLogText("ImGuiStyle& style = igGetStyle();" ~ IM_NEWLINE);
            for (int i = 0; i < ImGuiCol_COUNT; i++)
            {
                const ImVec4* col = &style.Colors[i];
                const(char)* name = igGetStyleColorName(i);
                if (!output_only_modified || memcmp(col, (ref_ ? &ref_.Colors[i] : &default_style.Colors[i]), ImVec4.sizeof) != 0)
                    igLogText("style.Colors[ImGuiCol_%s]%*s= ImVec4(%.2ff, %.2ff, %.2ff, %.2ff);" ~ IM_NEWLINE, name, 22 - cast(int)strlen(name), "".ptr, col.x, col.y, col.z, col.w);
            }
            igLogFinish();
        }
        igSameLine(); igPushItemWidth(120); igCombo2("##output_type", &output_dest, "To Clipboard\0To TTY\0"); igPopItemWidth();
        igSameLine(); igCheckbox("Only Modified Fields", &output_only_modified);

        igText("Tip: Left-click on colored square to open color picker,\nRight-click to open edit options menu.");

        static ImGuiTextFilterWrapper filter;
        filter.Draw("Filter colors", 200);

        static ImGuiColorEditFlags alpha_flags = 0;
        igRadioButton("Opaque", &alpha_flags, 0); igSameLine(); 
        igRadioButton("Alpha", &alpha_flags, ImGuiColorEditFlags_AlphaPreview); igSameLine(); 
        igRadioButton("Both", &alpha_flags, ImGuiColorEditFlags_AlphaPreviewHalf);

        igBeginChild("#colors", ImVec2(0, 300), true, ImGuiWindowFlags_AlwaysVerticalScrollbar);
        igPushItemWidth(-160);
        for (int i = 0; i < ImGuiCol_COUNT; i++)
        {
            const(char)* name = igGetStyleColorName(i);
            if (!filter.PassFilter(name))
                continue;
            igPushIDInt(i);
            igColorEdit4(name, (&style.Colors[i].x)[0..4], ImGuiColorEditFlags_AlphaBar | alpha_flags);
            if (memcmp(&style.Colors[i], (ref_ ? &ref_.Colors[i] : &default_style.Colors[i]), ImVec4.sizeof) != 0)
            {
                igSameLine(); if (igButton("Revert")) style.Colors[i] = ref_ ? ref_.Colors[i] : default_style.Colors[i];
                if (ref_) { igSameLine(); if (igButton("Save")) ref_.Colors[i] = style.Colors[i]; }
            }
            igPopID();
        }
        igPopItemWidth();
        igEndChild();

        igTreePop();
    }

    bool fonts_opened = igTreeNodeStr("Fonts", "Fonts (%d)", ImFontAtlas_Fonts_size(igGetIO().Fonts));
    igSameLine(); ShowHelpMarker("Tip: Load fonts with io.Fonts.AddFontFromFileTTF()\nbefore calling io.Fonts.GetTex* functions.");
    if (fonts_opened)
    {
        ImFontAtlas* atlas = igGetIO().Fonts;
        if (igTreeNodeStr("Atlas texture", "Atlas texture (%dx%d pixels)", ImFontAtlas_GetTexWidth(atlas), ImFontAtlas_GetTexHeight(atlas)))
        {
            igImage(ImFontAtlas_GetTexID(atlas), ImVec2(ImFontAtlas_GetTexWidth(atlas), ImFontAtlas_GetTexHeight(atlas)), ImVec2(0,0), ImVec2(1,1), ImColor(255,255,255,255), ImColor(255,255,255,128));
            igTreePop();
        }
        igPushItemWidth(100);
        for (int i = 0; i < ImFontAtlas_Fonts_size(igGetIO().Fonts); i++)
        {
            ImFont* font = ImFontAtlas_Fonts_index(atlas, i);
            bool font_details_opened = igTreeNodePtr(font, "Font %d: \'%s\', %.2f px, %d glyphs", i, ImFont_GetConfigData(font) ? &ImFont_GetConfigData(font)[0].Name[0] : "", ImFont_GetFontSize(font), ImFont_Glyphs_size(font));
            igSameLine(); if (igSmallButton("Set as default")) igGetIO().FontDefault = font;
            if (font_details_opened)
            {
                igPushFont(font);
                igText("The quick brown fox jumps over the lazy dog");
                igPopFont();
                float fontScale = ImFont_GetScale(font);
                igDragFloat("Font scale", &fontScale, 0.005f, 0.3f, 2.0f, "%.1f");   // Scale only this font
                ImFont_SetScale(font, fontScale);
                igSameLine(); ShowHelpMarker("Note than the default embedded font is NOT meant to be scaled.\n\nFont are currently rendered into bitmaps at a given size at the time of building the atlas. You may oversample them to get some flexibility with scaling. You can also render at multiple sizes and select which one to use at runtime.\n\n(Glimmer of hope: the atlas system should hopefully be rewritten in the future to make scaling more natural and automatic.)");
                igText("Ascent: %f, Descent: %f, Height: %f", ImFont_GetAscent(font), ImFont_GetDescent(font), ImFont_GetAscent(font) - ImFont_GetDescent(font));
                igText("Fallback character: '%c' (%d)", ImFont_GetFallbackChar(font), ImFont_GetFallbackChar(font));
                igText("Texture surface: %d pixels (approx) ~ %dx%d", ImFont_GetMetricsTotalSurface(font), cast(int)sqrtf(cast(float)ImFont_GetMetricsTotalSurface(font)), cast(int)sqrtf(cast(float)ImFont_GetMetricsTotalSurface(font)));
                auto c = ImFont_GetConfigDataCount(font);
                for (int config_i = 0; config_i < c; config_i++)
                {
                    ImFontConfig* cfg = &ImFont_GetConfigData(font)[config_i];
                    igBulletText("Input %d: \'%s\', Oversample: (%d,%d), PixelSnapH: %d", config_i, cfg.Name.ptr, cfg.OversampleH, cfg.OversampleV, cfg.PixelSnapH);
                }
                if (igTreeNodeStr("Glyphs", "Glyphs (%d)", ImFont_Glyphs_size(font)))
                {
                    // Display all glyphs of the fonts in separate pages of 256 characters
                    const ImFont_Glyph* glyph_fallback = ImFont_GetFallbackGlyph(font); // Forcefully/dodgily make FindGlyph() return null on fallback, which isn't the default behavior.
                    ImFont_SetFallbackGlyph(font, null);
                    for (int base = 0; base < 0x10000; base += 256)
                    {
                        int count = 0;
                        for (int n = 0; n < 256; n++)
                            count += ImFont_FindGlyph(font, cast(ImWchar)(base + n)) ? 1 : 0;
                        if (count > 0 && igTreeNodePtr(cast(void*)cast(intptr_t)base, "U+%04X..U+%04X (%d %s)", base, base+255, count, (count > 1 ? "glyphs" : "glyph").ptr))
                        {
                            float cell_spacing = style.ItemSpacing.y;
                            ImVec2 cell_size = ImVec2(ImFont_GetFontSize(font) * 1, ImFont_GetFontSize(font) * 1);
                            ImVec2 base_pos;
                            igGetCursorScreenPos(&base_pos);
                            ImDrawList* draw_list = igGetWindowDrawList();
                            for (int n = 0; n < 256; n++)
                            {
                                ImVec2 cell_p1 = ImVec2(base_pos.x + (n % 16) * (cell_size.x + cell_spacing), base_pos.y + (n / 16) * (cell_size.y + cell_spacing));
                                ImVec2 cell_p2 = ImVec2(cell_p1.x + cell_size.x, cell_p1.y + cell_size.y);
                                const ImFont_Glyph* glyph = ImFont_FindGlyph(font, cast(ImWchar)(base+n));
                                draw_list.ImDrawList_AddRect(cell_p1, cell_p2, glyph ? IM_COL32(255,255,255,100) : IM_COL32(255,255,255,50));
                                font.ImFont_RenderChar(draw_list, cell_size.x, cell_p1, igGetColorU32(ImGuiCol_Text), cast(ImWchar)(base+n)); // We use ImFont.RenderChar as a shortcut because we don't have UTF-8 conversion functions available to generate a string.
                                if (glyph && igIsMouseHoveringRect(cell_p1, cell_p2))
                                {
                                    igBeginTooltip();
                                    igText("Codepoint: U+%04X", base+n);
                                    igSeparator();
                                    igText("XAdvance+1: %.1f", glyph.XAdvance);
                                    igText("Pos: (%.2f,%.2f)->(%.2f,%.2f)", glyph.X0, glyph.Y0, glyph.X1, glyph.Y1);
                                    igText("UV: (%.3f,%.3f)->(%.3f,%.3f)", glyph.U0, glyph.V0, glyph.U1, glyph.V1);
                                    igEndTooltip();
                                }
                            }
                            auto sz = ImVec2((cell_size.x + cell_spacing) * 16, (cell_size.y + cell_spacing) * 16);
                            igDummy(&sz);
                            igTreePop();
                        }
                    }
                    ImFont_SetFallbackGlyph(font, glyph_fallback);
                    igTreePop();
                }
                igTreePop();
            }
        }
        static float window_scale = 1.0f;
        igDragFloat("this window scale", &window_scale, 0.005f, 0.3f, 2.0f, "%.1f");              // scale only this window
        igDragFloat("global scale", &igGetIO().FontGlobalScale, 0.005f, 0.3f, 2.0f, "%.1f"); // scale everything
        igPopItemWidth();
        igSetWindowFontScale(window_scale);
        igTreePop();
    }

    igPopItemWidth();
}

// Demonstrate creating a fullscreen menu bar and populating it.
void ShowExampleAppMainMenuBar()
{
    if (igBeginMainMenuBar())
    {
        if (igBeginMenu("File"))
        {
            ShowExampleMenuFile();
            igEndMenu();
        }
        if (igBeginMenu("Edit"))
        {
            if (igMenuItem("Undo", "CTRL+Z")) {}
            if (igMenuItem("Redo", "CTRL+Y", false, false)) {}  // Disabled item
            igSeparator();
            if (igMenuItem("Cut", "CTRL+X")) {}
            if (igMenuItem("Copy", "CTRL+C")) {}
            if (igMenuItem("Paste", "CTRL+V")) {}
            igEndMenu();
        }
        igEndMainMenuBar();
    }
}

void ShowExampleMenuFile()
{
    igMenuItem("(dummy menu)", null, false, false);
    if (igMenuItem("New")) {}
    if (igMenuItem("Open", "Ctrl+O")) {}
    if (igBeginMenu("Open Recent"))
    {
        igMenuItem("fish_hat.c");
        igMenuItem("fish_hat.inl");
        igMenuItem("fish_hat.h");
        if (igBeginMenu("More.."))
        {
            igMenuItem("Hello");
            igMenuItem("Sailor");
            if (igBeginMenu("Recurse.."))
            {
                ShowExampleMenuFile();
                igEndMenu();
            }
            igEndMenu();
        }
        igEndMenu();
    }
    if (igMenuItem("Save", "Ctrl+S")) {}
    if (igMenuItem("Save As..")) {}
    igSeparator();
    if (igBeginMenu("Options"))
    {
        static bool enabled = true;
        igMenuItemPtr("Enabled", "", &enabled);
        igBeginChild("child", ImVec2(0, 60), true);
        for (int i = 0; i < 10; i++)
            igText("Scrolling Text %d", i);
        igEndChild();
        static float f = 0.5f;
        static int n = 0;
        static bool b = true;
        igSliderFloat("Value", &f, 0.0f, 1.0f);
        igInputFloat("Input", &f, 0.1f);
        igCombo2("Combo", &n, "Yes\0No\0Maybe\0\0");
        igCheckbox("Check", &b);
        igEndMenu();
    }
    if (igBeginMenu("Colors"))
    {
        for (int i = 0; i < ImGuiCol_COUNT; i++)
            igMenuItem(igGetStyleColorName(cast(ImGuiCol)i));
        igEndMenu();
    }
    if (igBeginMenu("Disabled", false)) // Disabled
    {
        assert(0);
    }
    if (igMenuItem("Checked", null, true)) {}
    if (igMenuItem("Quit", "Alt+F4")) {}
}

// Demonstrate creating a window which gets auto-resized according to its content.
void ShowExampleAppAutoResize(bool* p_open)
{
    if (!igBegin("Example: Auto-resizing window", p_open, ImGuiWindowFlags_AlwaysAutoResize))
    {
        igEnd();
        return;
    }

    static int lines = 10;
    igText("Window will resize every-frame to the size of its content.\nNote that you probably don't want to query the window size to\noutput your content because that would create a feedback loop.");
    igSliderInt("Number of lines", &lines, 1, 20);
    for (int i = 0; i < lines; i++)
        igText("%*sThis is line %d", i*4, "".ptr, i); // Pad with space to extend size horizontally
    igEnd();
}

// Demonstrate creating a window with custom resize constraints.
void ShowExampleAppConstrainedResize(bool* p_open)
{
    struct CustomConstraints // Helper functions to demonstrate programmatic constraints
    {
    extern (C) nothrow:
        static void Square(ImGuiSizeConstraintCallbackData* data) { data.DesiredSize = ImVec2(IM_MAX(data.DesiredSize.x, data.DesiredSize.y), IM_MAX(data.DesiredSize.x, data.DesiredSize.y)); }
        static void Step(ImGuiSizeConstraintCallbackData* data)   { float step = cast(float)cast(int)cast(intptr_t)data.UserData; data.DesiredSize = ImVec2(cast(int)(data.DesiredSize.x / step + 0.5f) * step, cast(int)(data.DesiredSize.y / step + 0.5f) * step); }
    }

    static int type = 0;
    if (type == 0) igSetNextWindowSizeConstraints(ImVec2(-1, 0),    ImVec2(-1, FLT_MAX));      // Vertical only
    if (type == 1) igSetNextWindowSizeConstraints(ImVec2(0, -1),    ImVec2(FLT_MAX, -1));      // Horizontal only
    if (type == 2) igSetNextWindowSizeConstraints(ImVec2(100, 100), ImVec2(FLT_MAX, FLT_MAX)); // Width > 100, Height > 100
    if (type == 3) igSetNextWindowSizeConstraints(ImVec2(300, 0),   ImVec2(400, FLT_MAX));     // Width 300-400
    if (type == 4) igSetNextWindowSizeConstraints(ImVec2(0, 0),     ImVec2(FLT_MAX, FLT_MAX), &CustomConstraints.Square);          // Always Square
    if (type == 5) igSetNextWindowSizeConstraints(ImVec2(0, 0),     ImVec2(FLT_MAX, FLT_MAX), &CustomConstraints.Step, cast(void*)100);// Fixed Step

    if (igBegin("Example: Constrained Resize", p_open))
    {
        const(char)*[] desc = 
        [
            "Resize vertical only",
            "Resize horizontal only",
            "Width > 100, Height > 100",
            "Width 300-400",
            "Custom: Always Square",
            "Custom: Fixed Steps (100)",
        ];
        igCombo("Constraint", &type, desc.ptr, IM_ARRAYSIZE(desc)); 
        if (igButton("200x200")) igSetWindowSize(ImVec2(200,200)); igSameLine();
        if (igButton("500x500")) igSetWindowSize(ImVec2(500,500)); igSameLine();
        if (igButton("800x200")) igSetWindowSize(ImVec2(800,200));
        for (int i = 0; i < 10; i++) 
            igText("Hello, sailor! Making this line long enough for the example.");
    }
    igEnd();
}

// Demonstrate creating a simple static window with no decoration.
void ShowExampleAppFixedOverlay(bool* p_open)
{
    igSetNextWindowPos(ImVec2(10,10));
    if (!igBegin2("Example: Fixed Overlay", p_open, ImVec2(0,0), 0.3f, ImGuiWindowFlags_NoTitleBar|ImGuiWindowFlags_NoResize|ImGuiWindowFlags_NoMove|ImGuiWindowFlags_NoSavedSettings))
    {
        igEnd();
        return;
    }
    igText("Simple overlay\non the top-left side of the screen.");
    igSeparator();
    igText("Mouse Position: (%.1f,%.1f)", igGetIO().MousePos.x, igGetIO().MousePos.y);
    igEnd();
}

// Demonstrate using "##" and "###" in identifiers to manipulate ID generation.
// Read section "How can I have multiple widgets with the same label? Can I have widget without a label? (Yes). A primer on the purpose of labels/IDs." about ID.
void ShowExampleAppManipulatingWindowTitle(bool*)
{
    // By default, Windows are uniquely identified by their title.
    // You can use the "##" and "###" markers to manipulate the display/ID.

    // Using "##" to display same title but have unique identifier.
    igSetNextWindowPos(ImVec2(100,100), ImGuiCond_FirstUseEver);
    igBegin("Same title as another window##1");
    igText("This is window 1.\nMy title is the same as window 2, but my identifier is unique.");
    igEnd();

    igSetNextWindowPos(ImVec2(100,200), ImGuiCond_FirstUseEver);
    igBegin("Same title as another window##2");
    igText("This is window 2.\nMy title is the same as window 1, but my identifier is unique.");
    igEnd();

    // Using "###" to display a changing title but keep a static identifier "AnimatedTitle"
    char[128] buf;
    sprintf(buf.ptr, "Animated title %c %d###AnimatedTitle", "|/-\\"[cast(int)(igGetTime()/0.25f)&3], rand());
    igSetNextWindowPos(ImVec2(100,300), ImGuiCond_FirstUseEver);
    igBegin(buf.ptr);
    igText("This window has a changing title.");
    igEnd();
}

// Demonstrate using the low-level ImDrawList to draw custom shapes. 
void ShowExampleAppCustomRendering(bool* p_open)
{
    igSetNextWindowSize(ImVec2(350,560), ImGuiCond_FirstUseEver);
    if (!igBegin("Example: Custom rendering", p_open))
    {
        igEnd();
        return;
    }

    // Tip: If you do a lot of custom rendering, you probably want to use your own geometrical types and benefit of overloaded operators, etc.
    // Define IM_VEC2_CLASS_EXTRA in imconfig.h to create implicit conversions between your types and ImVec2/ImVec4.
    // ImGui defines overloaded operators but they are internal to imgui.cpp and not exposed outside (to avoid messing with your types)
    // In this example we are not using the maths operators!
    ImDrawList* draw_list = igGetWindowDrawList();

    // Primitives
    igText("Primitives");
    static float sz = 36.0f;
    static ImVec4 col = ImVec4(1.0f,1.0f,0.4f,1.0f);
    igDragFloat("Size", &sz, 0.2f, 2.0f, 72.0f, "%.0f");
    igColorEdit3("Color", (&col.x)[0..3]);
    {
        ImVec2 p;
        igGetCursorScreenPos(&p);
        const ImU32 col32 = ImColor(col).asImU32;
        float x = p.x + 4.0f, y = p.y + 4.0f, spacing = 8.0f;
        for (int n = 0; n < 2; n++)
        {
            float thickness = (n == 0) ? 1.0f : 4.0f;
            draw_list.ImDrawList_AddCircle(ImVec2(x+sz*0.5f, y+sz*0.5f), sz*0.5f, col32, 20, thickness); x += sz+spacing;
            draw_list.ImDrawList_AddRect(ImVec2(x, y), ImVec2(x+sz, y+sz), col32, 0.0f, ~0, thickness); x += sz+spacing;
            draw_list.ImDrawList_AddRect(ImVec2(x, y), ImVec2(x+sz, y+sz), col32, 10.0f, ~0, thickness); x += sz+spacing;
            draw_list.ImDrawList_AddTriangle(ImVec2(x+sz*0.5f, y), ImVec2(x+sz,y+sz-0.5f), ImVec2(x,y+sz-0.5f), col32, thickness); x += sz+spacing;
            draw_list.ImDrawList_AddLine(ImVec2(x, y), ImVec2(x+sz, y   ), col32, thickness); x += sz+spacing;
            draw_list.ImDrawList_AddLine(ImVec2(x, y), ImVec2(x+sz, y+sz), col32, thickness); x += sz+spacing;
            draw_list.ImDrawList_AddLine(ImVec2(x, y), ImVec2(x,    y+sz), col32, thickness); x += spacing;
            draw_list.ImDrawList_AddBezierCurve(ImVec2(x, y), ImVec2(x+sz*1.3f,y+sz*0.3f), ImVec2(x+sz-sz*1.3f,y+sz-sz*0.3f), ImVec2(x+sz, y+sz), col32, thickness);
            x = p.x + 4;
            y += sz+spacing;
        }
        draw_list.ImDrawList_AddCircleFilled(ImVec2(x+sz*0.5f, y+sz*0.5f), sz*0.5f, col32, 32); x += sz+spacing;
        draw_list.ImDrawList_AddRectFilled(ImVec2(x, y), ImVec2(x+sz, y+sz), col32); x += sz+spacing;
        draw_list.ImDrawList_AddRectFilled(ImVec2(x, y), ImVec2(x+sz, y+sz), col32, 10.0f); x += sz+spacing;
        draw_list.ImDrawList_AddTriangleFilled(ImVec2(x+sz*0.5f, y), ImVec2(x+sz,y+sz-0.5f), ImVec2(x,y+sz-0.5f), col32); x += sz+spacing;
        draw_list.ImDrawList_AddRectFilledMultiColor(ImVec2(x, y), ImVec2(x+sz, y+sz), ImColor(0,0,0).asImU32, ImColor(255,0,0).asImU32, ImColor(255,255,0).asImU32, ImColor(0,255,0).asImU32);
        auto sz2 = ImVec2((sz+spacing)*8, (sz+spacing)*3);
        igDummy(&sz2);
    }
    igSeparator();
    {
        static ImVec2[] points;
        static bool adding_line = false;
        igText("Canvas example");
        if (igButton("Clear")) points = null;
        if (points.length >= 2) { igSameLine(); if (igButton("Undo")) { points = points[0..$-2]; } }
        igText("Left-click and drag to add lines,\nRight-click to undo");

        // Here we are using InvisibleButton() as a convenience to 1) advance the cursor and 2) allows us to use IsItemHovered()
        // However you can draw directly and poll mouse/keyboard by yourself. You can manipulate the cursor using GetCursorPos() and SetCursorPos().
        // If you only use the ImDrawList API, you can notify the owner window of its extends by using SetCursorPos(max).
        ImVec2 canvas_pos;
        igGetCursorScreenPos(&canvas_pos);            // ImDrawList API uses screen coordinates!
        ImVec2 canvas_size;
        igGetContentRegionAvail(&canvas_size);        // Resize canvas to what's available
        if (canvas_size.x < 50.0f) canvas_size.x = 50.0f;
        if (canvas_size.y < 50.0f) canvas_size.y = 50.0f;
        draw_list.ImDrawList_AddRectFilledMultiColor(canvas_pos, ImVec2(canvas_pos.x + canvas_size.x, canvas_pos.y + canvas_size.y), ImColor(50,50,50).asImU32, ImColor(50,50,60).asImU32, ImColor(60,60,70).asImU32, ImColor(50,50,60).asImU32);
        draw_list.ImDrawList_AddRect(canvas_pos, ImVec2(canvas_pos.x + canvas_size.x, canvas_pos.y + canvas_size.y), ImColor(255,255,255).asImU32);

        bool adding_preview = false;
        igInvisibleButton("canvas", canvas_size);
        ImVec2 mouse_pos_in_canvas = ImVec2(igGetIO().MousePos.x - canvas_pos.x, igGetIO().MousePos.y - canvas_pos.y);
        if (adding_line)
        {
            adding_preview = true;
            points ~= mouse_pos_in_canvas;
            if (!igGetIO().MouseDown[0])
                adding_line = adding_preview = false;
        }
        if (igIsItemHovered())
        {
            if (!adding_line && igIsMouseClicked(0))
            {
                points ~= mouse_pos_in_canvas;
                adding_line = true;
            }
            if (igIsMouseClicked(1) && !points.empty())
            {
                adding_line = adding_preview = false;
                points = points[0..$-2];
            }
        }
        draw_list.ImDrawList_PushClipRect(canvas_pos, ImVec2(canvas_pos.x+canvas_size.x, canvas_pos.y+canvas_size.y));      // clip lines within the canvas (if we resize it, etc.)
        for (int i = 0; i + 1 < points.length; i += 2)
            draw_list.ImDrawList_AddLine(ImVec2(canvas_pos.x + points[i].x, canvas_pos.y + points[i].y), ImVec2(canvas_pos.x + points[i+1].x, canvas_pos.y + points[i+1].y), IM_COL32(255,255,0,255), 2.0f);
        draw_list.ImDrawList_PopClipRect();
        if (adding_preview)
            points = points[0..$-1];
    }
    igEnd();
}

// Demonstrating creating a simple console window, with scrolling, filtering, completion and history.
// For the console example, here we are using a more C++ like approach of declaring a class to hold the data and the functions.
class ExampleAppConsole
{
    char[256]             InputBuf;
    string[]              Items;
    bool                  ScrollToBottom;
    string[]              History;
    int                   HistoryPos;    // -1: new line, 0..History.Size-1 browsing history.
    string[]              Commands;

    this()
    {
        ClearLog();
        InputBuf[] = 0;
        HistoryPos = -1;
        Commands ~= "HELP";
        Commands ~= "HISTORY";
        Commands ~= "CLEAR";
        Commands ~= "CLASSIFY";  // "classify" is here to provide an example of "C"+[tab] completing to "CL" and displaying matches.
        AddLog("Welcome to ImGui!");
    }
    ~this()
    {
        ClearLog();
        History = null;
    }

    // Portable helpers
    static int   Stricmp(const(char)* str1, const(char)* str2)         { int d; while ((d = toupper(*str2) - toupper(*str1)) == 0 && *str1) { str1++; str2++; } return d; }
    static int   Strnicmp(const(char)* str1, const(char)* str2, int n) { int d = 0; while (n > 0 && (d = toupper(*str2) - toupper(*str1)) == 0 && *str1) { str1++; str2++; n--; } return d; }
    static string Strdup(const(char)* str)                             { return to!string(str); }

    void    ClearLog()
    {
        Items = null;
        ScrollToBottom = true;
    }

    void    AddLog(Char, Args...)(in Char[] fmt, Args args)
    {
        Items ~= format(fmt, args);
        ScrollToBottom = true;
    }

    void    Draw(const(char)* title, bool* p_open)
    {
        igSetNextWindowSize(ImVec2(520,600), ImGuiCond_FirstUseEver);
        if (!igBegin(title, p_open))
        {
            igEnd();
            return;
        }

        igTextWrapped("This example implements a console with basic coloring, completion and history. A more elaborate implementation may want to store entries along with extra data such as timestamp, emitter, etc.");
        igTextWrapped("Enter 'HELP' for help, press TAB to use text completion.");

        // TODO: display items starting from the bottom

        if (igSmallButton("Add Dummy Text")) { AddLog("%d some text", Items.length); AddLog("some more text"); AddLog("display very important message here!"); } igSameLine();
        if (igSmallButton("Add Dummy Error")) AddLog("[error] something went wrong"); igSameLine();
        if (igSmallButton("Clear")) ClearLog(); igSameLine();
        bool copy_to_clipboard = igSmallButton("Copy"); igSameLine();
        if (igSmallButton("Scroll to bottom")) ScrollToBottom = true;
        //static float t = 0.0f; if (igGetTime() - t > 0.02f) { t = igGetTime(); AddLog("Spam %f", t); }

        igSeparator();

        igPushStyleVarVec(ImGuiStyleVar_FramePadding, ImVec2(0,0));
        static ImGuiTextFilterWrapper filter;
        filter.Draw("Filter (\"incl,-excl\") (\"error\")", 180);
        igPopStyleVar();
        igSeparator();

        igBeginChild("ScrollingRegion", ImVec2(0,-igGetItemsLineHeightWithSpacing()), false, ImGuiWindowFlags_HorizontalScrollbar);
        if (igBeginPopupContextWindow())
        {
            if (igSelectable("Clear")) ClearLog();
            igEndPopup();
        }

        // Display every line as a separate entry so we can change their color or add custom widgets. If you only want raw text you can use igTextUnformatted(log.begin(), log.end());
        // NB- if you have thousands of entries this approach may be too inefficient and may require user-side clipping to only process visible items.
        // You can seek and display only the lines that are visible using the ImGuiListClipper helper, if your elements are evenly spaced and you have cheap random access to the elements.
        // To use the clipper we could replace the 'for (int i = 0; i < Items.Size; i++)' loop with:
        //     ImGuiListClipper clipper(Items.Size);
        //     while (clipper.Step())
        //         for (int i = clipper.DisplayStart; i < clipper.DisplayEnd; i++)
        // However take note that you can not use this code as is if a filter is active because it breaks the 'cheap random-access' property. We would need random-access on the post-filtered list.
        // A typical application wanting coarse clipping and filtering may want to pre-compute an array of indices that passed the filtering test, recomputing this array when user changes the filter,
        // and appending newly elements as they are inserted. This is left as a task to the user until we can manage to improve this example code!
        // If your items are of variable size you may want to implement code similar to what ImGuiListClipper does. Or split your data into fixed height items to allow random-seeking into your list.
        igPushStyleVarVec(ImGuiStyleVar_ItemSpacing, ImVec2(4,1)); // Tighten spacing
        if (copy_to_clipboard)
            igLogToClipboard();
        for (int i = 0; i < Items.length; i++)
        {
            string item = Items[i];
            if (!filter.PassFilter(item.ptr, item.ptr + item.length))
                continue;
            ImVec4 col = ImVec4(1.0f,1.0f,1.0f,1.0f); // A better implementation may store a type per-item. For the sample let's just parse the text.
            if (strstr(item.ptr, "[error]")) col = ImColor(1.0f,0.4f,0.4f,1.0f);
            else if (strncmp(item.ptr, "# ", 2) == 0) col = ImColor(1.0f,0.78f,0.58f,1.0f);
            igPushStyleColor(ImGuiCol_Text, col);
            igTextUnformatted(item.ptr, item.ptr + item.length);
            igPopStyleColor();
        }
        if (copy_to_clipboard)
            igLogFinish();
        if (ScrollToBottom)
            igSetScrollHere();
        ScrollToBottom = false;
        igPopStyleVar();
        igEndChild();
        igSeparator();

        // Command-line
        if (igInputText("Input", InputBuf.ptr, IM_ARRAYSIZE(InputBuf), ImGuiInputTextFlags_EnterReturnsTrue|ImGuiInputTextFlags_CallbackCompletion|ImGuiInputTextFlags_CallbackHistory, &TextEditCallbackStub, cast(void*)this))
        {
            char* input_end = InputBuf.ptr + strlen(InputBuf.ptr);
            while (input_end > InputBuf.ptr && input_end[-1] == ' ') input_end--; *input_end = 0;
            if (InputBuf[0])
                ExecCommand(to!string(InputBuf.ptr[0..(input_end - InputBuf.ptr)]));
            strcpy(InputBuf.ptr, "");
        }

        // Demonstrate keeping auto focus on the input box
        if (igIsItemHovered() || (igIsRootWindowOrAnyChildFocused() && !igIsAnyItemActive() && !igIsMouseClicked(0)))
            igSetKeyboardFocusHere(-1); // Auto focus previous widget

        igEnd();
    }

    void    ExecCommand(string command_line)
    {
        AddLog("# %s\n", command_line);

        // Insert into history. First find match and delete it so it can be pushed to the back. This isn't trying to be smart or optimal.
        HistoryPos = -1;
        for (int i = History.length - 1; i >= 0; i--)
            if (icmp(History[i], command_line) == 0)
            {
                History = History.remove(i);
                break;
            }
        History ~= command_line;

        // Process command
        if (icmp(command_line, "CLEAR") == 0)
        {
            ClearLog();
        }
        else if (icmp(command_line, "HELP") == 0)
        {
            AddLog("Commands:");
            for (int i = 0; i < Commands.length; i++)
                AddLog("- %s", Commands[i]);
        }
        else if (icmp(command_line, "HISTORY") == 0)
        {
            for (int i = History.length >= 10 ? History.length - 10 : 0; i < History.length; i++)
                AddLog("%3d: %s\n", i, History[i]);
        }
        else
        {
            AddLog("Unknown command: '%s'\n", command_line);
        }
    }

    extern(C) nothrow static int TextEditCallbackStub(ImGuiTextEditCallbackData* data) // In C++11 you are better off using lambdas for this sort of forwarding callbacks
    {
        ExampleAppConsole console = cast(ExampleAppConsole)data.UserData;
        return console.TextEditCallback(data);
    }

    nothrow int TextEditCallback(ImGuiTextEditCallbackData* data)
    {
        try {
            //AddLog("cursor: %d, selection: %d-%d", data.CursorPos, data.SelectionStart, data.SelectionEnd);
            switch (data.EventFlag)
            {
            case ImGuiInputTextFlags_CallbackCompletion:
                {
                    // Example of TEXT COMPLETION

                    // Locate beginning of current word
                    const(char)* word_end = data.Buf + data.CursorPos;
                    const(char)* word_start = word_end;
                    while (word_start > data.Buf)
                    {
                        const char c = word_start[-1];
                        if (c == ' ' || c == '\t' || c == ',' || c == ';')
                            break;
                        word_start--;
                    }

                    // Build a list of candidates
                    string[] candidates;
                    for (int i = 0; i < Commands.length; i++) {
                        import std.algorithm.comparison : min;
                        auto n = word_end-word_start;

                        if (icmp(Commands[i][0..min(n, $)], word_start[0..n]) == 0)
                            candidates ~= Commands[i];
                    }

                    if (candidates.length == 0)
                    {
                        // No match
                        AddLog("No match for \"%s\"!\n", word_start[0..(word_end-word_start)]);
                    }
                    else if (candidates.length == 1)
                    {
                        // Single match. Delete the beginning of the word and replace it entirely so we've got nice casing
                        data.DeleteChars(cast(int)(word_start-data.Buf), cast(int)(word_end-word_start));
                        data.InsertChars(data.CursorPos, candidates[0].ptr, candidates[0].ptr + candidates[0].length);
                        data.InsertChars(data.CursorPos, " ");
                    }
                    else
                    {
                        // Multiple matches. Complete as much as we can, so inputing "C" will complete to "CL" and display "CLEAR" and "CLASSIFY"
                        int match_len = cast(int)(word_end - word_start);
                        for (;;)
                        {
                            int c = 0;
                            bool all_candidates_matches = true;
                            for (int i = 0; i < candidates.length && all_candidates_matches; i++)
                                if (i == 0)
                                    c = toupper(candidates[i][match_len]);
                                else if (c == 0 || c != toupper(candidates[i][match_len]))
                                    all_candidates_matches = false;
                            if (!all_candidates_matches)
                                break;
                            match_len++;
                        }

                        if (match_len > 0)
                        {
                            data.DeleteChars(cast(int)(word_start - data.Buf), cast(int)(word_end-word_start));
                            data.InsertChars(data.CursorPos, candidates[0].ptr, candidates[0].ptr + match_len);
                        }

                        // List matches
                        AddLog("Possible matches:\n");
                        for (int i = 0; i < candidates.length; i++)
                            AddLog("- %s\n", candidates[i]);
                    }

                    break;
                }
            case ImGuiInputTextFlags_CallbackHistory:
                {
                    // Example of HISTORY
                    const int prev_history_pos = HistoryPos;
                    if (data.EventKey == ImGuiKey_UpArrow)
                    {
                        if (HistoryPos == -1)
                            HistoryPos = History.length - 1;
                        else if (HistoryPos > 0)
                            HistoryPos--;
                    }
                    else if (data.EventKey == ImGuiKey_DownArrow)
                    {
                        if (HistoryPos != -1)
                            if (++HistoryPos >= History.length)
                                HistoryPos = -1;
                    }

                    // A better implementation would preserve the data on the current input line along with cursor position.
                    if (prev_history_pos != HistoryPos)
                    {
                        data.CursorPos = data.SelectionStart = data.SelectionEnd = data.BufTextLen = cast(int)snprintf(data.Buf, cast(size_t)data.BufSize, "%s", (HistoryPos >= 0) ? History[HistoryPos].toStringz : "");
                        data.BufDirty = true;
                    }
                    break;
                }
            default:
                assert(false);
            }
            return 0;
        } catch(Exception e) {
            assert(false, e.toString);
        }
    }
}

void ShowExampleAppConsole(bool* p_open)
{
    static ExampleAppConsole console;
    if(console is null) console = new ExampleAppConsole;
    console.Draw("Example: Console", p_open);
}

// Usage:
//  static ExampleAppLog my_log;
//  my_log.AddLog("Hello %d world\n", 123);
//  my_log.Draw("title");
struct ExampleAppLog
{
    ImGuiTextBufferWrapper     Buf;
    ImGuiTextFilterWrapper     Filter;
    int[]               LineOffsets;        // Index to lines offset
    bool                ScrollToBottom;

    void    Clear()     { Buf.clear(); LineOffsets = null; }

    void    AddLog(const(char)* fmt, ...)
    {
        int old_size = Buf.size();
        va_list args;
        va_start(args, fmt);
        Buf.appendv(fmt, args);
        va_end(args);
        for (int new_size = Buf.size(); old_size < new_size; old_size++)
            if (Buf[old_size] == '\n')
                LineOffsets ~= old_size;
        ScrollToBottom = true;
    }

    void    Draw(const(char)* title, bool* p_open = null)
    {
        igSetNextWindowSize(ImVec2(500,400), ImGuiCond_FirstUseEver);
        igBegin(title, p_open);
        if (igButton("Clear")) Clear();
        igSameLine();
        bool copy = igButton("Copy");
        igSameLine();
        Filter.Draw("Filter", -100.0f);
        igSeparator();
        igBeginChild("scrolling", ImVec2(0,0), false, ImGuiWindowFlags_HorizontalScrollbar);
        if (copy) igLogToClipboard();

        if (Filter.IsActive())
        {
            const(char)* buf_begin = Buf.begin();
            const(char)* line = buf_begin;
            for (int line_no = 0; line != null; line_no++)
            {
                const(char)* line_end = (line_no < LineOffsets.length) ? buf_begin + LineOffsets[line_no] : null;
                if (Filter.PassFilter(line, line_end))
                    igTextUnformatted(line, line_end);
                line = line_end && line_end[1] ? line_end + 1 : null;
            }
        }
        else
        {
            igTextUnformatted(Buf.begin());
        }

        if (ScrollToBottom)
            igSetScrollHere(1.0f);
        ScrollToBottom = false;
        igEndChild();
        igEnd();
    }
}

// Demonstrate creating a simple log window with basic filtering.
void ShowExampleAppLog(bool* p_open)
{
    static ExampleAppLog log;

    // Demo: add random items (unless Ctrl is held)
    static float last_time = -1.0f;
    float time = igGetTime();
    if (time - last_time >= 0.20f && !igGetIO().KeyCtrl)
    {
        const(char)*[] random_words = [ "system", "info", "warning", "error", "fatal", "notice", "log" ];
        log.AddLog("[%s] Hello, time is %.1f, rand() %d\n", random_words[rand() % IM_ARRAYSIZE(random_words)], time, cast(int)rand());
        last_time = time;
    }

    log.Draw("Example: Log", p_open);
}

// Demonstrate create a window with multiple child windows.
void ShowExampleAppLayout(bool* p_open)
{
    igSetNextWindowSize(ImVec2(500, 440), ImGuiCond_FirstUseEver);
    if (igBegin("Example: Layout", p_open, ImGuiWindowFlags_MenuBar))
    {
        if (igBeginMenuBar())
        {
            if (igBeginMenu("File"))
            {
                if (igMenuItem("Close")) *p_open = false;
                igEndMenu();
            }
            igEndMenuBar();
        }

        // left
        static int selected = 0;
        igBeginChild("left pane", ImVec2(150, 0), true);
        for (int i = 0; i < 100; i++)
        {
            char[128] label;
            sprintf(label.ptr, "MyObject %d", i);
            if (igSelectable(label.ptr, selected == i))
                selected = i;
        }
        igEndChild();
        igSameLine();

        // right
        igBeginGroup();
            igBeginChild("item view", ImVec2(0, -igGetItemsLineHeightWithSpacing())); // Leave room for 1 line below us
                igText("MyObject: %d", selected);
                igSeparator();
                igTextWrapped("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ");
            igEndChild();
            igBeginChild("buttons");
                if (igButton("Revert")) {}
                igSameLine();
                if (igButton("Save")) {}
            igEndChild();
        igEndGroup();
    }
    igEnd();
}

// Demonstrate create a simple property editor.
void ShowExampleAppPropertyEditor(bool* p_open)
{
    igSetNextWindowSize(ImVec2(430,450), ImGuiCond_FirstUseEver);
    if (!igBegin("Example: Property editor", p_open))
    {
        igEnd();
        return;
    }

    ShowHelpMarker("This example shows how you may implement a property editor using two columns.\nAll objects/fields data are dummies here.\nRemember that in many simple cases, you can use igSameLine(xxx) to position\nyour cursor horizontally instead of using the Columns() API.");

    igPushStyleVarVec(ImGuiStyleVar_FramePadding, ImVec2(2,2));
    igColumns(2);
    igSeparator();

    struct funcs
    {
        static void ShowDummyObject(const(char)* prefix, int uid)
        {
            igPushIDInt(uid);                      // Use object uid as identifier. Most commonly you could also use the object pointer as a base ID.
            igAlignFirstTextHeightToWidgets();  // Text and Tree nodes are less high than regular widgets, here we add vertical spacing to make the tree lines equal high.
            bool node_open = igTreeNodeStr("Object", "%s_%u", prefix, uid);
            igNextColumn();
            igAlignFirstTextHeightToWidgets();
            igText("my sailor is rich");
            igNextColumn();
            if (node_open)
            {
                static float[8] dummy_members = [ 0.0f,0.0f,1.0f,3.1416f,100.0f,999.0f ];
                for (int i = 0; i < 8; i++)
                {
                    igPushIDInt(i); // Use field index as identifier.
                    if (i < 2)
                    {
                        ShowDummyObject("Child", 424242);
                    }
                    else
                    {
                        igAlignFirstTextHeightToWidgets();
                        // Here we use a Selectable (instead of Text) to highlight on hover
                        //igText("Field_%d", i);
                        char[32] label;
                        sprintf(label.ptr, "Field_%d", i);
                        igBullet();
                        igSelectable(label.ptr);
                        igNextColumn();
                        igPushItemWidth(-1);
                        if (i >= 5)
                            igInputFloat("##value", &dummy_members[i], 1.0f);
                        else
                            igDragFloat("##value", &dummy_members[i], 0.01f);
                        igPopItemWidth();
                        igNextColumn();
                    }
                    igPopID();
                }
                igTreePop();
            }
            igPopID();
        }
    }

    // Iterate dummy objects with dummy members (all the same data)
    for (int obj_i = 0; obj_i < 3; obj_i++)
        funcs.ShowDummyObject("Object", obj_i);

    igColumns(1);
    igSeparator();
    igPopStyleVar();
    igEnd();
}

// Demonstrate/test rendering huge amount of text, and the incidence of clipping.
void ShowExampleAppLongText(bool* p_open)
{
    igSetNextWindowSize(ImVec2(520,600), ImGuiCond_FirstUseEver);
    if (!igBegin("Example: Long text display", p_open))
    {
        igEnd();
        return;
    }

    static int test_type = 0;
    static ImGuiTextBufferWrapper log;
    static int lines = 0;
    igText("Printing unusually long amount of text.");
    igCombo2("Test type", &test_type, "Single call to TextUnformatted()\0Multiple calls to Text(), clipped manually\0Multiple calls to Text(), not clipped\0");
    igText("Buffer contents: %d lines, %d bytes", lines, log.size());
    if (igButton("Clear")) { log.clear(); lines = 0; }
    igSameLine();
    if (igButton("Add 1000 lines"))
    {
        for (int i = 0; i < 1000; i++)
            log.append("%i The quick brown fox jumps over the lazy dog\n", lines+i);
        lines += 1000;
    }
    igBeginChild("Log");
    switch (test_type)
    {
    case 0:
        // Single call to TextUnformatted() with a big buffer
        igTextUnformatted(log.begin(), log.end());
        break;
    case 1:
        {
            // Multiple calls to Text(), manually coarsely clipped - demonstrate how to use the ImGuiListClipper helper.
            igPushStyleVarVec(ImGuiStyleVar_ItemSpacing, ImVec2(0,0));
            ImGuiListClipper clipper = ImGuiListClipper(lines);
            while (clipper.Step())
                for (int i = clipper.DisplayStart; i < clipper.DisplayEnd; i++)
                    igText("%i The quick brown fox jumps over the lazy dog", i);
            igPopStyleVar();
            break;
        }
    case 2:
        // Multiple calls to Text(), not clipped (slow)
        igPushStyleVarVec(ImGuiStyleVar_ItemSpacing, ImVec2(0,0));
        for (int i = 0; i < lines; i++)
            igText("%i The quick brown fox jumps over the lazy dog", i);
        igPopStyleVar();
        break;
    default:
        assert(false);
    }
    igEndChild();
    igEnd();
}

// End of Demo code
