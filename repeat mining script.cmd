@echo off
@set repeat=999
@set interval=2
@set count=0

goto main

::::::::::::::::::::::::::::::::::::::::::::
:run
    echo run.exe2 %count%
    echo Error occured in %date%%time% >> log.txt

    goto:eof
::::::::::::::::::::::::::::::::::::::::::::


:main
    cd /d "%~dp0"
    set /a "count=%count%+1"

    :: the main program start here
    call:run
    :: end of program

    if %count% EQU %repeat% (
	    REM echo Exit...
    ) else (
	    echo Try again in %interval% seconds...
	    timeout /t %interval% > nul
	    goto main
    )

    pause



















