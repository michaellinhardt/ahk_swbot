clickokbtn() {
	global ax1
	global ay1
	global ax2
	global ay2
	ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\loot\ok.png
	if ( ErrorLevel == 0 )
		Click %X%,%Y%
	ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\loot\ok2.png
	if ( ErrorLevel == 0 )
		Click %X%,%Y%
	ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\loot\ok3.png
	if ( ErrorLevel == 0 )
		Click %X%,%Y%
	ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\loot\ok4.png
	if ( ErrorLevel == 0 )
		Click %X%,%Y%
	ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\loot\ok-dungeon.png
	if ( ErrorLevel == 0 )
		Click %X%,%Y%
	ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\loot\ok-dungeon2.png
	if ( ErrorLevel == 0 )
		Click %X%,%Y%
	return (1)
}

isokbtn() {
	global ax1
	global ay1
	global ax2
	global ay2
	ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\loot\ok.png
	if ( ErrorLevel == 0 )
		return (1)
	ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\loot\ok2.png
	if ( ErrorLevel == 0 )
		return (1)
	ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\loot\ok3.png
	if ( ErrorLevel == 0 )
		return (1)
	ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\loot\ok4.png
	if ( ErrorLevel == 0 )
		return (1)
	ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\loot\ok-dungeon.png
	if ( ErrorLevel == 0 )
		return (1)
	ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\loot\ok-dungeon2.png
	if ( ErrorLevel == 0 )
		return (1)
	return (0)
}

isloot3() {
	if (isokbtn() == 1) {
		clickokbtn()
		return (1)
	}
	return (0)
}

isloot2() {
	global ax1
	global ay1
	global ax2
	global ay2
	
	if ( isokbtn() == 1 )
	{
		iClickOk = 0
		ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\loot\mob-stat.png
		if ( ErrorLevel == 0 ) ; MOB
			iClickOk = 1
		ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\loot\tissu.png
		if ( ErrorLevel == 0 ) ; TISSU
			iClickOk = 1
		ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\loot\minerai.png
		if ( ErrorLevel == 0 ) ; MINERAI
			iClickOk = 1
		ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\loot\roche.png
		if ( ErrorLevel == 0 ) ; ROCHE
			iClickOk = 1
		ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\loot\compo.png
		if ( ErrorLevel == 0 ) ; VARIOUS COMPO
			iClickOk = 1
		ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\loot\compo-2.png
		if ( ErrorLevel == 0 ) ; ESSENCE
			iClickOk = 1
		ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\loot\pierre.png
		if ( ErrorLevel == 0 ) ; PIERRE
			iClickOk = 1
		if ( iClickOk == 1) {
			clickokbtn()
			sMsg = COMBAT: LOOT DETECTED (COMPO, MOB..) !
			displaymsg(sMsg)
			return (1)
		}
	}
	return (0)
}

isloot()
{
	global ax1
	global ay1
	global ax2
	global ay2
	global iZone
	; VELIN
	ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\loot\velin.png
	if ( ErrorLevel == 0 ) {
		sMsg = COMBAT: LOOT DETECTED, VELIN !
		displaymsg(sMsg)
		Click 553, 472
		return (1)
	}
	if (isloot2() == 1)
		return (1)
	; RUNE LOOT
	ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\loot\obtenu.png
	if ( ErrorLevel == 0 ) {
		; RUNE 4 ETOILE
		PixelGetColor, color, 478, 345
		PixelGetColor, color2, 478, 343
		sColor := % SubStr(color, 1, 3)
		sColor2 := % SubStr(color2, 1, 3)
		if ( iZone == 666 ) { ; ( sColor == "0xE" || sColor == "0xD" || sColor2 == "0xE" || sColor2 == "0xD" ) {
			sMsg = COMBAT: LOOT DETECTED, DUNGEON MODE, KEEP RUNE !
			displaymsg(sMsg)
			Click 600,490
			return (1)
		} else {
			sMsg = COMBAT: LOOT DETECTED, SELLING 1-3 STAR RUNE !
			if ( iZone != 666 )
				sMsg = COMBAT: LOOT DETECTED, FARM MODE, SELL RUNE
			displaymsg(sMsg)
			Click 511,494
			Sleep 3333
			ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\loot\confirm.png
			if ( ErrorLevel == 0 )
				Click 502,426
			return (1)
		}
	}
	return (0)
}