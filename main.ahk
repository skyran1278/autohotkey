#Requires AutoHotkey v2.0
#SingleInstance Force
SendMode "Input"
SetWorkingDir A_ScriptDir
CoordMode "Mouse", "Client"

#Include "Lib\AppManager.ahk"
#Include "Lib\VSManager.ahk"
#Include "Lib\NestManager.ahk"
#Include "Lib\turnOffMonitor.ahk"
#Include "Lib\stretchly.ahk"
#Include "Lib\switchEditor.ahk"
#Include "Lib\NestMaterial.ahk"
#Include "Lib\switchTheme.ahk"

global ENV := "dev" ; dev | prod | test
global ERROR_MESSAGE := ""
global INFO_MESSAGE := ""

test1() {
  vs := VSManager()
  vs.restart()

  nest := NestManager()
  nest.openFile("C:\D\Project\RsNEST_V14x64\RSNEST_V14\RSNEST_Test\test\Testcase_左右配刀_系統自動+人工微調.RSN")

  material := NestMaterial()
  material.width := "10000 cm"
  material.type := "塊狀"
  material.amount := "200"
  nest.modifyMaterial(material)

  nest.doNestingBlock()
}

test2() {
  nest := NestManager()
  nest.doNestingBlock()
}

ci() {
  ; Keyhistory
  nest := NestManager()

  vs := VSManager()
  vs.restart()

  startTime := A_TickCount

  nest.openFile("C:\D\Project\RsNEST_V14x64\RSNEST_V14\RSNEST_Test\test\Testcase_左右配刀_系統自動+人工微調+大檔案1.RSN")
  nest.waitTrayTipDisappear()
  nest.doNestingBlock()
  nest.waitTrayTip()
  Run("Snipaste snip --active-window -o quick-save")
  Sleep 1000

  nest.openFile("C:\D\Project\RsNEST_V14x64\RSNEST_V14\RSNEST_Test\test\Testcase_左右配刀_系統自動+人工微調+大檔案2.RSN")
  nest.waitTrayTipDisappear()
  nest.doNestingBlock()
  nest.waitTrayTip()
  Run("Snipaste snip --active-window -o quick-save")
  Sleep 1000

  nest.openFile("C:\D\Project\RsNEST_V14x64\RSNEST_V14\RSNEST_Test\test\Testcase_左右配刀_系統自動+人工微調+大檔案3.RSN")
  nest.waitTrayTipDisappear()
  nest.doNestingBlock()
  nest.waitTrayTip()
  Run("Snipaste snip --active-window -o quick-save")
  Sleep 1000

  nest.openFile("C:\D\Project\RsNEST_V14x64\RSNEST_V14\RSNEST_Test\test\Testcase_左右配刀_系統自動+人工微調+大檔案4.RSN")
  nest.waitTrayTipDisappear()
  nest.doNestingBlock()
  nest.waitTrayTip()
  Run("Snipaste snip --active-window -o quick-save")
  Sleep 1000

  nest.openFile("C:\D\Project\RsNEST_V14x64\RSNEST_V14\RSNEST_Test\test\Testcase_左右配刀_系統自動+人工微調+大檔案5.RSN")
  nest.waitTrayTipDisappear()
  nest.doNestingBlock()
  nest.waitTrayTip()
  Run("Snipaste snip --active-window -o quick-save")
  Sleep 1000

  endTime := A_TickCount
  elapsedTime := (endTime - startTime) / 1000
  TrayTip "執行時間", Format("= {1:0.3f}s", elapsedTime)
}

; !1:: test1()
; !2:: test2()
; !3:: ci()

; !q:: {
;   vs := VSManager()
;   vs.restart()
; }
; !w:: {
;   notepad := AppManager("ahk_exe Notepad.exe")
;   notepad.close()
; }
; !e:: {
;   vs := VSManager()
;   vs.stopDebugging()
; }
; !o:: {
;   vs := VSManager()
;   vs.startDebugging()
; }
; !s:: switchEditor()
!r:: Reload
!t:: turnOffMonitor()
!m:: stretchly("mini")
!l:: stretchly("long")
!d:: switchTheme()
; F6:: {
;   stretchly("toggle")
;   Run("Snipaste toggle-hotkeys")
; }
