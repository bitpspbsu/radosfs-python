#!/usr/bin/python
# -*- coding: utf8

__author__ = 'dima'

import radosfs
from sys import argv

username = argv[0]
ceph_conf = argv[1]

data_pool = argv[2]
metadata_pool = argv[3]


fs = radosfs.RadosFs(username, ceph_conf)
fs.add_data_pool(data_pool, "/")
fs.add_metadata_pool(metadata_pool, "/")
fs.dir("/").create(-1, False, 1000, 1000)
print fs.dir("/").is_writable()
print fs.dir("/").is_readable()
fs.file("/my.txt", radosfs.OpenMode.READ_WRITE).create(384, pool=data_pool)
fs.file("/my1.txt", radosfs.OpenMode.READ_WRITE).create(384, pool=data_pool)
fs.file("/my2.txt", radosfs.OpenMode.READ_WRITE).create(384, pool=data_pool)
fs.dir("/").update()
print fs.dir("/").entries()
print fs.dir("/").entry(0)
print fs.dir("/").entry(1)
print fs.dir("/").entry(2)
print fs.file("/my.txt", radosfs.OpenMode.READ_WRITE).mode() == radosfs.OpenMode.READ_WRITE
fs.file("/my.txt", radosfs.OpenMode.READ_WRITE).remove()
fs.file("/my1.txt", radosfs.OpenMode.READ_WRITE).remove()
fs.file("/my2.txt", radosfs.OpenMode.READ_WRITE).remove()