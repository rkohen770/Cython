import os
from compEngine import CompilationEngine
from vm_writer import VmWriter
import glob

cdef class JackAnalyzer:

    def __cinit__(self,input_file):

        path = input_file
        print(path)

        self.recursionMethod(path)

    cdef compile(self, filepath):
        with VmWriter(filepath[:-5] + ".vm") as code_writer:
            with CompilationEngine(filepath, code_writer) as ce:
                print ("compiling %s ..." % filepath)
                ce.compile()

    cdef recursionMethod(self, path):
        if os.path.isfile(path) and path.endswith('.jack'):
            self.compile(path)
        elif os.path.isdir(path):
            for file in os.listdir(path):
                self.recursionMethod(path + "/" + file)