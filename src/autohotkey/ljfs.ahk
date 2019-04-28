#SingleInstance Force
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

^!r::Reload  ; Assign Ctrl-Alt-R as a hotkey to restart the script.

#m::WinMaximize A
#w::WinClose A

#Left::return
#Right::return

#t::Run powershell.exe
