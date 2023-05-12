# cython: language_level=3, encoding=utf-8
# distutils: language = c++


import constants

cdef class Parser:

    # singleton instance
    cdef Parser _instance
    cdef str currentCommand


    # constructor open file and get ready to parse it
    def __cinit__(self,str comd):
        self._instance = self 
        self.currentCommand = comd        


    # singleton instance getter
    @staticmethod
    def get_instance(self, str comd):
        if self._instance is None:
            self._instance = self(comd)
        return self._instance

    # get arg1
    # returns the first argument of the current command
    # in the case of C_ARITHMETIC, the command itself (add, sub, etc.) is returned
    # should not be called if the current command is C_RETURN
    def  arg1(self):
        return self.currentCommand.split(' ')[1].strip()

    # get arg2
    # returns the second argument of the current command
    # should be called only if the current command is C_PUSH, C_POP, C_FUNCTION, or C_CALL
    def arg2(self):
        return int(self.currentCommand.split(' ')[2].strip())