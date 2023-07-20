# setup.py
# Adapted from: https://lyz-code.github.io/blue-book/coding/python/python_project_template/python_cli_template/
# 
# TODO: Edit parameters
# 

import os
from setuptools import setup, find_packages

package_name=os.path.basename(os.path.dirname(os.path.abspath(__file__)))
package_dir="src"
organization="daniel-templates"

# Set __version__ string
version_path = os.path.join(package_dir, package_name, "version.py")
exec(compile(open(version_path).read(), version_path, "exec"))

setup(
    name=package_name,
    version=__version__, # noqa: F821
    description="",
    long_description=open("README.md").read(),
    author="Daniel Kennedy",
    author_email="",
    license="GPLv3",
    url=f"https://github.com/{organization}/{package_name}",
    packages=[package_name],
    # packages=find_packages(where=package_dir),
    package_dir={"": package_dir}
)
