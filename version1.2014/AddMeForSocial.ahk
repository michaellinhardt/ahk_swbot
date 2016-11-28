#NoEnv
#Singleinstance force
#Include getPixel.ahk
#Persistent
CoordMode, Pixel
SetKeyDelay, 60, 60
iStatus = 0 ; iStatus 0 = OFF
iReload = 0 ; DEMANDE UN RECHARGEMENT DU SCRIPT APRES ARRET
iWait = 2500 ; TEMPS D'ATTENTE AVANT UNE NOUVELLE BOUCLE
iCanal = 0
iMsg = LOADING DU SCRIPT
goto Restart

F4::
	; RACCOURCIS 0 = OFF
	iStatus = 0
	iReload = 1
return

F1::
	; RACCOURCIS 1 = ON
	if ( iReload = "1" ) {
		Reload
		Sleep 1000
	}
	iMsg = DEMARRAGE
	msgSplash = %iMsg%
	SplashTextOn, 400, 1, %msgSplash%, a
	WinMove, %msgSplash%, , 5, 5
	iStatus = 1
return

Restart:
	msgSplash = %iMsg%
	SplashTextOn, 400, 1, %msgSplash%, a
	WinMove, %msgSplash%, , 5, 5
	; FONCTION QUI RELANCE LA BOUCLE
	settimer, Rootage, %iWait%
return

Rootage:
	; FONCTION DE ROOTAGE QUI DETECT OU L'ON SE TROUVE DANS SW
	settimer, Rootage, off
	
	if (iStatus = "0") {
		goto Restart
	}
	
	

	Click 320, 75 ; click champs text
	Sleep 1500
	Send Qdd 
	sleep 300
	Send % Chr(32)
	Send % Chr(59)
	Send e lvl 40
	Send % Chr(32) ; espace
	sleep 300
	Send only
	Sleep 300
	Click 590, 555 ; clic sur envoyer
	Sleep 1500
	Click 712, 579 ; click sur canal
	Sleep 700
	iCanal++
	Send {Raw}%iCanal%
	Sleep 700
	Click 545, 551 ; Click sur envoyer 2
	Sleep 700
	
	goto Restart
return