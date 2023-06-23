

cdef class SymbolTable:

    # static, field, arg, var
    IdentifierKind = ['STATIC', 'FIELD', 'ARG', 'VAR']

    cdef static_table
    cdef field_table
    cdef arg_table
    cdef var_table
    

    # constructor
    def __cinit__(self):
        self.static_table = {}
        self.field_table = {}
        self.arg_table = {}
        self.var_table = {}

    # Define a new identifier of a given name, type, and kind and assign it a running index.
    cdef define(self, name, identifier_type, kind):
        class Identifier:
            def __init__(self, identifier_type, kind, index):
                self.type = identifier_type
                self.kind = kind
                self.index = index

        if kind == self.IdentifierKind.index('STATIC'):
            self.static_table[name] = Identifier(identifier_type, kind, len(self.static_table))
        elif kind == self.IdentifierKind.index('FIELD'):
            self.field_table[name] = Identifier(identifier_type, kind, len(self.field_table))
        elif kind == self.IdentifierKind.index('ARG'):
            self.arg_table[name] = Identifier(identifier_type, kind, len(self.arg_table))
        elif kind == self.IdentifierKind.index('VAR'):
            self.var_table[name] = Identifier(identifier_type, kind, len(self.var_table))
        else:
            raise Exception('Invalid kind')

    cdef start_subroutin(self):
        self.arg_table = {}
        self.var_table = {}

    cdef var_count(self, kind):
        if kind == self.IdentifierKind.index('STATIC'):
            return len(self.static_table)
        elif kind == self.IdentifierKind.index('FIELD'):
            return len(self.field_table)
        elif kind == self.IdentifierKind.index('ARG'):
            return len(self.arg_table)
        elif kind == self.IdentifierKind.index('VAR'):
            return len(self.var_table)
        else:
            raise Exception('Invalid kind')

    cdef kind_of(self, name):
        cdef str identifier = self.find_by_name(name)
        if identifier:
            return identifier.kind
        else:
            return None

    cdef type_of(self, name):
        cdef str identifier = self.find_by_name(name)
        return identifier.type

    cdef index_of(self, name):
        cdef str identifier = self.find_by_name(name)
        return identifier.index

    cdef find_by_name(self, name):
        if name in self.static_table:
            return self.static_table[name]
        elif name in self.field_table:
            return self.field_table[name]
        elif name in self.arg_table:
            return self.arg_table[name]
        elif name in self.var_table:
            return self.var_table[name]
        else:
            return None
