# setup.py - unnecessary if not redistributing the code, see below
from setuptools import setup
from Cython.Build import cythonize

setup(name='Hello world app',ext_modules=cythonize("*.pyx"))