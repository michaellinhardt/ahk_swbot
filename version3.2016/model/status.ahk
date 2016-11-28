status_change()
{
	global status
	if ((ret := cfg( "APP", "status" )))
	{
		cfg_set( "APP", "status", 0)
		status = 0
		gui_msg( "CHANGE STATUS TO OFF" )
	}
	else
	{
		cfg_set( "APP", "status", 1)
		status = 1
		gui_msg( "CHANGE STATUS TO ON" )
		dodo( 500, "F4 KEY START LOOP" )
		loop()
	}
	gui_refresh()
}