#Firstly u have to install pyautogui.
#The commmand is : python3 -m pip install pyautogui
#Then u can run this by : python3 autocmt.py

import pyautogui
import time

comments = ["Hi","Hello Hacktober","Nice to meet you"]


time.sleep(4)

for i in range(100):
    pyautogui.typewrite(comments[i%3])
    pyautogui.typewrite("\n")
    time.sleep(2)