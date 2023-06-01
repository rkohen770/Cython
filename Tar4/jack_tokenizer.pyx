import constant 
import token


token_convert = {
    '&': '&amp;',
    '<': '&lt;',
    '>': '&gt;'
}

cdef class JackTokenizer():

    cdef object current_token
    cdef int linenum
    cdef str remained_line
    cdef list remained_tokens
    cdef object readfile

    def __cinit__(self, file_path):
        self.current_token = None
        self.linenum = 0
        self.remained_line = ''
        self.remained_tokens = []

        self.readfile = open(file_path)

        with open(file_path[:-5] + 'T.xml', 'w') as writefile:
            writefile.write('<tokens>\n')
            while 1:
                token = self.parse_next_token()
                if token:
                    element_name = ''
                    if token.type == constant.TokenType.KEYWORD:
                        element_name = 'keyword'
                    elif token.type == constant.TokenType.SYMBOL:
                        element_name = 'symbol'
                    elif token.type == constant.TokenType.IDENTIFIER:
                        element_name = 'identifier'
                    elif token.type == constant.TokenType.INT_CONST:
                        element_name = 'integerConstant'
                    elif token.type == constant.TokenType.STRING_CONST:
                        element_name = 'stringConstant'

                    self.remained_tokens.append(token)

                    writefile.write('<{}> {} </{}>\n'.format(element_name, token.value, element_name))
                else:
                    break
            writefile.write('</tokens>\n')

    cdef read_line(self):
        self.linenum += 1
        line = self.readfile.readline()
        if line:
            self.remained_line = line.split(constant.Tokens.LINE_COMMENT_START.token)[0].strip()
        else:
            self.remained_line = None
        return self.remained_line

    cdef parse_next_token(self):
        while True:

            if self.remained_line == '':
                self.read_line()
                if self.remained_line is None:
                    return None

            if self.remained_line:
                return self.pop_token()
            
    cdef pop_token(self):
        self.remained_line = self.remained_line.strip()
        for i in range(len(self.remained_line) + 1):
            temp = self.determine_token(self.remained_line[:i])
            if temp == constant.Tokens.COMMENT_START:
                end = self.remained_line.find(constant.Tokens.COMMENT_END.token)
                if end > -1:
                    self.remained_line = self.remained_line[end + 2:]
                    if len(self.remained_line) > 0:
                        return self.pop_token()
                    else:
                        self.read_line()
                        return self.pop_token()

                self.read_line()

            if i == len(self.remained_line):
                if self.determine_token(self.remained_line):
                    self.current_token = self.determine_token(self.remained_line[0:i])
                    self.remained_line = self.remained_line[i:]
                    return self.current_token
                else:
                    raise Exception('Invalid token: {}'.format(self.remained_line))
            else:
                temp1 = self.determine_token(self.remained_line[:i+1])
                if temp:
                    if temp1:
                        continue
                    else:
                        self.current_token = self.determine_token(self.remained_line[0:i])
                        self.remained_line = self.remained_line[i:]
                        return self.current_token

    cdef current_token_type(self):
        return self.detemine_token(self.current_token)

    cdef advance(self):
        if len(self.remained_tokens) > 0:
            self.current_token = self.remained_tokens.pop(0)
        else:
            self.current_token = None
        return self.current_token

    cdef see_next_token(self, index = 0):
        if len(self.remained_tokens) > index:
            return self.remained_tokens[index]
        else:
            return None

    cdef determine_token(self, token):
        if token in constant.TOKEN_MAP:
            return constant.TOKEN_MAP[token]
        elif constant.INTEGER_PATTERN.match(token):
            return constant.integerConstant(token)
        elif constant.STRING_PATTERN.match(token):
            return constant.stringConstant(token[1:-1])
        elif constant.IDENTIFIER_PATTERN.match(token):
            return constant.identifier(token)
        else:
            return None

    cdef token_type(self):
        return self.current_token.type

    cdef close(self):
        self.readfile.close()