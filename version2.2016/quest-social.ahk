if (iGotHearth == 0) {
	iGotHearth = 1 ; on le fias qu'une fois par execution de script

	iSend = 0
	sMsg = <3 <3 <3 <3 <3 <3 %iSend% <3 <3 <3 <3 <3 <3
	displaymsg(sMsg)
	Sleep 1000
	loop, 30 {
		iBreak = 1
		Sleep 1000
		Click 748,522 ; commu icone
		ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\base\friends.png
		if ( ErrorLevel == 0 ) {
			Click %X%,%Y%
			break
		}
	}
	loop, 30 {
		iBreak = 1
		ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\base\friends2.png
		if ( ErrorLevel == 0 )
			break
		Sleep 1500
	}

	loop, 30 {
		loop {
			iBreak = 1
			ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\quest\cadeau.png
			if ( ErrorLevel == 0 ) {
				Click %X%,%Y%
				iSend++
				iBreak = 0
				Sleep 1500
			}
			ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\quest\cadeau2.png
			if ( ErrorLevel == 0 ) {
				Click %X%,%Y%
				iSend++
				iBreak = 0
				Sleep 1500
			}
			ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\quest\cadeau3.png
			if ( ErrorLevel == 0 ) {
				Click %X%,%Y%
				iSend++
				iBreak = 0
				Sleep 1500
			}
			if (iBreak == 0 0) {
				sMsg = <3 <3 <3 <3 <3 <3 %iSend% <3 <3 <3 <3 <3 <3
				displaymsg(sMsg)
			}
			if (iBreak == 1)
				break
		}
		dragarene2()
		Sleep 3333
	}
	clickback(1)
}