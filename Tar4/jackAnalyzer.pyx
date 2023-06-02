# Input: a single fileName.jack, or a folder containing 0 or more such files

# For each file:
# 1. Creates a JackTokenizer from fileName.jack
# 2. Creates an output file named fileName.xml
# 3. Creates a CompilationEngine, and calls the compileClass method

import os
from compilationEngine import CompilationEngine

cdef class JackAnalyzer:

    # get the base name of the file and the directory it is in and create new file for output in the same directory
    cpdef compile(self, input_file, directory, output_file_name):

        # Extract the name of the file in the path without the 'T' extension
        file_name = os.path.splitext(os.path.basename(directory))[0]

        # Build the output file name
        output_file_name = os.path.join(directory, output_file_name  + '.xml')
        
        # Open the output file for writing
        output_file = open(output_file_name, 'w')

        # Create a CompilationEngine object
        # compilation_engine =  CompilationEngine(input_file, output_file)