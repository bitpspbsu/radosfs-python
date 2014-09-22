#!/bin/sh

rm -rf radosfs/*.cpp
rm -rf radosfs/*.so
rm -rf build
python setup.py build_ext --inplace
cp radosfs/*.py ./
rm -rf build
rm -rf radosfs/*.cpp