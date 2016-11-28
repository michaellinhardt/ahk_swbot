displaymsg( "MAP: VERIFY ARENE POINT" )
iArene = 999
Loop, 10 {
	ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\map\arene13.png
	if ( ErrorLevel == 0 )
		iArene = 13
	ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\map\arene12.png
	if ( ErrorLevel == 0 )
		iArene = 12
	ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\map\arene10.png
	if ( ErrorLevel == 0 )
		iArene = 10
	ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\map\arene9.png
	if ( ErrorLevel == 0 )
		iArene = 9
	ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\map\arene8.png
	if ( ErrorLevel == 0 )
		iArene = 8
	ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\map\arene7.png
	if ( ErrorLevel == 0 )
		iArene = 7
	ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\map\arene6.png
	if ( ErrorLevel == 0 )
		iArene = 6
	ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\map\arene5.png
	if ( ErrorLevel == 0 )
		iArene = 5
	ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\map\arene4.png
	if ( ErrorLevel == 0 )
		iArene = 4
	ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\map\arene3.png
	if ( ErrorLevel == 0 )
		iArene = 3
	ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\map\arene3-2.png
	if ( ErrorLevel == 0 )
		iArene = 3
	ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\map\arene2.png
	if ( ErrorLevel == 0 )
		iArene = 2
	ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\map\arene1.png
	if ( ErrorLevel == 0 )
		iArene = 1
	ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\map\arene0.png
	if ( ErrorLevel == 0 )
		iArene = 0
	if ( iArene != 999 )
		break ;
	Sleep 1000
}
if ( iArene > 0 )
	iGoodList = 0
if ((iArene > 0 || (iGoodList == 0 && iDoGoodList == 1 )) && (iLockPve > 0 || iArene >= iAreneForceFight))
  {
	sMsg = ARENE %iArene%/10: OPENING, GOODLIST %iGoodList%
	displaymsg( sMsg )
	Click 334, 308 ; open arene
	isArene = 1
	iClickArene = 1
	Loop, 30 {
		ImageSearch, X, Y, ax1, ay1, ax2, ay2, *90 .\img\arene\duel-screen.png
		if ( ErrorLevel == 0 )
			break
		ImageSearch, X, Y, ax1, ay1, ax2, ay2, *90 .\img\arene\duel-screen2.png
		if ( ErrorLevel == 0 )
			break
		Sleep 1500
	}
}