#Include "waitAnyFunctionReturnTrue.ahk"

waitAnyAppExist(apps, timeOut := -1) {
  If (Type(apps) != "Array") {
    apps := [apps]
  }
  functions := apps.Clone()
  Loop apps.Length {
    function() {
      return WinExist(apps[A_Index])
    }
    functions[A_Index] := function
  }
  return waitAnyFunctionReturnTrue(functions, timeOut)
}
