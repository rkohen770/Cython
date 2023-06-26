
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


    cpdef write_code(self, code):
        self.output_file.write(code + '\n')

    cpdef write_codes(self, codes):
        self.write_code('\n'.join(codes))

    cpdef write_push(self, segment, index):
        print('push', segment, index)
        self.write_code('push %s %d' % (self._get_segment_str(segment), int(index)))

    cpdef write_pop(self, segment, index):
        self.write_code('pop %s %d' % (self._get_segment_str(segment), int(index)))

    cpdef write_arithmetic(self, command):
        if command == 'add':
            self.write_code('add')
        elif command == 'sub':
            self.write_code('sub')
        elif command == 'neg':
            self.write_code('neg')
        elif command == 'eq':
            self.write_code('eq')
        elif command == 'gt':
            self.write_code('gt')
        elif command == 'lt':
            self.write_code('lt')
        elif command == 'and':
            self.write_code('and')
        elif command == 'or':
            self.write_code('or')
        elif command == 'not':
            self.write_code('not')
        else:
            raise Exception('unknown command %s' % command)

    cpdef write_label(self, label):
        self.write_code('label %s' % label)

    cpdef write_goto(self, label):
        self.write_code('goto %s' % label)

    cpdef write_if(self, label):
        self.write_code('if-goto %s' % label)

    cpdef write_call(self, name, n_args):
        self.write_code('call %s %d' % (name, int(n_args)))

    cpdef write_function(self, name, n_locals):
        self.write_code('function %s %d' % (name, int(n_locals)))

    cpdef write_return(self):
        self.write_code('return')

    cpdef _get_segment_str(self, segment):
        if segment == 'CONST' or segment == 'constant':
            return 'constant'
        elif segment == 'ARG' or segment == 'argument':
            return 'argument'
        elif segment == 'LOCAL' or segment == 'local':
            return 'local'
        elif segment == 'STATIC' or segment == 'static':
            return 'static'
        elif segment == 'THIS' or segment == 'this':
            return 'this'
        elif segment == 'THAT' or segment == 'that':
            return 'that'
        elif segment == 'POINTER' or segment == 'pointer':
            return 'pointer'
        elif segment == 'TEMP' or segment == 'temp':
            return 'temp'
        else:
            raise Exception('unknown segment %s' % segment)