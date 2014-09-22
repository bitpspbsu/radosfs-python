#!/bin/sh

rm -rf radosfs/*.cpp
rm -rf build
python setup.py install --user
rm -rf radosfs/*.cpp