@echo off
setlocal

for %%Q in ("%~dp0\.") do set "parent_dir=%%~fQ"
set "working_dir=%CD%"
for /F "delims=" %%i in ("%working_dir%") do set "project_name=%%~ni"
set "venv_dir=.venv.windows"
set "scripts_dir=%venv_dir%\Scripts"
set "venv_prompt=Python VENV: %project_name%"
set "venv_opts="
:: set "venv_opts=--clear --system-site-packages"
set "pip_opts="
:: set "pip_opts=--config-settings editable_mode=strict"

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
python -m pip install --editable . %pip_opts%

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

endlocal
exit /b 0
