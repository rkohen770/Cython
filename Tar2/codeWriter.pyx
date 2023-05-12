# cython: language_level=3, encoding=utf-8
# distutils: language = c++

import constants

cdef class CodeWriter:
    # singleton instance
    cdef CodeWriter _instance 

    cdef str currentFileName
    cdef int eq_counter
    cdef int gt_counter
    cdef int lt_counter
    cdef int label_counter
    cdef dict segment_dict 

    # singleton
    @staticmethod
    cdef get_instance(self):
        if self._instance is None:
            self._instance = self()
        return self._instance

    # constructor - open the output file/stream and gets ready to write into it.
    def __cinit__(self, file_name):
        self._instance = self
        self.currentFileName = file_name
        self.eq_counter = 0
        self.gt_counter = 0
        self.lt_counter = 0
        self.label_counter = 0
        self.segment_dict = {'local': 'LCL', 'argument': 'ARG', 'this': 'THIS', 'that': 'THAT'}

        
    # set current file name
    def setCurrenFileName(self, str file):
        self.currentFileName = file.split('\\.')[0]
        return f'// {file}\n'


    # writes to the output file the assembly code that implements the given arithmetic command.
    cpdef writeArithmetic(self, command):
        cdef str cmd
        # set the cmd to the correct command string by making the first letter uppercase and get the command from the constants file
        #cmd = getattr(constants, command.capitalize())()
        if command == 'add':
            cmd = constants.Add()
        elif command == 'sub':
            cmd = constants.Sub()
        elif command == 'neg':
            cmd = constants.Neg()
        elif command == 'eq':
            cmd = constants.Eq(self.eq_counter)
            self.eq_counter += 1
        elif command == 'gt':
            cmd = constants.Gt(self.gt_counter)
            self.gt_counter += 1
        elif command == 'lt':
            cmd = constants.Lt(self.lt_counter)
            self.lt_counter += 1
        elif command == 'and':
            cmd = constants.And()
        elif command == 'or':
            cmd = constants.Or()
        elif command == 'not':
            cmd = constants.Not()
        else:
            raise Exception('Unknown command: ' + command)
        return cmd

    # writes to the output file the assembly code that implements the given push/pop command.
    cpdef writePushPop(self, command, str segment, int index):
        cdef str cmd
        if command == 'push':
            if segment == 'constant':
                cmd = constants.PushConstant(index)
            elif segment == 'static':
                cmd = constants.PushStatic(index)
            elif segment in self.segment_dict:
                cmd = constants.PushSegment( index, self.segment_dict[segment])
            elif segment == 'temp':
                cmd = constants.PushTemp(index)
            elif segment == 'pointer':
                if index == 0:
                    cmd = constants.PushPointer('THIS')
                elif index == 1:
                    cmd = constants.PushPointer('THAT')
                else:
                    raise Exception('Unknown index: ' + str(index))
            else:
                raise Exception('Unknown segment: ' + segment)
                
        elif command == 'pop':
            if segment == 'static':
                cmd = constants.PopStatic(f'''{self.currentFileName}.{index}''')
            elif segment in self.segment_dict:
                cmd = constants.PopSegment( index, self.segment_dict[segment])
            elif segment == 'temp':
                cmd = constants.PopTemp(index)
            elif segment == 'pointer':
                if index == 0:
                    cmd = constants.PopPointer('THIS')
                elif index == 1:
                    cmd = constants.PopPointer('THAT')
                else:
                    raise Exception('Unknown index: ' + str(index))
            else:
                raise Exception('Unknown segment: ' + segment)
        else:
            raise Exception('Unknown command: ' + command)
        return cmd

    # writes to the output file the assembly code that implements the given label command.
    cpdef writeLabel(self, str label):
        return constants.Label(f'''{self.currentFileName}.{label}''')


    # writes to the output file the assembly code that implements the given goto command.
    cpdef writeGoto(self, str label):
        return constants.Goto(f'''{self.currentFileName}.{label}''')

    # writes to the output file the assembly code that implements the given if-goto command.
    cpdef writeIfGoto(self, str label):
        return constants.IfGoto(f'''{self.currentFileName}.{label}''')

    # writes to the output file the assembly code that implements the given function command.
    cpdef writeFunction(self, str functionName, int numLocals):
        return constants.Function(functionName, numLocals)

    # writes to the output file the assembly code that implements the given return command.
    cpdef writeReturn(self):
        return constants.Return()

    # writes to the output file the assembly code that implements the given call command.
    cpdef writeCall(self, str functionName, int numArgs):
        self.label_counter += 1
        return constants.Call(functionName, numArgs, self.label_counter)

    
    # init bootstrap code
    cpdef writeInit(self):
        return constants.Init()

    
    # Emit comment in the output file
    def emitComment(self, str comment):
        return f'// {comment}'

    # closes the output file.
    cdef close(output_file):
        output_file.close()
        

        





