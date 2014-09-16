# -*- coding: utf8

from radosfs_exception import RadosFsException
cimport cpython
cimport bindings

__author__ = 'dima'


cdef bindings.RadosFsDir* _dir(RadosFs rados_fs, bytes path, cpython.bool cacheable=True):
    return new bindings.RadosFsDir(rados_fs._cpp_rados_fs, path, cacheable)

cdef bindings.RadosFsFile* _file(RadosFs rados_fs, bytes path, int open_mode):
    return new bindings.RadosFsFile(rados_fs._cpp_rados_fs, path, open_mode)

cdef class RadosFs:
    cdef bindings.RadosFs* _cpp_rados_fs

    @staticmethod
    def set_log_level():
        pass

    @staticmethod
    def get_log_level():
        pass

    def __cinit__(self, bytes user_name, bytes configuration_file):
        self._cpp_rados_fs = new bindings.RadosFs()
        code = self._cpp_rados_fs.init(user_name, configuration_file)

        RadosFsException.check(code)

    def add_pool(self, bytes name, bytes prefix, int size=0):
        RadosFsException.check(self._cpp_rados_fs.addPool(name, prefix, size))

    def pool_prefix(self, bytes pool_name):
        return self._cpp_rados_fs.poolPrefix(pool_name)

    def pool_from_prefix(self, bytes prefix):
        return self._cpp_rados_fs.poolFromPrefix(prefix)

    def pool_size(self, bytes pool_name):
        return self._cpp_rados_fs.poolSize(pool_name)

    def __dealloc__(self):
        del self._cpp_rados_fs