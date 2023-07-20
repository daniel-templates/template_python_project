
from . import subpackage_1 as subpkg1
# from . import subpackage_2 as subpkg2
from .module1 import *
from .module2 import *
from .version import *

# To import this (top-level) package, use:
# A)
#   import template_python_project as pytemplate    <-- Top-level package
#   x = pytemplate.ClassModule1()                       <-- from module1.py
#   y = pytemplate.fcn_module2()                        <-- from module2.py
#   z = pytemplate.subpkg1.fcn_submodule1()                 <-- from subpackage_1/submodule1.py
#
# B)
#   from template_python_project import *           <-- Top-level package
#   x = ClassModule1()                                  <-- from module1.py
#   y = fcn_module2()                                   <-- from module2.py
#   z = subpkg1.fcn_submodule1()                            <-- from subpackage_1/submodule1.py
#   
