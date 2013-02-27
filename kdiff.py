#!/usr/bin/python

import sys
import os

os.system('kdiff3 "%s" "%s"' % (sys.argv[2], sys.argv[5]))