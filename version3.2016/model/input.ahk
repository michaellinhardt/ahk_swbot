F4::
	status_change()
return
F2::
	gui_size()
return
F5::
	Reload
return

F6::
	MouseGetPos, xpos, ypos
	PixelGetColor, color, %xpos%, %ypos%
	gui_msg( xpos "x" ypos " -- " color )
return