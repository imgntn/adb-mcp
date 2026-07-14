@echo off
echo ========================================
echo After Effects MCP Plugin Installer
echo ========================================
echo.
echo This script will create a symbolic link for the After Effects CEP plugin.
echo You need to run this as Administrator OR have Developer Mode enabled.
echo.
pause

REM Create CEP extensions directory if it doesn't exist
if not exist "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions" (
    echo Creating CEP extensions directory...
    mkdir "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions"
)

REM Create symbolic link
echo Creating symbolic link...
mklink /D "C:\Users\%USERNAME%\AppData\Roaming\Adobe\CEP\extensions\com.mikechambers.ae" "%~dp0cep\com.mikechambers.ae"

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo SUCCESS!
    echo ========================================
    echo Plugin installed successfully.
    echo You can now launch After Effects and access the plugin via:
    echo Window ^> Extensions ^> After Effects MCP Agent
) else (
    echo.
    echo ========================================
    echo ERROR!
    echo ========================================
    echo Failed to create symbolic link.
    echo Please try one of the following:
    echo 1. Run this script as Administrator ^(right-click ^> Run as administrator^)
    echo 2. Enable Developer Mode in Windows Settings ^> Update ^& Security ^> For developers
)

echo.
pause
