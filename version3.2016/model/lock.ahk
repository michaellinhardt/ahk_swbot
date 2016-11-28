lock_decrement()
{
	global pvplock
	global pvelock
	global chatlock
	global manalock
	global sociallock
	global questlock
	
	if ( pvplock > 0 )
		pvplock--
	if ( pvelock > 0 )
		pvelock--
	if ( chatlock > 0 )
		chatlock--
	if ( manalock > 0 )
		manalock--
	if ( sociallock > 0 )
		sociallock--
	if ( questlock > 0 )
		questlock--
}

lock( target )
{
	global pvplock
	global pvelock
	global chatlock
	global manalock
	global sociallock
	global questlock
	global pvplockmax
	global pvelockmax
	global chatlockmax
	global manalockmax
	global sociallockmax
	global questlockmax

	if ( target == "mana" )
		manalock = %manalockmax%

	if ( target == "pvp" )
		pvplock = %pvplockmax%

	if ( target == "pve" )
		pvelock = %pvelockmax%

	if ( target == "chat" )
		chatlock = %chatlockmax%

	if ( target == "social" )
		sociallock = %sociallockmax%

	if ( target == "quest" )
		questlock = %questlockmax%
}