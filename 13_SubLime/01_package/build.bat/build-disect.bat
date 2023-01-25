@echo off

set FN=build.bat



echo "%~dpnx0"
echo "%~d0"
echo "%CD%\%FN%"
echo %1

rem if "%~dpnx0" == "%CD%\%FN%" (
rem 	goto exit
rem )




:repeat
if exist "%CD%\%FN%" (
	call "%CD%\%FN%" %1
	goto exit
) else (
	if "%~d0\" == "%CD%" (
		goto exit
	) else (
		cd ..
		goto repeat
	)
)

:exit