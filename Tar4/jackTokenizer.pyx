# class that Ignores all comments and white space, gets the next token,
# and advances the input just beyond it.


import os
# import compilationEngine

cdef class JackTokenizer:

    # Constants
    KEYWORDS = ["class", "constructor", "function", "method", "field", "static", "var", "int", "char", "boolean",
                "void", "true", "false", "null", "this", "let", "do", "if", "else", "while", "return"]
    SYMBOLS = ['{', '}', '(', ')', '[', ']', '.', ',', ';', '+', '-', '*', '/', '&', '|', '<', '>', '=', '~']
    KEYWORD = "KEYWORD"
    SYMBOL = "SYMBOL"
    IDENTIFIER = "IDENTIFIER"
    INT_CONST = "INT_CONST"
    STRING_CONST = "STRING_CONST"

    cdef str input_file
    cdef str current_token
    cdef str current_token_type

    # recursive function to process each file in the folder
    def recursive_process(self, file_path):
        for entry in os.scandir(file_path):
            print(entry.path)
            if entry.is_file() and entry.name.endswith('.jack'):
            
                # Extract the name of the last folder in the path without the extension
                folder_name = os.path.basename(file_path)
                file_name = os.path.splitext(entry.name)[0]
                output_file = os.path.join(file_path, file_name +'T' + '.xml')
                print(output_file)
                self.process_file(entry.path, output_file)
            elif entry.is_dir():
                self.recursive_process(entry.path)



    # process each file
    cdef process_file(self, input_file, output_file):
        # open the input file
        with open(input_file, 'r') as f:
            # open the output file
            with open(output_file, 'w') as o:
                # write the xml header
                o.write("<tokens>\n")
                flag=True
                for line in self.input_file.readlines():
                    #print line
                    if flag:
                        if line!='\n':
                            if not "//" in line:
                                if not "/**" in line:
                                    self.addLine(line)
                                else:
                                    if not "*/" in line:
                                        flag=False
                            elif not line.startswith("//"):
                                self.addLine(line[:line.find("//")])
                    else:
                        if "*/" in line:
                            flag=True

                self.output_file.write("</tokens>\n")
                self.output_file.close()
                self.input_file.close()

    # add the line to the output file
    cdef addLine(self, line):
        token = ''
        flag = False
        for sign in line:
            if sign in self.SYMBOLS and not flag:
                self.tipulInWord(token)
                if sign =='<' and not flag:
                    self.output_file.write("<symbol> &lt; </symbol>\n")
                elif sign =='>' and not flag:
                    self.output_file.write("<symbol> &gt; </symbol>\n")
                elif sign =='&' and not flag:
                    self.output_file.write("<symbol> &amp; </symbol>\n")
                else:
                    self.output_file.write("<symbol> " + sign + " </symbol>\n")
                token = ""
            elif sign == ' ' and not flag:
                self.tipulInWord(token)
                token = ""
            elif sign == '/t' and not flag:
                self.tipulInWord(token)
                token = ""
            elif sign == '"':
                if flag:
                    self.output_file.write("<stringConstant> " + token +" </stringConstant>\n")
                    flag = False
                    token = ""
                else:
                    flag = True
            else:
                token += sign

    # check the type of the word
    cdef tipulInWord(self, word):
        if word==" " or word=="\t" or word=="" or word.strip()=="":
            return
        if word in self.KEYWORDS:
            self.output_file.write("<keyword> " + word + " </keyword>\n")
        elif word.isdigit():
            self.output_file.write("<integerConstant> " + word + " </integerConstant>\n")
        elif word.startswith('"') and word.endswith('"'):
            self.output_file.write("<stringConstant> " + word + " </stringConstant>\n")
        else:
            self.output_file.write("<identifier> " + word + " </identifier>\n")


    # Constructor - Opens the input file/stream and gets ready to tokenize it.
    def __cinit__(self):
        dir="C:\\Users\\rache\\PycharmProjects\\Cython\\Tar4\\10"
        flag_isDir=True
        if(flag_isDir):
            for f1 in os.listdir(dir):
                if (f1.endswith(".jack")):
                    j=JackTokenizer(dir+"/"+f1)
                    j.recursive_process(dir)

    # Returns true if there are more tokens in the input.
    cdef has_more_tokens(self):
        return self.current_token != None

    # Gets the next token from the input and makes it the current token.
    # This method should only be called if has_more_tokens() is true.
    # Initially there is no current token.
    cdef advance(self):
        self.current_token = self._get_next_token()
        self.current_token_type = self._get_token_type(self.current_token)

    # Returns the type of the current token.
    cdef token_type(self):
        return self.current_token_type

    # Returns the keyword which is the current token.
    # Should be called only when token_type() is KEYWORD.
    cdef keyword(self):
        return self.current_token

    # Returns the character which is the current token.
    # Should be called only when token_type() is SYMBOL.
    cdef char symbol(self):
        return self.current_token

    # Returns the identifier which is the current token.
    # Should be called only when token_type() is IDENTIFIER.
    cdef str identifier(self):
        return self.current_token

    # Returns the integer value of the current token.
    # Should be called only when token_type() is INT_CONST.
    cdef int int_val(self):
        return int(self.current_token)

    # Returns the string value of the current token, without the double quotes.
    # Should be called only when token_type() is STRING_CONST.
    cdef str string_val(self):
        return self.current_token[1:-1]


dir="C:\\Users\\rache\\PycharmProjects\\Cython\\Tar4\\10"
flag_isDir=True
if(flag_isDir):
    for f1 in os.listdir(dir):
        if (f1.endswith(".jack")):
            j=JackTokenizer(dir+"/"+f1)
            j.recursive_process(dir)
