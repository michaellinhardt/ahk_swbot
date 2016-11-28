; ECRAN ARENE RIVAL	
iRivalPage1 = 0
iRivalPage2 = 0
ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\arene\rival-page2.png
if ( ErrorLevel == 0 )
	iRivalPage2 = 1
ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\arene\rival-page2-variant.png
if ( ErrorLevel == 0 )
	iRivalPage2 = 1
ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\arene\rival-page1.png
if ( ErrorLevel == 0 )
	iRivalPage1 = 1
ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\arene\rival-page1-variant.png
if ( (ErrorLevel == 0 || iRivalPage1 == 1 || iRivalPage2 == 1) && iClickRival == 0 ) {
	sMsg = RIVAL %iArene%/10: NEED RELOAD, BACK TO MAP
	displaymsg( sMsg )
	Sleep 1500
	clickback2(1)
	Loop, 30 {
		ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\map\start.png
		if ( ErrorLevel == 0 )
			break
		Sleep 1500
	}
	goto Restart
} else if ( (ErrorLevel == 0 || iRivalPage1 == 1) && iClickRival == 1 ) {
	iNoMatch = 0
	sMsg = RIVAL %iArene%/10: SEARCHING OPPONENT
	displaymsg( sMsg )
	Sleep 1500
	loop {
		ImageSearch, X, Y, ax1, ay1, ax2, ay2, *130 .\img\arene\fight-up.png
		if ( ErrorLevel == 1 && iPage == 1 ) {
			sMsg = RIVAL %iArene%/10: NO ONE, SCROLLING DOWN
			displaymsg( sMsg )
			iPage++
			dragarene()
			Sleep 3333
			dragarene()
			Sleep 3333
			continue
		} else if ( ErrorLevel == 1 && iPage == 2 ) {
			sMsg = RIVAL %iArene%/10: ALL CLEAR, BACK TO MAP
			displaymsg( sMsg )
			iDoRival = 0 ; car si on arrive à ce cas c'est qu'il y a eu un bug
			clickback2(1)
			Loop, 30 {
				ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\map\start.png
				if ( ErrorLevel == 0 )
					break
				Sleep 1500
			}
			break
		} else if ( ErrorLevel == 0 ) {
			sMsg = RIVAL %iArene%/10: FOUND SOMEONE (wait 3sc)
			displaymsg( sMsg )
			Click %X%,%Y%
			Sleep 4000
			iDetect = 0
			ImageSearch, X, Y, ax1, ay1, ax2, ay2, *90 .\img\arene\arene-fight.png
			if ( ErrorLevel == 0 )
				iDetect = 1
			ImageSearch, X, Y, ax1, ay1, ax2, ay2, *90 .\img\arene\arene-fight2.png
			if ( ErrorLevel == 0 )
				iDetect = 1
			if ( iDetect == 1) {
				sMsg = RIVAL %iArene%/10: SELECT TEAM
				displaymsg( sMsg )
				areneinit()
				goteamrival()
				sMsg = RIVAL %iArene%/10: READY?!
				displaymsg( sMsg )
				Loop, 20 {
					Sleep 1500
					Click 805, 397 ; ferme tchat combat
					if (iscombat() == 1) {
						break
					}
				}
				iAreneFight = 1
				sMsg = RIVAL %iArene%/10: GO!!
				displaymsg( sMsg )
			} else {
				sMsg = RIVAL %iArene%/10: LAST FIGHT DONT START, BACK TO MAP
				displaymsg( sMsg )
				clickback(2)
			}
			break
		}
	}
}