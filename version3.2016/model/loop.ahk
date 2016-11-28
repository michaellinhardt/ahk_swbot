loop()
{
	global status
	global loop_wait
	global screen
	global verif_mobizen_in_loop

	gui_msg("START LOOP")

	Loop {
		
		if (verif_mobizen_in_loop == 1 && ( ret := gui_mobizen()) == -1)
			MsgBox, BUG impossible de trouver Mobizen
		else if ( verif_mobizen_in_loop == 1 && ret == -2 )
			MsgBox, BUG Mobizen mauvaise taille
		
		screen_detection()

		screen_rootage()

		lock_decrement()
		
		gui_refresh()
		
		if ( status == 0 )
			break
			
		dodo( loop_wait, "****** SLEEP BEFORE NEW LOOP ******")
	}
	gui_msg("LOOP OFF")
}