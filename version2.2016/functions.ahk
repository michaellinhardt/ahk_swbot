; FONCTIONS
displaymsg( sMsg ) {
	global sMsgLast		
	global iStatus
	global iRareEventLimit
	global iLockPve
	global iLockPveLoop
	global iLockArene
	global iLockAreneLoop
	global iLockChat
	global iLockChatLoop
	global iLockMana
	global iLockManaLoop
	global iLockQuest
	global iLockQuestLoop
	global iLeaveGame
	global iLeaveGameLimit
	global iLogSize
	global iMsgBox
	if (iMsgBox == 1) {	
		WinGetPos, X, Y, , , Mobizen
		title = %title% - Leave %iLeaveGame%/%iLeaveGameLimit%
		title = %title% - Mobi' %X%,%Y%
		title = %title% - Pve %iLockPve%/%iLockPveLoop%
		title = %title% - Arene %iLockArene%/%iLockAreneLoop%
		title = %title% - Mana %iLockMana%/%iLockManaLoop%
		title = %title% - Chat %iLockChat%/%iLockChatLoop%
		title = %title% - Quest %iLockQuest%/%iLockQuestLoop%

		if (sMsgLast != 0)
			sMsg = %sMsg%`n%sMsgLast%
		if (iLogSize == 1 || iStatus == 1) {
			SplashTextOn, 1024, 188, %title%, %sMsg%
			WinMove, %title%, , 0, -5
		} else {
			SplashTextOn, 400, 20, %title%, %sMsg%
			WinMove, %title%, , 625, 685
		}
		sMsgLast = %sMsg%
	}
}

displaymsg2() {
	global sMsgLast		
	global iStatus
	global iRareEventLimit
	global iLockPve
	global iLockPveLoop
	global iLockArene
	global iLockAreneLoop
	global iLockChat
	global iLockChatLoop
	global iLockMana
	global iLockManaLoop
	global iLockQuest
	global iLockQuestLoop
	global iLeaveGame
	global iLeaveGameLimit
	global iLogSize
	WinGetPos, X, Y, , , Mobizen
	title = %title% - Leave %iLeaveGame%/%iLeaveGameLimit%
	title = %title% - Mobi' %X%,%Y%
	title = %title% - Pve %iLockPve%/%iLockPveLoop%
	title = %title% - Arene %iLockArene%/%iLockAreneLoop%
	title = %title% - Mana %iLockMana%/%iLockManaLoop%
	title = %title% - Chat %iLockChat%/%iLockChatLoop%
	title = %title% - Quest %iLockQuest%/%iLockQuestLoop%
	if (iLogSize == 1 || iStatus == 1) {
		SplashTextOn, 1024, 188, %title%, %sMsgLast%
		WinMove, %title%, , 0, -5
	}
	else {
		SplashTextOn, 400, 20, %title%, %sMsgLast%
		WinMove, %title%, , 625, 685
	}
}

chatnumber() {
	Send {Numpad1}
	Sleep 1500
	Send {Numpad5}
	Sleep 1500
	Send {Numpad0}
	Sleep 1500
	Send {Numpad0}
}

goteamrival() {
	global iDraw
	
	iDraw = 0
	Sleep 1500
	Click 302, 396 ; ouvre team sauvegardé
	Sleep 3333
	Click 392, 334 ; team 1
	Sleep 3333
	Click 739, 448 ; lance le match
	Sleep 1500
}	
goteampvp() {
	global iDraw
	
	iDraw = 0
	Sleep 1500
	Click 302, 396 ; ouvre team sauvegardé
	Sleep 3333
	Click 408, 380 ; team 2
	Sleep 3333
	Click 739, 448 ; lance le match
	Sleep 1500
}

areneclick( iArene, iAreneForceFight, iLow ) {
	global ax1
	global ay1
	global ax2
	global ay2
	global iLockArene
	global iLockAreneLoop
	global iLockAreneNew
	global iDraw
	global iAreneForceFightt
	
	iDraw = 0
	ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\arene\joueur-down.png
	if ( ErrorLevel == 0 ) {
		Click 549, 425 ; ferme la boite comme quoi on a battu ce joueur
		return (-3)
	}
	ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\arene\no-credit.png
	if ( ErrorLevel == 0 ) {
		Click 596, 428 ; ferme la boite comme quoi on a pas dinvitation
		iLockArene = %iLockAreneLoop%
		return (-1)
	}
	iDetect = 0
	ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\arene\arene-fight.png
	if ( ErrorLevel == 0 )
		iDetect = 1
	ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\arene\arene-fight2.png
	if ( ErrorLevel == 0 )
		iDetect = 1
	if ( iDetect == 1 ) {
		if ( iArene >= iAreneForceFight )
			return (2)
		else {
			olast := 666 + 0
			Loop, 15 {
				Sleep 1500
				iEmpty := 0 + 0
				ImageSearch, X, Y, 656, 295, 711, 345, *90 .\img\arene\empty.png
				if ( ErrorLevel == 0 ) {
					displaymsg("Slot 1 empty")
					iEmpty += 1
				}
				ImageSearch, X, Y, 713, 326, 766, 377, *90 .\img\arene\empty.png
				if ( ErrorLevel == 0 ) {
					displaymsg("Slot 2 empty")
					iEmpty += 1
				}
				ImageSearch, X, Y, 659, 356, 709, 406, *90 .\img\arene\empty.png
				if ( ErrorLevel == 0 ) {
					displaymsg("Slot 3 empty")
					iEmpty += 1
				}
				ImageSearch, X, Y, 601, 326, 657, 375, *90 .\img\arene\empty.png
				if ( ErrorLevel == 0 ) {
					displaymsg("Slot 4 empty")
					iEmpty += 1
				}
				if (iEmpty != 4 && olast == iEmpty)
					break
				displaymsg( "LAST EMPTY SLOT: " olast )
				olast = %iEmpty%
				displaymsg( "EMPTY SLOT: " iEmpty )
			}
			if ( iEmpty == 3 || iLow > 0 ) {
				if ( iArene > 1 )
					return (1)
				else {
					iLockArene = %iLockAreneNew%
					return (-4)
				}
			} else if ( iEmpty == 2 && iArene >= iAreneForceFightt ) {
				if ( iArene > 1 )
					return (1)
				else {
					iLockArene = %iLockAreneNew%
					return (-4)
				}
			} else {
				Click 737, 512 ; ferme la boite de combat seulement si iLow est à 0				
				return (-2)
			}
		}
	}
	return (0)
}

arenerefresh() {
	global ax1
	global ay1
	global ax2
	global ay2
	global iArene
	global iLockArene
	global iLockPve
	global iLockAreneLoop
	global iAreneRefresh
	global iJoueurFocus
	global iGoodList
	
	sMsg = ARENE %iArene%/10: REFRESH LIST
	displaymsg(sMsg)
	
	Click 701, 300 ; boutton refresh
	Sleep 3333
	
	ImageSearch, X, Y, ax1, ay1, ax2, ay2, *90 .\img\arene\lag.png
	if ( ErrorLevel == 0 ) {
		Click 550,423
		Loop, 10 {
			ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\map\start.png
			if ( ErrorLevel == 0 )
				break
			clickback2(1)
			Sleep 1000
		}
		return (0)
	}
	
	iRefrechCooldown = 0
	ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\arene\refresh-cooldown1.png
	if ( ErrorLevel == 0 )
		iRefrechCooldown = 1
	ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\arene\refresh-cooldown2.png
	if ( ErrorLevel == 0 )
		iRefrechCooldown = 1
	if ( iRefrechCooldown == 1 ) {
		if ( iLockPve > 0 )
		{
			sMsg = ARENE %iArene%/10: REFRESH ON CD, WAITING ...
			displaymsg(sMsg)
			iRefreshOk = 0
			Loop, 20 {
				Sleep 10000
				ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\arene\refresh-up.png
				if ( ErrorLevel == 0 ) {
					sMsg = ARENE %iArene%/10: REFRESH READY, CLICK !!
					displaymsg(sMsg)
					Click 551, 406
					iRefreshOk = 1
					break ; on peux refresh
				}
				if ( iLockPve == 0 )
					return (0) ; le pve n'est plus lock, on retourne sur la map 
				lockdecrement()
			}
			if ( iRefreshOk == 0 )
				return (0)
		} else {
			sMsg = ARENE %iArene%/10: REFRESH ON CD, LOCK FOR %iLockAreneLoop%
			displaymsg(sMsg)
			iLockArene = %iLockAreneLoop%
			return (0)
		}
	}
	ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\arene\refresh-buff.png
	if ( ErrorLevel == 0 ) {
		sMsg = ARENE %iArene%/10: REFRESH LIST BUT LOSE BUFF
		displaymsg(sMsg)
		Click 557, 406
	}
	Sleep 3333
	iAreneRefresh = 0
	iJoueurFocus = 0
	iGoodList = 0
	iRefreshOk = 0
	Loop, 90 {
		Sleep 1000
		ImageSearch, X, Y, ax1, ay1, ax2, ay2, *90 .\img\arene\fight-up.png
		if ( ErrorLevel == 0 ) {
			iRefreshOk = 1
			break
		}
	}
	if ( iRefreshOk == 0 )
		return (0)
	return (1)
}

iscombat() {
	global iLoopCount
	global iDraw
	global iDrawLimit
	
	; NO LEADER FIGHT
	ImageSearch, X, Y, ax1, ay1, ax2, ay2, *90 .\img\fight\no-lead.png
	if ( ErrorLevel == 0 ) {
		Click 508,427 ; lancer combat sans leader
		Sleep 4000
	}
	
	WinGetPos, X, Y, , , Mobizen
	if (X != 277)
		return (0)
	iTotal = 0
	PixelGetColor, pixel1, 297, 542
	if (SubStr(pixel1, 1, 3) == "0xE" || SubStr(pixel1, 1, 3) == "0xF")
		iTotal++
	PixelGetColor, pixel2, 338, 542
	if (SubStr(pixel2, 1, 3) == "0xE" || SubStr(pixel2, 1, 3) == "0xF")
		iTotal++
	PixelGetColor, pixel3, 379, 542
	if (SubStr(pixel3, 1, 3) == "0xE" || SubStr(pixel3, 1, 3) == "0xF")
		iTotal++
	PixelGetColor, pixel4, 393, 528
	if (SubStr(pixel4, 1, 3) == "0xE" || SubStr(pixel4, 1, 3) == "0xF")
		iTotal++
	PixelGetColor, pixel5, 283, 532
	if (SubStr(pixel5, 1, 3) == "0xE" || SubStr(pixel5, 1, 3) == "0xF")
		iTotal++
	; sMsg = PIXEL SCAN %iTotal%: %pixel1% %pixel2% %pixel3% %pixel4% %pixel5% 
	; displaymsg(sMsg)
	if (iTotal > 3) {
		iPlay = 0
		PixelGetColor, pixel, 378, 527
		if (SubStr(pixel, 1, 3) == "0xF") {
			iPlay++
			Click 378, 527
		}
		if (iPlay == 1)
			sMsg = COMBAT LOOP *****************[ CLICK PLAY ]*****************[ %iLoopCount% ]
		else
			sMsg = COMBAT LOOP *****************[ %iTotal%/5 PIXEL ]*****************[ %iLoopCount% ]

		; DRAW DETECTION
		iTotal = 0
		PixelGetColor, pixel, 297, 305
		if (SubStr(pixel, 1, 3) == "0xF")
			iTotal++
		PixelGetColor, pixel, 306, 280
		if (SubStr(pixel, 1, 3) == "0xF")
			iTotal++
		PixelGetColor, pixel, 358, 292
		if (SubStr(pixel, 1, 3) == "0xF")
			iTotal++
		PixelGetColor, pixel, 286, 292
		if (SubStr(pixel, 1, 3) == "0xF")
			iTotal++
		if ( iTotal > 3 ) {
			iDraw++
			sMsg = COMBAT LOOP *************[ DRAW %iDraw%/%iDrawLimit% ]*************[ %iLoopCount% ]
			if ( iDraw >= iDrawLimit ) {
				Click 318, 288
				Sleep 2000
				Click 503, 439
				return (0)
			}
			Sleep 1000
		}

		; displaymsg(sMsg)
		return (1)
	}
	return (0)
}

replay() {
	global ax1
	global ay1
	global ax2
	global ay2
	global iReplay
	global iReplayMax
	global iLockPve
	
	if ( iReplay <= iReplayMax ) {
		sMsg = COMBAT: REPLAY %iReplay%/%iReplayMax% TRY
		displaymsg(sMsg)
		Sleep 2000
		Click 456,401 ; REPLAY
		Loop, 30 {
			Sleep 1500
			if (energyerror() == 1) {
				return (0)
				break
			}
			ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\fight\pve-fight.png
			if ( ErrorLevel == 0 ) {
				break
			}
		}
		Sleep 1000
		pveloby()
		return (1)
	} else {
		iLockPve = 5
		return (0)
	}
}

lowlevel( x1, y1, x2, y2) {
	global ax1
	global ay1
	global ax2
	global ay2
	iLow = 0
	ImageSearch, X, Y, x1, y1, x2, y2, *80 .\img\level\10.png
		if ( ErrorLevel == 0 )
			return (10)
	ImageSearch, X, Y, x1, y1, x2, y2, *80 .\img\level\10-2.png
		if ( ErrorLevel == 0 )
			return (10)
	ImageSearch, X, Y, x1, y1, x2, y2, *80 .\img\level\10-3.png
		if ( ErrorLevel == 0 )
			return (10)
	ImageSearch, X, Y, x1, y1, x2, y2, *80 .\img\level\20.png
		if ( ErrorLevel == 0 )
			return (20)
	ImageSearch, X, Y, x1, y1, x2, y2, *80 .\img\level\20-2.png
		if ( ErrorLevel == 0 )
			return (20)
	ImageSearch, X, Y, x1, y1, x2, y2, *80 .\img\level\20-3.png
		if ( ErrorLevel == 0 )
			return (20)
	ImageSearch, X, Y, x1, y1, x2, y2, *80 .\img\level\20-4.png
		if ( ErrorLevel == 0 )
			return (20)
	ImageSearch, X, Y, x1, y1, x2, y2, *80 .\img\level\20-5.png
		if ( ErrorLevel == 0 )
			return (20)
	ImageSearch, X, Y, x1, y1, x2, y2, *80 .\img\level\30.png
		if ( ErrorLevel == 0 )
			return (30)
	ImageSearch, X, Y, x1, y1, x2, y2, *80 .\img\level\30-2.png
		if ( ErrorLevel == 0 )
			return (30)
	ImageSearch, X, Y, x1, y1, x2, y2, *80 .\img\level\30-3.png
		if ( ErrorLevel == 0 )
			return (30)
	ImageSearch, X, Y, x1, y1, x2, y2, *50 .\img\level\31.png
		if ( ErrorLevel == 0 )
			return (31)
	ImageSearch, X, Y, x1, y1, x2, y2, *50 .\img\level\31-2.png
		if ( ErrorLevel == 0 )
			return (31)
	ImageSearch, X, Y, x1, y1, x2, y2, *80 .\img\level\32.png
		if ( ErrorLevel == 0 )
			return (32)
	ImageSearch, X, Y, x1, y1, x2, y2, *80 .\img\level\32-2.png
		if ( ErrorLevel == 0 )
			return (32)
	ImageSearch, X, Y, x1, y1, x2, y2, *80 .\img\level\33.png
		if ( ErrorLevel == 0 )
			return (33)
	ImageSearch, X, Y, x1, y1, x2, y2, *80 .\img\level\33-2.png
		if ( ErrorLevel == 0 )
			return (33)
	ImageSearch, X, Y, x1, y1, x2, y2, *80 .\img\level\33-3.png
		if ( ErrorLevel == 0 )
			return (33)
	ImageSearch, X, Y, x1, y1, x2, y2, *80 .\img\level\33-4.png
		if ( ErrorLevel == 0 )
			return (33)
	ImageSearch, X, Y, x1, y1, x2, y2, *80 .\img\level\33-5.png
		if ( ErrorLevel == 0 )
			return (33)
	ImageSearch, X, Y, x1, y1, x2, y2, *80 .\img\level\34.png
		if ( ErrorLevel == 0 )
			return (34)
	ImageSearch, X, Y, x1, y1, x2, y2, *80 .\img\level\34-2.png
		if ( ErrorLevel == 0 )
			return (34)
	ImageSearch, X, Y, x1, y1, x2, y2, *80 .\img\level\34-3.png
		if ( ErrorLevel == 0 )
			return (34)
	return (0)
}

isfarmeur() {
	global ax1
	global ay1
	global ax2
	global ay2
	return (1) ; on à plus besoin de ça .. 
	if (iZone == 666)
		return (1)
	sMsg = PVE - CHECK IF FARMEUR
	displaymsg(sMsg)
	ImageSearch, X, Y, ax1, ay1, ax2, ay2, *90 .\img\mob\farmeur\1.png
	if ( ErrorLevel == 0 )
		return (1)
	ImageSearch, X, Y, ax1, ay1, ax2, ay2, *90 .\img\mob\farmeur\1-2.png
	if ( ErrorLevel == 0 )
		return (1)
	ImageSearch, X, Y, ax1, ay1, ax2, ay2, *90 .\img\mob\farmeur\1-3.png
	if ( ErrorLevel == 0 )
		return (1)
	return (0)
}

jardin() {
	global ax1
	global ay1
	global ax2
	global ay2
	Sleep 3121
	displaymsg("JARDIN: MOB 1")
	Click 532,512
	iGotIt = 0
	Loop, 30 {
		if (iStatus == 0)
			return (0)
		ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\base\jardin.png
		if ( ErrorLevel == 0 ) {
			Sleep 1000
			Click 552,494
			iGotIt = 1
			break
		}
		Sleep 1500
	}
	if (iGotIt = 0)
		return (0)
	Sleep 1500
	displaymsg("JARDIN: MOB 2")
	Sleep 1500
	Click 582,514
	iGotIt = 0
	Loop, 30 {
		if (iStatus == 0)
			return (0)
		ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\base\jardin.png
		if ( ErrorLevel == 0 ) {
			Sleep 1000
			Click 552,494
			iGotIt = 1
			break
		}
		Sleep 1500
	}
	if (iGotIt = 0)
		return (0)
	Sleep 1500
	displaymsg("JARDIN: MOB 3")
	Sleep 1500
	Click 640,512
	iGotIt = 0
	Loop, 30 {
		if (iStatus == 0)
			return (0)
		ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\base\jardin.png
		if ( ErrorLevel == 0 ) {
			Sleep 1000
			Click 552,494
			iGotIt = 1
			break
		}
		Sleep 1500
	}
	if (iGotIt = 0)
		return (0)
	Sleep 1500
	displaymsg("JARDIN: MOB 4")
	Sleep 1500
	Click 691,510
	iGotIt = 0
	Loop, 30 {
		if (iStatus == 0)
			return (0)
		ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\base\jardin.png
		if ( ErrorLevel == 0 ) {
			Sleep 1000
			Click 552,494
			iGotIt = 1
			break
		}
		Sleep 1500
	}
	if (iGotIt = 0)
		return (0)
	return (1)
}

lockdecrement() {
	global iLockPve
	global iLockArene
	global iLockChat
	global iLockMana
	global iLockQuest
	global iLockPveLoop
	global iLockAreneLoop
	global iLockChatLoop
	global iLockManaLoop
	global iLockQuestLoop
	global iLockSocialMob
	global iLockSocialMobLoop
	
	if (iLockMana > 0)
		iLockMana--
		
	if (iLockChat > 0)
		iLockChat--
		
	if (iLockArene > 0)
		iLockArene--
		
	if (iLockPve > 0)
		iLockPve--
		
	if (iLockQuest > 0)
		iLockQuest--
		
	if (iLockSocialMob > 0)
		iLockSocialMob--
		
	sMsg = MANA %iLockMana%/%iLockManaLoop% /!\ CHAT %iLockChat%/%iLockChatLoop% /!\ ARENE %iLockArene%/%iLockAreneLoop% /!\ PVE %iLockPve%/%iLockPveLoop% /!\ QUEST %iLockQuest%/%iLockQuestLoop% /!\ %iLockSocialMob%/%iLockSocialMobLoop%
	displaymsg(sMsg)
}

setnocombat() {
	global iClickArene
	global iClickRival
	iClickArene = 0
	iClickRival = 0
}

areneinit() {
	global iClickArene
	global iClickRival
	global iAreneFight
	iAreneFight = 1
	iClickArene = 0
	iClickRival = 0
	iPage = 1
}

pveinit() {
	global iClickArene
	global iClickRival
	global iReplay
	iClickArene = 0
	iClickRival = 0
	iPage = 1
	iReplay++
}

clickback2( iCount = 1 ) {
	global ax1
	global ay1
	global ax2
	global ay2
	iTotal = 0
	loop {
		iTotal++
		if (iTotal > iCount)
			break
		; sMsg = PUSH BACK BUTTON %iTotal%/%iCount%
		; displaymsg( sMsg )
		MouseMove 790,555
		Sleep 1000
		ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\system\btn-back.png
		if ( ErrorLevel == 0 )
			Click %X%, %Y%
		Sleep 2000
	}
}

clickback( iCount = 1 ) {
	global ax1
	global ay1
	global ax2
	global ay2
	iTotal = 0
	loop {
		iTotal++
		if (iTotal > iCount)
			break
		MouseMove 631,572
		Sleep 500
		MouseMove 748,556
		Sleep 500
		ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\system\btn-back.png
		if ( ErrorLevel == 0 )
		{
			Click %X%, %Y%
			Sleep 2000
		}
	}
}

energyerror() {
	global ax1
	global ay1
	global ax2
	global ay2
	global iClickArene
	global iClickRival
	global iLockPve
	global iLockPveLoop
	ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\fight\no-energy.png
	if ( ErrorLevel == 0 ) {
		displaymsg(sMsg)
		iClickArene = 0
		iClickRival = 0
		iLockPve = %iLockPveLoop%
		return (1)
	}
	return (0)
}

mobizenreco() {
	global ax1
	global ay1
	global ax2
	global ay2
	; MOBIZEN A PLANTé et demande si on veux reco
	ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\system\reco.png
	if ( ErrorLevel == 0 ) {
		displaymsg("CLIC ON RECONNECT (wait 20s)")
		Click %X%, %Y%
		Sleep 21111
	}
	; MOBIZEN A PLANTé (bouton ok)
	ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\system\mobizen-ok.png
	if ( ErrorLevel == 0 ) {
		displaymsg("CLIC OK .. (wait 5s)")
		Click %X%, %Y%
		Sleep 5010
	}		
	; MOBIZEN A PLANTé (login)
	ImageSearch, connectX, connectY, ax1, ay1, ax2, ay2, *80 .\img\system\connect.png
	if ( ErrorLevel == 0 ) {
		displaymsg("TRYING TO LOGIN .. (wait 20s)")
		Click 403,303 ; retenir email btn to hide cursor from input box (otherwise no image detect) 
		Sleep 3333
		Click 403,303 ; retenir email btn to hide cursor from input box (otherwise no image detect) 
		Sleep 3121
		; VIDE LES CHAMPS LOGIN / MDP
		displaymsg("VIDE LES CHAMPS ...")
		loop {
			ImageSearch, X, Y, ax1, ay1, ax2, ay2, .\img\system\login-empty.png
			if ( ErrorLevel == 0 )
				break
			ImageSearch, X, Y, ax1, ay1, ax2, ay2, .\img\system\login-empty-2.png
			if ( ErrorLevel == 0 )
				break
			Click 497,245 ; champ login
			Sleep 3121
			iLoop = 30
			loop { ; vide le champs
				iLoop--
				if (iLoop == 0)
					break
				Send {Backspace}
				Sleep 20
				Send {Delete}
				Sleep 20
			}
			Send {Esc}
			Sleep 3121
			Click 428,280 ; champ mdp
			Sleep 3121
			iLoop = 30
			loop { ; vide le champs
				iLoop--
				if (iLoop == 0)
					break
				Send {Backspace}
				Sleep 20
				Send {Delete}
				Sleep 20
			}
			Send {Esc}
			Sleep 3121
			Click 403,303 ; retenir email btn to hide cursor from input box (otherwise no image detect) 
			Sleep 3333
			Click 403,303 ; retenir email btn to hide cursor from input box (otherwise no image detect) 
			Sleep 3121
		}
		displaymsg("SEND LOGIN/PASSWORD..")
		Sleep 3121
		Click 497,245 ; champ login
		Sleep 3121
		Send nestoyeur@gmail.com
		Send {Esc}
		Sleep 3121
		Click 428,280 ; champ mdp
		; Le mot de passe est dans c:\swbot.txt
		; Fichié créer avec cmd.bat par la commande: [echo|set /p="password" > swbot.txt]
		FileRead, mdp, C:\swbot.txt
		Sleep 3121
		Send %mdp%
		Sleep 3121
		displaymsg("CLIC LOGIN.. (wait 20sc)")
		Click %connectX%, %connectY%
		Sleep 21111
	}
}