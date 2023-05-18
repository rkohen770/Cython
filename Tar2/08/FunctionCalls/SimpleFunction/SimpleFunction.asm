//SimpleFunction

// function SimpleFunction.test 2
//------ start of function ------

//***************start function SimpleFunction.test***************//
    // function SimpleFunction.test 2
    (SimpleFunction.test)
    
    @0                //  A = 0
    D=A                 //  D = A
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1
    @0                //  A = 0
    D=A                 //  D = A
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1
//***************end function SimpleFunction.test***************//
    

//------ end of function ------

// push local 0
//------ start of push ------

    @LCL           //  A = LCL
    D=M                 //  D = ram[LCL]
    @0                //  A = 0
    A=D+A               //  A = ram[LCL] + 0
    D=M                 //  D = ram[A]
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

//------ end of push ------

// push local 1
//------ start of push ------

    @LCL           //  A = LCL
    D=M                 //  D = ram[LCL]
    @1                //  A = 1
    A=D+A               //  A = ram[LCL] + 1
    D=M                 //  D = ram[A]
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

//------ end of push ------

// add
//------ start of add ------

    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                 //  D = ram[A]
    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    M=M+D               //  ram[A] = ram[A] + D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

//------ end of add ------

// not
//------ start of not ------

    @SP                 //  A = 0
    A=M-1               //  A = ram[0] - 1
    M=!M                //  ram[A] = !ram[A]

//------ end of not ------

// push argument 0
//------ start of push ------

    @ARG           //  A = ARG
    D=M                 //  D = ram[ARG]
    @0                //  A = 0
    A=D+A               //  A = ram[ARG] + 0
    D=M                 //  D = ram[A]
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

//------ end of push ------

// add
//------ start of add ------

    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                 //  D = ram[A]
    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    M=M+D               //  ram[A] = ram[A] + D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

//------ end of add ------

// push argument 1
//------ start of push ------

    @ARG           //  A = ARG
    D=M                 //  D = ram[ARG]
    @1                //  A = 1
    A=D+A               //  A = ram[ARG] + 1
    D=M                 //  D = ram[A]
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

//------ end of push ------

// sub
//------ start of sub ------

    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                 //  D = ram[A]
    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    M=M-D               //  ram[A] = ram[A] - D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

//------ end of sub ------

// return
//------ start of return ------

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
    

//------ end of return ------

