module imgui_glfw;

import derelict.imgui.imgui;
import derelict.opengl3.gl3;
import derelict.glfw3.glfw3;

version(Windows) {
	import core.sys.windows.windows : HWND, HGLRC;
	mixin DerelictGLFW3_NativeBind;
}

// Data
GLFWwindow*  g_Window = null;
double       g_Time = 0.0f;
bool[3]      g_MousePressed = [ false, false, false ];
float        g_MouseWheel = 0.0f;
GLuint       g_FontTexture = 0;
int          g_ShaderHandle = 0, g_VertHandle = 0, g_FragHandle = 0;
int          g_AttribLocationTex = 0, g_AttribLocationProjMtx = 0;
int          g_AttribLocationPosition = 0, g_AttribLocationUV = 0, g_AttribLocationColor = 0;
uint         g_VboHandle = 0, g_VaoHandle = 0, g_ElementsHandle = 0;

// This is the main rendering function that you have to implement and provide to ImGui (via setting up 'RenderDrawListsFn' in the ImGuiIO structure)
// If text or lines are blurry when integrating ImGui in your engine:
// - in your Render function, try translating your projection matrix by (0.5f,0.5f) or (0.375f,0.375f)
extern(C) nothrow void igImplGlfwGL3_RenderDrawLists(ImDrawData* draw_data)
{
    // Avoid rendering when minimized, scale coordinates for retina displays (screen coordinates != framebuffer coordinates)
    auto io = igGetIO();
    int fb_width = cast(int)(io.DisplaySize.x * io.DisplayFramebufferScale.x);
    int fb_height = cast(int)(io.DisplaySize.y * io.DisplayFramebufferScale.y);
    if (fb_width == 0 || fb_height == 0)
        return;
    draw_data.ScaleClipRects(io.DisplayFramebufferScale);

    // Backup GL state
    GLenum last_active_texture; glGetIntegerv(GL_ACTIVE_TEXTURE, cast(GLint*)&last_active_texture);
    glActiveTexture(GL_TEXTURE0);
    GLint last_program; glGetIntegerv(GL_CURRENT_PROGRAM, &last_program);
    GLint last_texture; glGetIntegerv(GL_TEXTURE_BINDING_2D, &last_texture);
    GLint last_array_buffer; glGetIntegerv(GL_ARRAY_BUFFER_BINDING, &last_array_buffer);
    GLint last_element_array_buffer; glGetIntegerv(GL_ELEMENT_ARRAY_BUFFER_BINDING, &last_element_array_buffer);
    GLint last_vertex_array; glGetIntegerv(GL_VERTEX_ARRAY_BINDING, &last_vertex_array);
    GLint[4] last_viewport; glGetIntegerv(GL_VIEWPORT, last_viewport.ptr);
    GLint[4] last_scissor_box; glGetIntegerv(GL_SCISSOR_BOX, last_scissor_box.ptr);
    GLenum last_blend_src_rgb; glGetIntegerv(GL_BLEND_SRC_RGB, cast(GLint*)&last_blend_src_rgb);
    GLenum last_blend_dst_rgb; glGetIntegerv(GL_BLEND_DST_RGB, cast(GLint*)&last_blend_dst_rgb);
    GLenum last_blend_src_alpha; glGetIntegerv(GL_BLEND_SRC_ALPHA, cast(GLint*)&last_blend_src_alpha);
    GLenum last_blend_dst_alpha; glGetIntegerv(GL_BLEND_DST_ALPHA, cast(GLint*)&last_blend_dst_alpha);
    GLenum last_blend_equation_rgb; glGetIntegerv(GL_BLEND_EQUATION_RGB, cast(GLint*)&last_blend_equation_rgb);
    GLenum last_blend_equation_alpha; glGetIntegerv(GL_BLEND_EQUATION_ALPHA, cast(GLint*)&last_blend_equation_alpha);
    GLboolean last_enable_blend = glIsEnabled(GL_BLEND);
    GLboolean last_enable_cull_face = glIsEnabled(GL_CULL_FACE);
    GLboolean last_enable_depth_test = glIsEnabled(GL_DEPTH_TEST);
    GLboolean last_enable_scissor_test = glIsEnabled(GL_SCISSOR_TEST);

    // Setup render state: alpha-blending enabled, no face culling, no depth testing, scissor enabled
    glEnable(GL_BLEND);
    glBlendEquation(GL_FUNC_ADD);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    glDisable(GL_CULL_FACE);
    glDisable(GL_DEPTH_TEST);
    glEnable(GL_SCISSOR_TEST);

    // Setup viewport, orthographic projection matrix
    glViewport(0, 0, cast(GLsizei)fb_width, cast(GLsizei)fb_height);
    const float[4][4] ortho_projection =
    [
        [ 2.0f/io.DisplaySize.x, 0.0f,                   0.0f, 0.0f ],
        [ 0.0f,                  2.0f/-io.DisplaySize.y, 0.0f, 0.0f ],
        [ 0.0f,                  0.0f,                  -1.0f, 0.0f ],
        [-1.0f,                  1.0f,                   0.0f, 1.0f ],
    ];
    glUseProgram(g_ShaderHandle);
    glUniform1i(g_AttribLocationTex, 0);
    glUniformMatrix4fv(g_AttribLocationProjMtx, 1, GL_FALSE, &ortho_projection[0][0]);
    glBindVertexArray(g_VaoHandle);

    for (int n = 0; n < draw_data.CmdListsCount; n++)
    {
        ImDrawList* cmd_list = draw_data.CmdLists[n];
        ImDrawIdx* idx_buffer_offset;

        auto countVertices = ImDrawList_GetVertexBufferSize(cmd_list);
        auto countIndices = ImDrawList_GetIndexBufferSize(cmd_list);

        glBindBuffer(GL_ARRAY_BUFFER, g_VboHandle);
        glBufferData(GL_ARRAY_BUFFER, countVertices * ImDrawVert.sizeof, cast(GLvoid*)ImDrawList_GetVertexPtr(cmd_list,0), GL_STREAM_DRAW);

        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, g_ElementsHandle);
        glBufferData(GL_ELEMENT_ARRAY_BUFFER, countIndices * ImDrawIdx.sizeof, cast(GLvoid*)ImDrawList_GetIndexPtr(cmd_list,0), GL_STREAM_DRAW);

        auto cmdCnt = ImDrawList_GetCmdSize(cmd_list);

        foreach(cmd_i; 0..cmdCnt)
        {
            auto pcmd = ImDrawList_GetCmdPtr(cmd_list, cmd_i);

            if (pcmd.UserCallback)
            {
                pcmd.UserCallback(cmd_list, pcmd);
            }
            else
            {
                glBindTexture(GL_TEXTURE_2D, cast(GLuint)pcmd.TextureId);
                glScissor(cast(int)pcmd.ClipRect.x, cast(int)(fb_height - pcmd.ClipRect.w), cast(int)(pcmd.ClipRect.z - pcmd.ClipRect.x), cast(int)(pcmd.ClipRect.w - pcmd.ClipRect.y));
                glDrawElements(GL_TRIANGLES, cast(GLsizei)pcmd.ElemCount, ImDrawIdx.sizeof == 2 ? GL_UNSIGNED_SHORT : GL_UNSIGNED_INT, idx_buffer_offset);
            }
            idx_buffer_offset += pcmd.ElemCount;
        }
    }

    // Restore modified GL state
    glUseProgram(last_program);
    glBindTexture(GL_TEXTURE_2D, last_texture);
    glActiveTexture(last_active_texture);
    glBindVertexArray(last_vertex_array);
    glBindBuffer(GL_ARRAY_BUFFER, last_array_buffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, last_element_array_buffer);
    glBlendEquationSeparate(last_blend_equation_rgb, last_blend_equation_alpha);
    glBlendFuncSeparate(last_blend_src_rgb, last_blend_dst_rgb, last_blend_src_alpha, last_blend_dst_alpha);
    if (last_enable_blend) glEnable(GL_BLEND); else glDisable(GL_BLEND);
    if (last_enable_cull_face) glEnable(GL_CULL_FACE); else glDisable(GL_CULL_FACE);
    if (last_enable_depth_test) glEnable(GL_DEPTH_TEST); else glDisable(GL_DEPTH_TEST);
    if (last_enable_scissor_test) glEnable(GL_SCISSOR_TEST); else glDisable(GL_SCISSOR_TEST);
    glViewport(last_viewport[0], last_viewport[1], cast(GLsizei)last_viewport[2], cast(GLsizei)last_viewport[3]);
    glScissor(last_scissor_box[0], last_scissor_box[1], cast(GLsizei)last_scissor_box[2], cast(GLsizei)last_scissor_box[3]);
}

