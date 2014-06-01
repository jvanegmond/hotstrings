#include <HotString.au3>

HotStringSet("callme{enter}", examplefunction)

While 1
    Sleep(10)
WEnd

Func examplefunction()
    MsgBox(0,"","You typed callme! :)")
EndFunc