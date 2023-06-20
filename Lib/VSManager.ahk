#Include "AppManager.ahk"
#Include "waitAnyAppExist.ahk"

; 管理開發中的 app 的開啟和關閉
; 預計將來可以切換 production 與 dev
; 與 visual studio app 綁定
; 與所開發的 app 解偶
class VSManager extends AppManager
{
  buildErrorWindow := AppManager("ahk_class #32770")
  debuggingMode := AppManager("")
  runningMode := AppManager("")

  __New() {
    super.__New("Microsoft Visual Studio ahk_exe devenv.exe")
    this.debuggingMode := AppManager("(Debugging) - " this.winTitleParameter.winTitle)
    this.runningMode := AppManager("(Running) - " this.winTitleParameter.winTitle)
  }

  isRunning() {
    return WinExist(this.runningMode) != 0 || WinExist(this.debuggingMode) != 0
  }

  ; if build error, close window, then exit.
  handleBuildError() {
    ; side effect: will wait until running or build error to determine if is build error
    ;
    ; 另外一個寫法, 也很不錯, 留著做參考, 由於想要減少直接使用 waitAnyFunctionReturnTrue 所以才用 waitAnyAppExist
    ; 先定義 method
    ; isBuildError() {
    ;   return WinExist(this.buildErrorWindow) != 0
    ; }
    ; index := waitAnyFunctionReturnTrue([ObjBindMethod(this, "isRunning"), ObjBindMethod(this, "isBuildError")])
    ;
    ; 可能 Running 的狀態還保持著, 所以要稍微等一下
    Sleep(100)
    index := waitAnyAppExist([this.buildErrorWindow, this.debuggingMode, this.runningMode])
    If (index == 1) {
      TrayTip("Build Error", "Error", 3)
      ControlClick("&No", this.buildErrorWindow)
      Exit(1)
    }
  }

  startDebugging() {
    If (this.isActive()) {
      builtInVariable := BuiltInVariableHandler()
      builtInVariable.setMenuMaskKey("vkE8")
      ControlSend("{Alt}ds", , this)
    } else {
      ; close 完立刻 Restart 會失敗, 所以要稍微等一下
      Sleep(100)
      ControlSend("{F5}", , this)
    }
    this.handleBuildError()
  }

  stopDebugging() {
    If (this.isRunning()) {
      If (this.isActive()) {
        builtInVariable := BuiltInVariableHandler()
        builtInVariable.setMenuMaskKey("vkE8")
        ControlSend("{Alt}de", , this)
      } else {
        ControlSend("+{F5}", , this)
      }
    }
  }

  restart() {
    If (!this.isRunning()) {
      this.startDebugging()
      return
    }

    If (this.isActive()) {
      builtInVariable := BuiltInVariableHandler()
      builtInVariable.setMenuMaskKey("vkE8")
      ControlSend("{Alt}dr", , this)
    } else {
      ControlSend("^+{F5}", , this)
    }
    this.handleBuildError()
  }
}
