// Sys

// function Sys.init 0
//------ start of function ------

    (Sys.init)

    // Initialize local variables
    @0            //  A = 0
    D=A                     //  D = 0
    @Sys.init_END
    D;JEQ                   //  if numLocals == 0 goto Sys.init_END

    (Sys.init_LOOP)
    @SP                     //  A = 0
    A=M                     //  A = ram[0]
    M=0                     //  ram[A] = 0
    @SP                     //  A = 0
    M=M+1                   //  ram[0] = ram[0] + 1
    @Sys.init_LOOP
    D=D-1                   //  D = D - 1
    D;JNE                   //  if D != 0 goto Sys.init_LOOP

    (Sys.init_END)

    

//------ end of function ------

// push constant 4
//------ start of push ------

    @4                //  A = 4
    D=A                 //  D = A
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

//------ end of push ------

// call Main.fibonacci 1   // computes the 4'th fibonacci element
//------ start of call ------

    // push return-address Main.fibonacci.1
    @Main.fibonacci.1.ReturnAddress   
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
    @1                      //  A = 1
    D=D-A                           //  D = ram[0] - 1
    @5                              //  A = 5
    D=D-A                           //  D = ram[0] - 1 - 5
    @ARG                            //  A = ARG
    M=D                             //  ARG = ram[0] - 1 - 5

    // LCL = SP
    @SP                             //  A = 0
    D=M                             //  D = ram[0]
    @LCL                            //  A = LCL
    M=D                             //  LCL = ram[0]

    // goto functionName
    @Main.fibonacci  //  A = Main.fibonacci.1.ReturnAddress
    0;JMP                           //  goto Main.fibonacci

    // (return-address)
    (Main.fibonacci.1.ReturnAddress)
    

//------ end of call ------

// label WHILE
//------ start of label ------
(FibonacciElement.WHILE)

//------ end of label ------

// goto WHILE              // loops infinitely
//------ start of goto ------

    @FibonacciElement.WHILE
    0;JMP                   //  goto FibonacciElement.WHILE

//------ end of goto ------

