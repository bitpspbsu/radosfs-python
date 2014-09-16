#!/usr/bin/python
# -*- coding: utf8

__author__ = 'dima'


class RadosFsException(BaseException):
    @staticmethod
    def check(code):
        if code != 0:
            raise RadosFsException(code)

    def __init__(self, code):
        self.code = code

    def __str__(self):
        return "internal RadosFs error, code = %s" % self.code

    __repr__ = __str__