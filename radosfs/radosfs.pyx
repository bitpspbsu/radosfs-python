# -*- coding: utf8

from libcpp.string cimport string
from libcpp.set cimport set
from posix.types cimport off_t
from cpython cimport bool
cimport bindings

include "log_level.py"
include "radosfs_exception.py"
include "open_mode.py"

__author__ = 'dima'

cdef class RadosFs:
    cdef bindings.RadosFs* _cpp_rados_fs

    def __cinit__(self, bytes user_name, bytes configuration_file):
        self._cpp_rados_fs = new bindings.RadosFs()
        code = self._cpp_rados_fs.init(user_name, configuration_file)
        RadosFsException.check(code)

    #
    # DATA POOLS
    #

    def add_data_pool(self, bytes name, bytes prefix, int size=0):
        RadosFsException.check(self._cpp_rados_fs.addDataPool(name, prefix, size))

    def remove_data_pool(self, bytes name):
        RadosFsException.check(self._cpp_rados_fs.removeDataPool(name))

    def data_pools(self, bytes prefix):
        return self._cpp_rados_fs.dataPools(prefix)

    def data_pool_prefix(self, bytes pool_name):
        return self._cpp_rados_fs.dataPoolPrefix(pool_name)

    def pool_size(self, bytes pool_name):
        return self._cpp_rados_fs.dataPoolSize(pool_name)

    #
    # METADATA POOLS
    #

    def add_metadata_pool(self, bytes name, bytes prefix):
        RadosFsException.check(self._cpp_rados_fs.addMetadataPool(name, prefix))

    def remove_metadata_pool(self, bytes name):
        RadosFsException.check(self._cpp_rados_fs.removeMetadataPool(name))

    def metadata_pools(self):
        return self._cpp_rados_fs.metadataPools()

    def metadata_pool_prefix(self, bytes pool):
        return self.metadata_pool_prefix(pool)

    def metadata_pool_from_prefix(self, bytes prefix):
        return self.metadata_pool_prefix(prefix)

    #
    # FS ACTIONS
    #

    def dir(self, bytes path, bool cacheable=True):
        fs_dir = RadosFsDir()
        (<RadosFsDir>fs_dir).__setup__(new bindings.RadosFsDir(self._cpp_rados_fs, path, cacheable))
        return fs_dir

    def file(self, bytes path, _mode):
        fs_file = RadosFsFile()
        cdef int int_mode = _mode.get_mode()
        (<RadosFsFile>fs_file).__setup__(new bindings.RadosFsFile(self._cpp_rados_fs, path, <bindings.OpenMode> int_mode))
        return fs_file

    #
    # ETC
    #

    def set_log_level(self, _log_level):
        cdef int int_level = _log_level.get_level()
        self._cpp_rados_fs.setLogLevel(<bindings.LogLevel> int_level)

    def __dealloc__(self):
        del self._cpp_rados_fs


cdef class RadosFsDir:
    cdef bindings.RadosFsDir* _cpp_rados_fs_dir

    cdef __setup__(self, bindings.RadosFsDir* cpp_rados_fs_dir):
        self._cpp_rados_fs_dir = cpp_rados_fs_dir

    def create(self, int mode, bool make_path, int owner_uid, int owner_gid):
        RadosFsException.check(self._cpp_rados_fs_dir.create(mode, make_path, owner_uid, owner_gid))
        return self

    def remove(self):
        RadosFsException.check(self._cpp_rados_fs_dir.remove())

    def entries(self):
        cdef set[string] _entries
        RadosFsException.check(self._cpp_rados_fs_dir.entryList(_entries))
        return _entries

    def entry(self, int index):
        cdef string cpp_entry = string()
        RadosFsException.check(self._cpp_rados_fs_dir.entry(index, cpp_entry))
        return <bytes> cpp_entry

    def set_path(self, new_path):
        self._cpp_rados_fs_dir.setPath(new_path)

    def is_writable(self):
        return self._cpp_rados_fs_dir.isWritable()

    def is_readable(self):
        return self._cpp_rados_fs_dir.isReadable()

    def update(self):
        self._cpp_rados_fs_dir.update()


cdef class RadosFsFile:
    cdef bindings.RadosFsFile* _cpp_rados_fs_file

    cdef __setup__(self, bindings.RadosFsFile* cpp_rados_fs_file):
        self._cpp_rados_fs_file = cpp_rados_fs_file

    def mode(self):
        return OpenMode.from_code(self._cpp_rados_fs_file.mode())

    def read(self, offset, int length):
        cdef char* buf = NULL
        self._cpp_rados_fs_file.read(buf, <off_t>offset, length)
        return buf

    def write(self, bytes buf, offset=0, length=None):
        if length is None:
            length = len(buf)
        RadosFsException.check(self._cpp_rados_fs_file.writeSync(buf, <long>offset, length))

    def create(self, int permissions=-1, str pool=""):
        RadosFsException.check(self._cpp_rados_fs_file.create(permissions, pool))
        return self

    def remove(self):
        RadosFsException.check(self._cpp_rados_fs_file.remove())

    def truncate(self, size):
        RadosFsException.check(self._cpp_rados_fs_file.truncate(size))

    def is_readable(self):
        return self._cpp_rados_fs_file.isReadable()

    def is_writable(self):
        return self._cpp_rados_fs_file.isWritable()

    def update(self):
        self._cpp_rados_fs_file.update()