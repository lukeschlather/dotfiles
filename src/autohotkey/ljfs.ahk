#Persistent
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

; Use window spy (right click on autohotkey icon)
; These numbers are the x-coordinate of the leftmost pixel of each monitor
#1::MoveToMonitor(-2310)
#2::MoveToMonitor(0)
#3::MoveToMonitor(2303)

; Moves a window to a monitor and maximizes it.
MoveToMonitor(zeroIndex)
{
  monitorWidth := 1920
  monitorHeight := 1080

  activeWindow := WinActive("A")
  if activeWindow = 0
  {
          return
  }

  newX := zeroIndex
  newY := 0

  newWidth := (monitorWidth)
  newHeight := (monitorHeight - 40)

  WinMove, ahk_id %activeWindow%, , %newX%, %newY%, %newWidth%, %newHeight%
;  WinActivate ahk_id %activeWindow%   ;Needed - otherwise another window may overlap it
  WinMaximize ahk_id %activeWindow%
  return
}