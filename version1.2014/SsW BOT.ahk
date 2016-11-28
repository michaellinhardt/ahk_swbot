; **************************
; CONFIG DU SCRIPT AHK
; **************************
#NoEnv
#Singleinstance force
#Include getPixel.ahk
#Persistent
CoordMode, Pixel
SendMode, Input
SetKeyDelay, 60, 60
; **************************
; CONFIG INTERNE DU BOT
; **************************
iStatus = 0
iSummon = 0
iRune = 0
iReload = 0 ; DEMANDE UN RECHARGEMENT DU SCRIPT APRES ARRET
iRuntime = 0 ; CALCULE LE TEMPS DEPUIS LE DERNIER LANCEMENT DU SCRIPT
iLootmanaMax = 15 ; LOOT LE MANA TOUTE LES X MINUTES
iArene = 0 ; NA PAS FAIS DARENE ENCORE
iSwitchReq = 0 ; PARAM SYSTEM ! 1 = CHANGER DE COMPTE MAINTENANT
iWait = 1000 ; TEMPS D'ATTENTE AVANT UNE NOUVELLE BOUCLE
iWaitNoenergy = 300000 ; 5 min
iLootmana = 1900000 ; CALCULE LE TEMPS DEPUIS LE DERNIER LOOT DE MANA
iLootmana1 = %iLootmana%
iLootmana2 = %iLootmana%
iWaitCombat = 0
; **************************
; SYSTEME DE MESSAGE
; **************************
iMsg = LOADING SCRIPT
msgSplash = RT(%iRuntimeDisplay%) ACC(%iCurrentAcc%) LM1(%iLootmanaDisplay1%) LM2(%iLootmanaDisplay2%) - %iMsg%
SplashTextOn, 400, 1, %msgSplash%, a
WinMove, %msgSplash%, , 5, 5

; **************************
; CONFIG MULTIACCOUNT
; **************************
iSwitchAcc = 0 ; SI LE BOT DOIS CHANGER DACCOUNT QUAND PLUS DENERGY ?
iCurrentAcc = 1 ; LE COMPTE EN COURS (1 = MAIN) !

; **************************
; CONFIG COMPTE 1
; **************************
iRune4star1 = 0 ; GARDE LES RUNE 4 ETOILES
iRune3star1 = 0 ; GARDE LES RUNE 3 ETOILES
	; 1 = ENERGY	; 2 = FATALE	; 3 = BLADE
	; 4 = RAGE		; 5 = RAPIDE	; 6 = FOCUS
	; 7 = GARDIEN	; 8 = ENDURENCE	; 9 = VIOLENT
iZone1 = 3
iStage1 = 6
iDifficulty1 = 3

; **************************
; CONFIG COMPTE 2
; **************************
iRune4star2 = 1 ; GARDE LES RUNE 4 ETOILES
iRune3star2 = 1 ; GARDE LES RUNE 3 ETOILES
	; 1 = ENERGY	; 2 = FATALE	; 3 = BLADE
	; 4 = RAGE		; 5 = RAPIDE	; 6 = FOCUS
	; 7 = GARDIEN	; 8 = ENDURENCE	; 9 = VIOLENT
iZone2 = 2
iStage2 = 2 ; de 1 à 7
iDifficulty2 = 2 ; 1 à 3 (normal - hard - hell)

; LANCE LE BOT ->
goto Restart

; **************************
; TOUCHES POUR PILOTER LE BOT
; **************************
F1::
	iMsg = MODE BATAILLE
	msgSplash = RT(%iRuntimeDisplay%) ACC(%iCurrentAcc%) LM1(%iLootmanaDisplay1%) LM2(%iLootmanaDisplay2%) - %iMsg%
	SplashTextOn, 400, 1, %msgSplash%, a
	WinMove, %msgSplash%, , 5, 5

	iStatus = 1
	iSummon = 0
	iRune = 0
return
F2::
	iMsg = SUMMON BOUCLE
	msgSplash = RT(%iRuntimeDisplay%) ACC(%iCurrentAcc%) LM1(%iLootmanaDisplay1%) LM2(%iLootmanaDisplay2%) - %iMsg%
	SplashTextOn, 400, 1, %msgSplash%, a
	WinMove, %msgSplash%, , 5, 5

	iStatus = 0
	iSummon = 1
	iRune = 0
return
F3::
	iMsg = UPGRADE RUNE
	msgSplash = RT(%iRuntimeDisplay%) ACC(%iCurrentAcc%) LM1(%iLootmanaDisplay1%) LM2(%iLootmanaDisplay2%) - %iMsg%
	SplashTextOn, 400, 1, %msgSplash%, a
	WinMove, %msgSplash%, , 5, 5

	iStatus = 0
	iSummon = 0
	iRune = 1
return
F4::
	iMsg = STATUS OFF
	msgSplash = RT(%iRuntimeDisplay%) ACC(%iCurrentAcc%) LM1(%iLootmanaDisplay1%) LM2(%iLootmanaDisplay2%) - %iMsg%
	SplashTextOn, 400, 1, %msgSplash%, a
	WinMove, %msgSplash%, , 5, 5

	iStatus = 0
	iSummon = 0
	iRune = 0

	settimer, Rootage, off
	goto Restart
return
F5::
	Reload
	Sleep 1000
return

; **************************
; FONCTION QUI RELANCE LA BOUCLE
; **************************
Restart:
	if (iCurrentAcc = "1") {
		iLootmana1 = %iLootmana%
	}
	if (iCurrentAcc = "2") {
		iLootmana2 = %iLootmana%
		iLootmana2 = 0
	}

	msgSplash = RT(%iRuntimeDisplay%) ACC(%iCurrentAcc%) LM1(%iLootmanaDisplay1%) LM2(%iLootmanaDisplay2%) - %iMsg%
	SplashTextOn, 400, 1, %msgSplash%, a
	WinMove, %msgSplash%, , 5, 5
	settimer, Rootage, %iWait%
return

; **************************
; APPELLER SI PAS DENERGY
; **************************
Noenergy:
	if (iCurrentAcc = "1") {
		iLootmana1 = %iLootmana%
	}
	if (iCurrentAcc = "2") {
		iLootmana2 = %iLootmana%
		iLootmana2 = 0
	}

	iWaitMin := round(iWaitNoenergy/60000, 1)
	iMsg = NO ENERGY - WAIT %iWaitMin%
	msgSplash = RT(%iRuntimeDisplay%) ACC(%iCurrentAcc%) LM1(%iLootmanaDisplay1%) LM2(%iLootmanaDisplay2%) - %iMsg%
	SplashTextOn, 400, 1, %msgSplash%, a
	WinMove, %msgSplash%, , 5, 5
	iLootmana1 := iLootmana1+iWaitNoenergy-iWait
	iLootmana2 := iLootmana2+iWaitNoenergy-iWait
	iRuntime := iRuntime+iWaitNoenergy-iWait
	settimer, Rootage, %iWaitNoenergy%
