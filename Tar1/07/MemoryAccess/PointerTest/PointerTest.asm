// PointerTest

// push constant 3030

    @3030                //  A = 3030
    D=A                 //  D = A
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

// pop pointer 0

    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                 //  D = ram[A]
    @THIS                //  A = THIS
    M=D                 //  ram[A] = D

// push constant 3040

    @3040                //  A = 3040
    D=A                 //  D = A
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

// pop pointer 1

    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                 //  D = ram[A]
    @THAT                //  A = THAT
    M=D                 //  ram[A] = D

// push constant 32

    @32                //  A = 32
    D=A                 //  D = A
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

// pop this 2

    @SP                     //  A = 0
    AM=M-1                  //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                     //  D = ram[A]
    @THIS              //  A = THIS
    A=M                     //  A = ram[THIS]
    A=A+1              //  A = A + 1
A=A+1              //  A = A + 1
              //  A = ram[THIS] + 2
    M=D                     //  ram[A] = D

// push constant 46

    @46                //  A = 46
    D=A                 //  D = A
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

// pop that 6

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
A=A+1              //  A = A + 1
              //  A = ram[THAT] + 6
    M=D                     //  ram[A] = D

// push pointer 0

    @THIS                //  A = THIS
    D=M                 //  D = ram[A]
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

// push pointer 1

    @THAT                //  A = THAT
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

// push this 2

    @2                    //  A = 2
    D=A                     //  D = 2
    @THIS              //  A = THIS
    A=M+D                   //  A = ram[THIS] + D
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

// push that 6

    @6                    //  A = 6
    D=A                     //  D = 6
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

