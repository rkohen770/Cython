from jack_tokenizer import JackTokenizer
from symbol_table import SymbolTable
import os

cdef class CompilationEngine():
    cdef wf
    cdef tokenizer
    cdef symbol_table
    cdef vmw
    cdef compiled_class_name
    cdef label_num

    
    # Constructor
    def __cinit__(self, filepath, vm_writer):
        self.wf = open(filepath[:-5] + ".myImpl.xml", 'w')
        self.tokenizer = JackTokenizer(filepath)
        self.symbol_table = SymbolTable()
        self.vmw = vm_writer
        self.compiled_class_name = None
        self.label_num = 0 


    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.wf.close()

    cdef get_new_label(self):
        self.label_num += 1
        return 'LABEL_%d' % self.label_num

    cpdef compile(self):
        self.compile_class()

    cdef compile_class(self):
        self.write_element_start('class')

        self.compile_keyword('class')
        self.compiled_class_name = self.compile_class_name().token
        self.compile_symbol('{')

        while self.next_is_class_var_dec():
            self.compile_class_var_dec()

        while self.next_is_subroutine_dec():
            self.compile_subroutine_dec()

        self.compile_symbol('}')

        self.write_element_end('class')

    cdef compile_class_var_dec(self):
        self.write_element_start('classVarDec')

        token = self.compile_keyword(['static', 'field'])
        kind = None
        if token == 'static':
            kind = 'STATIC'
        elif token == 'field':
            kind = 'FIELD'
        else:
            self.raise_syntax_error('Unexpected token')

        type = self.compile_type().token
        self.compile_var_name(declaration=True, type=type, kind=kind)

        while self.next_is(','):
            self.compile_symbol(',')
            self.compile_var_name(declaration=True, type=type, kind=kind)

        self.compile_symbol(';')
        self.write_element_end('classVarDec')

    cdef int compile_var_dec(self):
        self.write_element_start('varDec')
        self.compile_keyword('var')
        type = self.compile_type().token
        cdef int var_num = 0
        self.compile_var_name(declaration=True, type=type, kind='VAR')
        var_num += 1

        while self.next_is(','):
            self.compile_symbol(',')
            self.compile_var_name(declaration=True, type=type, kind='VAR')
            var_num += 1

        self.compile_symbol(';')

        self.write_element_end('varDec')

        return var_num

    cdef compile_subroutine_dec(self):
        self.write_element_start('subroutineDec')

        self.symbol_table.start_subroutine()

        token = self.compile_keyword(['constructor', 'function', 'method'])
        if self.tokenizer.see_next().token == 'void':
            self.compile_keyword('void')
        else:
            self.compile_type()
        
        subroutine_name = self.compile_subroutine_name().token
        self.compile_symbol('(')

        if token == 'method':
            self.symbol_table.define('this', self.compiled_class_name, 'ARG')

        self.compile_parameter_list()
        self.compile_symbol(')')
        self.compile_subroutine_body( subroutine_name, token)

        self.write_element_end('subroutineDec')

    cdef compile_subroutine_name(self):
        self.write_identifier_info('category: subroutine')
        return self.compile_identifier()

    cdef compile_class_name(self):
        self.write_identifier_info('category: class')
        return self.compile_identifier()

    cdef compile_var_name(self, declaration=False, type=None, kind=None, let=False, call=False):
        if declaration:
            self.symbol_table.define(self.tokenizer.see_next().token, type, kind)
        elif let:
            pass
        elif call:
            pass
        else:
            kind = self.symbol_table.kind_of(self.tokenizer.see_next().token)
            if kind == 'arg':
                self.vmw.write_push('argument', self.symbol_table.index_of(self.tokenizer.see_next().token))
            elif kind == 'var':
                self.vmw.write_push('local', self.symbol_table.index_of(self.tokenizer.see_next().token))
            elif kind == 'static':
                self.vmw.write_push('static', self.symbol_table.index_of(self.tokenizer.see_next().token))
            elif kind == 'field':
                self.vmw.write_push('this', self.symbol_table.index_of(self.tokenizer.see_next().token))
            else:
                self.raise_syntax_error('Unexpected token')

        self.write_identifier_info('declaration: %s, kind: %s, index: %d' % (
            declaration, self.symbol_table.kind_of(self.tokenizer.see_next().token),
            self.symbol_table.index_of(self.tokenizer.see_next().token)))
        return self.compile_identifier()

    cdef write_identifier_info(self, info):
        self.write_element('IdentifierInfo', info)

    cdef compile_parameter_list(self):
        self.write_element_start('parameterList')

        if self.tokenizer.see_next().token in ['int', 'char', 'boolean'] or isinstance(self.tokenizer.see_next().token, 2):
            type = self.compile_type().token
            self.compile_var_name(declaration=True, type=type, kind='ARG')

            while self.next_is(','):
                self.compile_symbol(',')
                type = self.compile_type().token
                self.compile_var_name(declaration=True, type=type, kind='ARG')

        self.write_element_end('parameterList')

    cdef int compile_subroutine_body(self, subroutine_name, subroutine_dec_token):
        self.write_element_start('subroutineBody')
        print(subroutine_name, subroutine_dec_token)

        self.compile_symbol('{')
        cdef int var_num = 0
        while self.next_is('var'):
            var_num += self.compile_var_dec()

        self.vmw.write_function('%s.%s' % (self.compiled_class_name, subroutine_name), var_num)

        if subroutine_dec_token == 'constructor':
            self.vmw.write_push('constant', self.symbol_table.var_count('field'))
            self.vmw.write_call('Memory.alloc', 1)
            self.vmw.write_pop('pointer', 0)
        elif subroutine_dec_token == 'method':
            self.vmw.write_push('argument', 0)
            self.vmw.write_pop('pointer', 0)

        self.compile_statements()
        self.compile_symbol('}')

        self.write_element_end('subroutineBody')

        print("=====================================")

        for key in self.symbol_table.arg_table:
            print (self.symbol_table.arg_table[key].type,key,"kind:",self.symbol_table.arg_table[key].kind,"index:",self.symbol_table.arg_table[key].index)

        return var_num

    cdef compile_statements(self):
        if self.next_is('let'):
            self.write_element_start('letStatement')
            self.compile_keyword('let')
            let_var = self.compile_var_name(declaration=False, type=None, kind=None, let=True).token

            if self.next_is('['):
                self.compile_symbol('[')
                self.compile_expression() # index
                self.compile_symbol(']')
                self.compile_symbol('=')

                # base address 
                kind = self.symbol_table.kind_of(let_var)
                if kind == 'arg':
                    self.vmw.write_push('argument', self.symbol_table.index_of(let_var))
                elif kind == 'var':
                    self.vmw.write_push('local', self.symbol_table.index_of(let_var))
                elif kind == 'static':
                    self.vmw.write_push('static', self.symbol_table.index_of(let_var))
                elif kind == 'field':
                    self.vmw.write_push('this', self.symbol_table.index_of(let_var))
                else:
                    self.raise_syntax_error('Unexpected token')

                # temp_2 <- base + index
                self.vmw.write_arithmetic('add')
                self.vmw.write_pop('temp', 2)

                # value
                self.compile_expression()

                # set THAT <- base + index
                self.vmw.write_push('temp', 2)
                self.vmw.write_pop('pointer', 1)

                self.vmw.write_pop('that', 0)
                self.compile_symbol(';')

            else:
                self.compile_symbol('=')
                self.compile_expression()
                self.compile_symbol(';')

                kind = self.symbol_table.kind_of(let_var)
                if kind == 'arg':
                    self.vmw.write_pop('argument', self.symbol_table.index_of(let_var))
                elif kind == 'var':
                    self.vmw.write_pop('local', self.symbol_table.index_of(let_var))
                elif kind == 'static':
                    self.vmw.write_pop('static', self.symbol_table.index_of(let_var))
                elif kind == 'field':
                    self.vmw.write_pop('this', self.symbol_table.index_of(let_var))
                else:
                    self.raise_syntax_error('Unexpected token')

            self.write_element_end('letStatement')

        elif self.next_is('if'):
            self.write_element_start('ifStatement')
            self.compile_keyword('if')
            self.compile_symbol('(')
            self.compile_expression()
            self.compile_symbol(')')

            label1 = self.get_new_label()
            label2 = self.get_new_label()

            self.vmw.write_arithmetic('not')
            self.vmw.write_if(label1)

            self.compile_symbol('{')
            self.compile_statements()
            self.compile_symbol('}')

            self.vmw.write_goto(label2)
            self.vmw.write_label(label1)

            if self.next_is('else'):
                self.compile_keyword('else')
                self.compile_symbol('{')
                self.compile_statements()
                self.compile_symbol('}')

            self.vmw.write_label(label2)

            self.write_element_end('ifStatement')

        elif self.next_is('while'):
            self.write_element_start('whileStatement')
            self.compile_keyword('while')

            label1 = self.get_new_label()
            label2 = self.get_new_label()

            self.vmw.write_label(label1)

            self.compile_symbol('(')
            self.compile_expression()
            self.compile_symbol(')')

            self.vmw.write_arithmetic('not')
            self.vmw.write_if(label2)

            self.compile_symbol('{')
            self.compile_statements()
            self.compile_symbol('}')

            self.vmw.write_goto(label1)
            self.vmw.write_label(label2)

            self.write_element_end('whileStatement')

        elif self.next_is('do'):
            self.write_element_start('doStatement')
            self.compile_keyword('do')
            self.compile_subroutine_call()
            self.compile_symbol(';')
            self.write_element_end('doStatement')
            self.vmw.write_pop('temp', 0)

        elif self.next_is('return'):
            self.write_element_start('returnStatement')
            self.compile_keyword('return')

            if not self.next_is(';'):
                self.compile_expression()
            else:
                self.vmw.write_push('constant', 0)

            self.compile_symbol(';')
            self.vmw.write_return()
            self.write_element_end('returnStatement')

    cdef compile_subroutine_call(self):
        if self.next_is('(', idx =1 ):
            subroutine_name = self.compile_subroutine_name().token
            self.compile_symbol('(')
            self.vmw.write_push('pointer', 0)
            arg_num = self.compile_expression_list()
            self.compile_symbol(')')
            self.vmw.write_call('%s.%s' % (self.compiled_class_name, subroutine_name), arg_num + 1)

        else:
            identifier_str = self.tokenizer.see_next().token
            if self.symbol_table.kind_of(identifier_str) != None:
                instance_name = self.compile_var_name(declaration=False, type=None, kind=None, let=False, call=True).token
                self.compile_symbol('.')
                subroutinename = self.compile_subroutine_name().token
                self.compile_symbol('(')
                kind = self.symbol_table.kind_of(instance_name)
                if kind == 'arg':
                    self.vmw.write_push('argument', self.symbol_table.index_of(instance_name))
                elif kind == 'var':
                    self.vmw.write_push('local', self.symbol_table.index_of(instance_name))
                elif kind == 'static':
                    self.vmw.write_push('static', self.symbol_table.index_of(instance_name))
                elif kind == 'field':
                    self.vmw.write_push('this', self.symbol_table.index_of(instance_name))
                else:
                    self.raise_syntax_error('Unexpected token')

                arg_num = self.compile_expression_list()
                self.compile_symbol(')')
                self.vmw.write_call('%s.%s' % (self.symbol_table.type_of(instance_name), subroutinename), arg_num + 1)

            else:
                class_name = self.compile_class_name().token
                self.compile_symbol('.')
                subroutinename = self.compile_subroutine_name().token
                self.compile_symbol('(')
                arg_num = self.compile_expression_list()
                self.compile_symbol(')')
                self.vmw.write_call('%s.%s' % (class_name, subroutinename), arg_num)

    cdef compile_expression_list(self):
        self.write_element_start('expressionList')

        arg_num = 0
        if not self.next_is(')'):
            self.compile_expression()
            arg_num += 1

            while self.next_is(','):
                self.compile_symbol(',')
                self.compile_expression()
                arg_num += 1

        self.write_element_end('expressionList')

        return arg_num

    cdef compile_expression(self):
        self.write_element_start('expression')

        self.compile_term()

        while self.next_is(['+', '-', '*', '/', '&', '|', '<', '>', '=']):
            op = self.compile_symbol(['+', '-', '*', '/', '&', '|', '<', '>', '=']).token
            self.compile_term()

            if op == '+':
                self.vmw.write_arithmetic('add')
            elif op == '-':
                self.vmw.write_arithmetic('sub')
            elif op == '*':
                self.vmw.write_call('Math.multiply', 2)
            elif op == '/':
                self.vmw.write_call('Math.divide', 2)
            elif op == '&':
                self.vmw.write_arithmetic('and')
            elif op == '|':
                self.vmw.write_arithmetic('or')
            elif op == '<':
                self.vmw.write_arithmetic('lt')
            elif op == '>':
                self.vmw.write_arithmetic('gt')
            elif op == '=':
                self.vmw.write_arithmetic('eq')

        self.write_element_end('expression')

    cdef compile_term(self):
        self.write_element_start('term')

        if self.next_type_is('integerConstant'):
            value = self.compile_integer_constant().token
            self.vmw.write_push('constant', value)
        elif self.next_type_is('stringConstant'):
            self.compile_string_constant()
        elif self.next_is('null'):
            self.compile_keyword('null')
            self.vmw.write_push('constant', 0)
        elif self.next_is('true'):
            self.compile_keyword('true')
            self.vmw.write_push('constant', 0)
            self.vmw.write_arithmetic('not')
        elif self.next_is('false'):
            self.compile_keyword('false')
            self.vmw.write_push('constant', 0)
        elif self.next_is('this'):
            self.compile_keyword('this')
            self.vmw.write_push('pointer', 0)
        elif self.next_type_is('identifier'):
            if self.next_is('[', idx=1):
                var_name = self.compile_var_name().token
                self.compile_symbol('[')
                self.compile_expression()

                self.vmw.write_arithmetic('add')
                self.vmw.write_pop('pointer', 1)
                self.vmw.write_push('that', 0)

                self.compile_symbol(']')

            elif self.next_is('(', idx=1) or self.next_is('.', idx=1):
                self.compile_subroutine_call()
            else:
                self.compile_var_name()

        elif self.next_is('('):
            self.compile_symbol('(')
            self.compile_expression()
            self.compile_symbol(')')

        elif self.next_is(['-', '~']):
            unary_op = self.compile_symbol(['-', '~']).token
            self.compile_term()

            if unary_op == '-':
                self.vmw.write_arithmetic('neg')
            elif unary_op == '~':
                self.vmw.write_arithmetic('not')

        else:
            self.raise_syntax_error('Unexpected token')
        self.write_element_end('term')

    cdef next_type_is(self, token_type):
        return self.tokenizer.see_next().token_type == token_type

    cdef compile_type(self):
        token = self.tokenizer.see_next()

        if self.next_is(['int', 'char', 'boolean']):
            self.compile_keyword(['int', 'char', 'boolean'])
        else:
            self.compile_class_name()
        return token

    cdef next_is_statement(self):
        return self.next_is(['let', 'if', 'while', 'do', 'return'])

    cdef next_is(self, token, idx=0):
        if type(token, list):
            return self.tokenizer.see_next().token in token
        else:
            return self.tokenizer.see_next().token == token

    cdef next_is_class_var_dec(self):
        return self.next_is(['static', 'field'])

    cdef next_is_subroutine_dec(self):
        return self.next_is(['constructor', 'function', 'method'])

    cdef compile_symbol(self, symbol):
        self.tokenizer.advance()
        if type(symbol) == list:
            if self.tokenizer.current_token in symbol:
                self.write_element('symbol', self.tokenizer.current_token)
                return self.tokenizer.current_token
            else:
                self.raise_syntax_error('Unexpected token')
        else:
            if self.tokenizer.current_token == symbol:
                self.write_element('symbol', self.tokenizer.current_token)
                return self.tokenizer.current_token
            else:
                self.raise_syntax_error('Unexpected token')

    cdef compile_keyword(self, keyword):
        self.tokenizer.advance()
        if type(keyword) == list:
            if self.tokenizer.current_token in keyword:
                self.write_element('keyword', self.tokenizer.current_token)
                return self.tokenizer.current_token 
            else:
                self.raise_syntax_error('Unexpected token')
        else:
            if self.tokenizer.current_token == keyword:
                self.write_element('keyword', self.tokenizer.current_token)
                return self.tokenizer.current_token
            else:
                print(self.tokenizer.current_token)
                self.raise_syntax_error('Unexpected token')

    cdef compile_identifier(self):
        self.tokenizer.advance()
        if isinstance(self.tokenizer.current_token, 2):
            identifier_str = self.tokenizer.current_token
            self.write_element(
                'identifier',
                identifier_str
            )
            return self.tokenizer.current_token        
        else:
            self.raise_syntax_error('Unexpected token')

    cdef compile_integer_constant(self):
        self.tokenizer.advance()
        if self.current_token_type == 'integerConstant':
            self.write_element('integerConstant',self.tokenizer.current_token)
            return self.tokenizer.current_token
        else:
            self.raise_syntax_error('Unexpected token')

    cdef compile_string_constant(self):
        self.tokenizer.advance()
        if isinstance(self.tokenizer.current_token, 4):
            string = self.tokenizer.current_token.token
            self.write_element('stringConstant', self.tokenizer.current_token)
            self.vmw.write_push('constant', len(string))
            self.vmw.write_call('String.new', 1)
            for char in string:
                self.vmw.write_push('constant', ord(char))
                self.vmw.write_call('String.appendChar', 2)
        else:
            self.raise_syntax_error('Unexpected token')

    cdef write_element(self, element, value):
        self.wf.write('<%s> %s </%s>\n' % (element, value, element))

    cdef write_element_start(self, element):
        self.wf.write('<%s>\n' % element)

    cdef write_element_end(self, element):
        self.wf.write('</%s>\n' % element)

    cdef raise_syntax_error(self, message):
        raise Exception('Syntax error: %s' % message)
        