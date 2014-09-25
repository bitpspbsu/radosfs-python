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
    def test_creation_files_in_root_folder(self):
        f1 = self.fs.file("/my1.txt", radosfs.OpenMode.READ_WRITE)
        f1.create(384, pool=DATA_POOL)
        f2 = self.fs.file("/my2.txt", radosfs.OpenMode.READ_WRITE)
        f2.create(384, pool=DATA_POOL)
        self.fs.dir("/").update()
        self.assertEqual(["my1.txt", "my2.txt"], self.fs.dir("/").entries())
        f1.remove()
        f2.remove()

    def test_read_write_to_file(self):
        self.fs.dir("/").create(-1, False, 1000, 1000)
        f1 = self.fs.file("/my1.txt", radosfs.OpenMode.READ_WRITE)
        f1.create(384, pool=DATA_POOL)
        f1.write("qwerty", 0)
        self.assertEqual("qwerty", f1.read())
        f1.remove()

    def setUp(self):
        self.fs = radosfs.RadosFs(USER_NAME, CONFIG_PATH)
        self.fs.add_metadata_pool(META_DATA_POOL, "/")
        self.fs.add_data_pool(DATA_POOL, "/", size=1 << 30)
        self.fs.dir("/").create(-1, False, 1000, 1000)

    def tearDown(self):
        self.fs.dir("/").remove()
        self.fs.remove_metadata_pool(META_DATA_POOL)
        self.fs.remove_data_pool(DATA_POOL)


if __name__ == "__main__":
    unittest.main()