img( img, x1 = -1, y1 = -1, x2 = -1, y2 = -1 )
{
	global ximg
	global yimg
	global img_detect_try
	global gcd
	global zone_x1
	global zone_x2
	global zone_y1
	global zone_y2
	global wait_after_detect
	
	if ( x1 == -1 )
		x1 = %zone_x1%
	if ( x2 == -1 )
		x2 = %zone_x2%
	if ( y1 == -1 )
		y1 = %zone_y1%
	if ( y2 == -1 )
		y2 = %zone_y2%
	
	Loop %img_detect_try%
	{
		ImageSearch, x, y, x1, y1, x2, y2, %img%
		if ( ErrorLevel == 0 )
		{
			ximg = %x%
			yimg = %y%
			gui_msg( "DETECTED IMG: " img )
			if ( wait_after_detect > 0 )
				dodo( wait_after_detect, "wait after detect img" )
			return (1)
		}
		dodo( gcd )
	}
	return (0)
}

imgloop( time, img, x1 = -1, y1 = -1, x2 = -1, y2 = -1 )
{
	global gcd
	global zone_x1
	global zone_x2
	global zone_y1
	global zone_y2
	
	if ( x1 == -1 )
		x1 = %zone_x1%
	if ( x2 == -1 )
		x2 = %zone_x2%
	if ( y1 == -1 )
		y1 = %zone_y1%
	if ( y2 == -1 )
		y2 = %zone_y2%

	total = 0
	Loop
	{
		if ( img( img, x1, y1, x2, y2 ) )
			return (1)
		dodo( gcd )
		total += gcd
		if ( total >= time )
			return (0)
	}
	return (1)
}