@echo off
echo ========================================
echo Adobe MCP Proxy Server
echo ========================================
echo.
echo Starting proxy server on ws://localhost:3001
echo Keep this window open while using Adobe MCP tools
echo Press Ctrl+C to stop the server
echo.
echo ========================================
echo.

cd /d "%~dp0adb-proxy-socket"
node proxy.js

pause
