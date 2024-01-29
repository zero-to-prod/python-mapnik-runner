import mapnik
import os

# Folder where the file will be saved
folder_name = 'generated'

# Check if the folder exists, create it if it doesn't
if not os.path.exists(folder_name):
    os.makedirs(folder_name)

# File path
file_path = os.path.join(folder_name, 'example.txt')

# Open a file in write mode. If it doesn't exist, it will be created.
with open(file_path, 'w') as file:
    file.write("Hello, World!\n")

print("File created successfully in the 'generated' folder.")