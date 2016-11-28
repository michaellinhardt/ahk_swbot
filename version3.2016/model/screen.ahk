screen_detection()
{
	global screen
	
	screen = none
	if ( img( "*80 .\img\base\avatar.png" ) )
		screen = base
	else if ( img( "*60 .\img\map\start.png" ) )
		screen = map
	else if ( img ( "*80 .\img\fight\pve-fight.png" ) )
		screen = pve_loby
}

screen_rootage()
{
	global screen
	
	global pvelock
	global arene_point
	global force_arene
	
	if ( screen == "base" )
	{
		screen_base()
	}
	else if ( screen == "map" )
	{
		if ( pvelock == 0 && arene_point < force_arene )
			map_run_pve()
	}
	else if ( screen == "pve_loby" )
	{
		msgbox, pve loby
	}
	return (0)
}