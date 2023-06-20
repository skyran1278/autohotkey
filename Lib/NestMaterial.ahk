#Include "BuiltInVariableHandler.ahk"
#Include "waitAnyAppExist.ahk"
#Include "AppManager.ahk"

class NestMaterial {
  width := ""
  height := ""
  type := ""
  amount := ""

  ; __New(mainWindow) {
  ;   this.mainWindow := mainWindow
  ; }

  ; apply() {
  ;   builtInVariable := BuiltInVariableHandler()
  ;   builtInVariable.setControlDelay(-1)

  ;   waitAnyAppExist(this.mainWindow)

  ;   PostMessage(0x0111, 1048, 0, , this.mainWindow) ; 材料 -> 修改材料
  ;   materialWindow := AppManager("修改材料 ahk_exe RSNEST.exe")
  ;   waitAnyAppExist([materialWindow])

  ;   if (this.width != "") {
  ;     ControlSetText(this.width, "Edit3", materialWindow)
  ;   }

  ;   if (this.type != "") {
  ;     ControlSetText(this.type, "Edit18", materialWindow)
  ;   }

  ;   if (this.amount != "") {
  ;     ControlGetPos(&x, &y, &w, &h, "XTPReport1", materialWindow)
  ;     while y < h {
  ;       ControlClick("X" x + w / 3 * 2 " Y" y, materialWindow, , , , "Pos")
  ;       try {
  ;         ControlGetVisible("Edit20", materialWindow)
  ;         break
  ;       }
  ;       y += h / 10
  ;     }
  ;     ControlSetText(this.amount, "Edit20", materialWindow)
  ;   }

  ;   ControlClick("確定", materialWindow)
  ; }
}
