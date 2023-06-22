# Gets its input from a Jackinput_file, and emits its output to an output file

# The output is generated by a series of compilexxx routines,
# structured according to the grammar rules that define xxx

# Each compilexxx routine is responsible for handling all the tokens that make up 
#xxx, advancing the input_file exactly beyond these tokens, and outputing the parsing of xxx.

# Thus, compilexxx may only be called if indeed xxx is the next thing in the input.

from symbol_table import SymbolTable

cdef class CompilationEngine:
    cdef input_file
    cdef output_file
    cdef int indent
    cdef str next_token
    cdef str temp
    cdef int pointer
    
    # Constructor
    def __cinit__(self, input_file, output_file):
        self.pointer = 0
        self.output_file = output_file
        self.symbol_table = SymbolTable()
        self.indent = 0
        self.input_file = open(input_file, 'r').readlines()
        self.advance() # get the first token <tokens>

        self.compileClass()

        self.output_file.close()  

    # Get the next token from the input
    cdef advance(self):
        self.next_token = self.input_file[self.pointer].strip()
        self.pointer += 1

    # reverse the last advance
    cdef reverse(self):
        self.pointer -= 1

    # compile a complete class
    cdef compileClass(self):
        self.output_file.write('<class>\n')
        self.indent += 1

        self.advance() # get the next token <class>
        self.output_file.write(self.indent * "  " + self.next_token + '\n')

        self.advance() # get the next token <class_name>
        self.output_file.write(self.indent * "  " + self.next_token + '\n')

        self.advance() # get the next token {
        self.output_file.write(self.indent * "  " + self.next_token + '\n')

        # compile classVarDec*
        self.compileClassVarDec()

        # compile subroutineDec*
        self.compileSubroutineDec()

        self.advance() # get the next token }
        self.output_file.write(self.indent * "  " + self.next_token + '\n')

        self.indent -= 1
        self.output_file.write('</class>\n')

        self.output_file.close()

    # compile a static declaration or a field declaration
    cdef compileClassVarDec(self):
        # first determine whether there is a classVarDec, nextToken is } or start subroutineDec
        self.advance()
        if self.next_token == "<symbol> } </symbol>":
            self.reverse()
            return

        # next is subroutineDec
        if self.next_token == "<keyword> constructor </keyword>" or self.next_token == "<keyword> function </keyword>" or self.next_token == "<keyword> method </keyword>":
            self.reverse()
            return

        # next is classVarDec
        self.output_file.write(self.indent * "  " + '<classVarDec>\n')
        self.indent += 1

        self.output_file.write(self.indent * "  " + self.next_token + '\n')

        self.advance() # get the next token <type>
        self.output_file.write(self.indent * "  " + self.next_token + '\n')

        self.advance() # get the next token <varName>
        self.output_file.write(self.indent * "  " + self.next_token + '\n')

        # compile (, varName)*
        self.advance() # get the next token , or ;
        while self.next_token == "<symbol> , </symbol>":
            self.output_file.write(self.indent * "  " + self.next_token + '\n')

            self.advance() # get the next token <varName>
            self.output_file.write(self.indent * "  " + self.next_token + '\n')

            self.advance() # get the next token , or ;
        if self.next_token == "<symbol> ; </symbol>":
            self.output_file.write(self.indent * "  " + self.next_token + '\n')

        self.indent -= 1
        self.output_file.write(self.indent * "  " + '</classVarDec>\n')

        # compile classVarDec*
        self.compileClassVarDec()

    # compile a complete method, function, or constructor
    cdef compileSubroutineDec(self):
        # first determine whether there is a subroutineDec, nextToken is }
        self.advance() # get the next token <keyword> or }
        if self.next_token == "<symbol> } </symbol>":
            self.reverse()
            return

        # next is subroutineDec
        self.output_file.write(self.indent * "  " + '<subroutineDec>\n')
        self.indent += 1

        self.output_file.write(self.indent * "  " + self.next_token + '\n') # get the next token <keyword>

        self.advance() # get the next token <type> or void
        self.output_file.write(self.indent * "  " + self.next_token + '\n')

        self.advance() # get the next token <subroutineName>
        self.output_file.write(self.indent * "  " + self.next_token + '\n')

        self.advance() # get the next token (
        self.output_file.write(self.indent * "  " + self.next_token + '\n')

        # compile parameterList
        self.compileParameterList()

        self.advance() # get the next token )
        self.output_file.write(self.indent * "  " + self.next_token + '\n')

        # compile subroutineBody
        self.compileSubroutineBody()

        self.indent -= 1
        self.output_file.write(self.indent * "  " + '</subroutineDec>\n')

        # compile subroutineDec*
        self.compileSubroutineDec()

    # compile a (possibly empty) parameter list, not including the enclosing ()
    cdef compileParameterList(self):

        self.output_file.write(self.indent * "  " + '<parameterList>\n')
        self.indent += 1

        # first determine whether there is a parameterList, nextToken is )
        self.advance() # get the next token ) or <type>
        if self.next_token == "<symbol> ) </symbol>":
            self.reverse()
            self.indent -= 1
            self.output_file.write(self.indent * "  " + '</parameterList>\n')
            return

        # next is parameterList
        self.output_file.write(self.indent * "  " + self.next_token + '\n') # get the next token <type>
        self.advance() # get the next token <varName>
        self.output_file.write(self.indent * "  " + self.next_token + '\n')

        # compile (, type varName)*
        self.advance() # get the next token , or )
        while self.next_token == "<symbol> , </symbol>":
            self.output_file.write(self.indent * "  " + self.next_token + '\n')

            self.advance() # get the next token <type>
            self.output_file.write(self.indent * "  " + self.next_token + '\n')

            self.advance() # get the next token <varName>
            self.output_file.write(self.indent * "  " + self.next_token + '\n')

            self.advance() # get the next token , or )
        
        if self.next_token == "<symbol> ) </symbol>":
            self.reverse()

        self.indent -= 1
        self.output_file.write(self.indent * "  " + '</parameterList>\n')

    # compile a subroutine's body
    cdef compileSubroutineBody(self):
        self.output_file.write(self.indent * "  " + '<subroutineBody>\n')
        self.indent += 1

        self.advance() # get the next token {
        self.output_file.write(self.indent * "  " + self.next_token + '\n')

        # compile varDec*
        self.compileVarDec()

        # compile statements
        self.output_file.write(self.indent * "  " + '<statements>\n')
        self.indent += 1
        self.compileStatements()
        self.indent -= 1
        self.output_file.write(self.indent * "  " + '</statements>\n')

        self.advance() # get the next token }
        self.output_file.write(self.indent * "  " + self.next_token + '\n')

        self.indent -= 1
        self.output_file.write(self.indent * "  " + '</subroutineBody>\n')

    # compile a var declaration
    cdef compileVarDec(self):
        # determine if there is a varDec
        self.advance() # get the next token } or <keyword> var </keyword>

        # no 'var' go back
        if self.next_token != "<keyword> var </keyword>":
            self.reverse()
            return

        # next is varDec
        self.output_file.write(self.indent * "  " + '<varDec>\n')
        self.indent += 1

        self.output_file.write(self.indent * "  " + self.next_token + '\n') # get the next token <keyword> var </keyword>

        self.advance() # get the next token <type>
        self.output_file.write(self.indent * "  " + self.next_token + '\n')

        self.advance() # get the next token <varName>
        self.output_file.write(self.indent * "  " + self.next_token + '\n') # get the next token <varName>
           
        self.advance() # get the next token , or ;

        # compile (, varName)*
        while self.next_token == "<symbol> , </symbol>":
            self.output_file.write(self.indent * "  " + self.next_token + '\n') # get the next token ,
            self.advance() # get the next token <varName>
            self.output_file.write(self.indent * "  " + self.next_token + '\n') # get the next token <varName>
            self.advance() # get the next token , or ;

        self.output_file.write(self.indent * "  " + self.next_token + '\n') # get the next token ;

        self.indent -= 1
        self.output_file.write(self.indent * "  " + '</varDec>\n')

        # compile varDec*
        self.compileVarDec()
        
    # compile a sequence of statements, not including the enclosing {}
    cdef compileStatements(self):

        # first determine whether there is a statement, nextToken is }
        self.advance() # get the next token } or <keyword>
        if self.next_token == "<symbol> } </symbol>":
            self.reverse()
            return

        # next is statement
        if self.next_token == "<keyword> let </keyword>":
            self.compileLet()
        elif self.next_token == "<keyword> if </keyword>":
            self.compileIf()
        elif self.next_token == "<keyword> while </keyword>":
            self.compileWhile()
        elif self.next_token == "<keyword> do </keyword>":
            self.compileDo()
        elif self.next_token == "<keyword> return </keyword>":
            self.compileReturn()

        # compile statement*
        self.compileStatements()


    # compile a let statement
    cdef compileLet(self):
        self.output_file.write(self.indent * "  " + '<letStatement>\n')
        self.indent += 1

        self.output_file.write(self.indent * "  " + self.next_token + '\n') # get the next token <keyword> let </keyword>

        self.advance() # get the next token <varName>
        self.output_file.write(self.indent * "  " + self.next_token + '\n')

        # compile ([expression])?
        self.advance() # get the next token [ or =

        isExpression = False

        # '[' expression ']'
        if self.next_token == "<symbol> [ </symbol>":
            isExpression = True
            self.output_file.write(self.indent * "  " + self.next_token + '\n') # get the next token [

            # compile expression
            self.compileExpression()

            self.advance() # get the next token ]
            self.output_file.write(self.indent * "  " + self.next_token + '\n')

        if isExpression == True:
            self.advance() # get the next token =

        # '='
        self.output_file.write(self.indent * "  " + self.next_token + '\n')

        # compile expression
        self.compileExpression()

        self.advance() # get the next token ;
        self.output_file.write(self.indent * "  " + self.next_token + '\n')

        self.indent -= 1
        self.output_file.write(self.indent * "  " + "</letStatement>\n")

    # compile an if statement, possibly with a trailing else clause
    cdef compileIf(self):
        self.output_file.write(self.indent * "  " + '<ifStatement>\n')
        self.indent += 1

        self.output_file.write(self.indent * "  " + self.next_token + '\n') # get the next token <keyword> if </keyword>

        self.advance() # get the next token (
        self.output_file.write(self.indent * "  " + self.next_token + '\n')

        # compile expression
        self.compileExpression()

        self.advance() # get the next token )
        self.output_file.write(self.indent * "  " + self.next_token + '\n')

        self.advance() # get the next token {
        self.output_file.write(self.indent * "  " + self.next_token + '\n')

        # compile statements
        self.output_file.write(self.indent * "  " + '<statements>\n')
        self.indent += 1
        self.compileStatements()
        self.indent -= 1
        self.output_file.write(self.indent * "  " + '</statements>\n')


        self.advance() # get the next token }
        self.output_file.write(self.indent * "  " + self.next_token + '\n')

        # compile (else { statements })?
        self.advance() # get the next token else or not else
        if self.next_token == "<keyword> else </keyword>":
            self.output_file.write(self.indent * "  " + self.next_token + '\n')

            self.advance() # get the next token {
            self.output_file.write(self.indent * "  " + self.next_token + '\n')

            # compile statements
            self.output_file.write(self.indent * "  " + '<statements>\n')
            self.indent += 1
            self.compileStatements()
            self.indent -= 1
            self.output_file.write(self.indent * "  " + '</statements>\n')


            self.advance() # get the next token }
            self.output_file.write(self.indent * "  " + self.next_token + '\n')

        else:
            self.reverse()

        self.indent -= 1
        self.output_file.write(self.indent * "  " + '</ifStatement>\n')

    # compile a while statement
    cdef compileWhile(self):
        self.output_file.write(self.indent * "  " + '<whileStatement>\n')
        self.indent += 1

        self.output_file.write(self.indent * "  " + self.next_token + '\n') # get the next token <keyword> while </keyword>

        self.advance() # get the next token (
        self.output_file.write(self.indent * "  " + self.next_token + '\n')

        # compile expression
        self.compileExpression()

        self.advance() # get the next token )
        self.output_file.write(self.indent * "  " + self.next_token + '\n')

        self.advance() # get the next token {
        self.output_file.write(self.indent * "  " + self.next_token + '\n')

        # compile statements
        self.output_file.write(self.indent * "  " + '<statements>\n')
        self.indent += 1
        self.compileStatements()
        self.indent -= 1
        self.output_file.write(self.indent * "  " + '</statements>\n')


        self.advance() # get the next token }
        self.output_file.write(self.indent * "  " + self.next_token + '\n')

        self.indent -= 1
        self.output_file.write(self.indent * "  " + '</whileStatement>\n')

    # compile a do statement
    cdef compileDo(self):
        self.output_file.write(self.indent * "  " + '<doStatement>\n')
        self.indent += 1

        self.output_file.write(self.indent * "  " + self.next_token + '\n') # get the next token <keyword> do </keyword>

        # compile subroutineCall
        self.compileSubroutineCall()

        self.advance() # get the next token ;
        self.output_file.write(self.indent * "  " + self.next_token + '\n')

        self.indent -= 1
        self.output_file.write(self.indent * "  " + '</doStatement>\n')

    # compile a return statement
    cdef compileReturn(self):
        self.output_file.write(self.indent * "  " + '<returnStatement>\n')
        self.indent += 1

        self.output_file.write(self.indent * "  " + self.next_token + '\n') # get the next token <keyword> return </keyword>

        # compile expression?
        self.advance() # get the next token ; or not ;
        if self.next_token == "<symbol> ; </symbol>":
            self.output_file.write(self.indent * "  " + self.next_token + '\n')
            self.indent -= 1
            self.output_file.write(self.indent * "  " + '</returnStatement>\n')
            return
        self.reverse()
        self.compileExpression()

        self.advance() # get the next token ;
        self.output_file.write(self.indent * "  " + self.next_token + '\n')

        self.indent -= 1
        self.output_file.write(self.indent * "  " + '</returnStatement>\n')
        
    # compile an expression
    cdef compileExpression(self):
        self.output_file.write(self.indent * "  " + '<expression>\n')
        self.indent += 1

        # compile term
        self.compileTerm()

        # compile (op term)* 
        self.advance() # get the next token op or not op
        while self.next_token.startswith("<symbol> &lt; </symbol>") or self.next_token.startswith("<symbol> &gt; </symbol>") or self.next_token.startswith("<symbol> &amp; </symbol>") or self.next_token.startswith("<symbol> + </symbol>") or self.next_token.startswith("<symbol> - </symbol>") or self.next_token.startswith("<symbol> * </symbol>") or self.next_token.startswith("<symbol> / </symbol>") or self.next_token.startswith("<symbol> = </symbol>") or self.next_token.startswith("<symbol> | </symbol>"):

            self.output_file.write(self.indent * "  " + self.next_token + '\n')

            # compile term
            self.compileTerm()

            self.advance() # get the next token op or not op

        self.reverse()

        self.indent -= 1
        self.output_file.write(self.indent * "  " + '</expression>\n')

    # compile a term. If the current token is an identifier, the routine must distinguish between a variable, an array entry, and a subroutine call.
    # A single look-ahead token, which may be one of [, (, or . suffices to distinguish between the possibilities.
    # Any other token is not part of this term and should not be advanced over.
    cdef compileTerm(self):
        self.output_file.write(self.indent * "  " + '<term>\n')
        self.indent += 1
        
        self.advance() # get the next token

        # check if it is an identifier
        if self.next_token.startswith("<identifier>"):
            # varName|varName '[' expression ']'|subroutineCall
            self.temp = self.next_token # save the token
            self.advance() # get the next token [ or ( or .
            # varName '[' expression ']'
            if self.next_token == "<symbol> [ </symbol>":
                self.output_file.write(self.indent * "  " + self.temp + '\n')
         
                # this is an array entry
                self.output_file.write(self.indent * "  " + self.next_token + '\n')

                # compile expression
                self.compileExpression()

                self.advance() # get the next token ]
                self.output_file.write(self.indent * "  " + self.next_token + '\n')

            # subroutineCall
            elif self.next_token == "<symbol> ( </symbol>" or self.next_token == "<symbol> . </symbol>":
                self.reverse()
                self.reverse()
                self.compileSubroutineCall()


            # varName
            else:
                self.output_file.write(self.indent * "  " + self.temp + '\n')
                self.reverse()

        # check if it is a constant
        else:
            if self.next_token.startswith("<integerConstant>") or self.next_token.startswith("<stringConstant>") or self.next_token.startswith("<keyword> true </keyword>") or self.next_token.startswith("<keyword> false </keyword>") or self.next_token.startswith("<keyword> null </keyword>") or self.next_token.startswith("<keyword> this </keyword>"):
                # integerConstant|stringConstant|keywordConstant
                self.output_file.write(self.indent * "  " + self.next_token + '\n')

            elif self.next_token == "<symbol> ( </symbol>":
                self.output_file.write(self.indent * "  " + self.next_token + '\n')

                # compile expression
                self.compileExpression()

                self.advance() # get the next token )
                self.output_file.write(self.indent * "  " + self.next_token + '\n')

            elif self.next_token == "<symbol> - </symbol>" or self.next_token == "<symbol> ~ </symbol>":
                self.output_file.write(self.indent * "  " + self.next_token + '\n')

                # compile term
                self.compileTerm()

        self.indent -= 1
        self.output_file.write(self.indent * "  " + '</term>\n')


    # compile a (possibly empty) comma-separated list of expressions
    cdef compileExpressionList(self):
        
        self.advance() # get the next token ) or not )
        if self.next_token == "<symbol> ) </symbol>":
            self.reverse()
        else:
            self.reverse()
            self.compileExpression()

            # compile (, expression)*
            self.advance() # get the next token , or )
            while self.next_token == "<symbol> , </symbol>":
                self.output_file.write(self.indent * "  " + self.next_token + '\n')

                # compile expression
                self.compileExpression()

                self.advance() # get the next token , or )

            self.reverse()
            

    # compile a subroutine call
    cdef compileSubroutineCall(self):
        self.advance() # get the next token subroutineName or className or varName

        self.output_file.write(self.indent * "  " + self.next_token + '\n')

        self.advance() # get the next token ( or .

        if self.next_token == "<symbol> ( </symbol>":
            self.output_file.write(self.indent * "  " + self.next_token + '\n')

            # compile expressionList
            self.output_file.write(self.indent * "  " + '<expressionList>\n')   
            self.indent += 1
            self.compileExpressionList()
            self.indent -= 1
            self.output_file.write(self.indent * "  " + '</expressionList>\n')

            self.advance() # get the next token )
            self.output_file.write(self.indent * "  " + self.next_token + '\n')

        elif self.next_token == "<symbol> . </symbol>":
            self.output_file.write(self.indent * "  " + self.next_token + '\n')

            self.advance() # get the next token subroutineName
            self.output_file.write(self.indent * "  " + self.next_token + '\n')

            self.advance() # get the next token (
            self.output_file.write(self.indent * "  " + self.next_token + '\n')

            # compile expressionList
            self.output_file.write(self.indent * "  " + '<expressionList>\n')   
            self.indent += 1
            self.compileExpressionList()
            self.indent -= 1
            self.output_file.write(self.indent * "  " + '</expressionList>\n')

            self.advance() # get the next token )
            self.output_file.write(self.indent * "  " + self.next_token + '\n')
            