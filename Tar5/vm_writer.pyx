
import os
import sys
import re

cdef class VmWriter():

    cdef output_file


    def __cinit__(self, output_f):
        print('writing to', output_f)
        self.output_file = open(output_f, 'w')

    def __enter__(self):
        # Code executed when entering the context
        return self

    def __exit__(self, exc_type, exc_value, traceback):
        # Close the output file if it was opened
        if self.output_file is not None:
            self.output_file.close()


    cdef write_code(self, code):
        self.output_file.write(code + '\n')

    cdef write_codes(self, codes):
        self.write_code('\n'.join(codes))

    cdef write_push(self, segment, index):
        self.write_code('push %s %d' % (self._get_segment_str(segment), int(index)))

    cdef write_pop(self, segment, index):
        self.write_code('pop %s %d' % (self._get_segment_str(segment), int(index)))

    cdef write_arithmetic(self, command):
        if command == 'ADD':
            self.write_code('add')
        elif command == 'SUB':
            self.write_code('sub')
        elif command == 'NEG':
            self.write_code('neg')
        elif command == 'EQ':
            self.write_code('eq')
        elif command == 'GT':
            self.write_code('gt')
        elif command == 'LT':
            self.write_code('lt')
        elif command == 'AND':
            self.write_code('and')
        elif command == 'OR':
            self.write_code('or')
        elif command == 'NOT':
            self.write_code('not')
        else:
            raise Exception('unknown command %s' % command)

    cdef write_label(self, label):
        self.write_code('label %s' % label)

    cdef write_goto(self, label):
        self.write_code('goto %s' % label)

    cdef write_if(self, label):
        self.write_code('if-goto %s' % label)

    cdef write_call(self, name, n_args):
        self.write_code('call %s %d' % (name, int(n_args)))

    cpdef write_function(self, name, n_locals):
        self.write_code('function %s %d' % (name, int(n_locals)))

    cdef write_return(self):
        self.write_code('return')

    cdef _get_segment_str(self, segment):
        if segment == 'CONST':
            return 'constant'
        elif segment == 'ARG':
            return 'argument'
        elif segment == 'LOCAL':
            return 'local'
        elif segment == 'STATIC':
            return 'static'
        elif segment == 'THIS':
            return 'this'
        elif segment == 'THAT':
            return 'that'
        elif segment == 'POINTER':
            return 'pointer'
        elif segment == 'TEMP':
            return 'temp'
        else:
            raise Exception('unknown segment %s' % segment)