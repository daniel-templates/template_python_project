#!/usr/bin/env bash


parent_dir="$(dirname "$(readlink -f "$0")")"
working_dir="$PWD"
project_name="$(basename "$working_dir")"
venv_dir=".venv.linux"
scripts_dir="$venv_dir/bin"
venv_prompt="Python VENV: $project_name"
venv_opts="--upgrade-deps"
pip_opts=""
#pip_opts="--config-settings editable_mode=strict"




# Usage
function Usage {
    echo ""
    echo "Usage:"
    echo "  scripts/venv/init.bat [options]"
    echo ""
    echo "   -h --help /?            Show this info."
    echo "   --clear                 Reset the venv before reinstalling."
    echo "   --upgrade               Upgrade the existing venv to use this Python version."
    echo "   --system-site-packages  Give the venv access to the system site-packages."
    echo ""
    exit 0
}


# Args
while [[ "$1" != "" ]]; do
    case $1 in
      -h)        Usage ;;
      --help)    Usage ;;
      /?)        Usage ;;
      --clear)   venv_opts="$venv_opts $1" ;;
      --upgrade) venv_opts="$venv_opts $1" ;;
      --system-site-packages) venv_opts="$venv_opts $1" ;;
      *)         Usage ;;
    esac
    shift
done


# Checks
if [[ ! -d "$working_dir/.git" ]]; then
    echo "ERROR: Script must be run from root of Git repository."
    exit 1
fi

if [[ ! -f "$working_dir/setup.py" ]]; then
    echo "ERROR: setup.py not found."
    exit 1
fi

if [[ "$OS" =~ "Windows" ]]; then   # Git Bash, not Linux.
    batfile="${0%.*}.bat"
    "$batfile"      # Run the same-named .bat file
    exit $?
fi



# Start
echo ""
echo "Initializing Python Virtual Environment (Linux)..."

python -m venv "$venv_dir" $venv_opts --prompt="$venv_prompt"

if [[ $? != 0 ]]; then
    echo "ERROR: Could not initialize venv: \"$venv_dir\""
    exit 1
fi

echo ""
echo "Installing missing local packages..."

source $scripts_dir/activate
python -m pip install --editable . $pip_opts

if [[ $? != 0 ]]; then
    echo "ERROR: Failed to install one or more packages."
    exit 1
fi

echo ""
echo "Making scripts executable..."

chmod --recursive --verbose +x "$scripts_dir"

echo ""
echo "SUCCESS: ($venv_prompt) was installed to \"$venv_dir\"."
echo ""
echo "Activate using:"
echo "     source $scripts_dir/activate"
# echo  * Command Prompt:
# echo       %scripts_dir%\activate.bat
# echo  * Git Bash:
# echo       source %scripts_dir:\=/%/activate
# echo  *  Powershell:
# echo       Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force ; %scripts_dir%\Activate.ps1
echo ""


# End

exit 0
