# class that Ignores all comments and white space, gets the next token,
# and advances the input just beyond it.


import os
import re
from jackAnalyzer import JackAnalyzer
from vm_writer import VmWriter
from compEngine import CompilationEngine

cdef class JackTokenizer:

    # Constants
    KEYWORDS = ["class", "constructor", "function", "method", "field", "static", "var", "int", "char", "boolean",
                "void", "true", "false", "null", "this", "let", "do", "if", "else", "while", "return"]
    SYMBOLS = ['{', '}', '(', ')', '[', ']', '.', ',', ';', '+', '-', '*', '/', '&', '|', '<', '>', '=', '~']
    SYMBOL = "SYMBOL"
    IDENTIFIER = "IDENTIFIER"
    IDENTIFIER_PATTERN = re.compile(r'^[A-Za-z_][A-Za-z0-9_]*$')
    INTEGER_PATTERN = re.compile(r'^[0-9]+$')
    STRING_PATTERN = re.compile(r'^".*"$')

    cdef int line_num
    cdef str remained_line
    cdef remained_tokens
    cdef readfile
    cdef current_token

    cpdef get_current_token(self):
        return self.current_token

    cpdef get_identifier_pattern(self):
        return self.IDENTIFIER_PATTERN

    cpdef get_integer_pattern(self):
        return self.INTEGER_PATTERN

    cpdef get_string_pattern(self):
        return self.STRING_PATTERN

    def __cinit__(self, str filepath):
        self.current_token = None
        self.line_num = 0
        self.remained_line = ""
        self.remained_tokens = []

        self.readfile = open(filepath, 'r')

        with open(filepath[:-5] + "T.myImpl.xml", 'w') as writef:
            writef.write("<tokens>\n")
            while 1:
                token = self.parse_next_token()
                if token != None:
                    elem_name =''
                    if token in self.KEYWORDS:
                        elem_name = "keyword"
                    elif token in self.SYMBOLS:
                        if token == '<':
                            token = '&lt;'
                        elif token == '>':
                            token = '&gt;'
                        elif token == '&':
                            token = '&amp;'
                        elem_name = "symbol"
                    elif self.INTEGER_PATTERN.match(str(token)):
                        elem_name = "integerConstant"
                    elif self.IDENTIFIER_PATTERN.match(token):
                        elem_name = "identifier"
                    elif self.STRING_PATTERN.match(token):
                        # token = token[1:-1]
                        elem_name = "stringConstant"
                    else:
                        self.raise_exception('Unknown token exists')

                    self.remained_tokens.append(token)
                    writef.write("<%s> %s </%s>\n" % (elem_name, token, elem_name))
                else:
                    break
            writef.write("</tokens>\n")
            self.readfile.close()

    cdef _readline(self):
        self.line_num += 1
        cdef str line = self.readfile.readline()
        if line:
            self.remained_line = line.split("//")[0].strip()
            if self.remained_line[0:2] == '/*':
                while 1:
                    line = self.readfile.readline()
                    if line.find('*/') > -1:
                        self.remained_line = line[line.find('*/') + 2:].strip()
                        break
        else:
            self.remained_line = None
        return self.remained_line

    cdef parse_next_token(self):
        while True:
            # read new line
            if self.remained_line == '':

                self._readline()

                if self.remained_line is None:
                    return None

            if self.remained_line:
                return self._pop_token_from_remained_line()

    cdef _pop_token_from_remained_line(self):
        self.remained_line = self.remained_line.lstrip()  
        for i in range(1, len(self.remained_line) + 1):
            t_0 = self.judge_token(self.remained_line[0:i])
            # it has a comment
            if t_0 == '/*':
                print("t_0 is:", t_0)
                while 1:
                    end_i= self.remained_line.find('*/')
                    if end_i > -1:
                        self.remained_line = self.remained_line[end_i + 2:]
                        if len(self.remained_line) > 0:
                            return self._pop_token_from_remained_line()
                        else:
                            self._readline()
                            return self._pop_token_from_remained_line()

                    self._readline()

            if  i == len(self.remained_line):
                if self.judge_token(self.remained_line):
                    self.current_token = self.judge_token(self.remained_line[0:i])
                    self.remained_line = self.remained_line[i:]
                    return self.current_token
                else:
                    print(self.remained_line)
                    self.raise_exception('Unknown token exists')
            else:
                t_1 = self.judge_token(self.remained_line[0:i + 1])
                if t_0 != None:
                    if t_1 != None:
                        continue
                    else:
                        self.current_token = self.judge_token(self.remained_line[0:i])
                        self.remained_line = self.remained_line[i:]
                        return self.current_token

    cdef current_token_type(self):
        return self.judge_token(self.current_token)

    cdef raise_exception(self, str msg):
        raise Exception("line %d: %s" % (self.line_num, msg))

    cpdef advance(self):
        if len(self.remained_tokens) > 0:
            self.current_token = self.remained_tokens.pop(0)
        else:
            self.current_token = None
        return self.current_token

    cpdef see_next(self,idx=0):
        if len(self.remained_tokens) > idx:
            return self.remained_tokens[idx]
        else:
            return None

    cdef judge_token(self, judged_token):
        if judged_token in self.KEYWORDS:
            return judged_token
        elif judged_token in self.SYMBOLS:
            return judged_token
        elif self.INTEGER_PATTERN.match(judged_token):
            try:
                return int(judged_token)   
            except Exception as e:
                self.raise_exception(e.message)
        elif self.IDENTIFIER_PATTERN.match(judged_token):
            return str(judged_token)
        elif self.STRING_PATTERN.match(judged_token):
            return str(judged_token)
        else:
            return None
            

    cdef token_type(self):
        return self.current_token

    cdef close(self):
        self.readfile.close()