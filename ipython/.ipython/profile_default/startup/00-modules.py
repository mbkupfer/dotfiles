######################
#  Standard library  #
######################

import os
from importlib import reload
import urllib.request
import urllib.response
from pathlib import Path
import re
import shelve

#########################
#  3rd party libraries  #
#########################

try:
    import pandas as pd
    import numpy as np
except ModuleNotFoundError:
    print('Could not import pandas or numpy.')

#################
#  Global vars  #
#################

import sys
executable = sys.executable

