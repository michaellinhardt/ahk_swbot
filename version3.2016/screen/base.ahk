screen_base()
{
	global manalock
	global is_mana
	global base_to_map
	global after_finish_base
	
	if ( manalock == 0 && is_mana == 1 )
	{
		clic(96,227, "base detected - clic dans le vide", after_finish_base )
		script_mana()
		lock("mana")
	}

	clic(96,227, "base - clic dans le vide", after_finish_base )
	
	clic(311,305, "base - clic sur bataille", base_to_map )
}