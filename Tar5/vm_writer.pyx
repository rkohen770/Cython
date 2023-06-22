

cdef class VmWriter():
    def __cinit__(self, filepath):
        self.f = open(filepath, 'w')