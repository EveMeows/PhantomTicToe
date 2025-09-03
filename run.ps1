if (-not (Get-Command "luajit" -ErrorAction SilentlyContinue)) {
  Write-Host "Lua is not installed or not in PATH." -ForegroundColor Red
  exit 1
}

luajit main.lua
