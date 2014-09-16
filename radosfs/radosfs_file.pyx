# -*- coding: utf8

from libcpp.string cimport string
from cpython cimport bool
import radosfs_exception
import radosfs

__author__ = 'dima'


cdef class RadosFsFile:
    cdef _cpp_rados_fs_dir

    def __cinit__(self, rados_fs, bytes path, int mode):
        self._cpp_rados_fs_file = radosfs._file(radosfs, path, mode)

    def mode(self):
        return self._cpp_rados_fs_file.mode()