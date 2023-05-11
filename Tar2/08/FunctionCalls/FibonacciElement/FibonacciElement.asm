// Sys


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
    // function Sys.init 0

    (FibonacciElement.Sys.init)
             //  push 0 0 times

// push constant 4

    @4                //  A = 4
    D=A                 //  D = A
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

// call Main.fibonacci 1   // computes the 4'th fibonacci element

    // push return-address
    @RETURN.Main.fibonacci.1  //  A = RETURN.Main.fibonacci.1
    D=A                             //  D = RETURN.Main.fibonacci.1
    @SP                             //  A = 0
    A=M                             //  A = ram[0]
    M=D                             //  ram[A] = D
    @SP                             //  A = 0
    M=M+1                           //  ram[0] = ram[0] + 1

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
    @RETURN.Main.fibonacci.1  //  A = RETURN.Main.fibonacci.1
    0;JMP                           //  goto Main.fibonacci

    // (return-address)
    (RETURN.Main.fibonacci.1)
    

// label WHILE
(FibonacciElement.WHILE)

// goto WHILE              // loops infinitely

    @FibonacciElement.WHILE    //  A = FibonacciElement.WHILE
    0;JMP                   //  goto FibonacciElement.WHILE

