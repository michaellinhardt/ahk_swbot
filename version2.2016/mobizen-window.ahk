; PLACE LA FENETRE MOBIZEN AU PREMIER PLAN
IfWinExist Mobizen
{
	WinActivate, Mobizen
	WinGetPos, X, Y, width, height, Mobizen
	if ((width != 309 && width != 548) || (height != 620 && height != 381)) {
		displaymsg("MOBIZEN BAD WINDOW SIZE")
		mobizenreco()
		goto Restart
	} else if (width == 309 && (X != 358 || Y != 54))
		WinMove, Mobizen, , 358, 54
	else if (width == 548 && (X != 277 || Y != 209))
		WinMove, Mobizen, , 277, 209
} else {
	displaymsg("TRYING TO OPEN MOBIZEN (wait 20sc)")
	Run, Mobizen.exe, C:\Program Files (x86)\RSUPPORT\Mobizen
	Sleep 15000
}