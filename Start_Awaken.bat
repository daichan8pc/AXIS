@echo off
setlocal enabledelayedexpansion

REM ==========================================
REM AXIS v1.0.0 "Awaken" - Boot Sequence
REM ==========================================

REM 1. 初期設定
set AXIS_DRIVE=%~d0
set AXIS_ROOT=%~dp0
title AXIS v1.0.0 "Awaken" Console
color 0B

REM 2. エスケープシーケンス定義 (色をつける魔法)
for /F %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"
set "Red=%ESC%[91m"
set "Green=%ESC%[92m"
set "Cyan=%ESC%[96m"
set "Reset=%ESC%[0m"

REM 3. ロゴ表示
cls
echo.
echo  %Cyan%=======================================================%Reset%
echo  %Cyan%    ___    _  __ ____ ______   %Reset%
echo  %Cyan%   /   ^|  ^| ^|/ //   _// ____/   %Reset%
echo  %Cyan%  / /^| ^|  ^|   / / / /___ \     %Reset%
echo  %Cyan% / ___ ^| /   ^|_/ / ____/ /     %Reset%
echo  %Cyan%/_/  ^|_^|/_/^|_/___//_____/      %Reset%
echo  %Cyan%                           %Reset%
echo  %Cyan%   AXIS v1.0.0 "Awaken" - System Boot Sequence%Reset%
echo  %Cyan%=======================================================%Reset%
echo.

REM 4. システムチェック開始
echo  Checking system integrity...
echo.

set "ALL_SYSTEMS_GO=true"

REM チェックリスト定義 (名前 | パス)
REM ★ここにPythonのチェックを追加しました
call :CheckComponent "Python 3.12"  "%AXIS_ROOT%bin\Python\python.exe"
call :CheckComponent "Git Portable" "%AXIS_ROOT%bin\Git\bin\git.exe"
call :CheckComponent "VS Code"      "%AXIS_ROOT%bin\VSCode\Code.exe"
call :CheckDir       "Home Drive"   "%AXIS_ROOT%home"
call :CheckDir       "Projects"     "%AXIS_ROOT%home\projects"

echo.
if "!ALL_SYSTEMS_GO!"=="false" (
    echo  %Red%[WARNING] Critical components are missing.%Reset%
    echo  Please check the installation directory.
    pause
    exit /b
)

echo  %Green%All Systems Green. Launching "Awaken"...%Reset%
timeout /t 1 >nul

REM 5. 環境構築 (パス設定 & ホーム偽装)
set PATH=%AXIS_ROOT%bin\Python;%AXIS_ROOT%bin\Python\Scripts;%PATH%
set PATH=%AXIS_ROOT%bin\Git\bin;%PATH%
set PATH=%AXIS_ROOT%bin\VSCode\bin;%PATH%

set USERPROFILE=%AXIS_ROOT%home
set HOME=%AXIS_ROOT%home
set APPDATA=%AXIS_ROOT%home\AppData\Roaming
set LOCALAPPDATA=%AXIS_ROOT%home\AppData\Local

REM 6. コンソール情報表示
cls
echo.
echo  %Cyan%=======================================================%Reset%
echo  %Cyan%   AXIS v1.0.0 "Awaken" - Active%Reset%
echo  %Cyan%=======================================================%Reset%
echo.
echo    User:    kohane
echo    Host:    %COMPUTERNAME%
echo    Drive:   %AXIS_DRIVE%
echo    Mode:    Portable Environment
echo.
REM ★Pythonのバージョンを表示して動作確認
for /f "tokens=*" %%i in ('python --version 2^>^&1') do set PYTHON_VER=%%i
echo    Runtime: %Green%!PYTHON_VER!%Reset%
echo.
echo  %Green%[Ready]%Reset% Type 'code .' to open VS Code.
echo.

REM 7. VS Code 自動起動 (プロジェクトフォルダを開く)
if exist "%AXIS_ROOT%bin\VSCode\Code.exe" (
    echo  Launching Visual Studio Code...
    start "" "%AXIS_ROOT%bin\VSCode\Code.exe" "%AXIS_ROOT%home\projects"
)

REM 8. シェル維持
cd /d "%AXIS_ROOT%home\projects"
cmd /k

REM ---------------------------------------------------------
REM サブルーチン: ファイルチェック
:CheckComponent
if exist %2 (
    echo   [%Green% OK %Reset%] %~1
) else (
    echo   [%Red%MISS%Reset%] %~1
    set "ALL_SYSTEMS_GO=false"
)
exit /b

REM サブルーチン: フォルダチェック
:CheckDir
if exist %2 (
    echo   [%Green% OK %Reset%] %~1
) else (
    echo   [%Red%MISS%Reset%] %~1
    REM フォルダがない場合は自動生成を試みる (REMなら安全)
    echo           Target not found. Creating...
    mkdir %2 >nul 2>&1
    if exist %2 (
        echo           [%Green%CREATED%Reset%] Directory created.
    ) else (
        echo           [%Red%FAILED%Reset%] Could not create directory.
        set "ALL_SYSTEMS_GO=false"
    )
)
exit /b