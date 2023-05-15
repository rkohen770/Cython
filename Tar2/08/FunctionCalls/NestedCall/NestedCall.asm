//Sys

// function Sys.init 0
//------ start of function ------

//***************start function Sys.init***************//
    // function Sys.init 0
    (Sys.init)
    
//***************end function Sys.init***************//
    

//------ end of function ------

// push constant 4000 // test THIS and THAT context save
//------ start of push ------

    @4000                //  A = 4000
    D=A                 //  D = A
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

//------ end of push ------

// pop pointer 0
//------ start of pop ------

    @THIS                //  A = THIS
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

// push constant 5000
//------ start of push ------

    @5000                //  A = 5000
    D=A                 //  D = A
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

//------ end of push ------

// pop pointer 1
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

// call Sys.main 0
//------ start of call ------

    //-------start call Sys.main 0-------//
    // push return-address Sys.main.1
    @Sys.main.1.ReturnAddress   
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
    @5                              //  A = 5
    D=D-A                           //  D = ram[0] - 0 - 5
    @0                      //  A = 0
    D=D-A                           //  D = ram[0] - 0
    @ARG                            //  A = ARG
    M=D                             //  ARG = ram[0] - 0 - 5

    // LCL = SP
    @SP                             //  A = 0
    D=M                             //  D = ram[0]
    @LCL                            //  A = LCL
    M=D                             //  LCL = ram[0]

    // goto functionName
    @Sys.main         //  A = Sys.main
    0;JMP                           //  goto Sys.main.1.ReturnAddress

    // (return-address)
(Sys.main.1.ReturnAddress)

    //-------end call Sys.main 0-------//
    

//------ end of call ------

// pop temp 1
//------ start of pop ------

    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    @5                  //  A = 5
    A=A+1               //  A = A + 1          //  A = 5 + 1
    M=D                 //  ram[A] = D

//------ end of pop ------

// label LOOP
//------ start of label ------
(NestedCall.LOOP)

//------ end of label ------

// goto LOOP
//------ start of goto ------

    @NestedCall.LOOP
    0;JMP                   //  goto NestedCall.LOOP

//------ end of goto ------

// function Sys.main 5
//------ start of function ------

//***************start function Sys.main***************//
    // function Sys.main 5
    (Sys.main)
    
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
    @0                //  A = 0
    D=A                 //  D = A
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1
//***************end function Sys.main***************//
    

//------ end of function ------

// push constant 4001
//------ start of push ------

    @4001                //  A = 4001
    D=A                 //  D = A
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

//------ end of push ------

// pop pointer 0
//------ start of pop ------

    @THIS                //  A = THIS
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

// push constant 5001
//------ start of push ------

    @5001                //  A = 5001
    D=A                 //  D = A
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

//------ end of push ------

// pop pointer 1
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

// push constant 200
//------ start of push ------

    @200                //  A = 200
    D=A                 //  D = A
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

//------ end of push ------

// pop local 1
//------ start of pop ------

    @LCL            //  A = LCL
    D=M                 //  D = ram[LCL]
    @1                //  A = 1
    D=D+A               //  D = ram[LCL] + 1
    @R13                //  A = 13
    M=D                 //  ram[13] = D
    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                 //  D = ram[A]
    @R13                //  A = 13
    A=M                 //  A = ram[13]
    M=D                 //  ram[A] = D

//------ end of pop ------

// push constant 40
//------ start of push ------

    @40                //  A = 40
    D=A                 //  D = A
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

//------ end of push ------

// pop local 2
//------ start of pop ------

    @LCL            //  A = LCL
    D=M                 //  D = ram[LCL]
    @2                //  A = 2
    D=D+A               //  D = ram[LCL] + 2
    @R13                //  A = 13
    M=D                 //  ram[13] = D
    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                 //  D = ram[A]
    @R13                //  A = 13
    A=M                 //  A = ram[13]
    M=D                 //  ram[A] = D

//------ end of pop ------

// push constant 6
//------ start of push ------

    @6                //  A = 6
    D=A                 //  D = A
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

//------ end of push ------

// pop local 3
//------ start of pop ------

    @LCL            //  A = LCL
    D=M                 //  D = ram[LCL]
    @3                //  A = 3
    D=D+A               //  D = ram[LCL] + 3
    @R13                //  A = 13
    M=D                 //  ram[13] = D
    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                 //  D = ram[A]
    @R13                //  A = 13
    A=M                 //  A = ram[13]
    M=D                 //  ram[A] = D

//------ end of pop ------

// push constant 123
//------ start of push ------

    @123                //  A = 123
    D=A                 //  D = A
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

//------ end of push ------

// call Sys.add12 1
//------ start of call ------

    //-------start call Sys.add12 1-------//
    // push return-address Sys.add12.2
    @Sys.add12.2.ReturnAddress   
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
    @5                              //  A = 5
    D=D-A                           //  D = ram[0] - 1 - 5
    @1                      //  A = 1
    D=D-A                           //  D = ram[0] - 1
    @ARG                            //  A = ARG
    M=D                             //  ARG = ram[0] - 1 - 5

    // LCL = SP
    @SP                             //  A = 0
    D=M                             //  D = ram[0]
    @LCL                            //  A = LCL
    M=D                             //  LCL = ram[0]

    // goto functionName
    @Sys.add12         //  A = Sys.add12
    0;JMP                           //  goto Sys.add12.2.ReturnAddress

    // (return-address)
(Sys.add12.2.ReturnAddress)

    //-------end call Sys.add12 1-------//
    

//------ end of call ------

// pop temp 0
//------ start of pop ------

    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    @5                  //  A = 5
    A=A+1               //  A = A + 1          //  A = 5 + 0
    M=D                 //  ram[A] = D

//------ end of pop ------

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

// push local 2
//------ start of push ------

    @LCL           //  A = LCL
    D=M                 //  D = ram[LCL]
    @2                //  A = 2
    A=D+A               //  A = ram[LCL] + 2
    D=M                 //  D = ram[A]
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

//------ end of push ------

// push local 3
//------ start of push ------

    @LCL           //  A = LCL
    D=M                 //  D = ram[LCL]
    @3                //  A = 3
    A=D+A               //  A = ram[LCL] + 3
    D=M                 //  D = ram[A]
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

//------ end of push ------

// push local 4
//------ start of push ------

    @LCL           //  A = LCL
    D=M                 //  D = ram[LCL]
    @4                //  A = 4
    A=D+A               //  A = ram[LCL] + 4
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

// function Sys.add12 0
//------ start of function ------

//***************start function Sys.add12***************//
    // function Sys.add12 0
    (Sys.add12)
    
//***************end function Sys.add12***************//
    

//------ end of function ------

// push constant 4002
//------ start of push ------

    @4002                //  A = 4002
    D=A                 //  D = A
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

//------ end of push ------

// pop pointer 0
//------ start of pop ------

    @THIS                //  A = THIS
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

// push constant 5002
//------ start of push ------

    @5002                //  A = 5002
    D=A                 //  D = A
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

//------ end of push ------

// pop pointer 1
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

// push constant 12
//------ start of push ------

    @12                //  A = 12
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

