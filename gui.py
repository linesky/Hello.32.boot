import tkinter as tk
from tkinter import messagebox
from tkinter.filedialog import askopenfilename
from tkinter.filedialog import asksaveasfilename
import subprocess
import shutil
import os



class BareboneBuilder:
    def __init__(self, root):
        self.root = root
        self.root.title("Barebone Builder")

        # Janela amarela
        self.root.configure(bg='yellow')

        # Área de texto
        self.text_area = tk.Text(self.root, height=10, width=50)
        self.text_area.pack(pady=10)

        # Botões
        self.build_button = tk.Button(self.root, text="Build", command=self.build_kernel)
        self.build_button.pack(pady=5)

        self.run_button = tk.Button(self.root, text="Run", command=self.run_kernel)
        self.run_button.pack(pady=5)

        self.copy_button = tk.Button(self.root, text="new file", command=self.copy_file)
        self.copy_button.pack(pady=5)

    def execute_command(self, command,show:bool):
        try:
            
            result = subprocess.check_output(command, stderr=subprocess.STDOUT, shell=True, text=True)
            self.text_area.insert(tk.END, result)
        except subprocess.CalledProcessError as e:
            if show:
                self.text_area.insert(tk.END,f"Error executing command:\n{e.output}")

    def build_kernel(self):
        filename = tk.filedialog.askopenfilename(title="Select file")
        self.text_area.delete(1.0, tk.END)
        self.execute_command("nasm -o /tmp/boot.bin boot.asm",False)
        
        fff=f'gcc -o3 -c "$1" -o /tmp/kernel.o -nostdlib'.replace("$1",filename)
        
        self.execute_command(fff,True)
        self.execute_command("ld -T link.ld /tmp/kernel.o -o /tmp/hello.com -nostdlib",True)
        self.execute_command("objcopy -O binary  /tmp/hello.com  /tmp/hellos.com",True)
        
        self.execute_command("dd if=/tmp/hellos.com of=/tmp/boot.bin seek=1 conv=notrunc",True)
        self.execute_command("cp -f /tmp/boot.bin ./",True)
    def run_kernel(self):
        self.text_area.delete(1.0, tk.END)
        self.execute_command("/usr/bin/qemu-system-x86_64 -boot a -fda boot.bin",True)


    def copy_file(self):
        self.text_area.delete(1.0, tk.END)
        filename = tk.filedialog.asksaveasfilename(title="Select file")
        if filename:
            shutil.copy( f"./file/new",filename+".c")
            self.text_area.insert(tk.END, f"File {filename} copied \n",True)


if __name__ == "__main__":
    root = tk.Tk()
    builder = BareboneBuilder(root)
    root.mainloop()
