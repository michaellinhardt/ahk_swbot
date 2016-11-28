; ECRAN LIST PVP JOUEUR
iErrorOk = 1
ImageSearch, X, Y, ax1, ay1, ax2, ay2, *90 .\img\arene\duel-screen2.png
if ( ErrorLevel == 0)
	iErrorOk = 0
ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\arene\duel-screen.png
if ( (ErrorLevel == 0 || iErrorOk == 0) 
&& ( (iAreneFight == 0 && iClickArene == 0) || iLockArene > 0 || iArene == 0) )
{
	sMsg = ARENE %iArene%/10: BACK TO MAP
	displaymsg(sMsg)
	iClickArene = 0
	iAreneFight = 0
	clickback(1)
	Loop, 10 {
		ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\map\start.png
		if ( ErrorLevel == 0 )
			break
		Sleep 1000
	}
	goto Restart
} else if ( ErrorLevel == 0 ) {
	Sleep 3121
	iClickRival = 0
	if (iClickArene == 0) { ; drag l'arene quand on reviens de combat pvp ou qu'on viens de refresh
		Loop, 2 {
			revdragdungeon()
			Sleep 1000
		}
	}
	iAreneFight = 0
	iClickArene = 0
	ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\arene\rival-up.png
	if ( iDoRival == 0 )
		ErrorLevel = 1
	if (ErrorLevel == 0 && iArene > 1) {
			sMsg = ARENE %iArene%/10: RIVAl UP
			displaymsg( sMsg )
			iClickRival = 1
			iPage = 1
			Sleep 1500
			Click 367, 328 ; clic sur l'onglet rival
			Sleep 3333
	} else {
		if (iAreneRefresh == 1 && arenerefresh() == 0) {
				sMsg = ARENE %iArene%/10: CANT REFRESH, BACK TO MAP
				displaymsg( sMsg )
				clickback(2)
				Loop, 300 {
					ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\map\start.png
					if ( ErrorLevel == 0 )
						break
					Sleep 30
				}
				goto Restart
		} else {
			sMsg = ARENE %iArene%/10: SCANNING PLAYER LIST
			displaymsg( sMsg )
			iJoueur = 0
			loop
			{
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
					goto Restart
				}
				if (iStatus == 0)
					goto Restart
				if (iJoueur > 0) {
					Loop, 40 {
						ImageSearch, X, Y, ax1, ay1, ax2, ay2, *90 .\img\arene\duel-screen.png
						if ( ErrorLevel == 0 )
							break
						ImageSearch, X, Y, ax1, ay1, ax2, ay2, *90 .\img\arene\duel-screen2.png
						if ( ErrorLevel == 0 )
							break
						Sleep 100
					}
				}
				iJoueur++
				if (iJoueur > 10 || iJoueurFocus > 9)
					break
				; MOUVEMENT
				if ( iJoueur == 5 ) {
					sMsg = ARENE %iArene%/10: SCROLLING DOWN 1 TIMES
					displaymsg( sMsg )
					Sleep 2000
					dragArene2()
					Sleep 2000
				}
				if ( iJoueur == 7 ) {
					sMsg = ARENE %iArene%/10: SCROLLING DOWN 2 TIMES
					displaymsg( sMsg )
					Sleep 3121
					Loop, 2 {
						dragArene2()
						Sleep 2000
					}
				}
				
				; SKIP DEJA SCAN
				if (( iJoueur <= iJoueurFocus) || iJoueur <= iAreneSkip) {
					sMsg = ARENE %iArene%/10: PLAYER %iJoueur% ALREADY SCAN
					displaymsg( sMsg )
					continue
				}
				iJoueurFocus++
					
				; SCAn LE LEVEL
				iLow = 0
				if ( iJoueur == 1)
					iLow := lowlevel(429, 322, 523, 357)
				if ( iJoueur == 2)
					iLow := lowlevel(452, 355, 529, 391)
				if ( iJoueur == 3)
					iLow := lowlevel(451, 410, 534, 443)
				if ( iJoueur == 4)
					iLow := lowlevel(453, 445, 537, 485)
				if ( iJoueur == 5)
					iLow := lowlevel(441, 415, 543, 459)
				if ( iJoueur == 6)
					iLow := lowlevel(443, 458, 530, 496)
				if ( iJoueur == 7)			
					iLow := lowlevel(451, 342, 532, 381)
				if ( iJoueur == 8)
					iLow := lowlevel(448, 387, 526, 425)
				if ( iJoueur == 9)
					iLow := lowlevel(454, 430, 529, 467)
				if ( iJoueur == 10) {
					sMsg = ARENE %iArene%/10: SCROLLING DOWN 1 TIMES
					displaymsg(sMsg)
					dragArene2()
					Sleep 1000
					iLow := lowlevel(435, 410, 532, 449)
				}
				
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
					goto Restart
				}
				
				sMsg = ARENE %iArene%/10: PLAYER %iJoueur% SCAN LEVEL
				displaymsg(sMsg)
				
				; sort si on était la jsute pour une goodlist
				if ( iArene == 0 ) {
					if (iLow > 0 && iLow < iGoodListLevel) {
						sMsg = ARENE %iArene%/10: PLAYER %iJoueur% LV.%iLow% FOR GOODLIST
						displaymsg(sMsg)
						iGoodList = 1
						break
					}
					continue
				}
				
				; click now
				sMsg = ARENE %iArene%/10: PLAYER %iJoueur% LV.%iLow% OPEN TEAM
				displaymsg(sMsg)
				if (( iJoueur == 1) && ( iArene > 0 ))
						Click 717,340
				if (( iJoueur == 2) && ( iArene > 0 ))
						Click 719,380
				if (( iJoueur == 3) && ( iArene > 0 ))
						Click 718,426
				if (( iJoueur == 4) && ( iArene > 0 ))
						Click 720,467
				if (( iJoueur == 5) && ( iArene > 0 ))
						Click 719,432
				if (( iJoueur == 6) && ( iArene > 0 ))
						Click 717,473
				if (( iJoueur == 7) && ( iArene > 0 ))
						Click 722,361
				if (( iJoueur == 8) && ( iArene > 0 ))
						Click 716,401
				if (( iJoueur == 9) && ( iArene > 0 ))
						Click 719,451
				if (( iJoueur == 10) && ( iArene > 0 ))
						Click 718,439
				
				; wait method
				Sleep 1000
				Loop, 40 {
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
						goto Restart
					}
					ret := areneclick(iArene, iAreneForceFight, iLow)
					if ( ret != 0 )
						break
					Sleep 1000
				}
				Sleep 1000
				if (ret > 0) {
					if (ret == 2) {
						iAreneRefresh = 1
						sMsg = ARENE %iArene%/10: PLAYER %iJoueur% LV.%iLow% FORCE MATCH (15sc)
					} else if (iLow > 0) {
						iAreneRefresh = 0
						sMsg = ARENE %iArene%/10: PLAYER %iJoueur% LV.%iLow% EASY MATCH (15sc)
					} else
						sMsg = ARENE %iArene%/10: PLAYER %iJoueur% LV.%iLow% NO DEF MATCH (15sc)
					displaymsg(sMsg)
					; msgbox, % sMsg
					areneinit()
					goteampvp()
					iArene--
					sMsg = ARENE %iArene%/10: COMBAT LOADING...
					displaymsg(sMsg)
					Loop, 20 {
						Sleep 2500
						ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\arene\bug-pvp.png
						if (ErrorLevel == 0 ) {
							Click 553,420
							Sleep 2000
						}
						Click 805, 397 ; skip dialog
						if (iscombat() == 1)
							break
					}
					break
				} else if ( ret == -1 || ret == -4 ) {
					if ( ret == -1 ) {
						iJoueurFocus--
						sMsg = ARENE %iArene%/10: NO ARENE POINT! LOCK FOR %iLockAreneLoop%
						displaymsg(sMsg)
					} else if ( ret == -4 ) {
						iJoueurFocus--
						sMsg = ARENE %iArene%/10: KEEP THIS MATCH FOR LATER (NEED 2 ARENE POINT)
						displaymsg(sMsg)
						clickback(1)
					}
					clickback(1)
					setnocombat()
					goto Restart
				} else if ( ret == -3 ) {
					sMsg = ARENE %iArene%/10: PLAYER %iJoueur% LV.%iLow% IS ALREADY DOWN
				} else if ( ret == -2) {
					sMsg = ARENE %iArene%/10: PLAYER %iJoueur% LV.%iLow% IS TO STRONG
				}
				displaymsg(sMsg)
			}
			
			; FIN DE LA LOOP JOUEUR
			if (iJoueur > 10 || (iArene == 0 && iGoodList == 0)) {
				; aucun match trouvé ou pas de goodlist, on refresh
				setnocombat()
				if (arenerefresh() == 0) {
					sMsg = ARENE %iArene%/10: REFRESH CD, BACK TO MAP
					displaymsg(sMsg)
					iAreneRefresh = 1
					clickback2(2)
					if (iLockPve == 0) {
						iLockArene = 1
						sMsg = ARENE %iArene%/10: ENERGY UP, LOCKING PVP FOR %iLockArene%/%iLockAreneLoop% LOOP
						displaymsg(sMsg)
					}
					Loop, 10 {
						ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\map\start.png
						if ( ErrorLevel == 0 )
							break
						Sleep 100
					}
					goto Restart
				} else {
					sMsg = ARENE %iArene%/10: FRESH LIST, NEW SCAN COMMING (BACK TO MAP)
					displaymsg(sMsg)
					iAreneFight = 1
					iClickArene = 0
					Loop, 10 {
						ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\map\start.png
						if ( ErrorLevel == 0 )
							break
						clickback2(1)
						Sleep 1000
					}
					goto Restart
				}
			}
		}
	}
}
