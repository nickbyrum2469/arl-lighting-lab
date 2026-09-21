@echo off
setlocal
cd /d "%~dp0"
where py >nul 2>nul
if %errorlevel%==0 (
  start "ARL v1.8 Server" cmd /k py -m http.server 8765
) else (
  where python >nul 2>nul
  if %errorlevel%==0 (
    start "ARL v1.8 Server" cmd /k python -m http.server 8765
  ) else (
    echo Python was not found. Opening index.html directly instead.
    start "" "%~dp0index.html"
    exit /b
  )
)
timeout /t 2 /nobreak >nul
start "" "http://127.0.0.1:8765/index.html"
endlocal
