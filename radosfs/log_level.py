#!/usr/bin/python
# -*- coding: utf8

__author__ = 'dima'


class LogLevel(object):
    def __init__(self, str_level, int_level):
        self._str_level = str_level
        self._int_level = int_level

    def get_level(self):
        return self._int_level

    def __str__(self):
        return "LogLevel: " + self._str_level

    __repr__ = __str__

LogLevel.NONE = LogLevel("NONE", 0)
LogLevel.DEBUG = LogLevel("DEBUG", 1)