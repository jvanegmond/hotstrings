#include-once
#include <array.au3>
#include <Date.au3>		; used by sendS
Global $hotStringReplaceList[1]

Func hotStringSetInit($stringToMonitorFor, $stringToReplaceWith)
	_ArrayAdd($hotStringReplaceList, $stringToMonitorFor)
	_ArrayAdd($hotStringReplaceList, $stringToReplaceWith)
	HotStringSet($stringToMonitorFor, "hotStringMonitor")
EndFunc

Func hotStringMonitor ()
;	sleep(250)
	$stringDeleted = False
	$winActive = WinGetTitle("[ACTIVE]")
	$uBnd = UBound($hotStringReplaceList)-1
	For $i = 1 to $uBnd Step 2
		if $HotStringPressed = $hotStringReplaceList[$i] Then
			ConsoleWrite("FOUND: " & $HotStringPressed & "=>" & $hotStringReplaceList[$i] & @CRLF)
			; preceeding the replacement string with ~@| means the typed string shouldn't be deleted
			If StringLeft($hotStringReplaceList[$i+1],3) = "~@|" Then
				$stringDeleted = True
				sendS (StringMid($hotStringReplaceList[$i+1],4))
			; check if the hotstring should only be activated if in a particular window
			ElseIf StringLeft($hotStringReplaceList[$i+1],6) = "[TITLE" Then
				$winTitle = StringLeft($hotStringReplaceList[$i+1],StringInStr($hotStringReplaceList[$i+1],"]"))
				If $winActive = $winTitle Then
					If Not $stringDeleted Then	; only delete the trigger string once, but put it in here as no action if not correct window
						$lenCurStr = StringLen ($HotStringPressed)
						For $j = 1 to $lenCurStr
							Send ("{BS}")
						Next
					EndIf
					ConsoleWrite("TITLE: " & $hotStringReplaceList[$i] & "=>" & $hotStringReplaceList[$i+1] & @CRLF)
					sendS (StringMid($hotStringReplaceList[$i+1],StringInStr($hotStringReplaceList[$i+1],"]")+1))
				EndIf
			Else
				If Not $stringDeleted Then	; only delete the trigger string once, but put it in here as no action if not correct window
					$lenCurStr = StringLen ($HotStringPressed)
					For $j = 1 to $lenCurStr
						Send ("{BS}")
					Next
				EndIf
				ConsoleWrite("NONTITLE: " & $hotStringReplaceList[$i] & "=>" & $hotStringReplaceList[$i+1] & @CRLF)
				sendS ($hotStringReplaceList[$i+1])
			EndIf
		EndIf
	Next
EndFunc

