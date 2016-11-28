log( msg )
{
	global debug_log
	
	if (ret := % cfg( "DEBUG", "log" ))
		FileAppend, %msg%`n, %A_ScriptDir%\log.txt
}