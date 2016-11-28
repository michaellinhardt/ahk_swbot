cfg_set( section, key, value )
{
	config_file = %A_ScriptDir%\config.ini
	IniWrite, %value%, %config_file%, %section%, %key%
	return (value)
}

cfg( section, key )
{
	config_file = %A_ScriptDir%\config.ini
	IniRead, value, %config_file%, %section%, %key%
	return (value)
}

zzz( section, key )
{
	config_file = %A_ScriptDir%\sleep.ini
	IniRead, value, %config_file%, %section%, %key%
	return (value)
}

zzz_set( section, key, value )
{
	config_file = %A_ScriptDir%\sleep.ini
	IniWrite, %value%, %config_file%, %section%, %key%
	return (value)
}

x( section, key )
{
	pos_file = %A_ScriptDir%\pos.ini
	IniRead, value, %pos_file%, %section%, %key%
	StringSplit, pos, value, `,
	return (pos1)
}

y( section, key )
{
	pos_file = %A_ScriptDir%\pos.ini
	IniRead, value, %pos_file%, %section%, %key%
	StringSplit, pos, value, `,
	return (pos2)
}