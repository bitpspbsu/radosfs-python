# -*- coding: utf8
# distutils: language = c++
from libcpp.string cimport string
from libcpp cimport bool
from posix.stat cimport struct_stat as stat

__author__ = 'dima'

cdef extern from "libradosfs.hh" namespace "radosfs":
    cdef cppclass RadosFs:
        RadosFs() except +
        int init(string, string)
        int addPool(string, string, int)
        string poolPrefix(string)
        string poolFromPrefix(string)
        int poolSize(string)

    cdef cppclass RadosFsDir:
        RadosFsDir(RadosFs*, string, bool) except +
        int remove()
        int create(int, boolean, int, int)
        int entryList(set[string])
        void update()
        int entry(int, string)
        void setPath(string)
        bool isWritable()
        bool isReadable()
        int stat(stat*)
        int compact()
        int setMetadata(string, string, string)
        int getMetadata(string, string, string)
        int removeMetadata(string, string)
        int find(set[string], args)

    cdef cppclass RadosFsFile:
        RadosFsFile(RadoseFs, string, OpenMode)
        OpenMode mode()
        ssize_t read(char*, off_t, size_t)
        ssize_t write(char*, off_t, size_t)
        ssize_t writeSync(char*, off_t, size_t)
        int create(int)
        int remove()
        int truncate(unsigned long long size)
        bool isWritable()
        bool isReadable()
        void update()
        void setPath(string)
        int stat(stat*)

cdef extern from "libradosfs.hh" namespace "radosfs.RadosFsFile":
    cdef enum OpenMode:
        MODE_NONE, MODE_READ, MODE_WRITE, MODE_READ_WRITE