extern(C) nothrow const(char)* igImplGlfwGL3_GetClipboardText(void* user_data)
{
    return glfwGetClipboardString(cast(GLFWwindow*)user_data);
}

extern(C) nothrow void igImplGlfwGL3_SetClipboardText(void* user_data, const(char)* text)
{
    glfwSetClipboardString(cast(GLFWwindow*)user_data, text);
}

extern(C) nothrow void igImplGlfwGL3_MouseButtonCallback(GLFWwindow*, int button, int action, int /*mods*/)
{
    if (action == GLFW_PRESS && button >= 0 && button < 3)
        g_MousePressed[button] = true;
}

extern(C) nothrow void igImplGlfwGL3_ScrollCallback(GLFWwindow*, double /*xoffset*/, double yoffset)
{
    g_MouseWheel += cast(float)yoffset; // Use fractional mouse wheel, 1.0 unit 5 lines.
}

extern(C) nothrow void igImplGlfwGL3_KeyCallback(GLFWwindow*, int key, int, int action, int mods)
{
    if(key < 0) return; // ignore the special key code used for Japanese key board
    auto io = igGetIO();
    if (action == GLFW_PRESS)
        io.KeysDown[key] = true;
    if (action == GLFW_RELEASE)
        io.KeysDown[key] = false;

    //(void)mods; // Modifiers are not reliable across systems
    io.KeyCtrl = io.KeysDown[GLFW_KEY_LEFT_CONTROL] || io.KeysDown[GLFW_KEY_RIGHT_CONTROL];
    io.KeyShift = io.KeysDown[GLFW_KEY_LEFT_SHIFT] || io.KeysDown[GLFW_KEY_RIGHT_SHIFT];
    io.KeyAlt = io.KeysDown[GLFW_KEY_LEFT_ALT] || io.KeysDown[GLFW_KEY_RIGHT_ALT];
    io.KeySuper = io.KeysDown[GLFW_KEY_LEFT_SUPER] || io.KeysDown[GLFW_KEY_RIGHT_SUPER];
}

