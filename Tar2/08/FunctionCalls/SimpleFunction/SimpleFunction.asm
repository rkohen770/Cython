// SimpleFunction


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
    // function SimpleFunction.test 2

    (SimpleFunction.SimpleFunction.test)
    
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
    M=M+1               //  ram[0] = ram[0] + 1         //  push 0 2 times

// push local 0

    @0                    //  A = 0
    D=A                     //  D = 0
    @LCL              //  A = LCL
    A=M+D                   //  A = ram[LCL] + D
    D=M                     //  D = ram[A]
    @SP                     //  A = 0
    A=M                     //  A = ram[0]
    M=D                     //  ram[A] = D
    @SP                     //  A = 0
    M=M+1                   //  ram[0] = ram[0] + 1

// push local 1

    @1                    //  A = 1
    D=A                     //  D = 1
    @LCL              //  A = LCL
    A=M+D                   //  A = ram[LCL] + D
    D=M                     //  D = ram[A]
    @SP                     //  A = 0
    A=M                     //  A = ram[0]
    M=D                     //  ram[A] = D
    @SP                     //  A = 0
    M=M+1                   //  ram[0] = ram[0] + 1

// add

    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                 //  D = ram[A]
    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    M=M+D               //  ram[A] = ram[A] + D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

// not

    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    M=!M                //  ram[A] = !ram[A]
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

// push argument 0

    @0                    //  A = 0
    D=A                     //  D = 0
    @ARG              //  A = ARG
    A=M+D                   //  A = ram[ARG] + D
    D=M                     //  D = ram[A]
    @SP                     //  A = 0
    A=M                     //  A = ram[0]
    M=D                     //  ram[A] = D
    @SP                     //  A = 0
    M=M+1                   //  ram[0] = ram[0] + 1

// add

    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                 //  D = ram[A]
    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    M=M+D               //  ram[A] = ram[A] + D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

// push argument 1

    @1                    //  A = 1
    D=A                     //  D = 1
    @ARG              //  A = ARG
    A=M+D                   //  A = ram[ARG] + D
    D=M                     //  D = ram[A]
    @SP                     //  A = 0
    A=M                     //  A = ram[0]
    M=D                     //  ram[A] = D
    @SP                     //  A = 0
    M=M+1                   //  ram[0] = ram[0] + 1

// sub

    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                 //  D = ram[A]
    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    M=M-D               //  ram[A] = ram[A] - D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

// return

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

