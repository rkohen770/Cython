# setup.py - unnecessary if not redistributing the code, see below
from setuptools import setup, Extension
from Cython.Build import cythonize

ext_modules = [
    Extension("parser", sources=["parser.pyx"] ,depends=["constants.pyx"]),
    Extension("codeWriter", sources=["codeWriter.pyx"] ,depends=["constants.pyx"]),
    Extension("vmTranslator", sources=["vmTranslator.pyx"] ,depends=["parser.pyx", "codeWriter.pyx"]),
]
setup(name='Tar 1',ext_modules=cythonize("*.pyx"))