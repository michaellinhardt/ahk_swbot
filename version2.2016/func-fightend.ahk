fightend() {
	global ax1
	global ay1
	global ax2
	global ay2

	global iReplay
	global iReplayMax
	
	; REANIMER && REPLAY
	ImageSearch, FoundX, FoundY, ax1, ay1, ax2, ay2, *90 .\img\fight\reanimer.png
	if ( ErrorLevel == 0 ) {
		Click 632, 443 ; reanimer -> non <-
		sMsg = COMBAT: YOU LOSE.. CLICK REVIVE
		displaymsg(sMsg)
		setnocombat()
		Loop, 4 {
			Click 818, 388 ; clic tout à droite
			Sleep 3121
		}
		if ( replay() == 1 ) {
			return (1)
		} else {
			sMsg = COMBAT: REPLAY LIMIT %iReplay%/%iReplay%, BACK TO MAP
			displaymsg(sMsg)
			Sleep 3000
			Loop, 6 {
				clickback2(1)
				Sleep 1000
				ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\base\avatar.png
				if ( ErrorLevel == 0 )
					break
			}
			Click 588,520
			Sleep 3000
			return (1)
		}
	}
	
	; LOOT SCREEN && REPLAY
	if ( isloot() == 1 ) {
		setnocombat()
		Sleep 3333
		if ( replay() == 0 ) {
			sMsg = COMBAT: REPLAY LIMIT %iReplay%/%iReplay%, BACK TO MAP
			displaymsg(sMsg)
			Loop, 6 {
				clickback2(1)
				Sleep 1000
				ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\base\avatar.png
				if ( ErrorLevel == 0 )
					break
			}
			Click 588,520
			Sleep 3000
		}
	}
}