extern(C) nothrow void igImplGlfwGL3_CharCallback(GLFWwindow*, uint c)
{
    if (c > 0 && c < 0x10000)
        ImGuiIO_AddInputCharacter(cast(ushort)c);
}

bool igImplGlfwGL3_CreateFontsTexture()
{
    // Build texture atlas
    auto io = igGetIO();
    ubyte* pixels;
    int width, height;
    ImFontAtlas_GetTexDataAsRGBA32(io.Fonts, &pixels, &width, &height, null);   // Load as RGBA 32-bits (75% of the memory is wasted, but default font is so small) because it is more likely to be compatible with user's existing shaders. If your ImTextureId represent a higher-level concept than just a GL texture id, consider calling GetTexDataAsAlpha8() instead to save on GPU memory.

    // Upload texture to graphics system
    GLint last_texture;
    glGetIntegerv(GL_TEXTURE_BINDING_2D, &last_texture);
    glGenTextures(1, &g_FontTexture);
    glBindTexture(GL_TEXTURE_2D, g_FontTexture);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, pixels);

    // Store our identifier
    ImFontAtlas_SetTexID(io.Fonts, cast(void*)g_FontTexture);

    // Restore state
    glBindTexture(GL_TEXTURE_2D, last_texture);

    return true;
}

