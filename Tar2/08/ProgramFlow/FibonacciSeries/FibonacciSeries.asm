//FibonacciSeries

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

// pop pointer 1           // that = argument[1]
//------ start of pop ------

    @THAT                //  A = THAT
    D=A                 //  D = A
    @R13                //  A = 13
    M=D                 //  ram[13] = D
    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                 //  D = ram[A]
    @R13                //  A = 13
    A=M                 //  A = ram[13]
    M=D                 //  ram[A] = D

//------ end of pop ------

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

// pop that 0              // first element in the series = 0
//------ start of pop ------

    @THAT            //  A = THAT
    D=M                 //  D = ram[THAT]
    @0                //  A = 0
    D=D+A               //  D = ram[THAT] + 0
    @R13                //  A = 13
    M=D                 //  ram[13] = D
    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                 //  D = ram[A]
    @R13                //  A = 13
    A=M                 //  A = ram[13]
    M=D                 //  ram[A] = D

//------ end of pop ------

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

// pop that 1              // second element in the series = 1
//------ start of pop ------

    @THAT            //  A = THAT
    D=M                 //  D = ram[THAT]
    @1                //  A = 1
    D=D+A               //  D = ram[THAT] + 1
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

// push constant 2
//------ start of push ------

    @2                //  A = 2
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

// pop argument 0          // num_of_elements -= 2 (first 2 elements are set)
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

// label MAIN_LOOP_START
//------ start of label ------
(FibonacciSeries.MAIN_LOOP_START)

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

// if-goto COMPUTE_ELEMENT // if num_of_elements > 0, goto COMPUTE_ELEMENT
//------ start of if-goto ------

    @SP                     //  A = 0
    AM=M-1                  //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                     //  D = ram[A]
    A=A-1                   //  A = A - 1
    @FibonacciSeries.COMPUTE_ELEMENT
    D;JNE                   //  if D != 0 goto FibonacciSeries.COMPUTE_ELEMENT

//------ end of if-goto ------

// goto END_PROGRAM        // otherwise, goto END_PROGRAM
//------ start of goto ------

    @FibonacciSeries.END_PROGRAM
    0;JMP                   //  goto FibonacciSeries.END_PROGRAM

//------ end of goto ------

// label COMPUTE_ELEMENT
//------ start of label ------
(FibonacciSeries.COMPUTE_ELEMENT)

//------ end of label ------

// push that 0
//------ start of push ------

    @THAT           //  A = THAT
    D=M                 //  D = ram[THAT]
    @0                //  A = 0
    A=D+A               //  A = ram[THAT] + 0
    D=M                 //  D = ram[A]
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

//------ end of push ------

// push that 1
//------ start of push ------

    @THAT           //  A = THAT
    D=M                 //  D = ram[THAT]
    @1                //  A = 1
    A=D+A               //  A = ram[THAT] + 1
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

// pop that 2              // that[2] = that[0] + that[1]
//------ start of pop ------

    @THAT            //  A = THAT
    D=M                 //  D = ram[THAT]
    @2                //  A = 2
    D=D+A               //  D = ram[THAT] + 2
    @R13                //  A = 13
    M=D                 //  ram[13] = D
    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                 //  D = ram[A]
    @R13                //  A = 13
    A=M                 //  A = ram[13]
    M=D                 //  ram[A] = D

//------ end of pop ------

// push pointer 1
//------ start of push ------

    @THAT                //  A = THAT
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

// pop pointer 1           // that += 1
//------ start of pop ------

    @THAT                //  A = THAT
    D=A                 //  D = A
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

// pop argument 0          // num_of_elements--
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

// goto MAIN_LOOP_START
//------ start of goto ------

    @FibonacciSeries.MAIN_LOOP_START
    0;JMP                   //  goto FibonacciSeries.MAIN_LOOP_START

//------ end of goto ------

// label END_PROGRAM
//------ start of label ------
(FibonacciSeries.END_PROGRAM)

//------ end of label ------

