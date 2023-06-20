class BuiltInVariableHandler
{
  controlDelay := A_ControlDelay
  clipboard := A_Clipboard
  keyDelay := A_KeyDelay
  keyDuration := A_KeyDuration
  matchMode := A_TitleMatchMode
  menuMaskKey := A_MenuMaskKey

  reset() {
    A_Clipboard := this.clipboard
    this.setMenuMaskKey()
    this.setTitleMatchMode()
    this.setControlDelay()
    this.setKeyDelay()
  }

  setMenuMaskKey(key := this.menuMaskKey) {
    A_MenuMaskKey := key
  }

  setTitleMatchMode(matchMode := this.matchMode) {
    SetTitleMatchMode(matchMode)
  }

  setControlDelay(delay := this.controlDelay) {
    SetControlDelay(delay)
  }

  setKeyDelay(delay := this.keyDelay, duration := this.keyDuration) {
    SetKeyDelay(delay, duration)
  }

  __New() {
    A_Clipboard := ""
  }

  __Delete() {
    this.reset()
  }
}
