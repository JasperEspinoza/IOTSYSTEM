@echo off
title Deploy Dashboard to Firebase Hosting
cd /d "%~dp0"

echo ======================================================
echo    Deploying to Firebase Hosting (Production)
echo    Project: classroom-monitoring-sys-3a0b0
echo ======================================================
echo.

where firebase >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Firebase CLI is not found in PATH!
    echo Run: npm install -g firebase-tools
    pause
    exit /b 1
)

echo [1/2] Checking Firebase login status...
call firebase login --interactive

echo.
echo [2/2] Deploying hosting files...
call firebase deploy --only hosting

echo.
echo ======================================================
echo  Deployment complete!
echo  Your live dashboard URL:
echo  https://classroom-monitoring-sys-3a0b0.web.app
echo ======================================================
pause
