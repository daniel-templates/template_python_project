# module1.py
# Example module containing a class definition.

from .module2 import *
from . import subpackage_1 as subpkg1
from . import subpackage_2 as subpkg2
# import numpy as np

class ClassModule1:
    def __init__(self) -> None:
        self.pi = fcn_module2()
        self.submodules = [
            subpkg1.fcn_submodule1(),
            subpkg2.fcn_submodule2()
        ]


def hello_world():
    myobj = ClassModule1()
    print(vars(myobj))


if __name__ == '__main__':
    hello_world()