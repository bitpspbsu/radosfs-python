#!/usr/bin/python
# -*- coding: utf8

__author__ = 'dima'


class OpenMode(object):
    _REVERSED_MAP = dict()

    @staticmethod
    def _register(open_mode):
        OpenMode._REVERSED_MAP[open_mode.get_mode()] = open_mode

    @staticmethod
    def from_code(code):
        return OpenMode._REVERSED_MAP[code]

    def __init__(self, str_mode, int_mode):
        self._str_mode = str_mode
        self._int_mode = int_mode

    def get_mode(self):
        return self._int_mode

    def __str__(self):
        return "OpenMode: " + self._str_mode

    __repr__ = __str__

OpenMode.NONE = OpenMode("NONE", 0)
OpenMode.READ = OpenMode("READ", 1)
OpenMode.WRITE = OpenMode("WRITE", 1 << 1)
OpenMode.READ_WRITE = OpenMode("READ_WRITE", OpenMode.READ.get_mode() | OpenMode.WRITE.get_mode())

OpenMode._register(OpenMode.NONE)
OpenMode._register(OpenMode.READ)
OpenMode._register(OpenMode.WRITE)
OpenMode._register(OpenMode.READ_WRITE)