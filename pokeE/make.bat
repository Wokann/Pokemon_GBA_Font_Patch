@echo on
setlocal enabledelayedexpansion
:: 设置指令路径、工具路径、基础文件名
    set "WorkPath=%~dp0"
    cd /d %WorkPath%
    
    set "tool_armips=.\tools\armips\armips.exe"
    set "armips_main=.\main_E.asm"

    set "Origin_Rom_Name=baserom_E"

    set "Origin_Rom=.\%Origin_Rom_Name%.gba"
    set "Chinese_Patched_Rom=.\%Origin_Rom_Name%_chs.gba"
    set "Chinese_Patched_Sym=.\%Origin_Rom_Name%_chs.sym"
    set "Chinese_Patched_Temp=.\%Origin_Rom_Name%_chs.temp"

    if [%1]==[] (
        :: 检查原始rom是否存在
        if not exist "%Origin_Rom%" (
            @echo "%Origin_Rom%" is Not Exist!
	        goto :Exit
        )
        :: armips打补丁
        %tool_armips% %armips_main% ^
            -strequ Origin_Rom          "%Origin_Rom%" ^
            -strequ Chinese_Patched_Rom "%Chinese_Patched_Rom%" ^
            -sym    %Chinese_Patched_Sym% ^
            -temp   %Chinese_Patched_Temp% ^
            -stat ^
            -erroronwarning ^
            || (
                @echo Error^^!
                goto :Exit
                )
        @echo Patched^^!
        goto :Exit
    )
    :: 输入 "make clean"或".\make clean"可清理生成的文件
    if /I "%1"=="clean" (
        for %%f in ("%Chinese_Patched_Rom%") do (
            del /Q "%%~dpnf.sym"    2> nul
            del /Q "%%~dpnf.temp"   2> nul
            del /Q "%%~dpnf.gba"    2> nul
	    )
        @echo Cleaned^^!
        goto :Exit
    )

:Exit
    :: 3秒后自动关闭本窗口
    @echo off
    ping 127.0.0.1 -n 3 >nul

endlocal