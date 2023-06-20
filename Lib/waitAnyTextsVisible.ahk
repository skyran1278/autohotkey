#Include "waitAnyFunctionReturnTrue.ahk"

; @brief
;   需求
;     可能開啟視窗, 原本內建的 winTitles 會不一樣, 所以要增加 winTitles 參數
;     可能兩個視窗的 winTitles 一樣, 所以要增加 winTexts 參數
;     如果 winTitles 不一樣了, winTexts 也不用原本的了
; @param Array visibleTexts
; @param Array | String winTitles
; @param Array | String winTexts
; @param Array | String excludeTitles
; @param Array | String excludeTexts
; @param Number timeOut
; @return Number -1 for not found, otherwise the index of the visible text
waitAnyTextsVisible(visibleTexts, winTitles, winTexts := "", excludeTitles := "", excludeTexts := "", timeOut := -1) {
  ; Validate the visibleTexts parameter
  If (Type(visibleTexts) != "Array") {
    throw "visibleTexts parameter must be an array"
  }

  If (Type(winTitles) != "Array") {
    winTitles := [winTitles]
  }
  If (winTitles.Length != visibleTexts.Length) {
    winTitle := winTitles[1]
    winTitles := visibleTexts.Clone()
    Loop visibleTexts.Length {
      winTitles[A_Index] := winTitle
    }
  }

  If (Type(winTexts) != "Array") {
    winTexts := [winTexts]
  }
  If (winTexts.Length != visibleTexts.Length) {
    winText := winTexts[1]
    winTexts := visibleTexts.Clone()
    Loop visibleTexts.Length {
      winTexts[A_Index] := winText
    }
  }

  If (Type(excludeTitles) != "Array") {
    excludeTitles := [excludeTitles]
  }
  If (excludeTitles.Length != visibleTexts.Length) {
    excludeTitle := excludeTitles[1]
    excludeTitles := visibleTexts.Clone()
    Loop visibleTexts.Length {
      excludeTitles[A_Index] := excludeTitle
    }
  }

  If (Type(excludeTexts) != "Array") {
    excludeTexts := [excludeTexts]
  }
  If (excludeTexts.Length != visibleTexts.Length) {
    excludeText := excludeTexts[1]
    excludeTexts := visibleTexts.Clone()
    Loop visibleTexts.Length {
      excludeTexts[A_Index] := excludeText
    }
  }

  functions := visibleTexts.Clone()
  Loop visibleTexts.Length {
    function() {
      Try {
        ControlGetVisible(visibleTexts[A_Index], winTitles[A_Index], winTexts[A_Index], excludeTitles[A_Index], excludeTexts[A_Index])
        return true
      } Catch {
        return false
      }
    }
    functions[A_Index] := function
  }
  return waitAnyFunctionReturnTrue(functions, timeOut)
}
