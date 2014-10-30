#include <HotString.au3>
#include <HotStringHelpers.au3>

;Supported keys:
;{F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}
;{GRAVE}1234567890-={BACKSPACE}
;{TAB}QWERTYUIOP[]\
;{CAPSLOCK}ASDFGHJKL;{ACUTE/CEDILLA}
;{SHIFT}ZXCVBNM,./
;{CTRL}{Left Windows}{SPACE}{Right Windows}{Application}{Right Ctrl}
;{LEFT}{UP}{RIGHT}{DOWN}
;{INSERT}{HOME}{PGUP}{DELETE}{END}{PGDOWN}{Prnt Scrn}{SCROLL LOCK}{Pause}
;{Num Lock}{NUM DIVIDE}{NUMMULT}{NUM SUB}{NUM 7}{NUM 8}{NUM 9}{NUM PLUS}{NUM 4}{NUM 5}{NUM 6}{NUM 1}{NUM 2}{NUM 3}{NUM ENTER}{NUM 0}{NUM DECIMAL}

;{ESC} Doesn't seem to work with Win7 (but unsure if this is universal or a conflict with another installed program)


; *** EXAMPLES ***

; preceeding the replacement string with {NODEL} means the typed string won't be deleted
hotStringSetInit("`dontdel", "{NODEL} - this keeps the original hotstring text")

hotStringSetInit("`test", "This is a test")	; this will preface "`test", with "This is a test (note I often preceed strings with the backquote character at the top left of the qwerty keyboard as this isn't used for much)

hotStringSetInit("`hsd", "{call listHotStringDuplicates()}")	; this calls a function in hotstrings.au3 to check for conflicts between strings

hotStringSetInit("calltest", "{call calltest()}")	; this calls the following function
Func calltest()
    msgbox(1,"","you typed " & $HotStringPressed)
end Func

; these demonstrate pausing input and inserting times and dates (from HotStringHelpers.au3)
hotStringSetInit("`pause", "{pause}{enter}{pause}Pause Demo{pause 500}Waiting 1000{pause 1000}Finished{enter}")
hotStringSetInit("`tim", "{time}{tab}{time}{tab}{time}")
hotStringSetInit("`date", "{date}{tab}{date 4w}{tab}{date 6w}{tab}{date 1m}{tab}{date 1y}{tab}")


; This endless loop is required to keep monitoring for keystrokes (unless you want to include  from another file in which case, comment it out)
While True
	sleep (100)
WEnd
