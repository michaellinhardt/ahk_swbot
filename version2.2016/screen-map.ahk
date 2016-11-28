; SCREEN MAP
ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\map\start.png
if ( ErrorLevel == 0 ) {
	Sleep 3121
	iReplay = 0
	setnocombat()
	isArene = 0
	if (iLockArene > 0 && iLockPve > 0) {
		displaymsg("MAP: PVE AND ARENE ARE LOCK, zZzZ..")
		Sleep 3000
		goto Restart
	}
	if ( iLockArene == 0 ) {
		#Include screen-map-gopvp.ahk
	}
	; SI PAS D'ARENE POINT ->
	if (isArene == 0) {
		if ( iLockPve > 0 ) {
			displaymsg("MAP: NO ARENE NO PVE, zZzZ ...")
			Sleep 3000
			goto Restart
		} else
				#Include screen-map-gopve.ahk
	}
}