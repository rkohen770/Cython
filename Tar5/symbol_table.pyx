

# Identifier class moved outside of the define function
cdef class Identifier:
    cdef str type
    cdef str kind
    cdef int index

    def __cinit__(self, identifier_type, kind, index):
        self.type = identifier_type
        self.kind = kind
        self.index = index

    cpdef get_type(self):
        return self.type

    cpdef get_kind(self):
        return self.kind

    cpdef get_index(self):
        return self.index


cdef class SymbolTable:

    # static, field, arg, var
    IdentifierKind = ['STATIC', 'FIELD', 'ARG', 'VAR']

    cdef dict static_table
    cdef dict field_table
    cdef dict arg_table
    cdef dict var_table

    cpdef get_static_table(self):
        return self.static_table

    cpdef get_field_table(self):
        return self.field_table

    cpdef get_arg_table(self):
        return self.arg_table

    cpdef get_var_table(self):
        return self.var_table

    # constructor
    def __cinit__(self):
        self.static_table = {}
        self.field_table = {}
        self.arg_table = {}
        self.var_table = {}

    # Define a new identifier of a given name, type, and kind and assign it a running index.
    cpdef define(self, name, identifier_type, kind):
        kind = kind.upper()
        print('define', name, identifier_type, kind)

        if kind == 'STATIC':
            self.static_table[name] = Identifier(identifier_type, kind, len(self.static_table))
        elif kind == 'FIELD':
            self.field_table[name] = Identifier(identifier_type, kind, len(self.field_table))
        elif kind == 'ARG':
            self.arg_table[name] = Identifier(identifier_type, kind, len(self.arg_table))
        elif kind == 'VAR':
            self.var_table[name] = Identifier(identifier_type, kind, len(self.var_table))
        else:
            raise Exception('Invalid kind')

   


    cpdef start_subroutin(self):
        self.arg_table = {}
        self.var_table = {}

    cpdef var_count(self, kind):
        kind = kind.upper()
        print('var_count', kind)
        if kind == 'STATIC':
            return len(self.static_table)
        elif kind == 'FIELD':
            return len(self.field_table)
        elif kind == 'ARG':
            return len(self.arg_table)
        elif kind == 'VAR':
            return len(self.var_table)
        else:
            raise Exception('Invalid kind')

    cpdef kind_of(self, name):
        identifier = self.find_by_name(name)
        if identifier:
            return identifier.get_kind()
        else:
            return None

    cpdef type_of(self, name):
        identifier = self.find_by_name(name)
        if identifier:
            return identifier.get_type()
        else:
            return None

    cpdef index_of(self, name):
        identifier = self.find_by_name(name)
        if identifier:
            return identifier.get_index()
        else:
            return None

    cpdef find_by_name(self, name):
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
