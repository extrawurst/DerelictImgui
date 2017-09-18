module gui.guimain;

import std.string;
import std.conv;

import derelict.opengl3.gl3;
import derelict.glfw3.glfw3;
import derelict.imgui.imgui;
import imgui_glfw;
import imgui_demo;

GLFWwindow* window;
float[3] clear_color = [0.3f, 0.4f, 0.8f];
bool showDTestWindow;
bool showOrgTestWindow;

void main(string[] argv) {

	DerelictGL3.load();
	DerelictGLFW3.load();
	DerelictImgui.load();

	// Setup window
	window = initWindow("ImGui OpenGL3 example");
	if(!window) return;

	// Setup ImGui binding
	igImplGlfwGL3_Init(window, true);

	// Main loop
	while (!glfwWindowShouldClose(window)) {
		glfwPollEvents();
		igImplGlfwGL3_NewFrame();

		// contents
		if(igButton("RUN imgui_demo (D-lang version)")) showDTestWindow = !showDTestWindow;
		if(igButton("RUN imgui_demo (C++ version)")) showOrgTestWindow = !showOrgTestWindow;
		if(showDTestWindow) {
			igSetNextWindowPos(ImVec2(660, 30), ImGuiCond_FirstUseEver);
			imgui_demo.igShowTestWindow(&showDTestWindow);
		}
		if(showOrgTestWindow) {
			igSetNextWindowPos(ImVec2(650, 20), ImGuiCond_FirstUseEver);
			derelict.imgui.imgui.igShowTestWindow(&showOrgTestWindow);
		}

		// Rendering
		auto io = igGetIO();
		glViewport(0, 0, cast(int)io.DisplaySize.x, cast(int)io.DisplaySize.y);
		glClearColor(clear_color[0], clear_color[1], clear_color[2], 0);
		glClear(GL_COLOR_BUFFER_BIT);
		igRender();
		glfwSwapBuffers(window);
	}

	// Cleanup
	igImplGlfwGL3_Shutdown();
	glfwTerminate();
}

GLFWwindow* initWindow(string title) {

	// Setup window
	glfwSetErrorCallback(&error_callback);
	if (!glfwInit())
		return null;
	glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
	glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
	glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
	glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, true);
	auto window = glfwCreateWindow(1280, 720, title.toStringz(), null, null);
	glfwMakeContextCurrent(window);
	glfwSwapInterval(1); // Enable vsync
	glfwInit();

	DerelictGL3.reload();
	return window;
}

extern(C) nothrow void error_callback(int error, const(char)* description) {
	import std.stdio;
	import std.conv;
	try writefln("glfw err: %s ('%s')",error, to!string(description));
	catch(Throwable) {}
}
