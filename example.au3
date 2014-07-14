#include <HotString.au3>

HotStringSet("callme{enter}", examplefunction)

While 1
    Sleep(10)
WEnd

Func examplefunction()
    MsgBox(0,"","You typed callme! :)")
EndFunc



#cs
; ALTERNATIVELY give your method one parameter which will receive the full hotstring name

#include <HotString.au3>

HotStringSet("callme{enter}", examplefunction)

While 1
    Sleep(10)
WEnd

Func examplefunction($hotstring)
    MsgBox(0,"","You typed " & $hotstring & "! :)")
EndFunc

#ce
