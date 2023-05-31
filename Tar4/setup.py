# setup.py - unnecessary if not redistributing the code, see below
from setuptools import setup, Extension
from Cython.Build import cythonize

setup(name='Tar 4',ext_modules=cythonize("*.pyx"))