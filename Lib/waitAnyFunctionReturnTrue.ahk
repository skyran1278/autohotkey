waitAnyFunctionReturnTrue(functions, timeOut := -1) {
  ; https://www.autohotkey.com/boards/viewtopic.php?t=63999
  times := 0
  While (true) {
    Loop functions.Length {
      If (functions[A_Index]()) {
        return A_Index
      }
    }

    Sleep(100)
    times += 100
    If (timeOut >= 0 && times > timeOut * 1000) {
      return -1
    }
  }
}
