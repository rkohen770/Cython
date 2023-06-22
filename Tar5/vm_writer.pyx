
import os
import sys
import re

cdef class VmWriter():

    cdef output_file


    def __cinit__(self, output_f):
        print('writing to', output_f)
        self.output_file = output_f
