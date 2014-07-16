HotString library for AutoIt3
==========

HotStrings are similar to AutoIts HotKey function but they trigger on a string of characters, instead of a key or key combination. This has been built because of popular requested from the community.

Instructions for use: Download the HotString.au3 (that is attached in this post) and put it in the same directory as your script. Then try out the code example below, or use the library in your own application.

This code is not released under any license, however I will not exercise my copyrights over this code. If you need me to release this software under any license for whatever reason, send me a message.

```
  {ESC}{F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}
  {GRAVE}1234567890-={BACKSPACE}
  {TAB}QWERTYUIOP[]\
  {CAPSLOCK}ASDFGHJKL;{ACUTE/CEDILLA}
  {SHIFT}ZXCVBNM,./
  {CTRL}{Left Windows}{SPACE}{Right Windows}{Application}{Right Ctrl}
  {LEFT}{UP}{RIGHT}{DOWN}
  {INSERT}{HOME}{PGUP}{DELETE}{END}{PGDOWN}{Prnt Scrn}{SCROLL LOCK}{Pause}
  {Num Lock}{NUM DIVIDE}{NUMMULT}{NUM SUB}{NUM 7}{NUM 8}{NUM 9}{NUM PLUS}{NUM 4}{NUM 5}{NUM 6}{NUM 1}{NUM 2}{NUM 3}{NUM ENTER}{NUM 0}{NUM DECIMAL}
```

Modifiers are not supported, for example ^a for {CTRL}a. This is not CaSE SenSiTiVE.

AutoIt forums thread is here: http://www.autoitscript.com/forum/topic/68422-hotstrings-string-hotkeys/
