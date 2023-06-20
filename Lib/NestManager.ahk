#Include "waitAnyAppExist.ahk"
#Include "waitAnyFunctionReturnTrue.ahk"
#Include "BuiltInVariableHandler.ahk"
#Include "AppManager.ahk"
#Include "NestMaterial.ahk"

class NestManager extends AppManager
{
  ; ahk_class Afx:00007FF7D2030000:0:0000000000010005:0000000000000000:0000000000000000
  ; ahk_exe RSNEST.exe
  trayTipWindow := AppManager("ahk_exe RSNEST.exe ahk_class .*:0:.*", , "RegEx")

  __New() {
    super.__New("ahk_exe RSNEST.exe", "Menu Bar")
  }

  open() {
    super.open(, "C:\Program Files (x86)\RSNEST")
  }

  restart() {
    this.close()
    this.open()
  }

  ; 有時候會沒做任何事
  openFile(filePath) {
    builtInVariable := BuiltInVariableHandler()
    builtInVariable.setControlDelay(-1)

    ; 為了確保不是在重新啟動程式的階段, 所以要詢問兩次
    waitAnyAppExist(this)
    Sleep(100)
    waitAnyAppExist(this)

    ; MenuSelect 無效, 所以使用 PostMessage
    PostMessage(0x0111, 1004, 0, , this) ; 檔案 -> 開檔 Ctrl+O

    msgWindow := AppManager("RSNEST ahk_exe RSNEST.exe", "提醒: 開檔前需先關檔，是否先存檔?")
    fileWindow := AppManager("開啟 ahk_exe RSNEST.exe")

    index := waitAnyAppExist([msgWindow, fileWindow])
    If (index == 1) {
      ControlClick("否(&N)", msgWindow)
      waitAnyAppExist([fileWindow])
    }
    ControlSetText(filePath, "Edit1", fileWindow)
    ControlClick("開啟(&O)", fileWindow)
  }

  arrangement(nID) {
    builtInVariable := BuiltInVariableHandler()
    builtInVariable.setControlDelay(-1)

    waitAnyAppExist(this)

    PostMessage(0x0111, nID, 0, , this)

    ; 沒有跳出視窗怎辦
    ; 也可以等到 trayTip 出現, 但有兩個原因所以用秒數取代
    ; 1. 會與開檔時也出現 trayTip 衝突, 可以等待消失, 但效能較差
    ; 2. 如果跑很久, 等他跑完也很煩, 想提高效能, 所以用非同步的方式, 不等待結果
    ; this.waitTrayTipDisappear()
    ; index := waitAnyAppExist([msgBoxWindow, this.trayTipWindow], 5)
    msgBoxWindow := AppManager("RSNEST ahk_exe RSNEST.exe", "已排版，是否清空排刀圖?")
    index := waitAnyAppExist([msgBoxWindow], 5)
    If (index == 1) {
      ControlClick("是(&Y)", msgBoxWindow)
    }
  }

  modifyMaterial(material := NestMaterial()) {
    builtInVariable := BuiltInVariableHandler()
    builtInVariable.setControlDelay(-1)

    waitAnyAppExist(this)

    PostMessage(0x0111, 1048, 0, , this) ; 材料 -> 修改材料
    materialWindow := AppManager("修改材料 ahk_exe RSNEST.exe")
    waitAnyAppExist([materialWindow])

    if (material.width != "") {
      ControlSetText(material.width, "Edit3", materialWindow)
    }

    if (material.type != "") {
      ControlChooseString(material.type, "ComboBox7", materialWindow)
    }

    if (material.amount != "") {
      ControlGetPos(&x, &y, &w, &h, "XTPReport1", materialWindow)
      while y < y + h {
        y += h / 10
        ControlClick("X" x + w / 3 * 2 " Y" y, materialWindow, , , , "Pos")
        try {
          ControlGetVisible("Edit20", materialWindow)
          break
        }
      }
      ControlSetText(material.amount, "Edit20", materialWindow)
    }

    ControlClick("確定", materialWindow)
  }

  isTrayTipDisappear() {
    ; 這是一個滿特別的方法, 判斷是否一樣, 保留給以後參考
    ; uniqueID := WinExist(this.trayTipWindow)
    ; thisUniqueID := WinExist(this)
    ; return uniqueID == thisUniqueID

    return !WinExist(this.trayTipWindow)
  }

  waitTrayTipDisappear() {
    waitAnyFunctionReturnTrue([ObjBindMethod(this, "isTrayTipDisappear")])
  }

  waitTrayTip() {
    waitAnyAppExist(this.trayTipWindow)
  }

  zoomIn(count := 1) {
    while (count > 0) {
      PostMessage(0x0111, 1110, 0, , this)
      count--
    }
  }

  doMonoArrangement() {
    ; ini 好像會更改 ID: 1094
    this.arrangement(1093)
  }

  doNestingBlock() {
    this.arrangement(1098)
  }
}
