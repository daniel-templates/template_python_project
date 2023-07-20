from . import package_1
from . import package_2

# To import from this package: use
# A)
#   import pyregistryutils as reg
#   key = reg.Key(...)      # from "key.py"
#   hive = reg.HKLM         # from "common.py"
#
# B)
#   from pyregistryutils import *
#   key = Key(...)          # from "key.py"
#   hive = HKLM             # from "common.py"
#   