#!/usr/bin/python
# -*- coding: utf8

__author__ = 'dima'

from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext

setup(
    cmdclass = {'build_ext': build_ext},
    ext_modules = [
        Extension("radosfs",
                  sources=["radosfs/radosfs.pyx"],
                  libraries=["radosfs"],
                  language="c++",
             )
        ]
)