bool igImplGlfwGL3_CreateDeviceObjects()
{
    // Backup GL state
    GLint last_texture, last_array_buffer, last_vertex_array;
    glGetIntegerv(GL_TEXTURE_BINDING_2D, &last_texture);
    glGetIntegerv(GL_ARRAY_BUFFER_BINDING, &last_array_buffer);
    glGetIntegerv(GL_VERTEX_ARRAY_BINDING, &last_vertex_array);

    const GLchar *vertex_shader =
        "#version 330\n" ~
        "uniform mat4 ProjMtx;\n" ~
        "in vec2 Position;\n" ~
        "in vec2 UV;\n" ~
        "in vec4 Color;\n" ~
        "out vec2 Frag_UV;\n" ~
        "out vec4 Frag_Color;\n" ~
        "void main()\n" ~
        "{\n" ~
        "   Frag_UV = UV;\n" ~
        "   Frag_Color = Color;\n" ~
        "   gl_Position = ProjMtx * vec4(Position.xy,0,1);\n" ~
        "}\n";

    const GLchar* fragment_shader =
        "#version 330\n" ~
        "uniform sampler2D Texture;\n" ~
        "in vec2 Frag_UV;\n" ~
        "in vec4 Frag_Color;\n" ~
        "out vec4 Out_Color;\n" ~
        "void main()\n" ~
        "{\n" ~
        "   Out_Color = Frag_Color * texture( Texture, Frag_UV.st);\n" ~
        "}\n";

    g_ShaderHandle = glCreateProgram();
    g_VertHandle = glCreateShader(GL_VERTEX_SHADER);
    g_FragHandle = glCreateShader(GL_FRAGMENT_SHADER);
    glShaderSource(g_VertHandle, 1, &vertex_shader, null);
    glShaderSource(g_FragHandle, 1, &fragment_shader, null);
    glCompileShader(g_VertHandle);
    glCompileShader(g_FragHandle);
    glAttachShader(g_ShaderHandle, g_VertHandle);
    glAttachShader(g_ShaderHandle, g_FragHandle);
    glLinkProgram(g_ShaderHandle);

    g_AttribLocationTex = glGetUniformLocation(g_ShaderHandle, "Texture");
    g_AttribLocationProjMtx = glGetUniformLocation(g_ShaderHandle, "ProjMtx");
    g_AttribLocationPosition = glGetAttribLocation(g_ShaderHandle, "Position");
    g_AttribLocationUV = glGetAttribLocation(g_ShaderHandle, "UV");
    g_AttribLocationColor = glGetAttribLocation(g_ShaderHandle, "Color");

    glGenBuffers(1, &g_VboHandle);
    glGenBuffers(1, &g_ElementsHandle);

    glGenVertexArrays(1, &g_VaoHandle);
    glBindVertexArray(g_VaoHandle);
    glBindBuffer(GL_ARRAY_BUFFER, g_VboHandle);
    glEnableVertexAttribArray(g_AttribLocationPosition);
    glEnableVertexAttribArray(g_AttribLocationUV);
    glEnableVertexAttribArray(g_AttribLocationColor);

    glVertexAttribPointer(g_AttribLocationPosition, 2, GL_FLOAT, GL_FALSE, ImDrawVert.sizeof, cast(void*)ImDrawVert.pos.offsetof);
    glVertexAttribPointer(g_AttribLocationUV, 2, GL_FLOAT, GL_FALSE, ImDrawVert.sizeof, cast(void*)ImDrawVert.uv.offsetof);
    glVertexAttribPointer(g_AttribLocationColor, 4, GL_UNSIGNED_BYTE, GL_TRUE, ImDrawVert.sizeof, cast(void*)ImDrawVert.col.offsetof);

    igImplGlfwGL3_CreateFontsTexture();

    // Restore modified GL state
    glBindTexture(GL_TEXTURE_2D, last_texture);
    glBindBuffer(GL_ARRAY_BUFFER, last_array_buffer);
    glBindVertexArray(last_vertex_array);

    return true;
}

void igImplGlfwGL3_InvalidateDeviceObjects()
{
    if (g_VaoHandle) glDeleteVertexArrays(1, &g_VaoHandle);
    if (g_VboHandle) glDeleteBuffers(1, &g_VboHandle);
    if (g_ElementsHandle) glDeleteBuffers(1, &g_ElementsHandle);
    g_VaoHandle = g_VboHandle = g_ElementsHandle = 0;

    if (g_ShaderHandle && g_VertHandle) glDetachShader(g_ShaderHandle, g_VertHandle);
    if (g_VertHandle) glDeleteShader(g_VertHandle);
    g_VertHandle = 0;

    if (g_ShaderHandle && g_FragHandle) glDetachShader(g_ShaderHandle, g_FragHandle);
    if (g_FragHandle) glDeleteShader(g_FragHandle);
    g_FragHandle = 0;

    if (g_ShaderHandle) glDeleteProgram(g_ShaderHandle);
    g_ShaderHandle = 0;

    if (g_FontTexture)
    {
        glDeleteTextures(1, &g_FontTexture);
        ImFontAtlas_SetTexID(igGetIO().Fonts, cast(void*)0);
        g_FontTexture = 0;
    }
}

