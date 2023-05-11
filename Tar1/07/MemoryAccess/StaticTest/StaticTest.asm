// StaticTest

// push constant 111

    @111                //  A = 111
    D=A                 //  D = A
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

// push constant 333

    @333                //  A = 333
    D=A                 //  D = A
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

// push constant 888

    @888                //  A = 888
    D=A                 //  D = A
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

// pop static 8

    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                 //  D = ram[A]
    @16                 //  A = 16
    A=A+1              //  A = A + 1
A=A+1              //  A = A + 1
A=A+1              //  A = A + 1
A=A+1              //  A = A + 1
A=A+1              //  A = A + 1
A=A+1              //  A = A + 1
A=A+1              //  A = A + 1
A=A+1              //  A = A + 1
          //  A = 16 + 8
    M=D                 //  ram[A] = D

// pop static 3

    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                 //  D = ram[A]
    @16                 //  A = 16
    A=A+1              //  A = A + 1
A=A+1              //  A = A + 1
A=A+1              //  A = A + 1
          //  A = 16 + 3
    M=D                 //  ram[A] = D

// pop static 1

    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                 //  D = ram[A]
    @16                 //  A = 16
    A=A+1              //  A = A + 1
          //  A = 16 + 1
    M=D                 //  ram[A] = D

// push static 3

    @3                //  A = 3
    D=A                 //  D = 3
    @16                 //  A = 16
    A=A+D               //  A = 16 + D
    D=M                 //  D = ram[A]
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

// push static 1

    @1                //  A = 1
    D=A                 //  D = 1
    @16                 //  A = 16
    A=A+D               //  A = 16 + D
    D=M                 //  D = ram[A]
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
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

// push static 8

    @8                //  A = 8
    D=A                 //  D = 8
    @16                 //  A = 16
    A=A+D               //  A = 16 + D
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

