
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

// push constant 8
//------ start of push ------

    @8                //  A = 8
    D=A                 //  D = A
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

//------ end of push ------

// call Class1.set 2
//------ start of call ------

    //-------start call Class1.set 2-------//
    // push return-address Class1.set.1
    @Class1.set.1.ReturnAddress   
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
    D=D-A                           //  D = ram[0] - 2 - 5
    @2                      //  A = 2
    D=D-A                           //  D = ram[0] - 2
    @ARG                            //  A = ARG
    M=D                             //  ARG = ram[0] - 2 - 5

    // LCL = SP
    @SP                             //  A = 0
    D=M                             //  D = ram[0]
    @LCL                            //  A = LCL
    M=D                             //  LCL = ram[0]

    // goto functionName
    @Class1.set         //  A = Class1.set
    0;JMP                           //  goto Class1.set.1.ReturnAddress

    // (return-address)
(Class1.set.1.ReturnAddress)

    //-------end call Class1.set 2-------//
    

//------ end of call ------

// pop temp 0 // Dumps the return value
//------ start of pop ------

    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    @5                  //  A = 5
    A=A+1               //  A = A + 1          //  A = 5 + 0
    M=D                 //  ram[A] = D

//------ end of pop ------

// push constant 23
//------ start of push ------

    @23                //  A = 23
    D=A                 //  D = A
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

//------ end of push ------

// push constant 15
//------ start of push ------

    @15                //  A = 15
    D=A                 //  D = A
    @SP                 //  A = 0
    A=M                 //  A = ram[0]
    M=D                 //  ram[A] = D
    @SP                 //  A = 0
    M=M+1               //  ram[0] = ram[0] + 1

//------ end of push ------

// call Class2.set 2
//------ start of call ------

    //-------start call Class2.set 2-------//
    // push return-address Class2.set.2
    @Class2.set.2.ReturnAddress   
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
    D=D-A                           //  D = ram[0] - 2 - 5
    @2                      //  A = 2
    D=D-A                           //  D = ram[0] - 2
    @ARG                            //  A = ARG
    M=D                             //  ARG = ram[0] - 2 - 5

    // LCL = SP
    @SP                             //  A = 0
    D=M                             //  D = ram[0]
    @LCL                            //  A = LCL
    M=D                             //  LCL = ram[0]

    // goto functionName
    @Class2.set         //  A = Class2.set
    0;JMP                           //  goto Class2.set.2.ReturnAddress

    // (return-address)
(Class2.set.2.ReturnAddress)

    //-------end call Class2.set 2-------//
    

//------ end of call ------

// pop temp 0 // Dumps the return value
//------ start of pop ------

    @SP                 //  A = 0
    AM=M-1              //  A = ram[0] - 1 , ram[0] = ram[0] - 1
    @5                  //  A = 5
    A=A+1               //  A = A + 1          //  A = 5 + 0
    M=D                 //  ram[A] = D

//------ end of pop ------

// call Class1.get 0
//------ start of call ------

    //-------start call Class1.get 0-------//
    // push return-address Class1.get.3
    @Class1.get.3.ReturnAddress   
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
    @Class1.get         //  A = Class1.get
    0;JMP                           //  goto Class1.get.3.ReturnAddress

    // (return-address)
(Class1.get.3.ReturnAddress)

    //-------end call Class1.get 0-------//
    

//------ end of call ------

// call Class2.get 0
//------ start of call ------

    //-------start call Class2.get 0-------//
    // push return-address Class2.get.4
    @Class2.get.4.ReturnAddress   
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
    @Class2.get         //  A = Class2.get
    0;JMP                           //  goto Class2.get.4.ReturnAddress

    // (return-address)
(Class2.get.4.ReturnAddress)

    //-------end call Class2.get 0-------//
    

//------ end of call ------

// label WHILE
//------ start of label ------
(StaticsTest.WHILE)

//------ end of label ------

// goto WHILE
//------ start of goto ------

    @StaticsTest.WHILE
    0;JMP                   //  goto StaticsTest.WHILE

//------ end of goto ------

