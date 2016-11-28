; CONFIG DU SCRIPT AHK
#NoEnv
#Singleinstance force
#Persistent
CoordMode, Pixel, Screen
CoordMode, Mouse, Screen
SendMode, Input
SetKeyDelay, 60, 60

; INCLUDE
#Include config.ahk
#Include func-drag.ahk
#Include func-loot.ahk
#Include functions.ahk
#Include func-fightloop.ahk
#Include func-fightend.ahk
#Include func-pveloby.ahk
; #Include gui.ahk ; testing


; LANCE LE BOT ->
sMsg = START INFINITE LOOP
if ( iAutoStart == 1 ) {
	sMsg = START INFINITE LOOP - AUTO START
	Sleep 5000
	iStatus = 1
}
displaymsg(sMsg)

iReset := 1000 * 60 * 45
settimer, Reset, %iReset%
goto Restart

; #Include tool-mousepos.ahk

; TOUCHES POUR PILOTER LE BOT
F1::
	settimer, Rootage, off
	if ( iStatus == 1 ) {
		iStatus = 0
		goto Restart
	} else {
		iRestartTotal = 0
		iStatus = 1
		goto Restart2
	}
return
F2::
	if ( iLogSize == 1 )
		iLogSize = 0
	else
		iLogSize = 1
	displaymsg2()
return
F5::
	settimer, Rootage, off
	displaymsg("F5 KEY -> RELOADING SCRIPT")
	iStatus = 0
	Sleep 1500
	Reload
	Sleep 3333
return
F6::
	settimer, Rootage, off
	MouseGetPos, xpos, ypos
	PixelGetColor, color, %xpos%, %ypos%
	sMsg = MOUSE X.Y -> %xpos%.%ypos% COLOR -> %color%
	displaymsg(sMsg)
	iColorX = %xpos%
	iColorY = %ypos%
	iColorFail = 0
	iColorFail2 = 0
	iColorOk = 0
	color = %color%
	color2 = NA
	iColorLast = NA
	iStatus = 2
	goto Restart
return


; FORCE START SANS CD
Restart2:
	settimer, Rootage, off
	settimer, Rootage, 1
return

Reset:
	settimer, Rootage, off
	displaymsg("F5 KEY -> RELOADING SCRIPT")
	iStatus = 0
	Sleep 1500
	Reload
	Sleep 3333
return

; QUITTE TOUTES LES APP OUVERTES
ExitAll:
	clickback(1)
	settimer, Rootage, off
	settimer, Rootage, %iWait%
return

; FONCTION QUI RELANCE LA BOUCLE
Restart:
	settimer, Rootage, off
	settimer, Rootage, %iWait%
return

; FONCTION PRINCIPALE DU SCRIPT
Rootage:
	iRestartTotal++
	; STOP SI STATUS OFF
	if (iStatus == 0) {
		goto Restart
	} else if ( iStatus == 2 ) {
		PixelGetColor, color2, %iColorX%, %iColorY%
		if ( color == color2 )
			iColorOk++
		else if ( iColorFail == 0 || color2 == iColorLast )
		{
			iColorLast = %color2%
			iColorFail++
		}
		else
			iColorFail2++
		iTotal := % iColorFail + iColorOk + iColorFail2
		iColorOkP := round((iColorOk / iTotal) * 100, 1)
		iColorFailP := round((iColorFail / iTotal) * 100, 1)
		iColorFail2P := round((iColorFail2 / iTotal) * 100, 1)
		sMsg = %iColorX%.%iColorY% [%color% - %iColorLast% - %color2%] [%iColorOk% %iColorFail% %iColorFail2%] [%iColorOkP% %iColorFailP% %iColorFail2P%] /%iTotal%
		displaymsg( sMsg )
		goto Restart
	}
	
	sMsg = GAME ********************************[  %iRestartTotal%  ]******************************** LOOP
	displaymsg(sMsg)
	
	#Include test.ahk
	
	#Include mobizen-window.ahk
	
	lockdecrement()
	
	; displaymsg("??????????????????????????? BASE ???????????????????????????")
	#Include screen-base.ahk
	if (iStatus != 1)
		goto Restart
	; displaymsg("??????????????????????????? MAP ???????????????????????????")
	#Include screen-map.ahk
	if (iStatus != 1)
		goto Restart
	; displaymsg("??????????????????????????? PVP ???????????????????????????")
	#Include screen-pvp.ahk
	if (iStatus != 1)
		goto Restart
	; displaymsg("??????????????????????????? RIVAL ???????????????????????????")
	#Include screen-rival.ahk
	if (iStatus != 1)
		goto Restart
	
	iAgain = 1
	iRestartNow = 0
	Loop {
		; displaymsg("??????????????????????????? PVELOBY ???????????????????????????")
		if (pveloby() == 1)
			iAgain += 2
	if (iStatus != 1)
		goto Restart
		; displaymsg("??????????????????????????? FIGHT LOOP ???????????????????????????")
		if (fightloop() == 1)
			iAgain += 2
	if (iStatus != 1)
		goto Restart
		; displaymsg("??????????????????????????? FIGHT END ???????????????????????????")
		if (fightend() == 1)
			iAgain += 2
	if (iStatus != 1)
		goto Restart
		if (iAgain == 1)
			break
		else
			iRestartNow = 1
		iAgain--
		lockdecrement()
	}
	if ( iRestartNow == 1 )
		goto Restart
	
	
	#Include screen-rareevent.ahk
	if (iStatus != 1)
		goto Restart

	sMsg = LOOP OVER, STILL IN RARE EVENT MODE, CLICK BACK
	displaymsg(sMsg)
	goto ExitAll
return