bool igImplGlfwGL3_Init(GLFWwindow* window, bool install_callbacks)
{
    g_Window = window;

    auto io = igGetIO();
    io.KeyMap[ImGuiKey_Tab] = GLFW_KEY_TAB;                         // Keyboard mapping. ImGui will use those indices to peek into the io.KeyDown[] array.
    io.KeyMap[ImGuiKey_LeftArrow] = GLFW_KEY_LEFT;
    io.KeyMap[ImGuiKey_RightArrow] = GLFW_KEY_RIGHT;
    io.KeyMap[ImGuiKey_UpArrow] = GLFW_KEY_UP;
    io.KeyMap[ImGuiKey_DownArrow] = GLFW_KEY_DOWN;
    io.KeyMap[ImGuiKey_PageUp] = GLFW_KEY_PAGE_UP;
    io.KeyMap[ImGuiKey_PageDown] = GLFW_KEY_PAGE_DOWN;
    io.KeyMap[ImGuiKey_Home] = GLFW_KEY_HOME;
    io.KeyMap[ImGuiKey_End] = GLFW_KEY_END;
    io.KeyMap[ImGuiKey_Delete] = GLFW_KEY_DELETE;
    io.KeyMap[ImGuiKey_Backspace] = GLFW_KEY_BACKSPACE;
    io.KeyMap[ImGuiKey_Enter] = GLFW_KEY_ENTER;
    io.KeyMap[ImGuiKey_Escape] = GLFW_KEY_ESCAPE;
    io.KeyMap[ImGuiKey_A] = GLFW_KEY_A;
    io.KeyMap[ImGuiKey_C] = GLFW_KEY_C;
    io.KeyMap[ImGuiKey_V] = GLFW_KEY_V;
    io.KeyMap[ImGuiKey_X] = GLFW_KEY_X;
    io.KeyMap[ImGuiKey_Y] = GLFW_KEY_Y;
    io.KeyMap[ImGuiKey_Z] = GLFW_KEY_Z;

    io.RenderDrawListsFn = &igImplGlfwGL3_RenderDrawLists;       // Alternatively you can set this to NULL and call ImGui::GetDrawData() after ImGui::Render() to get the same ImDrawData pointer.
    io.SetClipboardTextFn = &igImplGlfwGL3_SetClipboardText;
    io.GetClipboardTextFn = &igImplGlfwGL3_GetClipboardText;
    io.ClipboardUserData = g_Window;
    version( Windows ) {
		DerelictGLFW3_loadNative;
        io.ImeWindowHandle = glfwGetWin32Window(g_Window);
    }

    if (install_callbacks)
    {
        glfwSetMouseButtonCallback(window, &igImplGlfwGL3_MouseButtonCallback);
        glfwSetScrollCallback(window, &igImplGlfwGL3_ScrollCallback);
        glfwSetKeyCallback(window, &igImplGlfwGL3_KeyCallback);
        glfwSetCharCallback(window, &igImplGlfwGL3_CharCallback);
    }

    return true;
}

void igImplGlfwGL3_Shutdown()
{
    igImplGlfwGL3_InvalidateDeviceObjects();
    igShutdown();
}

void igImplGlfwGL3_NewFrame()
{
    if (!g_FontTexture)
        igImplGlfwGL3_CreateDeviceObjects();

    auto io = igGetIO();

    // Setup display size (every frame to accommodate for window resizing)
    int w, h;
    int display_w, display_h;
    glfwGetWindowSize(g_Window, &w, &h);
    glfwGetFramebufferSize(g_Window, &display_w, &display_h);
    io.DisplaySize = ImVec2(cast(float)w, cast(float)h);
    io.DisplayFramebufferScale = ImVec2(w > 0 ? (cast(float)display_w / w) : 0, h > 0 ? (cast(float)display_h / h) : 0);

    // Setup time step
    double current_time =  glfwGetTime();
    io.DeltaTime = g_Time > 0.0 ? cast(float)(current_time - g_Time) : cast(float)(1.0f/60.0f);
    g_Time = current_time;

    // Setup inputs
    // (we already got mouse wheel, keyboard keys & characters from glfw callbacks polled in glfwPollEvents())
    if (glfwGetWindowAttrib(g_Window, GLFW_FOCUSED))
    {
        double mouse_x, mouse_y;
        glfwGetCursorPos(g_Window, &mouse_x, &mouse_y);
        io.MousePos = ImVec2(cast(float)mouse_x, cast(float)mouse_y);   // Mouse position in screen coordinates (set to -1,-1 if no mouse / on another screen, etc.)
    }
    else
    {
        io.MousePos = ImVec2(-1,-1);
    }

    for (int i = 0; i < 3; i++)
    {
        io.MouseDown[i] = g_MousePressed[i] || glfwGetMouseButton(g_Window, i) != 0;    // If a mouse press event came, always pass it as "mouse held this frame", so we don't miss click-release events that are shorter than 1 frame.
        g_MousePressed[i] = false;
    }

    io.MouseWheel = g_MouseWheel;
    g_MouseWheel = 0.0f;

    // Hide OS mouse cursor if ImGui is drawing it
    glfwSetInputMode(g_Window, GLFW_CURSOR, io.MouseDrawCursor ? GLFW_CURSOR_HIDDEN : GLFW_CURSOR_NORMAL);

    // Start the frame
    igNewFrame();
}
