@echo off
setlocal

for %%Q in ("%~dp0\.") do set "parent_dir=%%~fQ"
set "working_dir=%CD%"
for /F "delims=" %%i in ("%working_dir%") do set "project_name=%%~ni"
set "venv_dir=.venv.windows"
set "scripts_dir=%venv_dir%\Scripts"
set "venv_prompt=Python VENV: %project_name%"
set "venv_opts=--upgrade-deps"
set "pip_opts="
:: set "pip_opts=--config-settings editable_mode=strict"

goto ARGPARSE


:: Usage
:Usage
echo.
echo Usage:
echo   scripts\venv\init.bat [options]
echo.
echo    -h --help /?            Show this info.
echo    --clear                 Reset the venv before reinstalling.
echo    --upgrade               Upgrade the existing venv to use this Python version.
echo    --system-site-packages  Give the venv access to the system site-packages.
echo.
exit /b 0



:: Args
:ARGPARSE
if /I "%1" == "-h" goto :Usage
if /I "%1" == "--help" goto :Usage
if /I "%1" == "/?" goto :Usage
if /I "%1" == "--clear" set "venv_opts=%venv_opts% %1"
if /I "%1" == "--upgrade" set "venv_opts=%venv_opts% %1"
if /I "%1" == "--system-site-packages" set "venv_opts=%venv_opts% %1"
shift
if not "%1" == "" goto :ARGPARSE





:: Checks
if not exist "%working_dir%\.git" (
    echo ERROR: Script must be run from root of Git repository.
    exit /b 1
)

if not exist "%working_dir%\setup.py" (
    echo ERROR: setup.py not found.
    exit /b 1
)

:: if [[ "$OS" =~ "Windows" ]]; then   # Git Bash
::     batfile="${0%.*}.bat"
::     "$batfile"      # Run the same-named .bat file
::     exit $?
:: fi



:: Start
echo.
echo Initializing Python Virtual Environment (Windows)...

python -m venv "%venv_dir%" %venv_opts% --prompt="%venv_prompt%"

if %ERRORLEVEL% neq 0 (
    echo ERROR: Could not initialize venv: "%venv_dir%".
    exit /b 1
)

echo.
echo Installing missing local packages...

call %scripts_dir%\activate.bat
python -m pip install %pip_opts% --editable .

if %ERRORLEVEL% neq 0 (
    echo ERROR: Failed to install one or more packages.
    exit /b 1
)

:: echo ""
:: echo "Making scripts executable..."
:: 
:: chmod --recursive --verbose +x "$scripts_dir"

echo.
echo SUCCESS: (%venv_prompt%) was installed to "%venv_dir%".
echo.
echo Activate using:
:: echo "     source $scripts_dir/activate"
echo  * Command Prompt:
echo       %scripts_dir%\activate.bat
echo  * Git Bash:
echo       source %scripts_dir:\=/%/activate
echo  *  Powershell:
echo       Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force ; %scripts_dir%\Activate.ps1
echo.


:: End
endlocal
exit /b 0
