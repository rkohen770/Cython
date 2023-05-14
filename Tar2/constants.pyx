# קבוצה: 150060.31.5783.01, 150060.31.5783.43
# רחל לאה כהן: 211372156
# הודיה שנקר: 211720503

# cython: language_level=3, encoding=utf-8
# distutils: language = c++

#repitition of code for pop segment
cdef str repit(int x):
    string =''
    for i in range(x-1):
        string += 'A=A+1               //  A = A + 1\n'
    string += 'A=A+1               //  A = A + 1'
    return string

#repitition of code for push 0
cdef str repit2(int x):
    string =''
    for i in range(x):
        string += PushConstant(0)
    return string



#----- region: group 1 (local, argument, this, that) -----#


# push local X / argument X / this X / that X
cpdef PushSegment(int x, str segment):
    return f'''
    @{segment}           //  A = {segment}
    D=M                 //  D = ram[{segment}]
    @{x}                //  A = {x}
    A=D+A               //  A = ram[{segment}] + {x}
    D=M                 //  D = ram[A]
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1'''


# pop local X / argument X / this X / that X
cpdef PopSegment(int x, str segment):
    return f'''
    @{segment}            //  A = {segment}
    D=M                 //  D = ram[{segment}]
    @{x}                //  A = {x}
    D=D+A               //  D = ram[{segment}] + {x}
    @R13                //  A = 13
    M=D                 //  ram[13] = D
    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                 //  D = ram[A]
    @R13                //  A = 13
    A=M                 //  A = ram[13]
    M=D                 //  ram[A] = D'''


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
    A=M-1               //  A = ram[0] - 1
    D=M                 //  D = ram[A]
    @5                  //  A = 5
    {repit(x)}          
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M-1               //  ram[0] = ram[0] - 1'''
    

#----- endregion: group 2 (temp) -----#

#----- region: group 3 (static) -----#

# push static X
cpdef PushStatic(x):
    return f'''
    @{x}                //  A = {x}
    D=M                 //  D = ram[A]
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1'''

# pop static X
cpdef PopStatic(x):
    return f'''
    @{x}                //  A = {x}
    D=A                 //  D = A
    @R13                //  A = 13
    M=D                 //  ram[13] = D
    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                 //  D = ram[A]
    @R13                //  A = 13
    A=M                 //  A = ram[13]
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
    A=M-1               //  A = ram[0] - 1
    D=M                 //  D = ram[A]
    @{x}                //  A = {x}
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M-1               //  ram[0] = ram[0] - 1'''

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
    D=0                 //  D = 0
    @SP                 //  A = 0
    A=M-1               //  A = ram[0] - 1
    M=D-M               //  ram[A] = D - ram[A]'''

# eq
cpdef Eq(int index):
    return f'''
    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                 //  D = ram[A]
    A=A-1               //  A = A - 1
    D=M-D               //  D = ram[A] - D
    @EQ.{index}_FALSE
    D;JNE               //  if D != 0 goto EQ.{index}_FALSE
    @SP                 //  A = 0
    A=M-1               //  A = ram[0] - 1
    M=-1                //  ram[A] = -1
    @EQ.{index}_END
    0;JMP               //  goto EQ.{index}_END
(EQ.{index}_FALSE)
    @SP                 //  A = 0
    A=M-1               //  A = ram[0] - 1
    M=0                 //  ram[A] = 0
(EQ.{index}_END)
    '''

# gt
cpdef Gt(int index):
    return f'''
    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                 //  D = ram[A]
    A=A-1               //  A = A - 1
    D=M-D               //  D = ram[A] - D
    @GT.{index}_FALSE 
    D;JLE               //  if D <= 0 goto GT.{index}_FALSE
    @SP                 //  A = 0
    A=M-1               //  A = ram[0] - 1
    M=-1                //  ram[A] = -1
    @GT.{index}_END
    0;JMP               //  goto GT.{index}_END
(GT.{index}_FALSE)
    @SP                 //  A = 0
    A=M-1               //  A = ram[0] - 1
    M=0                 //  ram[A] = 0
(GT.{index}_END)
    '''
    
# lt
cpdef Lt(int index):
    return f'''
    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                 //  D = ram[A]
    A=A-1               //  A = A - 1
    D=M-D               //  D = ram[A] - D
    @LT.{index}_FALSE 
    D;JGE               //  if D >= 0 goto LT.{index}_FALSE
    @SP                 //  A = 0
    A=M-1               //  A = ram[0] - 1
    M=-1                //  ram[A] = -1
    @LT.{index}_END
    0;JMP               //  goto LT.{index}_END
(LT.{index}_FALSE)
    @SP                 //  A = 0
    A=M-1               //  A = ram[0] - 1
    M=0                 //  ram[A] = 0
(LT.{index}_END)
    '''
    
# and
cpdef And():
    return '''
    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                 //  D = ram[A]
    A=A-1               //  A = A - 1
    M=D&M               //  ram[A] = D && ram[A]'''

# or
cpdef Or():
    return '''
    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                 //  D = ram[A]
    A=A-1               //  A = A - 1
    M=D|M               //  ram[A] = D || ram[A]'''

# not
cpdef Not():
    return '''
    @SP                 //  A = 0
    A=M-1               //  A = ram[0] - 1
    M=!M                //  ram[A] = !ram[A]'''

#----- endregion: group 6 (add, sub, neg, eq, gt, lt, and, or, not) -----#

#----- region: group 7 (label, goto, if-goto) -----#

# label X
cpdef Label(str label ):
    return f'''({label})'''

# goto X
cpdef Goto( str label ):
    return f'''
    @{label}
    0;JMP                   //  goto {label}'''

