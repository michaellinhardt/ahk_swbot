map_run_pve()
{
	global pvelock
	global pvplock
	global zone
	
	if ( pvelock == 0 )
	{
		screen_map_zone()
		if ( zone > 1 )
		{
			screen_map_difficulty()
			screen_map_niveau()
		}
		else
		{
			screen_dungeon()
			screen_dungeon_niveau()
		}
	}
}

screen_dungeon_niveau()
{
	global niveau
	global loading_loby
	global ximg
	global yimg
	
	img := "*90 .\img\dungeon\-" niveau ".png"
	msgbox, % img
	
	Loop, 5
	{
		if ( img( img ) )
		{
			ximg += 130
			clic( ximg, yimg, "selecting dungeon - niveau " niveau, loading_loby )
			return (1)
		}
		if ( niveau > 6 )
			dragdungeonniveaurev()
		else
			dragdungeonniveau()
	}
	return (0)
}

screen_dungeon()
{
	global dungeon
	global opening_dungeon
	global ximg
	global yimg
	
	img = *90 .\img\dungeon\
	
	img1 := img "magie.png"
	img2 := img "geant.png"
	img3 := img "necro.png"
	img4 := img "dragon.png"
	img5 := img "vent.png"
	img6 := img "eau.png" ; image a venir
	img7 := img "feu.png" ; image a venir
	img8 := img "dark.png" ; image a venir
	img9 := img "light.png" ; image a venir
	
	img := img%dungeon%
	
	Loop, 4
	{
		if ( img( img ) )
		{
			clic( ximg, yimg, "clic enter dungeon", opening_dungeonss )
			return (1)
		}
		dragdungeon()
	}
	gui_msg ( "Cant find dungeon " img ", trying with magie" )
	Loop, 4
	{
		if ( img( img1 ) )
		{
			clic( ximg, yimg, "clic enter dungeon", opening_dungeonss )
			return (1)
		}
		dragdungeon()
	}
	return (0)
}

screen_map_zone()
{
	global zone
	global opening_zone
	global opening_dungeon
	
	if ( zone == 2 )
		clic( 59,236, "map - clic zone 1", opening_zone )
	else if ( zone == 3 )
		clic( 181,124, "map - clic zone 2", opening_zone )
	else if ( zone == 4 )
		clic( 318,193, "map - clic zone 3", opening_zone )
	else if ( zone == 5 )
		clic( 399,51, "map - clic zone 4", opening_zone )
	else if ( zone == 6 )
		clic( 502,96, "map - clic zone 5", opening_zone )
	else if ( zone == 7 )
		clic( 538,154, "map - clic zone 6", opening_zone )
	else if ( zone == 8 )
	{
		clic( 538,154, "map - clic zone 6 (going 7)", opening_zone )
		clic( 182,308, "map - clic zone 7", opening_zone )
	}
	else if ( zone == 9 )
	{
		clic( 538,154, "map - clic zone 6 (going 7)", opening_zone )
		clic( 182,308, "map - clic zone 7", opening_zone )
		clic( 234,256, "map - clic zone 8", opening_zone )
	}
	else if ( zone == 10 )
	{
		clic( 538,154, "map - clic zone 6 (going 7)", opening_zone )
		clic( 182,308, "map - clic zone 7", opening_zone )
		clic( 238,189, "map - clic zone 9", opening_zone )
	}
	else if (zone == 1 )
	{
		clic( 295,287, "map - clic dungeon", opening_dungeon )
	}
}

screen_map_difficulty()
{
	global difficulty
	global difficulty_change
	global difficulty_change_over
	
	clic( 480,89, "zone - clic difficulty", difficulty_change )
	
	if ( difficulty == 1 )
		clic( 464,204, "zone - clic difficulty normal", difficulty_change )
	if ( difficulty == 2 )
		clic( 459,204, "zone - clic difficulty hard", difficulty_change )
	if ( difficulty == 3 )
		clic( 452,273, "zone - clic difficulty hell", difficulty_change_over )
}

screen_map_niveau()
{
	global niveau
	global niveau_loading
	
	if ( niveau == 1 )
		clic( 503,138, "zone - clic niveau 1", niveau_loading )
	else if ( niveau == 2 )
		clic( 505,194, "zone - clic niveau 2", niveau_loading )
	else if ( niveau == 3 )
		clic( 501,252, "zone - clic niveau 3", niveau_loading )
	else if ( niveau == 4 )
		clic( 502,299, "zone - clic niveau 4", niveau_loading )
	else if ( niveau > 4 )
	{
		dragniveau()
		dragniveau()
		if ( niveau == 5 )
			clic( 502,168, "zone - clic niveau 5", niveau_loading )
		if ( niveau == 6 )
			clic( 502,223, "zone - clic niveau 6", niveau_loading )
		if ( niveau == 7 )
			clic( 502,280, "zone - clic niveau 7", niveau_loading )
	}
}