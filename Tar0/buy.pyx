# קבוצה: 150060.31.5783.01, 150060.31.5783.43
# רחל לאה כהן: 211372156
# הודיה שנקר: 211720503


# distutils: language = c++

import os


cdef double totalBuy = 0
cdef double totalCell = 0

cdef str HandleBuy( str ProductName, int Amount, double Price ):
    # open the file Tar0.asm and write the text: "### BUY <ProductName> ### /n<Amount*Price>" to the end of the file.
    global totalBuy
    totalBuy += Amount * Price
    return str("### BUY " + ProductName + " ###\n" + str("{:.2f}".format(Amount*Price)) + "\n")
    

   
cdef str HandleCell( str ProductName, int Amount, double Price ):
    # open the file Tar0.asm and write the text: "$$$ CELL <ProductName> $$$ /n<Amount*Price>" to the end of the file.
    global totalCell
    totalCell += Amount * Price
    return ("$$$ CELL " + ProductName + " $$$\n" + str("{:.2f}".format(Amount*Price)) + "\n")

def process_file(file_path, output_file):
    # Extract the name of the file without the extension
    file_name = os.path.splitext(os.path.basename(file_path))[0]

    # Write the file name to the output file
    output_file.write(f"{file_name}\n")

    # Open the VM file for reading
    with open(file_path, 'r') as input_file:
        for line in input_file:
            # Split the line into words
            words = line.split()

            # Call the appropriate function based on the first word
            if words[0] == "buy":
                buy_string = HandleBuy( words[1], int(words[2]),float(words[3]))
                output_file.write(buy_string)
            elif words[0] == "cell":
                cell_string = HandleCell( words[1], int(words[2]), float(words[3]))
                output_file.write(cell_string)


def buy_cell(folder_path):
    # Extract the name of the last folder in the path
    folder_name = os.path.basename(folder_path)

    # Build the output file name
    output_file_name = os.path.join(folder_path, folder_name + ".asm")

    # Open the output file for writing
    output_file = open(output_file_name, 'w')

    # Process each file in the folder
    for filename in os.listdir(folder_path):
        # Check if the file is a VM file
        if filename.endswith(".vm"):
            file_path = os.path.join(folder_path, filename)
            process_file(file_path, output_file)

    #print("TOTAL BUY: " + str(totalBuy)) to the end of the file.
    output_file.write("TOTAL BUY: " + str(totalBuy) + "\n")
    #print("TOTAL CELL: " + str(totalCell)) to the end of the file.
    output_file.write("TOTAL CELL: " + str(totalCell) + "\n")

    output_file.close()
    # open new file called "Tar0.asm" for writing and locate it in the folder "folde_path".

