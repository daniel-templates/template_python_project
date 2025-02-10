# setup.py
# Adapted from: https://lyz-code.github.io/blue-book/coding/python/python_project_template/python_cli_template/

# Requires project structure matching:
#
#   python_pkg/
#     .git/
#     src/
#       python_pkg/
#           __init__.py
#           version.py
#     setup.py
#     requirements.txt



import os
from setuptools import setup, find_packages

# TODO: Edit package metadata

#===============================================================================
# Project Paths
#
ROOT_DIR=os.path.dirname(os.path.abspath(__file__))
PACKAGE_NAME=os.path.basename(ROOT_DIR)
PACKAGE_DIR="src"
VERSION_PATH = os.path.join(PACKAGE_DIR, PACKAGE_NAME, "version.py")
REQUIREMENTS_PATH=os.path.join(ROOT_DIR, 'requirements.txt')
LONG_DESCRIPTION_PATH=os.path.join(ROOT_DIR, 'README.md')
LONG_DESCRIPTION_CONTENT_TYPE = "text/markdown"

#===============================================================================
# Metadata
#
DESCRIPTION = "Python project template"
LICENSE = "GPLv3"
AUTHOR = "Daniel Kennedy"
AUTHOR_EMAIL = ""
ORGANIZATION = "daniel-templates"
URL=f"https://github.com/{ORGANIZATION}/{PACKAGE_NAME}"
REQUIRES_PYTHON = ">=3.10.0"

#===============================================================================
# Entry Points
#   When package is installed, these console commands are defined which point to
#   specific functions to run
#
CONSOLE_SCRIPTS=[
    # console-cmd = package:function
    'hello_world = template_python_project:hello_world',
]
GUI_SCRIPTS=[]

#===============================================================================


# Set REQUIRES from requirements.txt
try:
    with open(REQUIREMENTS_PATH, encoding='utf-8') as f:
        REQUIRES = f.read().splitlines()
except FileNotFoundError:
    REQUIRES = []


# Set LONG_DESCRIPTION from README.md
try:
    with open(LONG_DESCRIPTION_PATH, encoding='utf-8') as f:
        LONG_DESCRIPTION = '\n' + f.read()
except FileNotFoundError:
    LONG_DESCRIPTION = DESCRIPTION


# Set __version__ string by executing version.py
exec(compile(open(VERSION_PATH).read(), VERSION_PATH, "exec"))


# Begin setup
setup(
    name=PACKAGE_NAME,
    version=__version__, # noqa:F821 # type:ignore
    description=DESCRIPTION,
    long_description=LONG_DESCRIPTION,
    long_description_content_type=LONG_DESCRIPTION_CONTENT_TYPE,
    author=AUTHOR,
    author_email=AUTHOR_EMAIL,
    license=LICENSE,
    url=URL,
    # include_package_data=True,
    install_requires=REQUIRES,
    python_requires=REQUIRES_PYTHON,
    packages=find_packages(where=PACKAGE_DIR),
    package_dir={"": PACKAGE_DIR},
    entry_points={
        'console_scripts': CONSOLE_SCRIPTS,
        'gui_scripts': GUI_SCRIPTS
    }
)
