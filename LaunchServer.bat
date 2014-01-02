@ECHO OFF

:: Maximum amount of Ram to use to run the server. Limited at 1582M for 32 Bit Java
set MAXRAM32=1G
set MAXRAM64=2G

:: Don't edit past this point :: Don't edit past this point :: Don't edit past this point ::

set JVM_VERSION=""
if $SYSTEM_os_arch==x86 (
  set JVM_VERSION=32
) else (
  set JVM_VERSION=64
)

set TEMP_FILE=%TEMP%\javaCheck%RANDOM%%TIME:~9,5%.txt

java -version 2>%TEMP_FILE%
FOR /F "tokens=*" %%i in (%TEMP_FILE%) do (
  echo %%i | find "HotSpot" >nul
  if not errorlevel 1 (
    echo %%i | find "64-Bit" >nul
    if not errorlevel 1 (
      set JVM_VERSION=64
    ) else (
      set JVM_VERSION=32
    )
  )
)

del %TEMP_FILE%

if %JVM_VERSION%==32 (
echo Detected 32 Bit Java
java -Xmx%MAXRAM32% -XX:MaxPermSize=256M -jar forge-1.6.4-9.11.1.953-universal.jar nogui
) else (
echo Detected 64 Bit Java
java -Xmx%MAXRAM64% -XX:MaxPermSize=256M -jar forge-1.6.4-9.11.1.953-universal.jar nogui
)
PAUSE
