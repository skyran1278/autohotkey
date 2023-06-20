#Include "BuiltInVariableHandler.ahk"
#Include "waitAnyAppExist.ahk"
#Include "AppManager.ahk"

switchEditor() {
  builtInVariable := BuiltInVariableHandler()
  vscode := AppManager("ahk_exe Code.exe")
  vs := AppManager("Microsoft Visual Studio ahk_exe devenv.exe")
  vsOpenFileWindow := AppManager("Open File ahk_exe devenv.exe")
  vsGoToLineWindow := AppManager("Go To Line ahk_exe devenv.exe")

  If (vscode.isActive()) {
    builtInVariable.setKeyDelay(0, 100)
    ControlSend("+!c", , vscode)
    filePath := A_Clipboard

    builtInVariable.setKeyDelay(0, 50)
    ControlSend("^+p", , vscode)

    ; 有時候會沒有複製到行數, 看起來有正確執行 command line, 還不清楚沒有複製到行數的原因
    builtInVariable.setKeyDelay(10, -1)
    ControlSend("Tasks: Run Task", , vscode)

    builtInVariable.setKeyDelay(0, 50)
    ControlSend("{Enter}", , vscode)
    ControlSend("{Enter}", , vscode)

    ; vs.activate()
    ControlSend("^o", , vs)
    waitAnyAppExist(vsOpenFileWindow)
    ControlSetText(filePath, "Edit1", vsOpenFileWindow)
    builtInVariable.setControlDelay(-1)
    ControlClick("&Open", vsOpenFileWindow)

    ; 沒有開啟搜尋框
    ; 只有開啟檔案或在編輯器貼上文字
    Sleep(1000)
    ControlSend("^g", , vs)

    ; 有啟動搜尋框, 但在編輯器貼上文字
    ; 推測為 ^v 先到, ^f 後到
    Sleep(100)

    builtInVariable.setKeyDelay(0, 100)
    ControlSend("^v", , vsGoToLineWindow)
    builtInVariable.setKeyDelay(0, 50)

    ControlSend("{Enter}", , vsGoToLineWindow)
  } else {
    builtInVariable.setKeyDelay(0, 50)
    ControlSend("^c", , vs)
    line := A_Clipboard

    ; 在編輯器輸入大寫 C
    Sleep(200)
    ControlSend("+!c", , vs)

    vscode.activate()

    ControlSend("^p", , vscode)
    ControlSend("^v", , vscode)
    ControlSend("{Enter}", , vscode)

    ; 沒有開啟搜尋框
    ; 1. 只有開啟檔案或
    ; 2. 在編輯器貼上文字
    ; 3. 編輯器原本有開啟但沒有反選文字
    Sleep(100)
    ControlSend("^f", , vscode)
    A_Clipboard := line
    ControlSend("^v", , vscode)
  }
}
