

clic(x, y, msg, time = 0)
{
	Click %x%,%y%
	gui_msg( "CLICK " x "x" y " --> " msg )
	if ( time > 0 )
		dodo( time )
}

click_ok( time = 0 )
{
	global ximg
	global yimg
	
	if ( img( "*90 .\img\loot\ok.png" ) )
	{
		clic(ximg, yimg, "CLICK OK: ok", time) 
		return (1)
	}
	else if ( img( "*90 .\img\loot\ok2.png" ) )
	{
		clic(ximg, yimg, "CLICK OK: ok2", time) 
		return (1)
	}
	else if ( img( "*90 .\img\loot\ok3.png" ) )
	{
		clic(ximg, yimg, "CLICK OK: ok3", time) 
		return (1)
	}
	else if ( img( "*90 .\img\loot\ok4.png" ) )
	{
		clic(ximg, yimg, "CLICK OK: ok4", time) 
		return (1)
	}
	else if ( img( "*90 .\img\loot\ok-dungeon.png" ) )
	{
		clic(ximg, yimg, "CLICK OK: ok-dungeon", time) 
		return (1)
	}
	else if ( img( "*90 .\img\loot\ok-dungeon2.png" ) )
	{
		clic(ximg, yimg, "CLICK OK: ok-dungeon2", time) 
		return (1)
	}
	else if ( img( "*90 .\img\loot\ok5.png" ) )
	{
		clic(ximg, yimg, "CLICK OK: ok5", time)
		return (1)
	}
	return (0)
}