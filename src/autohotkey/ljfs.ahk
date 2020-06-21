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

#t::Run pwsh.exe
#s::Run "C:\Program Files (x86)\Steam\Steam.exe" steam://open/friends/

; Use window spy (right click on autohotkey icon)
; These numbers are the x-coordinate of the leftmost pixel of each monitor
#1::MoveToMonitor(0)
#2::MoveToMonitor(1920)

; Moves a window to a monitor and maximizes it.
MoveToMonitor(Zero_X)
{

  logger := FileOpen("C:\Users\LUKE~1.SCH\AppData\Local\Temp\ljfs.ahk.log", "w")

  SysGet, MonitorName, MonitorName, %Monitor_Index%
  SysGet, Monitor, Monitor, %Monitor_Index%
  SysGet, MonitorWorkArea, MonitorWorkArea, %Monitor_Index%

  width := 1920
  height := 1080

  MonitorLeft := Zero_X
  MonitorRight := 1920
  MonitorTop := 0
  MonitorBottom := height

  logger.WriteLine("Monitor: " . Monitor_Index)
  logger.WriteLine("Zero_X: " . Zero_X)
  logger.WriteLine("MonitorLeft: " . MonitorLeft . " MonitorRight: " . MonitorRight)
  logger.WriteLine("WorkAreaLeft: " . %MonitorWorkAreaLeft%)

  WinRestore ahk_id %activeWindow%
  activeWindow := WinActive("A")
  WinRestore ahk_id %activeWindow%
  if activeWindow = 0
  {
      return
  }

  msg = "Left: %MonitorLeft% Bottom: %MonitorBottom% Width: %width%, Height: %height%"
  logger.WriteLine()

  newX := (MonitorLeft)
  newY := (MonitorTop)
  newWidth := (width / 2)
  newHeight := (height / 2)
  WinRestore ahk_id %activeWindow%

  logger.WriteLine("Moving to X: " . newX . " Y: " . newY . " Width: " . newWidth . " Height: " . newHeight)
  WinMove, ahk_id %activeWindow%, , %newX%, %newY%, %newWidth%, %newHeight%

  WinActivate ahk_id %activeWindow%   ;Needed - otherwise another window may overlap it
  WinRestore ahk_id %activeWindow%
  WinMaximize ahk_id %activeWindow%
  return
}
