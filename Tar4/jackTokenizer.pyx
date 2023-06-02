# class that Ignores all comments and white space, gets the next token,
# and advances the input just beyond it.


import os
from jackAnalyzer import JackAnalyzer

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

    cdef str input_file_path
    cdef str current_token
    cdef str current_token_type

    # recursive function to process each file in the folder
    cpdef recursive_process(self, file_path):
        for entry in os.scandir(file_path):
            print(entry.path)

            if entry.is_file() and entry.name.endswith('.jack'):
            
                # Extract the name of the file in the path without the extension
                file_name = os.path.splitext(entry.name)[0]
                print(file_name)

                 # Build the output file name
                output_file_name = os.path.join(file_path, file_name + 'T' + '.xml')
        
                # Open the output file for writing
                output_file = open(output_file_name, 'w')
                
                self.process_file(entry.path, output_file)
                output_file.close()

                # Create an instance of the JackAnalyzer class
                analyzer = JackAnalyzer()

                # Call the compile method on the analyzer instance, passing the output file and directory as arguments
                analyzer.compile(output_file, file_path , file_name)

            elif entry.is_dir():
                self.recursive_process(entry.path)



    # process each file
    cdef process_file(self, input_file, output_file):

        output_file.write("<tokens>\n")
        # open the input file
        with open(input_file, 'r') as f:
            # open the output file
            for line in f:
                # remove white spaces and tabs in the beginning and end of the line
                line = line.strip()

                # ignore comments and empty lines
                if line.startswith("//") or line.startswith("/**") or line.startswith("\n") or line.startswith("*"):
                    continue
                # remove comments
                elif "//" in line:
                    line = line[:line.index("//")]
                elif "/*" in line:
                    line = line[:line.index("/*")]
                    while "*/" not in line:
                        line += next(f)
                    line = line[line.index("*/"):]

                # remove empty lines
                if line.strip() == "":
                    continue
                # remove white spaces and tabs in the beginning and end of the line
                line = line.strip()
                # add the line to the output file
                self.processLine(line, output_file)


                

            output_file.write("</tokens>\n")


    # process each line
    cdef processLine(self, line, output_file):
        print(line)
        token = ''
        flag = False
        for sign in line:
            if sign in self.SYMBOLS and not flag:
                self.tipulInWord(token, output_file)
                if sign =='<' and not flag:
                    output_file.write("<symbol> &lt; </symbol>\n")
                elif sign =='>' and not flag:
                    output_file.write("<symbol> &gt; </symbol>\n")
                elif sign =='&' and not flag:
                    output_file.write("<symbol> &amp; </symbol>\n")
                else:
                    output_file.write("<symbol> " + sign + " </symbol>\n")
                token = ""
            elif sign == ' ' and not flag:
                self.tipulInWord(token, output_file)
                token = ""
            elif sign == '/t' and not flag:
                self.tipulInWord(token, output_file)
                token = ""
            elif sign == '"':
                if flag:
                    output_file.write("<stringConstant> " + token +" </stringConstant>\n")
                    flag = False
                    token = ""
                else:
                    flag = True
            else:
                token += sign



    # check the type of the word
    cdef tipulInWord(self, word, output_file):
        if word==" " or word=="\t" or word=="" or word.strip()=="":
            return
        if word in self.KEYWORDS:
            output_file.write("<keyword> " + word + " </keyword>\n")
        elif word.isdigit():
            output_file.write("<integerConstant> " + word + " </integerConstant>\n")
        elif word.startswith('"') and word.endswith('"'):
            output_file.write("<stringConstant> " + word + " </stringConstant>\n")
        else:
            output_file.write("<identifier> " + word + " </identifier>\n")


