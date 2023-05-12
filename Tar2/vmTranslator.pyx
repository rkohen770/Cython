# distutils: language = c++
# cython: language_level=3, encoding=utf-8

import os
import constants
import codeWriter
import parser


cdef  prs = None


# recursive function to process each file in the folder
cpdef recursive_div(file_path):
    cdef str init= ""
    global writer
    for entry in os.scandir(file_path):
        print(entry.path)
        
        if entry.is_file() and entry.name.endswith('.vm'):
            # Extract the name of the last folder in the path without the extension
            folder_name = os.path.basename(file_path)
            writer = codeWriter.CodeWriter(folder_name)    
        
            # Build the output file name
            output_file_name = os.path.join(file_path, folder_name + ".asm")
        
            # Open the output file for writing
            output_file = open(output_file_name, 'w')
            output_file.write(init)
            process_file(entry.path, output_file)
        elif entry.is_dir():
            # if has two or more .vm files, then bootstrap
            count = 0
            for f in os.scandir(entry.path):
                if f.is_file() and f.name.endswith('.vm'):
                    count += 1
            if count > 1:
                init = constants.Bootstrap()
            recursive_div(entry.path)

cdef process_file(str file_path, output_file):

    # Extract the name of the file without the extension
    file_name = os.path.splitext(os.path.basename(file_path))[0]

    # Write the file name to the output file
    output_file.write(f"// {file_name}\n\n")

    

    # Open the VM file for reading
    with open(file_path, 'r') as input_file:
        for line in input_file:
            # ignore comments and empty lines
            if line.startswith("//") or line == '\n':
                continue
            else:
                output_file.write(translateVmFile(line))

    
    # Close the output file
    output_file.close()



# The heart of the program.
# Analyze the .vm file using the "parser" instance.
# And then translates and writes the commands using a "writer" instance to a .asm file.
cpdef str translateVmFile(str comd):
    cdef str line=""
    prs = parser.Parser(comd)
    

    line += writer.emitComment(comd)
    comndTp = comd.split(' ')[0].strip()
    line += "//------ start of " + comndTp + " ------\n"
    if comndTp == 'push' or comndTp == 'pop':
        line += writer.writePushPop(comndTp, prs.arg1(), prs.arg2()) + "\n\n"
    elif comndTp == 'add' or comndTp == 'sub' or comndTp == 'neg' or comndTp == 'eq' or comndTp == 'gt' or comndTp == 'lt' or comndTp == 'and' or comndTp == 'or' or comndTp == 'not':
        line += writer.writeArithmetic(comndTp) + "\n\n"
    elif comndTp == 'label':
        line += writer.writeLabel(prs.arg1()) + "\n\n"
    elif comndTp == 'goto':
        line += writer.writeGoto(prs.arg1()) + "\n\n"
    elif comndTp == 'if-goto':
        line += writer.writeIfGoto(prs.arg1()) + "\n\n"
    elif comndTp == 'function':
        line += writer.writeFunction(prs.arg1(), prs.arg2()) + "\n\n"
    elif comndTp == 'call':
        line += writer.writeCall(prs.arg1(), prs.arg2()) + "\n\n"
    elif comndTp == 'return':
        line += writer.writeReturn() + "\n\n"
    else:
        print("Error: Invalid command type: " + comndTp)
        exit(1)
    line += "//------ end of " + comndTp + " ------\n\n"
    return line

