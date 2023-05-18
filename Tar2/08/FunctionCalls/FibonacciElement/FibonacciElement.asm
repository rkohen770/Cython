
    // bootstrap
    @256                //  A = 256
    D=A                 //  D = 256
    @SP                 //  A = 0
    M=D                 //  ram[0] = 256
    
    // call Sys.init 0
    
    //-------start call Sys.init 0-------//
    // push return-address Sys.init.0
    @Sys.init.0.ReturnAddress   
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
    @Sys.init         //  A = Sys.init
    0;JMP                           //  goto Sys.init.0.ReturnAddress

    // (return-address)
(Sys.init.0.ReturnAddress)

    //-------end call Sys.init 0-------//
    
    //Sys

// function Sys.init 0
//------ start of function ------

//***************start function Sys.init***************//
    // function Sys.init 0
    (Sys.init)
    
//***************end function Sys.init***************//
    

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

    //-------start call Main.fibonacci 1-------//
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
    @Main.fibonacci         //  A = Main.fibonacci
    0;JMP                           //  goto Main.fibonacci.1.ReturnAddress

    // (return-address)
(Main.fibonacci.1.ReturnAddress)

    //-------end call Main.fibonacci 1-------//
    

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

)+fib(n-1)
//------ start of label ------
(FibonacciElement.IF_FALSE)

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

// call Main.fibonacci 1  // computes fib(n-2)
//------ start of call ------

    //-------start call Main.fibonacci 1-------//
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
    @Main.fibonacci         //  A = Main.fibonacci
    0;JMP                           //  goto Main.fibonacci.1.ReturnAddress

    // (return-address)
(Main.fibonacci.1.ReturnAddress)

    //-------end call Main.fibonacci 1-------//
    

//------ end of call ------

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

// call Main.fibonacci 1  // computes fib(n-1)
//------ start of call ------

    //-------start call Main.fibonacci 1-------//
    // push return-address Main.fibonacci.2
    @Main.fibonacci.2.ReturnAddress   
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
    @Main.fibonacci         //  A = Main.fibonacci
    0;JMP                           //  goto Main.fibonacci.2.ReturnAddress

    // (return-address)
(Main.fibonacci.2.ReturnAddress)

    //-------end call Main.fibonacci 1-------//
    

//------ end of call ------

// add                    // returns fib(n-1) + fib(n-2)
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

