stretchly(command) {
  localAppData := EnvGet("LOCALAPPDATA")
  Run(localAppData . "\Programs\Stretchly\stretchly.exe " . command)
}
