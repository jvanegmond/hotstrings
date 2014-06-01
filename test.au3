#include <HotString.au3>

HotStringSet("callme{enter}", examplefunction)
HotStringSet("othertrigger{enter}", examplefunction2)

Local $numTimes_examplefunction, $numTimes_examplefunction2

Run("notepad.exe")
WinWaitActive("Untitled - Notepad")
ConsoleWrite("Send trigger" & @CRLF)
Send("callme{ENTER}")
ConsoleWrite("Send other trigger" & @CRLF)
Send("othertrigger{ENTER}")

ProcessClose("notepad.exe")

If $numTimes_examplefunction == 1 And $numTimes_examplefunction2 == 1 Then
   Exit 0
Else
   ConsoleWriteError("Tests did not execute the expected amount")
   Exit 1
EndIf


Func examplefunction()
   ConsoleWrite("Received trigger!" & @CRLF)
   $numTimes_examplefunction += 1
EndFunc

Func examplefunction2()
   ConsoleWrite("Received other trigger!" & @CRLF)
   $numTimes_examplefunction2 += 1
EndFunc