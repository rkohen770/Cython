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

    (NestedCall.Sys.init)
             //  push 0 0 times

// push constant 4000 // test THIS and THAT context save

    @4000                //  A = 4000
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

// push constant 5000

    @5000                //  A = 5000
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

// call Sys.main 0

    // push return-address
    @RETURN.Sys.main.1  //  A = RETURN.Sys.main.1
    D=A                             //  D = RETURN.Sys.main.1
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
    @0                      //  A = 0
    D=D-A                           //  D = ram[0] - 0
    @5                              //  A = 5
    D=D-A                           //  D = ram[0] - 0 - 5
    @ARG                            //  A = ARG
    M=D                             //  ARG = ram[0] - 0 - 5

    // LCL = SP
    @SP                             //  A = 0
    D=M                             //  D = ram[0]
    @LCL                            //  A = LCL
    M=D                             //  LCL = ram[0]

    // goto functionName
    @RETURN.Sys.main.1  //  A = RETURN.Sys.main.1
    0;JMP                           //  goto Sys.main

    // (return-address)
    (RETURN.Sys.main.1)
    

// pop temp 1

    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    @5                  //  A = 5
    A=A+1              //  A = A + 1
          //  A = 5 + 1
    M=D                 //  ram[A] = D

// label LOOP
(NestedCall.LOOP)

// goto LOOP

    @NestedCall.LOOP
    //  A = NestedCall.LOOP

    0;JMP                   //  goto NestedCall.LOOP


// function Sys.main 5

    (NestedCall.Sys.main)
    
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
    M=M+1               //  ram[0] = ram[0] + 1         //  push 0 5 times

// push constant 4001

    @4001                //  A = 4001
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

// push constant 5001

    @5001                //  A = 5001
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

// push constant 200

    @200                //  A = 200
    D=A                 //  D = A
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

// pop local 1

    @SP                     //  A = 0
    AM=M-1                  //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                     //  D = ram[A]
    @LCL              //  A = LCL
    A=M                     //  A = ram[LCL]
    A=A+1              //  A = A + 1
              //  A = ram[LCL] + 1
    M=D                     //  ram[A] = D

// push constant 40

    @40                //  A = 40
    D=A                 //  D = A
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

// pop local 2

    @SP                     //  A = 0
    AM=M-1                  //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                     //  D = ram[A]
    @LCL              //  A = LCL
    A=M                     //  A = ram[LCL]
    A=A+1              //  A = A + 1
A=A+1              //  A = A + 1
              //  A = ram[LCL] + 2
    M=D                     //  ram[A] = D

// push constant 6

    @6                //  A = 6
    D=A                 //  D = A
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

// pop local 3

    @SP                     //  A = 0
    AM=M-1                  //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                     //  D = ram[A]
    @LCL              //  A = LCL
    A=M                     //  A = ram[LCL]
    A=A+1              //  A = A + 1
A=A+1              //  A = A + 1
A=A+1              //  A = A + 1
              //  A = ram[LCL] + 3
    M=D                     //  ram[A] = D

// push constant 123

    @123                //  A = 123
    D=A                 //  D = A
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

// call Sys.add12 1

    // push return-address
    @RETURN.Sys.add12.2  //  A = RETURN.Sys.add12.2
    D=A                             //  D = RETURN.Sys.add12.2
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
    @RETURN.Sys.add12.2  //  A = RETURN.Sys.add12.2
    0;JMP                           //  goto Sys.add12

    // (return-address)
    (RETURN.Sys.add12.2)
    

// pop temp 0

    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    @5                  //  A = 5
              //  A = 5 + 0
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

// push local 2

    @2                    //  A = 2
    D=A                     //  D = 2
    @LCL              //  A = LCL
    A=M+D                   //  A = ram[LCL] + D
    D=M                     //  D = ram[A]
    @SP                     //  A = 0
    A=M                     //  A = ram[0]
    M=D                     //  ram[A] = D
    @SP                     //  A = 0
    M=M+1                   //  ram[0] = ram[0] + 1

// push local 3

    @3                    //  A = 3
    D=A                     //  D = 3
    @LCL              //  A = LCL
    A=M+D                   //  A = ram[LCL] + D
    D=M                     //  D = ram[A]
    @SP                     //  A = 0
    A=M                     //  A = ram[0]
    M=D                     //  ram[A] = D
    @SP                     //  A = 0
    M=M+1                   //  ram[0] = ram[0] + 1

// push local 4

    @4                    //  A = 4
    D=A                     //  D = 4
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

// add

    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                 //  D = ram[A]
    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    M=M+D               //  ram[A] = ram[A] + D
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

// add

    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    D=M                 //  D = ram[A]
    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    M=M+D               //  ram[A] = ram[A] + D
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

// function Sys.add12 0

    (NestedCall.Sys.add12)
             //  push 0 0 times

// push constant 4002

    @4002                //  A = 4002
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

// push constant 5002

    @5002                //  A = 5002
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

// push constant 12

    @12                //  A = 12
    D=A                 //  D = A
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

