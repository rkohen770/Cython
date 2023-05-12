// BasicLoop

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

    @SP                     //  A = 0
    A=M-1                   //  A = ram[0] - 1
    D=M                     //  D = ram[A]
    @LCL              //  A = LCL
    A=M                     //  A = ram[LCL]
    A=A+1               //  A = A + 1              
    M=D                     //  ram[A] = D
    @SP                     //  A = 0
    M=M-1                   //  ram[0] = ram[0] - 1

//------ end of pop ------

// label LOOP_START
//------ start of label ------
(BasicLoop.LOOP_START)

//------ end of label ------

// push argument 0    
//------ start of push ------

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

//------ end of push ------

// push local 0
//------ start of push ------

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

//------ end of push ------

// add
//------ start of add ------

    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                 //  D = ram[A]
    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M+D               //  D = ram[A] + D
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

//------ end of add ------

// pop local 0	        // sum = sum + counter
//------ start of pop ------

    @SP                     //  A = 0
    A=M-1                   //  A = ram[0] - 1
    D=M                     //  D = ram[A]
    @LCL              //  A = LCL
    A=M                     //  A = ram[LCL]
    A=A+1               //  A = A + 1              
    M=D                     //  ram[A] = D
    @SP                     //  A = 0
    M=M-1                   //  ram[0] = ram[0] - 1

//------ end of pop ------

// push argument 0
//------ start of push ------

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

    @SP                     //  A = 0
    A=M-1                   //  A = ram[0] - 1
    D=M                     //  D = ram[A]
    @ARG              //  A = ARG
    A=M                     //  A = ram[ARG]
    A=A+1               //  A = A + 1              
    M=D                     //  ram[A] = D
    @SP                     //  A = 0
    M=M-1                   //  ram[0] = ram[0] - 1

//------ end of pop ------

// push argument 0
//------ start of push ------

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

//------ end of push ------

// if-goto LOOP_START  // If counter != 0, goto LOOP_START
//------ start of if-goto ------

    @SP                     //  A = 0
    AM=M-1                  //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                     //  D = ram[A]
    @BasicLoop.LOOP_START
    D;JNE                   //  if D != 0 goto BasicLoop.LOOP_START

//------ end of if-goto ------

// push local 0
//------ start of push ------

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

//------ end of push ------

