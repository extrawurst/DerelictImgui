Notes to make cimgui.lib:
1. open cimgui\cimgui\cimgui.sln
2. copy cimgui.lib, cimgui.dll to libs\windows\x86
3. rename cimgui.lib to cimgui-coff.lib
4. convert it by "coffimplib cimgui-coff.lib cimgui.lib"
