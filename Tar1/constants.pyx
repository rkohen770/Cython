# קבוצה: 150060.31.5783.01, 150060.31.5783.43
# רחל לאה כהן: 211372156
# הודיה שנקר: 211720503

# cython: language_level=3, encoding=utf-8
# distutils: language = c++

#repitition of code for pop segment
cdef str repit(int x):
    string =''
    for i in range(x):
        string += 'A=A+1              //  A = A + 1\n'
    return string


#----- region: group 1 (local, argument, this, that) -----#


# push local X / argument X / this X / that X
cpdef PushSegment(int x, str segment):
    return f'''
    @{x}                    //  A = {x}
    D=A                     //  D = {x}
    @{segment}              //  A = {segment}
    A=M+D                   //  A = ram[{segment}] + D
    D=M                     //  D = ram[A]
    @SP                     //  A = 0
    A=M                     //  A = ram[0]
    M=D                     //  ram[A] = D
    @SP                     //  A = 0
    M=M+1                   //  ram[0] = ram[0] + 1'''


# pop local X / argument X / this X / that X
cpdef PopSegment(int x, str segment):
    return f'''
    @SP                     //  A = 0
    AM=M-1                  //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                     //  D = ram[A]
    @{segment}              //  A = {segment}
    A=M                     //  A = ram[{segment}]'''+ f'''
    {repit(x)}              //  A = ram[{segment}] + {x}
    M=D                     //  ram[A] = D'''


#----- endregion: group 1 (local, argument, this, that) -----#

#----- region: group 2 (temp) -----#

# push temp X
cpdef PushTemp(x):
    return f'''
    @{x}                //  A = {x}
    D=A                 //  D = A
    @5                  //  A = 5
    D=A+D               //  D = 5 + D
    A=D                 //  A = D
    D=M                 //  D = ram[A]
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1'''

# pop temp x
cpdef PopTemp(x):
    return f'''
    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    @5                  //  A = 5'''+ f'''
    {repit(x)}          //  A = 5 + {x}
    M=D                 //  ram[A] = D'''
    

#----- endregion: group 2 (temp) -----#

#----- region: group 3 (static) -----#

# push static X
cpdef PushStatic(x):
    return f'''
    @{x}                //  A = {x}
    D=A                 //  D = {x}
    @16                 //  A = 16
    A=A+D               //  A = 16 + D
    D=M                 //  D = ram[A]
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1'''

# pop static X
cpdef PopStatic(x):
    return f'''
    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                 //  D = ram[A]
    @16                 //  A = 16'''+ f'''
    {repit(x)}          //  A = 16 + {x}
    M=D                 //  ram[A] = D'''

#----- endregion: group 3 (static) -----#

#----- region: group 4 (pointer 1, pointer 2) -----#

# push pointer X
cpdef PushPointer(x):
    return f'''
    @{x}                //  A = {x}
    D=M                 //  D = ram[A]
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1'''

# pop pointer X
cpdef PopPointer(x):
    return f'''
    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                 //  D = ram[A]
    @{x}                //  A = {x}
    M=D                 //  ram[A] = D'''

#----- endregion: group 4 (pointer 1, pointer 2) -----#

#----- region: group 5 (constant) -----#

# push constant X
cpdef PushConstant(int x):
    return f'''
    @{x}                //  A = {x}
    D=A                 //  D = A
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1'''

#----- endregion: group 5 (constant) -----#

#----- region: group 6 (add, sub, neg, eq, gt, lt, and, or, not) -----#

# add
cpdef Add():
    return '''
    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                 //  D = ram[A]
    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    M=M+D               //  ram[A] = ram[A] + D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1'''

# sub
cpdef Sub():
    return '''
    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                 //  D = ram[A]
    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    M=M-D               //  ram[A] = ram[A] - D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1'''

# neg
cpdef Neg():
    return '''
    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    M=-M                //  ram[A] = -ram[A]
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1'''

# eq
cpdef Eq(int index):
    return f'''
    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                 //  D = ram[A]
    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=D-M               //  D = D - ram[A]
    @EQ.{index}_TRUE
    D;JEQ               //  if D == 0 goto EQ.{index}_TRUE
    D=0                 //  D = 0
    @EQ.{index}_FALSE
    0;JMP               //  goto EQ.{index}_END
    (EQ.{index}_TRUE)
    D=-1                //  D = -1
    (EQ.{index}_FALSE)
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1'''

# gt
cpdef Gt(int index):
    return f'''
    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                 //  D = ram[A]
    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M-D               //  D = ram[A] - D
    @GT.{index}_TRUE
    D;JGT               //  if D > 0 goto GT.{index}_TRUE
    D=0                 //  D = 0
    @GT.{index}_FALSE
    0;JMP               //  goto GT.{index}_END
    (GT.{index}_TRUE)
    D=-1                //  D = -1
    (GT.{index}_FALSE)
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1'''

# lt
cpdef Lt(int index):
    return f'''
    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                 //  D = ram[A]
    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M-D               //  D = ram[A] - D
    @LT.{index}_TRUE
    D;JLT               //  if D < 0 goto LT.{index}_TRUE
    D=0                 //  D = 0
    @LT.{index}_FALSE
    0;JMP               //  goto LT.{index}_END
    (LT.{index}_TRUE)
    D=-1                //  D = -1
    (LT.{index}_FALSE)
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1'''

# and
cpdef And():
    return '''
    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                 //  D = ram[A]
    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    M=D&M               //  ram[A] = D && ram[A]
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1'''

# or
cpdef Or():
    return '''
    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                 //  D = ram[A]
    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    M=D|M               //  ram[A] = D || ram[A]
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1'''

# not
cpdef Not():
    return '''
    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    M=!M                //  ram[A] = !ram[A]
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1'''

#----- endregion: group 6 (add, sub, neg, eq, gt, lt, and, or, not) -----#