//BasicLoop

// push constant 0    
//------ start of push ------

    @0                //  A = 0
    D=A                 //  D = A
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

//------ end of push ------

// pop local 0         // initializes sum = 0
//------ start of pop ------

    @LCL            //  A = LCL
    D=M                 //  D = ram[LCL]
    @0                //  A = 0
    D=D+A               //  D = ram[LCL] + 0
    @R13                //  A = 13
    M=D                 //  ram[13] = D
    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                 //  D = ram[A]
    @R13                //  A = 13
    A=M                 //  A = ram[13]
    M=D                 //  ram[A] = D

//------ end of pop ------

// label LOOP_START
//------ start of label ------
(BasicLoop.LOOP_START)

//------ end of label ------

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

// pop local 0	        // sum = sum + counter
//------ start of pop ------

    @LCL            //  A = LCL
    D=M                 //  D = ram[LCL]
    @0                //  A = 0
    D=D+A               //  D = ram[LCL] + 0
    @R13                //  A = 13
    M=D                 //  ram[13] = D
    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                 //  D = ram[A]
    @R13                //  A = 13
    A=M                 //  A = ram[13]
    M=D                 //  ram[A] = D

//------ end of pop ------

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

// push constant 1
//------ start of push ------

    @1                //  A = 1
    D=A                 //  D = A
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

// pop argument 0      // counter--
//------ start of pop ------

    @ARG            //  A = ARG
    D=M                 //  D = ram[ARG]
    @0                //  A = 0
    D=D+A               //  D = ram[ARG] + 0
    @R13                //  A = 13
    M=D                 //  ram[13] = D
    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                 //  D = ram[A]
    @R13                //  A = 13
    A=M                 //  A = ram[13]
    M=D                 //  ram[A] = D

//------ end of pop ------

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

// if-goto LOOP_START  // If counter != 0, goto LOOP_START
//------ start of if-goto ------

    @SP                     //  A = 0
    AM=M-1                  //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                     //  D = ram[A]
    A=A-1                   //  A = A - 1
    @BasicLoop.LOOP_START
    D;JNE                   //  if D != 0 goto BasicLoop.LOOP_START

//------ end of if-goto ------

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

