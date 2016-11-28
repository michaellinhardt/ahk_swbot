; displaymsg("??????????????????????????? RARE EVENT ???????????????????????????")

if (energyerror() == 1) {
	sMsg = ENERGY ERROR, BACK AND GOTO RESTART
	displaymsg(sMsg)
	clickback(1)
	goto Restart
}

; ICONE SW DETECTé
ImageSearch, FoundX, FoundY, ax1, ay1, ax2, ay2, *80 .\img\system\sw-open.png
if ( ErrorLevel == 0 ) {
	sMsg = ICONE SW DETECTED, GO (45sc)
	displaymsg(sMsg)
	Click 629, 357
	Sleep %iWaitSWLoad%
}

iLoop = 0
loop {
	ImageSearch, FoundX, FoundY, ax1, ay1, ax2, ay2, *90 .\img\system\pub-start.png
	if ( ErrorLevel == 1 )
		break
	iLoop++
	sMsg = STARTING SCREENN PUB LOOP %iLoop%  (2sc)
	displaymsg(sMsg)
	Click 350,524
	Sleep 3333
}

; START SCREEN
ImageSearch, FoundX, FoundY, ax1, ay1, ax2, ay2, *80 .\img\system\start.png
if ( ErrorLevel == 0 ) {
	sMsg = TOUCH TO START (4sc)
	displaymsg(sMsg)
	Click 350,524
	Sleep 4000
}

; PUB
ImageSearch, FoundX, FoundY, ax1, ay1, ax2, ay2, *90 .\img\pub\1.png
if ( ErrorLevel == 0 ) {
	sMsg = IM A BOT, I DONT WANT BUY YOUR SHIT
	displaymsg(sMsg)
	Click 506,437
	Sleep 3333
}

; CONNEXTION RETARDé
ImageSearch, FoundX, FoundY, ax1, ay1, ax2, ay2, *90 .\img\system\deco.png
if ( ErrorLevel == 0 ) {
	Click 505,442
	Goto Restart
}

; VOULEZ VOUS VRAIMENT QUITTER LE JEU
ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\system\leave-game.png
if ( ErrorLevel == 0 ) {
	iLeaveGame++
	if (iLeaveGame >= iLeaveGameLimit) {
		ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\system\leave-game-start.png
		if ( ErrorLevel == 0 ) {
			sMsg = LEAVE ERROR ON START SCREEN, CLICK BACK
			displaymsg(sMsg)
			clickback(1)
			sMsg = NOW TOUCH TO START
			displaymsg(sMsg)
			Click 350,524 ; (on est sur lecran dacceuil donc on lance le jeu)
			Sleep 3333
			goto Restart		
		}
		sMsg = LEAVE ERROR %iLeaveGame%/%iLeaveGameLimit%, LIMIT! RESTART GAME
		displaymsg(sMsg)
		Click 460,426 ; clic oui (pour relancer le jeu)
		Sleep 3333
		goto Restart
	} else {
		sMsg = LEAVE ERROR %iLeaveGame%/%iLeaveGameLimit%, CLICK BACK
		displaymsg(sMsg)
		goto ExitAll
	}
}

; ARENE RANK BOX
ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\arene\rank-box.png
if ( ErrorLevel == 0 ) {
	Click 510,452
	Sleep 3121
}
mobizenreco()