# if-goto X
cpdef IfGoto( str label ):
    return f'''
    @SP                     //  A = 0
    AM=M-1                  //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                     //  D = ram[A]
    @{label}
    D;JNE                   //  if D != 0 goto {label}'''

#----- endregion: group 7 (label, goto, if-goto) -----#

#----- region: group 8 (function, call, return) -----#

# function X Y
cpdef Function(str functionName, int numLocals):
    return f'''
({functionName})

    // Initialize local variables
    @{numLocals}            //  A = {numLocals}
    D=A                     //  D = {numLocals}
    @{functionName}_FALSE
    D;JEQ                   //  if numLocals == 0 goto {functionName}_FALSE

({functionName}_LOOP)
    @SP                     //  A = 0
    A=M                     //  A = ram[0]
    M=0                     //  ram[A] = 0
    @SP                     //  A = 0
    M=M+1                   //  ram[0] = ram[0] + 1
    @{functionName}_LOOP
    D=D-1                   //  D = D - 1
    D;JNE                   //  if D != 0 goto {functionName}_LOOP

({functionName}_FALSE)

    '''

# call functionName numArgs
cpdef Call( str functionName, int numArgs, int index):
    return f'''
    // push return-address {functionName}.{index}
    @{functionName}.{index}.ReturnAddress   
    D=A
    @SP
    A=M
    M=D
    @SP
    M=M+1

    // push LCL
    @LCL                            //  A = LCL
    D=M                             //  D = LCL
    @SP                             //  A = 0
    A=M                             //  A = ram[0]
    M=D                             //  ram[A] = D
    @SP                             //  A = 0
    M=M+1                           //  ram[0] = ram[0] + 1

    // push ARG
    @ARG                            //  A = ARG
    D=M                             //  D = ARG
    @SP                             //  A = 0
    A=M                             //  A = ram[0]
    M=D                             //  ram[A] = D
    @SP                             //  A = 0
    M=M+1                           //  ram[0] = ram[0] + 1
    
    // push THIS
    @THIS                           //  A = THIS
    D=M                             //  D = THIS
    @SP                             //  A = 0
    A=M                             //  A = ram[0]
    M=D                             //  ram[A] = D
    @SP                             //  A = 0
    M=M+1                           //  ram[0] = ram[0] + 1

    // push THAT
    @THAT                           //  A = THAT
    D=M                             //  D = THAT
    @SP                             //  A = 0
    A=M                             //  A = ram[0]
    M=D                             //  ram[A] = D
    @SP                             //  A = 0
    M=M+1                           //  ram[0] = ram[0] + 1

    // ARG = SP-n-5
    @SP                             //  A = 0
    D=M                             //  D = ram[0]
    @5                              //  A = 5
    D=D-A                           //  D = ram[0] - {numArgs} - 5
    @{numArgs}                      //  A = {numArgs}
    D=D-A                           //  D = ram[0] - {numArgs}
    @ARG                            //  A = ARG
    M=D                             //  ARG = ram[0] - {numArgs} - 5

    // LCL = SP
    @SP                             //  A = 0
    D=M                             //  D = ram[0]
    @LCL                            //  A = LCL
    M=D                             //  LCL = ram[0]

    // goto functionName
    @{functionName}                 //  A = {functionName}.{index}.ReturnAddress
    0;JMP                           //  goto {functionName}

    // (return-address)
({functionName}.{index}.ReturnAddress)
    '''
    
# return
cpdef Return ():
    return f'''
    //return function

    // FRAME = LCL
    @LCL
    D=M

    // RET = * (FRAME-5)
    // RAM[13] = (LOCAL - 5)
    @5
    A=D-A
    D=M
    @13
    M=D

    // * ARG = pop()	
    @SP
    M=M-1
    A=M
    D=M
    @ARG
    A=M
    M=D

    // SP = ARG+1 
    @ARG
    D=M
    @SP
    M=D+1
    
    // THAT = *(FRAM-1)
    @LCL
    M=M-1
    A=M
    D=M
    @THAT
    M=D
    
    // THIS = *(FRAM-2) 
    @LCL
    M=M-1
    A=M
    D=M
    @THIS
    M=D

    // ARG = *(FRAM-3)
    @LCL
    M=M-1
    A=M
    D=M
    @ARG
    M=D		

    // LCL = *(FRAM-4)
    @LCL
    M=M-1
    A=M
    D=M
    @LCL
    M=D
    
    // goto RET
    @13
    A=M
    0; JMP
    
    '''

#----- endregion: group 8 (function, call, return) -----#


#----- region: group 9 (bootstrap) -----# 

# bootstrap
cpdef Bootstrap():
    return f'''
    // bootstrap
    @256                //  A = 256
    D=A                 //  D = 256
    @SP                 //  A = 0
    M=D                 //  ram[0] = 256
    
    // call Sys.init 0
    @Sys.init.returnAdd
    D=A
    @SP
    A=M
    M=D
    @SP
    M=M+1

    @LCL
    D=M
    @SP
    A=M
    M=D
    @SP
    M=M+1

    @ARG
    D=M
    @SP
    A=M
    M=D
    @SP
    M=M+1

    @THIS
    D=M
    @SP
    A=M
    M=D
    @SP
    M=M+1

    @THAT
    D=M
    @SP
    A=M
    M=D
    @SP
    M=M+1

    @SP
    D=M
    @5
    D=D-A
    @ARG
    M=D
    @SP
    D=M
    @LCL
    M=D

    @Sys.init.returnAdd
    0;JMP
(Sys.init.returnAdd)
    '''
