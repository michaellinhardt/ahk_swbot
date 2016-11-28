pveloby() {
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

	; SCREEN COMBAT PVE LOBBY
	if ( iLockPve == 0 ) {
		ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\fight\pve-fight.png
		if ( ErrorLevel == 0 ) {
			if (iZone < 666 && isfarmeur() == 0) {
				sMsg = PVE %iReplay%/%iReplayMax%: ALERT NO FARMEUR FOUND, BACK TO MAP
				displaymsg( sMsg )
				iLockPve = %iLockPveLoop%
				Loop, 6 {
					clickback2(1)
					Sleep 1000
					ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\base\avatar.png
					if ( ErrorLevel == 0 )
						break
				}
				Click 588,520
				Sleep 3000
			} else {
				sMsg = PVE %iReplay%/%iReplayMax%: CLIC ON PLAY
				displaymsg( sMsg )
				Click 742,458 ; lance le combat
				sMsg = PVE %iReplay%/%iReplayMax%: CHECKING ENERGY, START FIGHT
				displaymsg(sMsg)
				Sleep 3333
				if (energyerror() == 0) {
					sMsg = PVE %iReplay%/%iReplayMax%: READY?!
					displaymsg(sMsg)
					pveinit()
					Loop, 20 {
						if (iscombat() == 1)
							break
						Sleep 3121
					}
					sMsg = PVE %iReplay%/%iReplayMax%: GO!!
					displaymsg(sMsg)
				}
			}
		}
	}
}