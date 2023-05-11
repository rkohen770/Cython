// BasicTest

// push constant 10

    @10                //  A = 10
    D=A                 //  D = A
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

// pop local 0

    @SP                     //  A = 0
    AM=M-1                  //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                     //  D = ram[A]
    @LCL              //  A = LCL
    A=M                     //  A = ram[LCL]
                  //  A = ram[LCL] + 0
    M=D                     //  ram[A] = D

// push constant 21

    @21                //  A = 21
    D=A                 //  D = A
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

// push constant 22

    @22                //  A = 22
    D=A                 //  D = A
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

// pop argument 2

    @SP                     //  A = 0
    AM=M-1                  //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                     //  D = ram[A]
    @ARG              //  A = ARG
    A=M                     //  A = ram[ARG]
    A=A+1              //  A = A + 1
A=A+1              //  A = A + 1
              //  A = ram[ARG] + 2
    M=D                     //  ram[A] = D

// pop argument 1

    @SP                     //  A = 0
    AM=M-1                  //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                     //  D = ram[A]
    @ARG              //  A = ARG
    A=M                     //  A = ram[ARG]
    A=A+1              //  A = A + 1
              //  A = ram[ARG] + 1
    M=D                     //  ram[A] = D

// push constant 36

    @36                //  A = 36
    D=A                 //  D = A
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

// pop this 6

    @SP                     //  A = 0
    AM=M-1                  //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                     //  D = ram[A]
    @THIS              //  A = THIS
    A=M                     //  A = ram[THIS]
    A=A+1              //  A = A + 1
A=A+1              //  A = A + 1
A=A+1              //  A = A + 1
A=A+1              //  A = A + 1
A=A+1              //  A = A + 1
A=A+1              //  A = A + 1
              //  A = ram[THIS] + 6
    M=D                     //  ram[A] = D

// push constant 42

    @42                //  A = 42
    D=A                 //  D = A
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

// push constant 45

    @45                //  A = 45
    D=A                 //  D = A
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

// pop that 5

    @SP                     //  A = 0
    AM=M-1                  //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                     //  D = ram[A]
    @THAT              //  A = THAT
    A=M                     //  A = ram[THAT]
    A=A+1              //  A = A + 1
A=A+1              //  A = A + 1
A=A+1              //  A = A + 1
A=A+1              //  A = A + 1
A=A+1              //  A = A + 1
              //  A = ram[THAT] + 5
    M=D                     //  ram[A] = D

// pop that 2

    @SP                     //  A = 0
    AM=M-1                  //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                     //  D = ram[A]
    @THAT              //  A = THAT
    A=M                     //  A = ram[THAT]
    A=A+1              //  A = A + 1
A=A+1              //  A = A + 1
              //  A = ram[THAT] + 2
    M=D                     //  ram[A] = D

// push constant 510

    @510                //  A = 510
    D=A                 //  D = A
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

// pop temp 6

    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    @5                  //  A = 5
    A=A+1              //  A = A + 1
A=A+1              //  A = A + 1
A=A+1              //  A = A + 1
A=A+1              //  A = A + 1
A=A+1              //  A = A + 1
A=A+1              //  A = A + 1
          //  A = 5 + 6
    M=D                 //  ram[A] = D

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

// push that 5

    @5                    //  A = 5
    D=A                     //  D = 5
    @THAT              //  A = THAT
    A=M+D                   //  A = ram[THAT] + D
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

// push this 6

    @6                    //  A = 6
    D=A                     //  D = 6
    @THIS              //  A = THIS
    A=M+D                   //  A = ram[THIS] + D
    D=M                     //  D = ram[A]
    @SP                     //  A = 0
    A=M                     //  A = ram[0]
    M=D                     //  ram[A] = D
    @SP                     //  A = 0
    M=M+1                   //  ram[0] = ram[0] + 1

// push this 6

    @6                    //  A = 6
    D=A                     //  D = 6
    @THIS              //  A = THIS
    A=M+D                   //  A = ram[THIS] + D
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

// sub

    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                 //  D = ram[A]
    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    M=M-D               //  ram[A] = ram[A] - D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

// push temp 6

    @6                //  A = 6
    D=A                 //  D = A
    @5                  //  A = 5
    D=A+D               //  D = 5 + D
    A=D                 //  A = D
    D=M                 //  D = ram[A]
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

// add

    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                 //  D = ram[A]
    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    M=M+D               //  ram[A] = ram[A] + D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

