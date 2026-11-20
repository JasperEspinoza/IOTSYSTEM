@echo off
title ESP32 IoT Classroom Monitoring System
cd /d "%~dp0"

echo ======================================================
echo    ESP32 Classroom IoT Monitoring Dashboard
echo ======================================================
echo.

:: Check if Node.js is installed
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Node.js is not found in your system PATH!
    echo Please install Node.js from https://nodejs.org/ to run the server.
    echo.
    echo Attempting Python fallback server...
    where python >nul 2>nul
    if %ERRORLEVEL% EQU 0 (
        echo [INFO] Starting Python HTTP server on port 3000...
        timeout /t 2 /nobreak >nul
        start http://localhost:3000
        python -m http.server 3000
    ) else (
        echo [ERROR] Neither Node.js nor Python were found.
        pause
        exit /b 1
    )
    exit /b 0
)

echo [1/2] Launching dashboard server on http://localhost:3000 ...

:: Launch browser after a short delay in the background
start "" cmd /c "timeout /t 2 /nobreak >nul & start http://localhost:3000"

echo [2/2] Opening your default web browser...
echo.
echo ======================================================
echo  Dashboard URL: http://localhost:3000
echo  Press Ctrl+C in this window anytime to stop the server.
echo ======================================================
echo.

:: Run the Node.js server
node server.js

pause

