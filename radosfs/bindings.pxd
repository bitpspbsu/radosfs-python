# -*- coding: utf8
# distutils: language = c++
from libcpp.string cimport string
from libcpp.vector cimport vector
from libcpp.set cimport set
from libcpp cimport bool
from posix.stat cimport struct_stat as stat

__author__ = 'dima'

cdef extern from "libradosfs.hh" namespace "radosfs":
    cppclass RadosFs:
        RadosFs() except +
        int init(string, string)
        int addDataPool(string, string, int)
        int removeDataPool(string)
        vector[string] dataPools(string)
        string dataPoolPrefix(string)
        int dataPoolSize(string)
        int addMetadataPool(string, string)
        int removeMetadataPool(string)
        vector[string] metadataPools()
        string metadataPoolPrefix(string)
        string metadataPoolFromPrefix(string)
        void setLogLevel(LogLevel)

    cppclass RadosFsDir:
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

    cppclass RadosFsFile:
        RadosFsFile(RadosFs*, string, OpenMode) except +
        OpenMode mode()
        ssize_t read(char*, long, size_t)
        ssize_t write(char*, long, size_t)
        ssize_t writeSync(char*, long, size_t)
        int create(int, string)
        int remove()
        int truncate(unsigned long long size)
        bool isWritable()
        bool isReadable()
        void update()
        void setPath(string)
        int stat(stat*)

cdef extern from "libradosfs.hh" namespace "radosfs::RadosFs":
    ctypedef enum LogLevel:
        LOG_LEVEL_NONE
        LOG_LEVEL_DEBUG


cdef extern from "libradosfs.hh" namespace "radosfs::RadosFsFile":
    ctypedef enum OpenMode:
        MODE_NONE
        MODE_READ
        MODE_WRITE
        MODE_READ_WRITE