sMsg = MAP %iZone%-%iNiveau%: GO TO ZONE %iZone%
displaymsg( sMsg )
Sleep 1500
; COMMENCE LE ROOTAGE DE LA ZONE
if ( iZone == 1 )
	Click 410,380
if ( iZone == 2 )
	Click 499,336
if ( iZone == 3 )
	Click 595,355
if ( iZone == 4 )
	Click 626,285
if ( iZone == 5 )
	Click 787,307
if ( iZone == 6 )
	Click 769,385
if (iZone > 6 && iZone < 666) {
	Click 769,385
	Sleep 3333
	Click 809,270
	Sleep 3333
}
if ( iZone == 7 )
	Click 501,442
if ( iZone == 8 )
	Click 807,463
if ( iZone == 9 )
	Click 627,382
	
if ( iZone < 666 ) {
	sMsg = MAP %iZone%-%iNiveau%: SELECT DIFFICULTY %iDifficulty%
	displaymsg( sMsg )
	Sleep 3333
	
	;difficulté
	Click 763,298
	Sleep 1500
	if ( iDifficulty == 1 )
		Click 742,354
	else if ( iDifficulty == 2 )
		Click 736,419
	else
		Click 733,479
		
	sMsg = MAP %iZone%-%iNiveau%: GO TO NIVEAU %iNiveau%
	displaymsg( sMsg )
	Sleep 1500

	; niveau
	if ( iNiveau == 1 )
		Click 782,353
	if ( iNiveau == 2 )
		Click 781,410
	if ( iNiveau == 3 )
		Click 782,464
	if ( iNiveau == 4 )
		Click 782,514
	if ( iNiveau > 4 ) {
		dragniveau()
		Sleep 3333
		dragniveau()
		Sleep 3333
	}
	if ( iNiveau == 5 )
		Click 784,382
	if ( iNiveau == 6 )
		Click 780,438
	if ( iNiveau == 7 )
		Click 780,489
	sMsg = MAP %iZone%-%iNiveau%: VERIF ENERGY..
	displaymsg( sMsg )
	Sleep 3333
	if (energyerror() == 1) {
		sMsg = MAP %iZone%-%iNiveau%: NO ENERGY, BACK TO BASE
		displaymsg( sMsg )
		clickback(3)
		Loop, 30 {			
			ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\base\avatar.png
			if ( ErrorLevel == 0 )
				break
			Sleep 1500
		}
		goto Restart
	}
}
if ( iZone == 666 ) { ;dungeon
	sMsg = MAP %iZone%-%iNiveau%: OPEN DUNGEON
	displaymsg( sMsg )
	Click 607,500 ; clic dungeon on map
	Loop, 30 {
		ImageSearch, X, Y, ax1, ay1, ax2, ay2, *90 .\img\dungeon\geant.png
		if ( ErrorLevel == 0 )
			break
		Sleep 1500
	}
	Sleep 1500
	sFile = .\img\dungeon\magie.png
	sMsg = MAP %iZone%-%iNiveau%:
	if ( iDungeon == 1 ) { ; magie
		sFile = .\img\dungeon\magie.png
		sMsg = %sMsg% GO MAGIE
	}
	if ( iDungeon == 2 ) { ; vent
		sFile = .\img\dungeon\vent.png
		sMsg = %sMsg% GO VENT
	}
	if ( iDungeon == 3 ) { ; geant
		sFile = .\img\dungeon\geant.png
		sMsg = %sMsg% GO GEANT
	}
	if ( iDungeon == 4 ) { ; dragon
		sFile = .\img\dungeon\dragon.png
		sMsg = %sMsg% GO DRAGON
	}
	if ( iDungeon == 5 ) { ; necro
		sFile = .\img\dungeon\necro.png
		sMsg = %sMsg% GO NECRO
	}
	if ( iDungeon == 6 ) { ; feu
		sFile = .\img\dungeon\feu.png
		sMsg = %sMsg% GO FEU
	}
	if ( iDungeon == 7 ) { ; eau
		sFile = .\img\dungeon\eau.png
		sMsg = %sMsg% GO EAU
	}
	if ( iDungeon == 8 ) { ; dark
		sFile = .\img\dungeon\dark.png
		sMsg = %sMsg% GO DARK
	}
	displaymsg(sMsg)
	iEnter = 0
	loop, 5 {
		;cherche entré
		ImageSearch, X, Y, ax1, ay1, ax2, ay2, *100 %sFile%
		if ( ErrorLevel == 0 ) {
			sMsg = MAP %iZone%-%iNiveau%: ENTER IN DUNGEON
			displaymsg( sMsg )
			Click %X%, %Y% 
			iEnter++
			Sleep 3000
			break
		}
		dragdungeon() ; drag
		Sleep 1500
	}
	if ( iEnter == 0 )
	{
		sFile = .\img\dungeon\magie.png
		loop, 5 {
			;cherche entré
			ImageSearch, X, Y, ax1, ay1, ax2, ay2, *100 %sFile%
			if ( ErrorLevel == 0 ) {
				sMsg = MAP %iZone%-%iNiveau%: ENTER IN DUNGEON
				displaymsg( sMsg )
				Click %X%, %Y% 
				iEnter++
				Sleep 3000
				break
			}
			dragdungeon() ; drag
			Sleep 1500
		}
	}

	if (iEnter == 0) {
		sMsg = MAP %iZone%-%iNiveau%: CANT FIND DUNGEON ENTRANCE, BACK BASE & LOCK
		iLockPve = %iLockPveLoop%
		displaymsg( sMsg )
		clickback(4)
		goto Restart
	}

	sMsg = MAP %iZone%-%iNiveau%: REVERSE DRAG NIVEAU 1/3
	displaymsg( sMsg )
	revdragdungeon()
	sMsg = MAP %iZone%-%iNiveau%: REVERSE DRAG NIVEAU 2/3
	displaymsg( sMsg )
	Sleep 3121
	revdragdungeon()
	sMsg = MAP %iZone%-%iNiveau%: REVERSE DRAG NIVEAU 3/3
	displaymsg( sMsg )
	Sleep 3121
	revdragdungeon()
	sMsg = MAP %iZone%-%iNiveau%: SELECT NIVEAU %iNiveau%
	displaymsg( sMsg )
	Sleep 3121
	if ( iNiveau == 1 )
		Click 719,348
	if ( iNiveau == 2 )
		Click 718,395
	if ( iNiveau == 3 )
		Click 717,440
	if ( iNiveau == 4 )
		Click 720,493
	if (iNiveau > 4 ) {
		dragarene()
		Sleep 3121
	}
	if ( iNiveau == 5 )
		Click 720,386
	if ( iNiveau == 6 )
		Click 715,437
	if ( iNiveau == 7 )
		Click 718,482
	if (iNiveau > 7 ) {
		dragarene()
		Sleep 3121
	}
	if (iNiveau == 8 )
		Click 718,404
	if (iNiveau == 9)
		Click 718,455
	if (iNiveau == 10)
		Click 719,498
	
	Sleep 3333
	if (energyerror() == 1) {
		sMsg = DUNGEON %iZone%-%iNiveau%: NO ENERGY, BACK TO BASE
		displaymsg( sMsg )
		clickback(3)
		goto Restart
	}
	sMsg = DUNGEON %iZone%-%iNiveau%: CHECK ENERGY
	displaymsg( sMsg )
	Sleep 3333
	Click 738,450 ; clic sur go
	Sleep 3333
	if (energyerror() == 1) {
		sMsg = DUNGEON %iZone%-%iNiveau%: NO ENERGY, BACK TO BASE
		displaymsg( sMsg )
		clickback(4)
		goto Restart
	}
	sMsg = DUNGEON %iZone%-%iNiveau%: READY?!
	displaymsg( sMsg )
	Loop, 20 {
		Sleep 3121
		Click 805, 397 ; skip dialog
		if (iscombat() == 1)
			break
	}
	sMsg = DUNGEON %iZone%-%iNiveau%: GO!!
	displaymsg( sMsg )
}