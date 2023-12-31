﻿#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.
FileEncoding UTF-8-RAW
CoordMode, Mouse, Client

activateRB() {
    if WinExist("ahk_exe RCAD_Building.exe") {
        WinActivate ; Use the window found by WinExist.
        return true
    }
    return false
}

open(rb_path, dwg_path, excel_path) {
    if (!activateRB())
        return
    ; 登入
    Send, {enter}
    Sleep, 1000
    activateRB()
    Send, {enter}
    Sleep, 5000

    if (!activateRB())
        return
    Send, ^o ; 開啟舊檔
    Sleep, 1000

    Send, {Blind}{Text}%rb_path%
    Send, {enter}
    Send, {enter}
    Sleep, 2000

    if (!activateRB())
        return
    Click, 360, 70 ; OK
    Sleep, 4000

    activateRB()
    Click, right, 200, 85 ; 右鍵 檔名
    Click, 300, 130 ; 展開
    Sleep, 1000

    activateRB()
    Click, right, 200, 160 ; 右鍵 配筋-柱
    Click, 300, 220 ; 科建 SRC2.1
    Click, 600, 260 ; 科建 SRC2.1
    Sleep, 1000

    activateRB()
    Click, 400, 110 ; 匯入 excel
    Click, 400, 110 ; read
    Sleep, 1000

    Send, {Blind}{Text}%excel_path%
    Send, {enter}
    Send, {enter}
    Sleep, 3000

    activateRB()
    Click, 450, 60 ; exit
    Sleep, 2000

    activateRB()
    Click, 400, 150 ; 匯入結構平面圖

    Send, {Blind}{Text}%dwg_path%
    Send, {enter}
    Send, {enter}
    Sleep, 1000

    if WinExist("ahk_exe notepad.exe") {
        WinKill ; 關檔
        Sleep, 1000
    }

    activateRB()
}

!1::
    start_time := A_TickCount

    rb_path := "D:\GitHub\autohotkey\RB\2021-0423 科建 SRC2.1\2021-0423 科建 SRC2.1.rb"

    ; excel_path := "D:\GitHub\autohotkey\RB\2021-0423 科建 SRC2.1\2021-0423 科建 SRC2.1.xlsx"
    ; dwg_path := "D:\GitHub\autohotkey\RB\2021-0423 科建 SRC2.1\2021-0423 科建 SRC2.1.dwg"

    ; excel_path := "D:\GitHub\autohotkey\RB\2021-0423 科建 SRC2.1\2021-0428 科建 SRC2.1.xlsx"
    ; dwg_path := "D:\GitHub\autohotkey\RB\2021-0423 科建 SRC2.1\2021-0428 科建 SRC2.1.dwg"

    ; excel_path := "D:\GitHub\autohotkey\RB\2021-0423 科建 SRC2.1\2021-0423 科建 SRC2.1.xlsx"
    ; dwg_path := "D:\GitHub\autohotkey\RB\2021-0423 科建 SRC2.1\2021-0504 科建 SRC2.1.dwg"

    excel_path := "D:\GitHub\autohotkey\RB\2021-0423 科建 SRC2.1\2021-0428 科建 SRC2.1.xlsx"
    dwg_path := "D:\GitHub\autohotkey\RB\2021-0423 科建 SRC2.1\2021-0505 科建 SRC2.1.dwg"

    open(rb_path, dwg_path, excel_path)

    elapsed_time := (A_TickCount - start_time) / 1000

    TrayTip 執行時間, % elapsed_time . "s"
Return

!r::Reload

!x::ExitApp

!w::
    While WinExist("ahk_exe notepad.exe") {
        WinKill ; 關檔
    }
Return
