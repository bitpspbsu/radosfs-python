#!/usr/bin/python
# -*- coding: utf8

__author__ = 'dima'

import radosfs
import unittest
import os


USER_NAME = os.environ["PRFS_USER_NAME"]
CONFIG_PATH = os.environ["PRFS_CONFIG_PATH"]
DATA_POOL = os.environ["PRFS_DATA_POOL_TEST"]
META_DATA_POOL = os.environ["PRFS_META_DATA_POOL_TEST"]


class RadosFsTest(unittest.TestCase):
    pass


if __name__ == "__main__":
    unittest.main()