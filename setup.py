# setup.py
# Adapted from: https://lyz-code.github.io/blue-book/coding/python/python_project_template/python_cli_template/

# Requires project structure matching:
#
#   python_pkg/
#     .git/
#     src/
#       python_pkg/
#           __init__.py
#     setup.py



import os
from setuptools import setup, find_packages

ROOT_DIR=os.path.dirname(os.path.abspath(__file__))
PACKAGE_NAME=os.path.basename(ROOT_DIR)
PACKAGE_DIR="src"

# TODO: Edit package metadata
DESCRIPTION = "Python project template"
LICENSE = "GPLv3"
AUTHOR = "Daniel Kennedy"
AUTHOR_EMAIL = ""
ORGANIZATION = "daniel-templates"
REQUIRES = [
    #   "numpy"
    #   "pywin32 >= 1.0;platform_system=='Windows'",
    #   "enum34;python_version<'3.4'",
    #   "Package-A @ git+https://example.net/package-a.git@main",
]
REQUIRES_PYTHON = ">=3.10.0"
URL=f"https://github.com/{ORGANIZATION}/{PACKAGE_NAME}"


# Set LONG_DESCRIPTION from README.md
try:
    with open(os.path.join(ROOT_DIR, 'README.md'), encoding='utf-8') as f:
        LONG_DESCRIPTION = '\n' + f.read()
except FileNotFoundError:
    LONG_DESCRIPTION = DESCRIPTION


# Set __version__ string by executing version.py
version_path = os.path.join(PACKAGE_DIR, PACKAGE_NAME, "version.py")
exec(compile(open(version_path).read(), version_path, "exec"))


# Begin setup
setup(
    name=PACKAGE_NAME,
    version=__version__, # noqa: F821
    description=DESCRIPTION,
    long_description=LONG_DESCRIPTION,
    long_description_content_type="text/markdown",
    author=AUTHOR,
    author_email=AUTHOR_EMAIL,
    license=LICENSE,
    url=URL,
    # include_package_data=True,
    install_requires=REQUIRES,
    python_requires=REQUIRES_PYTHON,
    packages=find_packages(where=PACKAGE_DIR),
    package_dir={"": PACKAGE_DIR}
)