Func listHotStringDuplicates()
	$dupHotStringList = ""
	$blockHotStringList = ""
	For $i = 0 to UBound($_hotString_hotkeys)-1
		For $j = $i+1 to UBound($_hotString_hotkeys)-1
			If $_hotString_hotkeys[$i] = $_hotString_hotkeys[$j] Then
				; exact match
				$dupHotStringList &= "¬" & $_hotString_hotkeys[$i] & "¬" & @CRLF
			ElseIf StringLeft($_hotString_hotkeys[$i],StringLen($_hotString_hotkeys[$j])) = $_hotString_hotkeys[$j] Then
				; [$j] matches start of [$i] (so will activate prior to [$i]
				$blockHotStringList &= """" & $_hotString_hotkeys[$j] & """ will block """ & $_hotString_hotkeys[$i] & """" & @CRLF
			EndIf
		Next
	Next
	If $dupHotStringList = "" and $blockHotStringList = "" Then
;		MsgBox(1,"","No Duplicate Hot Strings Found")
	ElseIf $blockHotStringList = "" Then
		InputBox("","Duplicate strings identified:" & @CRLF & StringReplace($dupHotStringList,"¬",""),StringReplace($dupHotStringList,"¬",""))
	ElseIf $dupHotStringList = "" Then
		InputBox("","Blocking strings identified:" & @CRLF & $blockHotStringList,$blockHotStringList)
	Else
		InputBox("","Duplicate strings identified:" & @CRLF & StringReplace($dupHotStringList,"¬",""),StringReplace($dupHotStringList,"¬",""))
		InputBox("","Blocking strings identified:" & @CRLF & $blockHotStringList,$blockHotStringList)
	EndIf
EndFunc

Func sendS ($stringToSend)
	;smart(er) version of Send
	UnstickKeys()
	$stringToSend = StringReplace($stringToSend,"{pause}","{pause 100}")
	$stringToSend = StringReplace($stringToSend,"{time}",@HOUR & ":" & @MIN)
	$stringToSend = StringReplace($stringToSend,"{date}",@MDAY & "/" & @MON & "/" & @YEAR)
	$sNewDate = _DateTimeFormat(_DateAdd('d', 7*4, _NowCalcDate()),2)
	$stringToSend = StringReplace($stringToSend,"{date 4w}",$sNewDate)
	$sNewDate = _DateTimeFormat(_DateAdd('d', 7*6, _NowCalcDate()),2)
	$stringToSend = StringReplace($stringToSend,"{date 6w}",$sNewDate)
	$sNewDate = _DateTimeFormat(_DateAdd('d', 28*3, _NowCalcDate()),2)
	$stringToSend = StringReplace($stringToSend,"{date 3m}",$sNewDate)
	$stringToSend = StringReplace($stringToSend,"{date 1y}",@MDAY & "/" & @MON & "/" & @YEAR +1)
	$stringToSend = StringReplace($stringToSend,"{pause","||{pause")
	$stringToSend = StringReplace($stringToSend,"{call ","||{call")
	$stringToSend = StringReplace($stringToSend,"{RC ","||{RC")
	$stringToSend = StringReplace($stringToSend,"}","}||")
	$stringToSend = StringReplace($stringToSend,"||||","||")
	$stringToSend = StringSplit($stringToSend,"||",1)
	for $i = 1 to $stringToSend[0]
		$stringToSend[$i] = StringReplace($stringToSend[$i],"||","")
		ConsoleWrite($stringToSend[$i])
		If StringInStr($stringToSend[$i],"{pause") > 0 then
			$stringToSend[$i] = StringReplace($stringToSend[$i],"{pause","")
			$stringToSend[$i] = StringReplace($stringToSend[$i],"}","")
			$sleepDuration = StringStripWS($stringToSend[$i],8)
			Sleep($sleepDuration)
		ElseIf StringInStr($stringToSend[$i],"{RC") > 0 then
			$stringToSend[$i] = StringReplace($stringToSend[$i],"{RC","")
			$stringToSend[$i] = StringReplace($stringToSend[$i],"}","")
			$stringToSend[$i] = StringStripWS($stringToSend[$i],3)
			$stringToSend[$i] = "{APPSKEY}{PAUSE}{ENTER}{PAUSE 150}" & $stringToSend[$i] & "{enter}{PAUSE 150}{APPSKEY}{PAUSE}{ENTER}{pause 200}"
			Send ($stringToSend[$i])
		ElseIf StringInStr($stringToSend[$i],"{call") > 0 then
			$stringToSend[$i] = StringReplace($stringToSend[$i],"{call","")
			$stringToSend[$i] = StringReplace($stringToSend[$i],"}","")
			$funcNameEnd = StringInStr($stringToSend[$i],"(")
			$callStr = StringLeft($stringToSend[$i],$funcNameEnd-1)
			$callStr = StringStripWS($callStr,8)

			$stringToSend[$i] = StringMid($stringToSend[$i],$funcNameEnd+1)
			$stringToSend[$i] = StringReplace($stringToSend[$i],")","")
;			$stringToSend[$i] = StringReplace($stringToSend[$i],"""","")
			$stringToSend[$i] = StringReplace($stringToSend[$i],""", """,""",""")
;			$funcParam = StringStripWS($stringToSend[$i],8)

			$funcParam = StringSplit($stringToSend[$i],",")
;				MsgBox(1,"",$stringToSend[$i])
;				MsgBox(1,"",$funcParam[0])
			for $j = 1 to $funcParam[0]
				$funcParam[$j] = StringReplace($funcParam[$j],"""", "")
				$funcParam[$j] = StringStripWS($funcParam[$j],3)
;				MsgBox(1,"",$funcParam[$j])
			Next
			$funcParam[0] = "CallArgArray" ; This is required, otherwise, Call() will not recognize the array as containing arguments

			if $stringToSend[$i] <> "" Then
				Call ($callStr, $funcParam)
			Else
				Call ($callStr)
			EndIf
		Else
			Send ($stringToSend[$i])
		EndIf
	Next
	Sleep(500)	; else sometimes keys left pressed (and without delay sometimes up happens before typing finished.
	UnstickKeys()
EndFunc

; sometimes autoit causes keys to get stuck down, UnstickKeys can help and needs $user32dll and $keys.
$user32dll = DllOpen("C:\Windows\System32\user32.dll")
;0xa0=LSHIFT;	0xa1=RSHIFT;	0xa2=LCTRL;	0xa3=RCTRL;	0xa4=LALT;	0xa5=RALT;	0x5b=LWIN;	0x5c=RWIN
Global Const $keys[8] = [0xa0, 0xa1, 0xa2, 0xa3, 0xa4, 0xa5, 0x5b, 0x5c]


Func UnstickKeys()
; also a 'sleep()' call may help: Good News! I have determined that inserting a "sleep()" command before the "send()" command will also reliably resolve the stuck-key problem. On slow computers, a "send(300)" was required, while on fast machines, a "send(100)" was enough.  Most importantly, this experiment showed that the problem occurs BECAUSE the "send()" action starts before the hotkey detection function completes. When the "send()" action starts too soon, it seems to cause the detection function to silently error out and fail to finish it's normal cleanup after each use (speculation).
	For $vkvalue in $keys
		DllCall($user32dll,"int","keybd_event","int",$vkvalue,"int",0,"long",2,"long",0) ;Release each key
	Next
EndFunc
func UnstickKeys2()
	send("{CTRLUP}{SHIFTUP}{ALTUP}{LWINUP}{RWINUP}")
EndFunc
