displaymsg("ah")
F7::
	FileDelete, mouse.txt
return

F8::
	mob = 4
	MouseGetPos, X, Y
	ilol++
	sMsg = m[%mob%, %ilol%] = %X%
	FileAppend, %sMsg%`n, mouse.txt
	ilol++
	sMsg = m[%mob%, %ilol%] = %Y%
	FileAppend, %sMsg%`n, mouse.txt
return
displaymsg("bb")