return

; **************************
; FONCTION PRINCIPALE DU SCRIPT
; **************************
Rootage:
	; **************************
	; COUPE LE TIMER ET CALCULE LE UPTIME & LE LOOTMANA
	; **************************
	settimer, Rootage, off
	iRuntime := iRuntime+iWait
	iRuntimeDisplay := round(iRuntime/60000, 1)

	iLootmana1 := iLootmana1+iWait
	iLootmanaDisplay1 := round(iLootmana1/60000, 1)
	iLootmana2 := iLootmana2+iWait
	iLootmanaDisplay2 := round(iLootmana2/60000, 1)

	if (iCurrentAcc = "1") {
		iLootmana = %iLootmana1%
	}
	if (iCurrentAcc = "2") {
		iLootmana = %iLootmana2%
		iLootmana = 0
	}

	; **************************
	; RECUPERE LES VARIABLE DU COMPTE ACTUEL (ZONEetc / RUNE3&4 / LOOTMANA)
	; **************************
	if (iCurrentAcc = "1") {
		iRune4star = %iRune4star1%
		iRune3star = %iRune3star1%
		iZone = %iZone1%
		iStage = %iStage1%
		iDifficulty = %iDifficulty1%
		iLootmana = %iLootmana1%
		iLootmanaDisplay = %iLootmanaDisplay1%
	}
	if (iCurrentAcc = "2") {
		iRune4star = %iRune4star2%
		iRune3star = %iRune3star2%
		iZone = %iZone2%
		iStage = %iStage2%
		iDifficulty = %iDifficulty2%
		iLootmana = %iLootmana2%
		iLootmanaDisplay = %iLootmanaDisplay2%
	}

	; **************************
	; STOP ICI SI TOUT LES STATUS SON OFF (Battle, Summon, UpgradeGem)
	; **************************
	if (iStatus = "0" && iSummon = "0" && iRune = "0") {
		; INTERRUPTION
		iMsg = STATUS OFF
		goto Restart
	}

	; **************************
	; PRENDS LE SCREEN POUR LA PIXEL DETECTION
	; **************************
	updateFastPixelGetColor()
	iMsg = NO MATCH FOUND

	; **************************
	; FONCTION DUPGRADE DES RUNE
	; **************************
	if (iRune = "1") {
		; UPGRADE RUNE
		ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\upgraderune.png
		if ( ErrorLevel = 0 ) {
			iMsg = UPGRADE RUNE CLICK
			Click 449, 246
			goto Restart
		} else {
			iMsg = UPGRADE RUNE WAIT
			goto Restart
		}
	}

	; **************************
	; FONCTION POUR SUMMON EN BOUCLE DES MONSTRES
	; **************************
	if (iSummon = "1") {
		iMsg = SUMMON
		; CLICK SUR SUMMON
		ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\summon-invoquer.png
		if ( ErrorLevel = 0 ) {
		iMsg = SUMMON CLICK BUY
			Click %FoundX%, %FoundY%
			goto Restart
		}
		; CLICK SUR OK
		ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\summon-ok.png
		if ( ErrorLevel = 0 ) {
		iMsg = SUMMON CLICK OK
			Click %FoundX%, %FoundY%
			goto Restart
		}
		; SUMMON SKIP
		iMsg = SUMMON CLICK SKIP
		Click 303, 645
		goto Restart
	}


	; **************************
	; OUVRE LA RECOMPENSE APRES COMBAT
	; **************************
	pixel1 := fastPixelGetColor(515, 196) ; 16776960 = UP
	pixel2 := fastPixelGetColor(514, 367) ; 65535 = UP
	pixel3 := fastPixelGetColor(513, 538) ; 255 = UP
	if ( pixel1 = "16776960" && pixel2 = "65535" && pixel3 = "255" ) {
		iMsg = BATTLE - RECOMPENSE
		iArene = 1
		Click 383, 372
		Sleep 2000
		Click 383, 372
		goto Restart
	}

	; **************************
	; ECRAN DE SELECTION DES MOB
	; CLIC SUR JOUER POUR 3 ENERGY (et 4 et 5)
	; **************************
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\jouer3energy.png
	if ( ErrorLevel = 0 ) {
		iMsg = JOUER 3 ENERGY
		Click 414, 613
		goto Restart
	}
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\jouer4energy.png
	if ( ErrorLevel = 0 ) {
		iMsg = JOUER 4 ENERGY
		Click 414, 613
		goto Restart
	}
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\jouer5energy.png
	if ( ErrorLevel = 0 ) {
		iMsg = JOUER 5 ENERGY
		Click 414, 613
		goto Restart
	}

	; **************************
	; AVERTISSEMENT PAS DE LEADER
	; CLICK SUR OK ET LANCE LE MATCH
	; **************************
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\noleader.png
	if ( ErrorLevel = 0 ) {
		iMsg = NO LEADER
		Click 462, 291
		goto Restart
	}


	; **************************
	; ECRAN APRES COMBAT POUR REJOUER
	; RETOURNE AU FIEF
	; **************************
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\rejouer.png
	if ( ErrorLevel = 0 ) {
		iMsg = COMBAT TERMINER - RETOUR
		Click 370, 570
		goto Restart
	}
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\rejouer2.png
	if ( ErrorLevel = 0 ) {
		iMsg = COMBAT TERMINER - RETOUR
		Click 370, 570
		goto Restart
	}

	; **************************
	; RECOMPENSE OBTENUE: VELIN
	; **************************
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\loot-velin.png
	if ( ErrorLevel = 0 ) {
		iMsg = VICTORY - LOOT VELIN
		Click 383, 372
		goto Restart
	}
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\loot-velin2.png
	if ( ErrorLevel = 0 ) {
		iMsg = VICTORY - LOOT VELIN
		Click 383, 372
		goto Restart
	}

	; **************************
	; RECOMPENSE OBTENUE: RUNE
	; **************************
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\loot-rune.png
	if ( ErrorLevel = 0 ) {
		; **************************
		; VERIFIE SI RUNE 4 ET 3 ETOILE ET SI
		; CONFIG DEMANDE DE GARDER
		; **************************
		Sleep 5000
		updateFastPixelGetColor()
		pixel1 := fastPixelGetColor(586, 259) ; 16777215 = UP
		pixel2 := fastPixelGetColor(587, 260) ; 16777215 = UP
		if ( pixel1 = "16777215" && pixel2 = "16777215" && iRune4star = "1" ) {
			iMsg = PRENDS RUNE 4+ ETOILE
			Click 360, 433
			Sleep 3000
			goto Restart
		}
		pixel1 := fastPixelGetColor(588, 253) ; 16777215 = UP
		pixel2 := fastPixelGetColor(586, 252) ; 16777215 = UP
		if ( pixel1 = "16777215" && pixel2 = "16777215" && iRune3star = "1" ) {
			iMsg = PRENDS RUNE 3 ETOILE
			Click 360, 433
			Sleep 3000
			goto Restart
		}
		; **************************
		; SINON ON VENDS
		; **************************
		iMsg = VENDS RUNE
		Click 370, 300
		goto Restart
	}

	; **************************
	; RECOMPENSE OBTENUE: MOB
	; **************************
	pixel1 := fastPixelGetColor(509, 190) ; 16776960 = UP
	pixel2 := fastPixelGetColor(514, 367) ; 0 = UP
	pixel3 := fastPixelGetColor(511, 543) ; 8061183 = UP
	pixel4 := fastPixelGetColor(368, 252) ; 65535 = UP
	pixel5 := fastPixelGetColor(370, 491) ; 65535 = UP
	if ( pixel1 = "16776960" && pixel2 = "0" && pixel3 = "8061183" && pixel4 = "65535" && pixel5 = "65535" ) {
		iMsg = VICTORY - LOOT MOB
		Click 370, 300
		goto Restart
	}
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\loot-mob.png
	if ( ErrorLevel = 0 ) {
		iMsg = VICTORY - LOOT MOB
		Click 361, 371
		goto Restart
	}
	pixel1 := fastPixelGetColor(666, 260) ; 65535 = UP
	pixel2 := fastPixelGetColor(672, 477) ; 65535 = UP
	pixel3 := fastPixelGetColor(364, 381) ; 16777215 = UP
	pixel4 := fastPixelGetColor(627, 520) ; 255 = UP
	if ( pixel1 = "65535" && pixel2 = "65535" && pixel3 = "16777215" && pixel4 = "255" ) {
		iMsg = VICTORY - LOOT MOB
		Click 361, 371
		goto Restart
	}

	; **************************
	; ECRAN DE DEFAITE
	; **************************
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\dead.png
	if ( ErrorLevel = 0 ) {
		iMsg = DEAD - LOSER
		Click 441, 495
		goto Restart
	}
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\defeated.png
	if ( ErrorLevel = 0 ) {
		iMsg = DEFEATED - LOSER
		Click %FoundX%, %FoundY%
		goto Restart
	}

	; **************************
	; ARENE: SELECTION DE LEQUIPE
	; CLICK SUR GO
	; **************************
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\arenego.png
	if ( ErrorLevel = 0 ) {
		iMsg = ARENE - GO
		iArene = 1
		Click %FoundX%, %FoundY%
		goto Restart
	}

	; **************************
	; ARENE: ACTIVE LE MODE AUTO
	; **************************
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\arenemodeauto.png
	if ( ErrorLevel = 0 ) {
		iMsg = ARENE - MODE AUTO
		iArene = 1
		Click %FoundX%, %FoundY%
		goto Restart
	}

	; **************************
	; ARENE: MATCH TERMINER
	; **************************
	pixel1 := fastPixelGetColor(521, 83) ; 255 = UP
	pixel2 := fastPixelGetColor(403, 103) ; 16777215 = UP
	pixel3 := fastPixelGetColor(420, 362) ; 65535 = UP
	pixel4 := fastPixelGetColor(452, 471) ; 16777215 = UP
	if ( pixel1 = "255" && pixel2 = "16777215" && pixel3 = "65535" && pixel4 = "16777215" ) {
		iMsg = ARENE - CLOSE
		iArene = 1
		Click 383, 372
		goto Restart
	}

	; **************************
	; ARENE: QUITTE LA LISTE DES ADVERSAIRE
	; **************************
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\areneerror.png
	if ( ErrorLevel = 0 ) {
		iMsg = ARENE ERREUR - DEJA COMBATU
		iArene = 1
		Click 464, 364
		Sleep 3000
		Click 697, 671
		goto Restart
	}

	; **************************
	; ARENE: LISTE DES ADVERSAIRE
	; **************************
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\menuarene.png
	if ( ErrorLevel = 0 ) {
		iMsg = ARENE: LISTE DES ADVERSAIRE
		msgSplash = RT(%iRuntimeDisplay%) ACC(%iCurrentAcc%) LM1(%iLootmanaDisplay1%) LM2(%iLootmanaDisplay2%) - %iMsg%
		SplashTextOn, 400, 1, %msgSplash%, a
		WinMove, %msgSplash%, , 5, 5
		; FERME ARENE SI ON A DEJA FAIS UN MATCH
		if ( iArene = "1" ) {
			iMsg = SORTIS DE MATCH
			iArene = 0 ; SORTI DU MENU ARENE CONFIRMER
			Click 697, 671
			goto Restart
		}
		; RAFFRAICHIS LA LISTE
		iMsg = RAFRAICHIS LA LISTE
		msgSplash = RT(%iRuntimeDisplay%) ACC(%iCurrentAcc%) LM1(%iLootmanaDisplay1%) LM2(%iLootmanaDisplay2%) - %iMsg%
		SplashTextOn, 400, 1, %msgSplash%, a
		WinMove, %msgSplash%, , 5, 5
		Click 655, 563
		Sleep 3000
		ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\arenerefresh1.png
		if ( ErrorLevel = 0 ) {
			iMsg = ARENE - RAFRAICHIS
			Click 490, 367
		}
		ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\arenerefresh2.png
		if ( ErrorLevel = 0 ) {
			iMsg = ARENE - RAFRAICHIS
			Click 645, 557
		}
		ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\arenerefresh3.png
		if ( ErrorLevel = 0 ) {
			iMsg = ARENE - RAFRAICHIS
			Click %FoundX%, %FoundY%
		}
		Sleep 5000
		iMsg = LANCE UN MATCH
		Click 602, 622
		goto Restart
	}

	; **************************
	; SELECTION DU LEVEL
	; **************************
	pixel1 := fastPixelGetColor(729, 66) ; 16777215 = UP
	pixel2 := fastPixelGetColor(733, 191) ; 65535 = UP
	pixel3 := fastPixelGetColor(722, 335) ; 4 = UP
	if ( pixel1 = "16777215" && pixel2 = "65535" && pixel3 = "4" ) {
		; **************************
		; VERIFIE SI MATCH ARENE NECESSAIRE
		; **************************
		ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\arene10.png
		if ( ErrorLevel = 0 ) {
			iMsg = ARENE 10 !
			Click 648, 106
			goto Restart
		}
		ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\arene9.png
		if ( ErrorLevel = 0 ) {
			iMsg = ARENE 9 !
			Click 648, 106
			goto Restart
		}
		ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\arene8.png
		if ( ErrorLevel = 0 ) {
			iMsg = ARENE 8 !
			Click 648, 106
			goto Restart
		}
		ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\arene7.png
		if ( ErrorLevel = 0 ) {
			iMsg = ARENE 7 !
			Click 648, 106
			goto Restart
		}
		ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\arene6.png
		if ( ErrorLevel = 0 ) {
			iMsg = ARENE 6 !
			Click 648, 106
			goto Restart
		}
		ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\arene5.png
		if ( ErrorLevel = 0 ) {
			iMsg = ARENE 5 !
			Click 648, 106
			goto Restart
		}

		; **************************
		; SELECTION DE LA ZONE
		; **************************
		; 1 = ENERGY
		; 2 = FATALE
		; 3 = BLADE
		; 4 = RAGE
		; 5 = RAPIDE
		; 6 = FOCUS
		; 7 = GARDIEN
		; 8 = ENDURENCE
		; 9 = VIOLENT
		if (iZone = "1") {
			iMsg = SELECT ZONE - ENERGY
			msgSplash = RT(%iRuntimeDisplay%) ACC(%iCurrentAcc%) LM1(%iLootmanaDisplay1%) LM2(%iLootmanaDisplay2%) - %iMsg%
			SplashTextOn, 400, 1, %msgSplash%, a
			WinMove, %msgSplash%, , 5, 5
			Click 474, 228
			Sleep 1000
		}
		if (iZone = "2") {
			iMsg = SELECT ZONE - FATAL
			msgSplash = RT(%iRuntimeDisplay%) ACC(%iCurrentAcc%) LM1(%iLootmanaDisplay1%) LM2(%iLootmanaDisplay2%) - %iMsg%
			SplashTextOn, 400, 1, %msgSplash%, a
			WinMove, %msgSplash%, , 5, 5
			Click 524, 379
			Sleep 1000
		}
		if (iZone = "3") {
			iMsg = SELECT ZONE - BLADE
			msgSplash = RT(%iRuntimeDisplay%) ACC(%iCurrentAcc%) LM1(%iLootmanaDisplay1%) LM2(%iLootmanaDisplay2%) - %iMsg%
			SplashTextOn, 400, 1, %msgSplash%, a
			WinMove, %msgSplash%, , 5, 5
			Click 506, 495
			Sleep 1000
		}
		if (iZone = "4") {
			iMsg = SELECT ZONE - RAGE
			msgSplash = RT(%iRuntimeDisplay%) ACC(%iCurrentAcc%) LM1(%iLootmanaDisplay1%) LM2(%iLootmanaDisplay2%) - %iMsg%
			SplashTextOn, 400, 1, %msgSplash%, a
			WinMove, %msgSplash%, , 5, 5
			Click 659, 447
			Sleep 1000
		}
		if (iZone = "5") {
			iMsg = SELECT ZONE - RAPIDE
			msgSplash = RT(%iRuntimeDisplay%) ACC(%iCurrentAcc%) LM1(%iLootmanaDisplay1%) LM2(%iLootmanaDisplay2%) - %iMsg%
			SplashTextOn, 400, 1, %msgSplash%, a
			WinMove, %msgSplash%, , 5, 5
			Click 587, 685
			Sleep 1000
		}
		if (iZone = "6") {
			iMsg = SELECT ZONE - FOCUS
			msgSplash = RT(%iRuntimeDisplay%) ACC(%iCurrentAcc%) LM1(%iLootmanaDisplay1%) LM2(%iLootmanaDisplay2%) - %iMsg%
			SplashTextOn, 400, 1, %msgSplash%, a
			WinMove, %msgSplash%, , 5, 5
			Click 460, 636
			Sleep 1000
		}
		if (iZone = "7") {
			iMsg = SELECT ZONE - GARDIEN
			msgSplash = RT(%iRuntimeDisplay%) ACC(%iCurrentAcc%) LM1(%iLootmanaDisplay1%) LM2(%iLootmanaDisplay2%) - %iMsg%
			SplashTextOn, 400, 1, %msgSplash%, a
			WinMove, %msgSplash%, , 5, 5
			Click 455, 641
			Sleep 1000
			Click 709, 705
			Sleep 1000
			Click 305, 343
			Sleep 1000
		}
		if (iZone = "8") {
			iMsg = SELECT ZONE - ENDURENCE
			msgSplash = RT(%iRuntimeDisplay%) ACC(%iCurrentAcc%) LM1(%iLootmanaDisplay1%) LM2(%iLootmanaDisplay2%) - %iMsg%
			SplashTextOn, 400, 1, %msgSplash%, a
			WinMove, %msgSplash%, , 5, 5
			Click 455, 641
			Sleep 1000
			Click 709, 705
			Sleep 1000
			Click 310, 574
			Sleep 1000
		}
		if (iZone = "9") {
			iMsg = SELECT ZONE - VIOLENT
			msgSplash = RT(%iRuntimeDisplay%) ACC(%iCurrentAcc%) LM1(%iLootmanaDisplay1%) LM2(%iLootmanaDisplay2%) - %iMsg%
			SplashTextOn, 400, 1, %msgSplash%, a
			WinMove, %msgSplash%, , 5, 5
			Click 455, 641
			Sleep 1000
			Click 709, 705
			Sleep 1000
			Click 450, 645
			Sleep 1000
		}
		Sleep 1000

		; **************************
		; SELECTION DE LA DIFFICULTER
		; **************************
		Click 658, 629
		Sleep 1000
		if (iDifficulty = "1") {
			Click 570, 580
		}
		if (iDifficulty = "2") {
			Click 475, 575
		}
		if (iDifficulty = "3") {
			Click 377, 580
		}
		Sleep 1000

		; **************************
		; SELECTION DU STAGE
		; **************************
		if (iStage = "1") {
			iMsg = SELECT STAGE 1
			Click 580, 655
		}
		if (iStage = "2") {
			iMsg = SELECT STAGE 2
			Click 494, 656
		}
		if (iStage = "3") {
			iMsg = SELECT STAGE 3
			Click 411, 664
		}
		if (iStage = "4") {
			iMsg = SELECT STAGE 4
			Click 333, 656
		}
		if (iStage > 4) {
			; SCROLL DOWN
			Click {left DOWN} 414, 548
			MouseMove 490, 548
			Click {left UP} 490,548
			Sleep 500
			Click {left DOWN} 414, 548
			MouseMove 490, 548
			Click {left UP} 490,548
			Sleep 1500
		}
		if (iStage = "5") {
			iMsg = SELECT STAGE 5
			Click 530, 655
		}
		if (iStage = "6") {
			iMsg = SELECT STAGE 6
			Click 444, 655
		}
		if (iStage = "7") {
			iMsg = SELECT STAGE 7
			Click 355, 655
		}

		goto Restart
	}

	; **************************
	; ECRAN DU FIEF
	; **************************
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\bataille.png
	if ( ErrorLevel = 0 ) {
		; **************************
		; REINITIALISE LA BOUCLE ANTI BUG DE COMBAT
		; **************************
		iWaitCombat = 0
		; **************************
		; VERIFIE SI ON EST SUR LE BON COMPTE
		; SINON MET LE MEME COMPTE QUE LIPHONE
		; **************************
		ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\avatar1.png
		if ( ErrorLevel = 0 && iCurrentAcc = "2" ) {
			iMsg = CuAcc(%iCurrentAcc%) va changer
			msgSplash = RT(%iRuntimeDisplay%) ACC(%iCurrentAcc%) LM1(%iLootmanaDisplay1%) LM2(%iLootmanaDisplay2%) - %iMsg%
			SplashTextOn, 400, 1, %msgSplash%, a
			WinMove, %msgSplash%, , 5, 5
			iCurrentAcc = 1
			Sleep 1000
			goto Restart
		}
		ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\avatar2.png
		if ( ErrorLevel = 0 && iCurrentAcc = "1" ) {
			iMsg = CuAcc(%iCurrentAcc%) va changer
			msgSplash = RT(%iRuntimeDisplay%) ACC(%iCurrentAcc%) LM1(%iLootmanaDisplay1%) LM2(%iLootmanaDisplay2%) - %iMsg%
			SplashTextOn, 400, 1, %msgSplash%, a
			WinMove, %msgSplash%, , 5, 5
			iCurrentAcc = 2
			Sleep 1000
			goto Restart
		}

		; **************************
		; VERIFIE SI ON DOIS LOOT LE MANA ET INSPECTER LE SHOP
		; **************************
		if ( iLootmanaDisplay > iLootmanaMax ) {
			iMsg = LOOTING MANA !
			Sleep 2000
			msgSplash = RT(%iRuntimeDisplay%) ACC(%iCurrentAcc%) LM1(%iLootmanaDisplay1%) LM2(%iLootmanaDisplay2%) - %iMsg%
			SplashTextOn, 400, 1, %msgSplash%, a
			WinMove, %msgSplash%, , 5, 5

			Click 562, 605 ; FONTAINE 1
			Sleep 2000
			Click 594, 497 ; FONTAINE 2
			Sleep 2000
			Click 645, 402 ; FONTAINE 3
			Sleep 2000
			Click 665, 317 ; FONTAINE CRISTAUX
			Sleep 2000
			Click 526, 368 ; CLIC SUR ECHOP MAGIE
			Sleep 1000
			Click 309, 517 ; CLIC SUR BOUTON ACHETER
			Sleep 6000 ; LAISSE LE MAGASIN SOUVRIR

			; **************************
			; ECHOPE DE MAGIE
			; **************************
			ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\echopedemagie.png
			if ( ErrorLevel = 0 ) {
				iMsg = ECHOPE DE MAGIE
				msgSplash = RT(%iRuntimeDisplay%) ACC(%iCurrentAcc%) LM1(%iLootmanaDisplay1%) LM2(%iLootmanaDisplay2%) - %iMsg%
				SplashTextOn, 400, 1, %msgSplash%, a
				WinMove, %msgSplash%, , 5, 5

				; ITEM 1
				Click 579, 546
				Sleep 2000
				ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\velinmystique.png
				if ( ErrorLevel = 0 ) {
					Click 415, 128
					Sleep 1500
					Click 458, 301
					Sleep 4000
					; SHOP NO MANA
					ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\shopnomana.png
					if ( ErrorLevel = 0 ) {
						iMsg = SHOP NO MANA
						Click 463, 440
						Sleep 2000
						Click 706, 691
						iLootmana = 0
						Sleep 3000
						goto Restart
					}
				}
				;ITEM 2
				Click 493, 541
				Sleep 2000
				ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\velinmystique.png
				if ( ErrorLevel = 0 ) {
					Click 415, 128
					Sleep 1500
					Click 458, 301
					Sleep 4000
					; SHOP NO MANA
					ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\shopnomana.png
					if ( ErrorLevel = 0 ) {
						iMsg = SHOP NO MANA
						Click 463, 440
						Sleep 2000
						Click 706, 691
						iLootmana = 0
						Sleep 3000
						goto Restart
					}
				}
				; ITEM 3
				Click 414, 548
				Sleep 2000
				ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\velinmystique.png
				if ( ErrorLevel = 0 ) {
					Click 415, 128
					Sleep 1500
					Click 458, 301
					Sleep 4000
					; SHOP NO MANA
					ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\shopnomana.png
					if ( ErrorLevel = 0 ) {
						iMsg = SHOP NO MANA
						Click 463, 440
						Sleep 2000
						Click 706, 691
						iLootmana = 0
						Sleep 3000
						goto Restart
					}
				}
				; MOVE 1
				Click {left DOWN} 414, 548
				MouseMove 460, 548
				Click {left UP} 460,548
				Sleep 1000
				;ITEM 4
				Click 493, 541
				Sleep 2000
				ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\velinmystique.png
				if ( ErrorLevel = 0 ) {
					Click 415, 128
					Sleep 1500
					Click 458, 301
					Sleep 4000
					; SHOP NO MANA
					ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\shopnomana.png
					if ( ErrorLevel = 0 ) {
						iMsg = SHOP NO MANA
						Click 463, 440
						Sleep 2000
						Click 706, 691
						iLootmana = 0
						Sleep 3000
						goto Restart
					}
				}
				; ITEM 5
				Click 412, 548
				Sleep 2000
				ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\velinmystique.png
				if ( ErrorLevel = 0 ) {
					Click 415, 128
					Sleep 1500
					Click 458, 301
					Sleep 4000
					; SHOP NO MANA
					ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\shopnomana.png
					if ( ErrorLevel = 0 ) {
						iMsg = SHOP NO MANA
						Click 463, 440
						Sleep 2000
						Click 706, 691
						iLootmana = 0
						Sleep 3000
						goto Restart
					}
				}
				; MOVE 2
				Click {left DOWN} 414, 548
				MouseMove 460, 548
				Click {left UP} 460,548
				Sleep 1000
				;ITEM 6
				Click 458, 541
				Sleep 2000
				ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\velinmystique.png
				if ( ErrorLevel = 0 ) {
					Click 415, 128
					Sleep 1500
					Click 458, 301
					Sleep 4000
					; SHOP NO MANA
					ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\shopnomana.png
					if ( ErrorLevel = 0 ) {
						iMsg = SHOP NO MANA
						Click 463, 440
						Sleep 2000
						Click 706, 691
						iLootmana = 0
						Sleep 3000
						goto Restart
					}
				}
				; ITEM 7
				Click 412, 548
				Sleep 2000
				ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\velinmystique.png
				if ( ErrorLevel = 0 ) {
					Click 415, 128
					Sleep 1500
					Click 458, 301
					Sleep 4000
					; SHOP NO MANA
					ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\shopnomana.png
					if ( ErrorLevel = 0 ) {
						iMsg = SHOP NO MANA
						Click 463, 440
						Sleep 2000
						Click 706, 691
						iLootmana = 0
						Sleep 3000
						goto Restart
					}
				}
				; MOVE 3
				Click {left DOWN} 414, 548
				MouseMove 460, 548
				Click {left UP} 460,548
				Sleep 1000
				; ITEM 8
				Click 455, 548
				Sleep 2000
				ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\velinmystique.png
				if ( ErrorLevel = 0 ) {
					Click 415, 128
					Sleep 1500
					Click 458, 301
					Sleep 4000
					; SHOP NO MANA
					ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\shopnomana.png
					if ( ErrorLevel = 0 ) {
						iMsg = SHOP NO MANA
						Click 463, 440
						Sleep 2000
						Click 706, 691
						iLootmana = 0
						Sleep 3000
						goto Restart
					}
				}
				; MOVE 3
				Click {left DOWN} 414, 548
				MouseMove 460, 548
				Click {left UP} 460,548
				Sleep 1000
				;ITEM 9
				Click 514, 541
				Sleep 2000
				ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\velinmystique.png
				if ( ErrorLevel = 0 ) {
					Click 415, 128
					Sleep 1500
					Click 458, 301
					Sleep 4000
					; SHOP NO MANA
					ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\shopnomana.png
					if ( ErrorLevel = 0 ) {
						iMsg = SHOP NO MANA
						Click 463, 440
						Sleep 2000
						Click 706, 691
						iLootmana = 0
						Sleep 3000
						goto Restart
					}
				}
				; ITEM 10
				Click 431, 548
				Sleep 2000
				ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\velinmystique.png
				if ( ErrorLevel = 0 ) {
					Click 415, 128
					Sleep 1500
					Click 458, 301
					Sleep 4000
					; SHOP NO MANA
					ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\shopnomana.png
					if ( ErrorLevel = 0 ) {
						iMsg = SHOP NO MANA
						Click 463, 440
						Sleep 2000
						Click 706, 691
						iLootmana = 0
						Sleep 3000
						goto Restart
					}
				}
				; MOVE 3
				Click {left DOWN} 414, 548
				MouseMove 470, 548
				Click {left UP} 470,548
				Sleep 1000
				;ITEM 11
				Click 473, 541
				Sleep 2000
				ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\velinmystique.png
				if ( ErrorLevel = 0 ) {
					Click 415, 128
					Sleep 1500
					Click 458, 301
					Sleep 4000
					; SHOP NO MANA
					ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\shopnomana.png
					if ( ErrorLevel = 0 ) {
						iMsg = SHOP NO MANA
						Click 463, 440
						Sleep 2000
						Click 706, 691
						iLootmana = 0
						Sleep 3000
						goto Restart
					}
				}
				; ITEM 12
				Click 390, 548
				Sleep 2000
				ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\velinmystique.png
				if ( ErrorLevel = 0 ) {
					Click 415, 128
					Sleep 1500
					Click 458, 301
					Sleep 4000
					; SHOP NO MANA
					ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\shopnomana.png
					if ( ErrorLevel = 0 ) {
						iMsg = SHOP NO MANA
						Click 463, 440
						Sleep 2000
						Click 706, 691
						iLootmana = 0
						Sleep 3000
						goto Restart
					}
				}

				; **************************
				; FERME LECHOPE DE MAGIE
				; **************************
				Sleep 1000
				Click 706, 691
				Sleep 3000
			}
			; **************************
			; VALIDE LE LOOT DE MANA ET RESTART
			; **************************
			iLootmana = 0
			goto Restart
		}
		; **************************
		; VERIFIE SI ON DOIS CHANGER DE COMPTE APRES UN NOENERGY
		; **************************
		if (iSwitchAcc = "1" && iSwitchReq = "1") {
			Click 695, 53
			Sleep 1000
			Click 490, 482
			Sleep 5000
			goto Restart
		}
		; **************************
		; CLICK SUR BATAILLE POUR ENTRER DANS LA MAP
		; **************************
		iMsg = CLICK BATAILLE
		Click 310, 360
		goto Restart
	}

	; **************************
	; BATIMENT: MENU DEPLACER
	; **************************
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\deplacer.png
	if ( ErrorLevel = 0 ) {
		iMsg = BATIMENT MENU DEPLACER
		Click %FoundX%, %FoundY%
		Sleep 3000
		Click 316, 592
		goto Restart
	}

	; **************************
	; FERME LE COFFRE OUVERT
	; **************************
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\coffre.png
	if ( ErrorLevel = 0 ) {
		iMsg = FERME LE COFFRE OUVERT
		Click 680,655
		goto Restart
	}
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\coffre2.png
	if ( ErrorLevel = 0 ) {
		iMsg = FERME LE COFFRE OUVERT
		Click 680,655
		goto Restart
	}

	; **************************
	; SPRINGBOARD - LANCE LE JEU
	; **************************
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\springboard1.png
	if ( ErrorLevel = 0 ) {
		iMsg = SPRINGBOARD - LANCE LE JEU
		Click 450, 355
		goto Restart
	}

	; **************************
	; APPSTORE OUVERT - CLIC DROIT POUR QUITTER
	; **************************
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\appstore.png
	if ( ErrorLevel = 0 ) {
		iMsg = APPSTORE - CLIC DROIT
		Click right 507,376
		goto Restart
	}

	; **************************
	; ECRAN ACCUEIL DU JEU (TOUCH START)
	; **************************
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\accueil.png
	if ( ErrorLevel = 0 ) {
		iMsg = ECRAN ACCUEIL - CLIC AU MILIEU
		Click 324,692
		goto Restart
	}

	; **************************
	; SHOP CRISTAUX ROUGE OUVERT
	; **************************
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\shopopen.png
	if ( ErrorLevel = 0 ) {
		iMsg = SHOP CRISTAUX ROUGE OUVERT
		Click 728, 704
		goto Restart
	}


	; **************************
	; GESTION DES PUB
	; **************************
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\pub1.png
	if ( ErrorLevel = 0 ) {
		iMsg = PUB 1 - 3 OFFRE A 29.9e
		Click 688, 657
		goto Restart
	}
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\pub2.png
	if ( ErrorLevel = 0 ) {
		iMsg = PUB 2 - OFFRE MENSUEL
		Click 310, 360
		goto Restart
	}
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\pub3.png
	if ( ErrorLevel = 0 ) {
		iMsg = PUB 2 - OFFRE MENSUEL
		Click 713, 690
		goto Restart
	}
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\pub4.png
	if ( ErrorLevel = 0 ) {
		iMsg = PUB 4 - PARCHO TENEBRE LIGHT
		Click 366, 474
		goto Restart
	}
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\pub5.png
	if ( ErrorLevel = 0 ) {
		iMsg = PUB 5 - PACK ENERGY MANA
		Click 687, 657
		goto Restart
	}
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\pub6.png
	if ( ErrorLevel = 0 ) {
		iMsg = PUB 5 - PACK DEBUTANT
		Click 712, 694
		goto Restart
	}
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\pub7.png
	if ( ErrorLevel = 0 ) {
		iMsg = PUB 5 - PACK DEBUTANT
		Click 369, 481
		goto Restart
	}

	; **************************
	; FERMETURE DU POPUP CONFIRMATION DE PUB
	; **************************
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\pub1-close.png
	if ( ErrorLevel = 0 ) {
		iMsg = PUB - CLOSE
		Click %FoundX%, %FoundY%
		goto Restart
	}
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\pub2-close.png
	if ( ErrorLevel = 0 ) {
		iMsg = PUB - CLOSE
		Click 440, 373
		goto Restart
	}

	; **************************
	; EVENEMENT MENSUEL
	; **************************
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\eventmensuel.png
	if ( ErrorLevel = 0 ) {
		iMsg = EVENEMENT MENSUEL
		Click 715, 633
		goto Restart
	}

	; **************************
	; BATTLE EN PAUSE CLIC SUR LE ROUAGE
	; **************************
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\jeupause.png
	if ( ErrorLevel = 0 ) {
		iMsg = BATTLE - JEU PAUSE
		Click %FoundX%, %FoundY%
		goto Restart
	}
	pixel1 := fastPixelGetColor(308, 49) ; 255 = UP
	pixel2 := fastPixelGetColor(287, 111) ; 16777215 = UP
	pixel3 := fastPixelGetColor(308, 172) ; 16777215 = UP
	if ( pixel1 = "255" && pixel2 = "16777215" && pixel3 = "16777215" ) {
		iMsg = BATTLE - JEU PAUSE
		Click 308, 172
		goto Restart
	}

	; **************************
	; BATTLE REGLE LA VITESSE SUR 3X
	; **************************
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\vitesse1x.png
	if ( ErrorLevel = 0 ) {
		iMsg = BATTLE - VITESSE 1X
		Click %FoundX%, %FoundY%
		goto Restart
	}
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\vitesse1xnoir.png
	if ( ErrorLevel = 0 ) {
		iMsg = BATTLE - VITESSE 1X
		Click %FoundX%, %FoundY%
		goto Restart
	}
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\vitesse2x.png
	if ( ErrorLevel = 0 ) {
		iMsg = BATTLE - VITESSE 2X
		Click %FoundX%, %FoundY%
		goto Restart
	}
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\vitesse2xnoir.png
	if ( ErrorLevel = 0 ) {
		iMsg = BATTLE - VITESSE 2X
		Click %FoundX%, %FoundY%
		goto Restart
	}


	; **************************
	; ACTIVE LE MODE AUTO
	; **************************
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\modeauto.png
	if ( ErrorLevel = 0 ) {
		iMsg = BATTLE - MODE AUTO
		Click %FoundX%, %FoundY%
		goto Restart
	}
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\modeautonoir.png
	if ( ErrorLevel = 0 ) {
		iMsg = BATTLE - MODE AUTO
		Click %FoundX%, %FoundY%
		goto Restart
	}

	; **************************
	; ARENE EN PAUSE & VITESSE 3X
	; **************************
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\arenepause.png
	if ( ErrorLevel = 0 ) {
		iMsg = ARENE - PAUSE
		iArene = 1
		Click %FoundX%, %FoundY%
		goto Restart
	}
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\arenevitesse1x.png
	if ( ErrorLevel = 0 ) {
		iMsg = ARENE - VITESSE 1x
		iArene = 1
		Click %FoundX%, %FoundY%
		goto Restart
	}
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\arenevitesse2x.png
	if ( ErrorLevel = 0 ) {
		iMsg = ARENE - VITESSE 2x
		iArene = 1
		Click %FoundX%, %FoundY%
		goto Restart
	}

	; **************************
	; MESSAGE NO ENERGY !
	; **************************
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\noenergy.png
	if ( ErrorLevel = 0 ) {
		iWaitMin := round(iWaitNoenergy/60000, 1)
		iMsg = NO ENERGY - WAIT %iWaitMin%
		Click 460, 444
		Sleep 3000
		; **************************
		; QUITTE LA MAP SI ELLE EST OUVERTE
		; **************************
		ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\info.png
		if ( ErrorLevel = 0 ) {
			Click 707, 697
			Sleep 2000
			Click 321, 680
			Sleep 3000
		}
		; **************************
		; DEMANDE UN CHANGEMENT DE COMPTE SI LOPTION EST ACTIVER
		; **************************
		if (iSwitchAcc = "1") {
			iMsg = NO ENERGY - SWITCH ACCOUNT
			iSwitchReq = 1 ; INITIALISERA UNE DECO DEPUIS LE FIEF
			goto Restart
		}
		goto Noenergy
	}

	; **************************
	; CONNEXION PERDU OU RETARDER
	; **************************
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\connexion.png
	if ( ErrorLevel = 0 ) {
		iMsg = CONNEXION LOST
		Click 466, 373
		Sleep 3000
		; LEAVE MAP
		ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\info.png
		if ( ErrorLevel = 0 ) {
			iMsg = CONNEXION LOST - LEAVE MAP
			Click 707, 697
			Sleep 2000
			Click 321, 680
			goto Restart
		}
		goto Restart
	}

	; **************************
	; NE PAS SE FIER (IPHONE BRANCHER EN USB)
	; **************************
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\nepassefier.png
	if ( ErrorLevel = 0 ) {
		iMsg = NE PAS SE FIER
		Click %FoundX%, %FoundY%
		goto Restart
	}
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\nepassefier2.png
	if ( ErrorLevel = 0 ) {
		iMsg = NE PAS SE FIER
		Click %FoundX%, %FoundY%
		goto Restart
	}
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\nepassefier3.png
	if ( ErrorLevel = 0 ) {
		iMsg = NE PAS SE FIER
		Click %FoundX%, %FoundY%
		goto Restart
	}

	; **************************
	; BONUS DAILY EVOLUTION 6 ETOILES
	; **************************
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\bonusevolution.png
	if ( ErrorLevel = 0 ) {
		iMsg = BONUS EVOLUTION 6 ETOILES
		Click 366, 366
		goto Restart
	}

	; **************************
	; MISE A JOUR DU JEU NECESSAIRE
	; **************************
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\maj.png
	if ( ErrorLevel = 0 ) {
		iMsg = MAJ
		Click 433, 368
		goto Restart
	}
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\maj2.png
	if ( ErrorLevel = 0 ) {
		iMsg = MAJ 2
		Click 433, 368
		goto Restart
	}

	; **************************
	; SESSION DE LOGIN - CHANGEMENT DE COMPTE
	; **************************
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, .\img\login.png
	if ( ErrorLevel = 0 ) {
		; **************************
		; HELLO MSG
		; **************************
		iMsg = LOGIN SCREEN CuAcc(%iCurrentAcc%)
		msgSplash = RT(%iRuntimeDisplay%) ACC(%iCurrentAcc%) LM1(%iLootmanaDisplay1%) LM2(%iLootmanaDisplay2%) - %iMsg%
		SplashTextOn, 400, 1, %msgSplash%, a
		WinMove, %msgSplash%, , 5, 5
		Sleep 1000
		; **************************
		; CHANGEMENT DE COMPTE REQUIS
		; **************************
		if (iSwitchReq = "1" && iSwitchAcc = "1") {
			iSwitchReq = 0
			if (iCurrentAcc = "1") {
				iCurrentAcc = 2
			} else {
				iCurrentAcc = 1
			}
			iMsg = CuAcc(%iCurrentAcc%) is the new account
			msgSplash = RT(%iRuntimeDisplay%) ACC(%iCurrentAcc%) LM1(%iLootmanaDisplay1%) LM2(%iLootmanaDisplay2%) - %iMsg%
			SplashTextOn, 400, 1, %msgSplash%, a
			WinMove, %msgSplash%, , 5, 5
		}

		; **************************
		; SELECTIONNE ET RESET LE CHAMPS NICKNAME
		; **************************
		Click 609, 84 ; clic sur le champs
		Sleep 3000
		Click 655, 463 ; positionne le curseur
		Sleep 500
		Click {left DOWN} 365, 683
		Sleep 4000
		Click {left UP} 365, 683
		Sleep 500

		; **************************
		; CONNECT NESTOYEUR (MAIN)
		; **************************
		if (iCurrentAcc = "1") {
			Send compte1
		}
		; **************************
		; CONNECT NESSTOYEUR (REROLL)
		; **************************
		if (iCurrentAcc = "2") {
			Send compte2
		}
		Sleep 1000

		Click 585, 108
		; **************************
		; ECRIS LE PASSWORD & VALID
		; **************************
		Sleep 1000
		Click 306, 81 ; clavier 123
		Sleep 500
		; clic sequence removed to set repo public :)

		goto Restart
	}

	; **************************
	; AUCUNE INSTRUCTION TROUVER
	; PEUT ETRE EN COMBAT BUGUER
	; EXECUTE UN CLIC TOUT A DROITE DE LECRAN
	; **************************
	Sleep 1500
	updateFastPixelGetColor()
	Sleep 500
	pixel1 := fastPixelGetColor(722, 42) ; 16777215 = UP
	pixel2 := fastPixelGetColor(722, 48) ; 0 = UP
	pixel3 := fastPixelGetColor(722, 54) ; 0 = UP
	pixel4 := fastPixelGetColor(722, 61) ; 0 = UP
	pixel5 := fastPixelGetColor(722, 65) ; 16777215 = UP
	if ( pixel1 = "16777215" && pixel2 = "0" && pixel3 = "0" && pixel4 = "0" && pixel5 = "16777215" ) {
		; **************************
		; SI BESOIN ACTIVE LE MODE AUTO
		; **************************
		pixel1 := fastPixelGetColor(305, 173) ; 16777215 = UP
		pixel2 := fastPixelGetColor(300, 50) ; 16777215 = UP
		pixel3 := fastPixelGetColor(286, 109) ; 16777215 = UP
		if ( pixel1 = "16777215" && pixel2 = "16777215" && pixel3 = "16777215" ) {
			iMsg = COMBAT (%iWaitCombat%) - PUT MODE AUTO
			Click 305, 169
			goto Restart
		} else {
			; **************************
			; CLICK EN BORDURE DECRAN POUR CONTRER UN LVEL UP OU AUTRE
			; **************************
			iWaitCombat++
			iMsg = COMBAT (%iWaitCombat%) - WATCHING
			if (iWaitCombat > 5) {
				iMsg = COMBAT (%iWaitCombat%) - CLICK BORDURE
				iWaitCombat = 0
				Click 488, 703
			}
		}
	}


	goto Restart
return
