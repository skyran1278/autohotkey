class WinTitleHandler
{
  winTitle := ""
  title := ""
  ahkClass := ""
  ahkId := ""
  ahkPid := ""
  ahkExe := ""
  exe := ""

  __New(winTitle) {
    this.winTitle := winTitle

    ; Define regex patterns for each component
    titlePattern := "^(.*?)\s*(?=ahk_class|ahk_exe|ahk_id|ahk_pid|$)"
    ahkExePattern := "ahk_exe\s+(\S+)"
    ahkClassPattern := "ahk_class\s+(\S+)"
    ahkIdPattern := "ahk_id\s+(\S+)"
    ahkPidPattern := "ahk_pid\s+(\S+)"

    ; Extract title
    if (RegExMatch(this.winTitle, titlePattern, &titleMatch)) {
      this.title := titleMatch[1]
    }

    ; Extract ahk_exe
    if (RegExMatch(this.winTitle, ahkExePattern, &ahkExeMatch)) {
      this.ahkExe := ahkExeMatch[0]
      this.exe := ahkExeMatch[1]
    }

    ; Extract ahk_class
    if (RegExMatch(this.winTitle, ahkClassPattern, &ahkClassMatch)) {
      this.ahkClass := ahkClassMatch[0]
    }

    if (RegExMatch(this.winTitle, ahkIdPattern, &ahkIdMatch)) {
      this.ahkId := ahkIdMatch[0]
    }

    if (RegExMatch(this.winTitle, ahkPidPattern, &ahkPidMatch)) {
      this.ahkPid := ahkPidMatch[0]
    }

    ; MsgBox "title: " this.title "`n" "ahk_exe: " this.ahkExe "`n" "ahk_class: " this.ahkClass "`n" "ahk_id: " this.ahkId "`n" "ahk_pid: " this.ahkPid "`n" "exe: " this.exe "`n" "winTitle: " this.winTitle
  }
}
