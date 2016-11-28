; Click 508,422 ; Veux tu faire un voeux ? (oui)



/*

; (1 haut, 2 droite, 3 bas, 4 gauche)
m := []

m[1, 1] = 654
m[1, 2] = 294
m[1, 3] = 711
m[1, 4] = 347

displaymsg("Test here")
m[2, 1] = 712
m[2, 2] = 325
m[2, 3] = 767
m[2, 4] = 377

m[3, 1] = 657
m[3, 2] = 355
m[3, 3] = 712
m[3, 4] = 405

m[4, 1] = 603
m[4, 2] = 326
m[4, 3] = 656
m[4, 4] = 376


iLoop = 0
loop {
	iLoop++
	if (iStatus == 0)
		break
	i = 0
	ret =
	loop ; sur mob
	{
	
	
	

   
		i++
		
		ret = %ret% - %i% 
		ImageSearch, X, Y, 712, 323, 769, 381, *TransBlack .\img\mob\40.png
		if ( ErrorLevel == 0 )
			ret = %ret% oui
		else
			ret = %ret% nope
		
		
		displaymsg(ret)
		
		Sleep 1500
		if (i > 3)
			break
			
	}
		
	displaymsg(ret)
	Sleep 21111
}

goto Restart
*/