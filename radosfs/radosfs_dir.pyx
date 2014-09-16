# -*- coding: utf8

from libcpp.string cimport string
from cpython cimport bool
import radosfs_exception
import radosfs

__author__ = 'dima'


cdef class RadosFsDir:
    cdef _cpp_rados_fs_dir

    def __cinit__(self, a_rados_fs, bytes path, bool cacheable=True):
        self._cpp_rados_fs_dir = radosfs._dir(a_rados_fs._cpp_rados_fs, path, <bool> cacheable)

    def create(self, int mode, bool make_path, int owner_uid, int owner_gid):
        radosfs_exception.RadosFsException.check(self._cpp_rados_fs_dir.create(mode, make_path, owner_uid, owner_gid))

    def remove(self):
        radosfs_exception.RadosFsException.check(self._cpp_rados_fs_dir.remove())

    def entry_list(self):
        cdef entries = set()
        radosfs_exception.RadosFsException.check(self._cpp_rados_fs_dir.entryList(entries))
        return entries

    def entry(self, int index):
        cdef string cpp_entry = string()
        radosfs_exception.RadosFsException.check(self._cpp_rados_fs_dir.entry(index, cpp_entry))
        return <bytes> cpp_entry

    def set_path(self, new_path):
        self._cpp_rados_fs_dir.setPath(new_path)

    def is_writable(self):
        return self._cpp_rados_fs_dir.isWritable()

    def is_readable(self):
        return self._cpp_rados_fs_dir.isReadable()

