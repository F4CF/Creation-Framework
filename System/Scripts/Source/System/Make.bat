@ECHO OFF

REM System.esl
CALL "..\System\Build.bat"
CALL "..\System.Diagnostics\Build.bat"
CALL "..\System.Objects\Build.bat"

REM System.XSE.esl
CALL "..\System.XSE\Build.bat"
CALL "..\System.UI\Build.bat"

REM Scripting.esl
CALL "..\Scripting\Build.bat"
