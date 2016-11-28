fightloop() {
	global ax1
	global ay1
	global ax2
	global ay2
	global iLockPve
	global iZone
	global iReplay
	global iReplayMax
	global iLockPve
	global iLockPveLoop
	global iReplayMax


	if (iscombat() == 1) {
		iLoopCount = 0
		loop {
			if (iStatus == 0)
				break
			if (iscombat() == 0) {
				if (iLoopCount > 0) {
					Sleep 3121
					if (iscombat() == 0) {
						sMsg = COMBAT: FIGHT OVER, WAIT FOR LOOT SCREEN
						displaymsg(sMsg)
						iLoop = 0
						sMsg = COMBAT: CLICK TO POP LOOT
						displaymsg(sMsg)
						Loop {
							iLoop++
							Click 805, 397
							Sleep 1000
							ImageSearch, FoundX, FoundY, ax1, ay1, ax2, ay2, *90 .\img\fight\lag.png
							if ( ErrorLevel == 0 ) {
								Click 502,442
								Sleep 5000
							}
							if ((isloot3() == 1 || isloot() == 1) && replay() == 0) {
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
								break
							}
							ImageSearch, FoundX, FoundY, ax1, ay1, ax2, ay2, *90 .\img\fight\reanimer.png
							if ( ErrorLevel == 0 )
								break
							ImageSearch, FoundX, FoundY, ax1, ay1, ax2, ay2, *90 .\img\arene\duel-screen.png
							if ( ErrorLevel == 0 )
								break
							ImageSearch, FoundX, FoundY, ax1, ay1, ax2, ay2, *90 .\img\arene\duel-screen2.png
							if ( ErrorLevel == 0 )
								break
							ImageSearch, X, Y, ax1, ay1, ax2, ay2, *90 .\img\fight\pve-fight.png
							if ( ErrorLevel == 0 )
								break
							ImageSearch, X, Y, ax1, ay1, ax2, ay2, *90 .\img\arene\arene.png
							if ( ErrorLevel == 0 )
								break
							ImageSearch, X, Y, ax1, ay1, ax2, ay2, *90 .\img\arene\rival-page.png
							if ( ErrorLevel == 0 )
								break
							if ((iAreneFight == 1 && iLoop >= 50) || iLoop >= 100)
									break
						}
						return (1)
					}
				}
			}
			iLoopCount++
			Sleep 3333
		}
		sMsg = COMBAT: SCANNING FOR LOOT
		displaymsg(sMsg)
	}
	return (0)
}