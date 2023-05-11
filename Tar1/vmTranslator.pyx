# distutils: language = c++
# cython: language_level=3, encoding=utf-8

import os
import constants
import codeWriter
import parser


cdef  prs = None


# recursive function to process each file in the folder
cpdef recursive_div(file_path):
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

            process_file(entry.path, output_file)
        elif entry.is_dir():
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
    if comndTp == 'push' or comndTp == 'pop':
        line += writer.writePushPop(comndTp, prs.arg1(), prs.arg2()) + "\n\n"
    elif comndTp == 'add' or comndTp == 'sub' or comndTp == 'neg' or comndTp == 'eq' or comndTp == 'gt' or comndTp == 'lt' or comndTp == 'and' or comndTp == 'or' or comndTp == 'not':
        line += writer.writeArithmetic(comndTp) + "\n\n"
    return line



# # handle a single .vm file.
# cdef void handleSingleFile( str vmFile, writer,  prs):
#     writer.setCurrentFileName(vmFile.getName())
#     translateVmFile(vmFile, writer, prs)
#     writer.close()


# # handle a directory of .vm files.
# cdef void handleDir(str dir, writer,  prs):
#     cdef str filename
#     for filename in dir.listFiles():
#         if filename.endswith(".vm"):
#             translateVmFile(filename, writer, prs)
#     writer.close()