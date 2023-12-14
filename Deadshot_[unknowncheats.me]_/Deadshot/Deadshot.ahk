init:
#NoEnv
#SingleInstance, Force
#Persistent
#InstallKeybdHook
#UseHook
#KeyHistory, 0
#HotKeyInterval 1
#MaxHotkeysPerInterval 127

if (FileExist("config.ini")) 
{
}
Else
{
IniWrite, 0xB82C29, config.ini, main, EMCol ; Yellow = 0xA5A528 Red = 0xB82C29
IniWrite, 20, config.ini, main, ColVn
}

IniRead, EMCol, config.ini, main, EMCol
IniRead, ColVn, config.ini, main, ColVn


toggle = 1
toggle2 = 1


AntiShakeX := (A_ScreenHeight // 160)
AntiShakeY := (A_ScreenHeight // 128)
ZeroX := (A_ScreenWidth // 2) ;dont touch?
ZeroY := (A_ScreenHeight // 2) 
CFovX := (A_ScreenWidth // 40)  ;configure for FOV up = smaller lower= bigger current boxes right fov
CFovY := (A_ScreenHeight // 64)
ScanL := ZeroX - CFovX
ScanT := ZeroY
ScanR := ZeroX + CFovX
ScanB := ZeroY + CFovY
NearAimScanL := ZeroX - AntiShakeX
NearAimScanT := ZeroY - AntiShakeY
NearAimScanR := ZeroX + AntiShakeX
NearAimScanB := ZeroY + AntiShakeY

Gui Add, Text, cBlue, Deadshot.io cheat
Gui Add, Text, cPurple, Press F2 to activate
Gui Add, Text, cPurple, Press F3 to close
Gui Add, Text, cBlue, Hope you enjoy!
Gui Add, Text, cBlue, Credits to 0xb4dc0d3x
Gui show

Gui 2: Color, EEAA99
Gui 2: Font, S72, Arial Black

Gui 2: Add, GroupBox, w100 h250 cFFB10F BackgroundTrans,
Gui 2: +LastFound +AlwaysOnTop +ToolWindow
WinSet, TransColor, EEAA99
Gui 2: -Caption

F3::
ExitApp
return

~F2::
SoundBeep, 750, 500

SetKeyDelay,-1, 1
SetControlDelay, -1
SetMouseDelay, -1
SendMode, InputThenPlay
SetBatchLines,-1
SetWinDelay,-1
ListLines, Off
CoordMode, Pixel, Screen, RGB
CoordMode, Mouse, Screen
PID := DllCall("GetCurrentProcessId")
Process, Priority, %PID%, High

Loop
{
    PixelSearch, AimPixelX, AimPixelY, NearAimScanL, NearAimScanT, NearAimScanR, NearAimScanB, EMCol, ColVn, Fast RGB	
    
    if (!ErrorLevel)
    {
        PixelSearch, AimPixelX, AimPixelY, ScanL, ScanT, ScanR, ScanB, EMCol, ColVn, Fast RGB
        AimX := AimPixelX - ZeroX
        AimY := AimPixelY - ZeroY
        DirX := -1
        DirY := -1
        If ( AimX > 0 )
        {
            DirX := 1
        }
        If ( AimY > 0 )
        {
            DirY := 1
        }
        AimOffsetX := AimX * DirX
        AimOffsetY := AimY * DirY
        MoveX := Floor(( AimOffsetX ** ( 1 / 2 ))) * DirX
        MoveY := Floor(( AimOffsetY ** ( 1 / 2 ))) * DirY
        DllCall("mouse_event", uint, 1, int, MoveX * 2, int, MoveY, uint, 0, int, 0) ;turing mouse to color were it says * is the speed of the aimbot turn up for unhuman reactions lower for human
        ; Add mouse click action (shoot) here
        Click
    }
}

return:
goto, init

Home::
if toggle2 = 0
{
    toggle2 = 1
    Gui Hide
}
Else
{
    toggle2 = 0
    Gui Show
}

action1:
if toggle = 0
{
    toggle = 1
    Gui 2: Hide
}
Else
{
    toggle = 0
    Gui 2: Show
}
return

end::
exitapp
return

Quitter:
ExitApp

GuiClose:
ExitApp

Click:
send {Lbutton down}
sleep, 1
send {lbutton up}
return
