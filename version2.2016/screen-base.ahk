; ECRAN DE LA BASE
ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\base\avatar.png
if ( ErrorLevel == 0 ) {
	Sleep 1500
	Click 373,468 ; clic dans le vide
	Sleep 3333
	setnocombat()
	if (iLockChat == 0 && iChat == 1) {
		displaymsg("CHAT: OPEN CHAT")
		Click 454,263 ; ouvre tchat
		Sleep 3333
		displaymsg("CHAT: GO TO NORMAL CHAT")
		Click 327,262 ; onglet normal
		Sleep 3333
		displaymsg("CHAT: CHANGE CANNAL")
		Click 734,259 ; Canal xxx
		Sleep 3333
		chatnumber()
		displaymsg("CHAT: GOGOGO")
		Sleep 3121
		Click 725,254 ; Envoie
		Sleep 3121
		clickback(1)
		iLockChat = %iLockChatLoop%
		Sleep 3121
	}
	if (iLockMana == 0 && iManaLoot == 1) {
		Click 546,389 ; boutique
		Sleep 3121
		Click 695,521 ; ouvrir
		Sleep 3333
		Click 803,262 ; fermer
		Sleep 3333
		iTime = 1500
		displaymsg("MANA: LOOT FONTAiNE 1")
		Click 709, 356 ; fontaine 1 
		Sleep %iTime%
		if (iStatus == 0)
			goto Restart
		displaymsg("MANA: LOOT FONTAiNE 2")
		Click 633, 331 ; fontaine 2
		Sleep %iTime%
		if (iStatus == 0)
			goto Restart
		displaymsg("MANA: LOOT FONTAiNE 3")
		Click 569, 299 ; fontaine 3
		Sleep %iTime%
		if (iStatus == 0)
			goto Restart
		displaymsg("MANA: LOOT CRISTAUX 1")
		Click 511, 282 ; crystaux 1
		Sleep %iTime%
		if (iStatus == 0)
			goto Restart
		displaymsg("MANA: LOOT CRISTAUX 2")
		Click 464, 343 ; crystaux 2
		Sleep %iTime%
		if (iStatus == 0)
			goto Restart
		displaymsg("MANA:JARDIN 1")
		Loop, 2 {
			Sleep 3121
			Click 717,399
		}
		if (jardin() == 0)
			goto Restart
		displaymsg("MANA:JARDIN 2")
		Loop, 2 {
			Sleep 3121
			Click 422,484
		}
		if (jardin() == 0)
			goto Restart
		Sleep 3121
		Click 546,389 ; boutique
		Sleep 3121
		Click 695,521 ; ouvrir
		Sleep 3333
		Click 803,262 ; fermer
		Sleep 3333
		Click 360,423 ; sort menu pour voir bataille icone
		Sleep 3121
		iLockMana = %iLockManaLoop%
	}
	if (iLockPve == 0 || iLockArene == 0) {
			displaymsg("BASE: GO TO MAP SCREEN")
			Sleep 1500
			Click 360,423 ; sort menu pour voir bataille icone
			Sleep 3121
			Click 583, 505 ; bataille go
			Loop, 20 {
				ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\map\start.png
				if ( ErrorLevel == 0 )
					break
				Sleep 1000
			}
	} else {
		sMsg = LOCK PVE %iLockPve%/%iLockPveLoop% - LOCK ARENE %iLockArene%/%iLockAreneLoop%
		displaymsg(sMsg)
	}
}