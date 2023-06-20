#Include "WinTitleHandler.ahk"
#Include "BuiltInVariableHandler.ahk"

; 之所以取名叫做 App Manager, 而不叫 Window Manager, 是因為這個類別不會處理 Window 的位置、大小、顏色、圖片等等
; 這個類別只會處理 App 的開啟、關閉、重啟、是否存在、是否 Activate 等等
class AppManager
{
  __New(winTitle, winText := "", titleMatchMode := A_TitleMatchMode) {
    ; 之所以叫 winTitleParameter 是因為包含了 winTitle, title, ahk_exe, ...
    this.winTitleParameter := WinTitleHandler(winTitle)
    this.winText := winText
    this.titleMatchMode := titleMatchMode
  }

  Hwnd {
    get {
      builtInVariable := BuiltInVariableHandler()
      builtInVariable.setTitleMatchMode(this.titleMatchMode)
      return WinExist(this.winTitleParameter.winTitle, this.winText)
    }
  }

  ; WinActivate 不太可靠，不推薦依賴程式是否 Activate
  ; 因為使用者正在操作時，容易把 Activate 變成 not Activate
  activate() {
    if (WinExist(this)) {
      WinActivate ; Use the window found by WinExist.
      return true
    }
    return false
  }

  isActive() {
    uniqueID := WinActive("A")
    appID := WinActive(this)
    return uniqueID == appID
  }

  open(target := this.winTitleParameter.exe, workingDir := "") {
    Run(target, workingDir)
  }

  close() {
    While WinExist(this) {
      WinKill ; 關檔
    }
  }

  restart() {
    this.close()
    this.open()
  }

  waitAnyTextsVisible(visibleTexts, timeOut := 100) {
    ; https://www.autohotkey.com/boards/viewtopic.php?t=63999
    times := 0
    While (true) {
      Loop visibleTexts.Length {
        Try {
          ControlGetVisible(visibleTexts[A_Index], this)
          return A_Index
        } Catch {
          ; ControlGetVisible() will throw an error if the control is not found
          ; so we just ignore it
        }
      }

      Sleep(100)
      times += 100
      If (times > timeOut * 1000) {
        return -1
      }
    }
  }
}
