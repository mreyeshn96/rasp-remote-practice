# LIBRERIAS
from paramiko import SSHClient
from paramiko import AutoAddPolicy

from tkinter import messagebox
from tkinter import *

# CONFIGURACIÓN

SERVER_IP = "your_ip_raspberry_here"
SERVER_USER = 'your_user_raspberry_here'
SERVER_PASSWORD = 'your_password_raspberry_here'

# SSH CONEXIÓN
connHandle = SSHClient()
connHandle.set_missing_host_key_policy(AutoAddPolicy())
connHandle.connect(SERVER_IP, username=SERVER_USER, password=SERVER_PASSWORD)

# Funciones
def makeSum():

    if len(entrySumNum1.get()) == 0 or len(entrySumNum2.get()) == 0:
        messagebox.showerror(title="Se ha producido un error", message="El campo número 1 y 2 de suma son obligatorios.")
    else:
        ssh_stdin, ssh_stdout, ssh_stderr = connHandle.exec_command("/home/pi/Desktop/clase2/calculadora")
        ssh_stdin.write("1\n")
        ssh_stdin.write(f"{entrySumNum1.get()}\n")
        ssh_stdin.write(f"{entrySumNum2.get()}\n")
        ssh_stdin.flush()

        allResults = ssh_stdout.readlines()
        resultString = str(allResults[12])

        entrySumResult.delete(0, END)
        entrySumResult.insert(0, resultString)

def makeSubtraction():
    if len(entrySubtractionNum1.get()) == 0 or len(entrySubtractionNum2.get()) == 0:
        messagebox.showerror(title="Se ha producido un error",
                             message="El campo número 1 y 2 de resta son obligatorios.")
    else:
        ssh_stdin, ssh_stdout, ssh_stderr = connHandle.exec_command("/home/pi/Desktop/clase2/calculadora")
        ssh_stdin.write("2\n")
        ssh_stdin.write(f"{entrySubtractionNum1.get()}\n")
        ssh_stdin.write(f"{entrySubtractionNum2.get()}\n")
        ssh_stdin.flush()

        allResults = ssh_stdout.readlines()
        resultString = str(allResults[12])

        entrySubtractionResult.delete(0, END)
        entrySubtractionResult.insert(0, resultString)

def updateGpioState(pin, objectimage):
    ssh_stdin, ssh_stdout, ssh_stderr = connHandle.exec_command(f"gpio read {pin}")
    result = str(ssh_stdout.readlines())
    print(result)
    if result[2] == "1":
        objectimage['file'] = r'on.png'
    else:
        objectimage['file'] = r'off.png'

    mainWindow.after(1000, lambda:updateGpioState(pin, objectimage))

def actionViaCalc(pin):
    ssh_stdin, ssh_stdout, ssh_stderr = connHandle.exec_command("/home/pi/Desktop/clase2/calculadora")
    ssh_stdin.write(f"{pin}\n")
    ssh_stdin.flush()


# CREAR TKINTER.
mainWindow = Tk()
mainWindow.geometry("550x350")

# Creación de Widgets de resta.
lblSubtraction = Label(text="Operación restar")
entrySubtractionNum1 = Entry()
entrySubtractionNum2 = Entry()
buttonSubtraction = Button(text="Realizar operación de resta", command=lambda:makeSubtraction())
entrySubtractionResult = Entry()

# Creación de Widgets de suma.
lblSum = Label(text="Operación sumar")
entrySumNum1 = Entry()
entrySumNum2 = Entry()
buttonSum = Button(text="Realizar operación suma", command=lambda:makeSum())
entrySumResult = Entry()

# Creación de Widgets de GPIO #0.
imgGpio0 = PhotoImage(file=r"on.png")
buttonStateGpio0 = Button(image=imgGpio0)

lblGpio0 = Label(text="GPIO #0")
buttonGpio0on = Button(text="Encender", command=lambda:actionViaCalc(3))
buttonGpio0off = Button(text="Apagar", command=lambda:actionViaCalc(4))

# Creación de Widgets de GPIO #2.
imgGpio2 = PhotoImage(file=r"on.png")
buttonStateGpio2 = Button(image=imgGpio2)

lblGpio2 = Label(text="GPIO #2")
buttonGpio2on = Button(text="Encender", command=lambda:actionViaCalc(5))
buttonGpio2off = Button(text="Apagar", command=lambda:actionViaCalc(6))

# Creación de Widgets de GPIO #21.
imgGpio21 = PhotoImage(file=r"on.png")
buttonStateGpio21 = Button(image=imgGpio21)

lblGpio21 = Label(text="GPIO #21")
buttonGpio21on = Button(text="Encender", command=lambda:actionViaCalc(7))
buttonGpio21off = Button(text="Apagar", command=lambda:actionViaCalc(8))

# Mostrando widgets de resta
lblSubtraction.grid(row=3, column=0)
entrySubtractionNum1.grid(row=3, column=2)
entrySubtractionNum2.grid(row=3, column=4)
buttonSubtraction.grid(row=3, column=6)
entrySubtractionResult.grid(row=3, column=8)

# Mostrando widgets de suma
lblSum.grid(row=5, column=0)
entrySumNum1.grid(row=5, column=2)
entrySumNum2.grid(row=5, column=4)
buttonSum.grid(row=5, column=6)
entrySumResult.grid(row=5, column=8)

# Mostrando widgets de GPIO 0
buttonStateGpio0.grid(row=9, column=0)
lblGpio0.grid(row=9, column=1)
buttonGpio0on.grid(row=9, column=2)
buttonGpio0off.grid(row=9, column=3)

# Mostrando widgets de GPIO 2
buttonStateGpio2.grid(row=10, column=0)

lblGpio2.grid(row=10, column=1)
buttonGpio2on.grid(row=10, column=2)
buttonGpio2off.grid(row=10, column=3)

# Mostrando widgets de GPIO 21
buttonStateGpio21.grid(row=11, column=0)


lblGpio21.grid(row=11, column=1)
buttonGpio21on.grid(row=11, column=2)
buttonGpio21off.grid(row=11, column=3)


# Actualización automatica de los estados.
updateGpioState(0, imgGpio0)
updateGpioState(2, imgGpio2)
updateGpioState(21, imgGpio21)

mainWindow.mainloop()

