#!/usr/bin/python
# -*- coding: utf8

__author__ = 'dima'

from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext

setup(
    name='RadosFsPython',
    version='0.0.1',
    author='Dmitry Batkovich',
    author_email='batya239@gmail.com',
    cmdclass = {'build_ext': build_ext},
    ext_modules = [
        Extension("radosfs",
                  sources=["radosfs/radosfs.pyx"],
                  libraries=["radosfs"],
                  language="c++",
             )
        ],
    license='LICENSE',
    description='RadosFs Python bindings',
    long_description=open('README.md').read(),
)