dodo( time, msg = -1 )
{
	global status
	global gcd

	total = 0
	if ( msg != "-1" )
	{
		msg = [%time%/%gcd%] %msg%
		gui_msg( msg )
	}
	Loop {
		Sleep %gcd%
		GuiControl,, bar_dodo, % (ret := ( 100 / time ) * total)
		if (total < time )
			total +=  %gcd%
		if ( total >= time)
			break
	}
}

step( who, percent, msg = -1 )
{
	GuiControl,, bar_dodo, % percent
	msg = [%who%] %msg%
	if ( msg != -1 )
		gui_msg( msg )
}