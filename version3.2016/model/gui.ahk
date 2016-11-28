box_init = 0
box_msg_last = 0

gui_size()
{
	global console_display
	if ((ret := cfg( "GUI", "fullsize" )))
	{
		cfg_set( "GUI", "fullsize", 0)
		gui_box_init()
		gui_msg( "GUI HIDE CONSOL" )
		console_display = 0
	}
	else
	{
		cfg_set( "GUI", "fullsize", 1)
		gui_box_init()
		console_display = 1
		gui_msg( "GUI DISPLAY CONSOL" )
	}
	gui_refresh()
}

gui_refresh()
{
	global pvplock
	global pvplockmax
	global pvelock
	global pvelockmax
	global chatlock
	global chatlockmax
	global manalock
	global manalockmax
	global sociallock
	global sociallockmax
	global questlock
	global questlockmax
	global niveau
	global pvereplay
	global difficulty
	global zone
	global dungeon
	
	global is_pve
	global is_pvp
	global is_mana
	global is_quest
	global is_chat
	global is_social
	global is_log
	
	global gcd
	global loop_wait
	global img_detect_try
	global force_arene
	
	if ((ret := cfg( "GUI", "fullsize" )))
		GuiControl Text, btn_console, HIDE CONSOLE
	else
		GuiControl Text, btn_console, SHOW CONSOLE
		
	if ((ret := cfg( "APP", "status" )))
		GuiControl Text, btn_status, SWITCH OFF
	else
		GuiControl Text, btn_status, SWITCH ON

	GuiControl Text, loop_wait , %loop_wait%
	GuiControl Text, gcd , %gcd%
	GuiControl Text, img_detect_try , %img_detect_try%
	GuiControl Text, force_arene , %force_arene%
		
	GuiControl Text, pvelock , %pvelock%
	GuiControl Text, pvelockmax , %pvelockmax%
	GuiControl Text, pvplock , %pvplock%
	GuiControl Text, pvplockmax , %pvplockmax%
	GuiControl Text, chatlock , %chatlock%
	GuiControl Text, chatlockmax , %chatlockmax%
	GuiControl Text, manalock , %manalock%
	GuiControl Text, manalockmax , %manalockmax%
	GuiControl Text, sociallock , %sociallock%
	GuiControl Text, sociallockmax , %sociallockmax%
	GuiControl Text, questlock , %questlock%
	GuiControl Text, questlockmax , %questlockmax%
	GuiControl, Choose, difficulty, %difficulty%
	GuiControl, Choose, niveau, %niveau%
	GuiControl, Choose, pvereplay, %pvereplay%
	
	GuiControl,, bar_pve, % 100 - (ret := ( 100 / pvelockmax ) * pvelock)
	GuiControl,, bar_pvp, % 100 - (ret := ( 100 / pvplockmax ) * pvplock)
	GuiControl,, bar_mana, % 100 - (ret := ( 100 / manalockmax ) * manalock)
	GuiControl,, bar_quest, % 100 - (ret := ( 100 / questlockmax ) * questlock)
	GuiControl,, bar_social, % 100 - (ret := ( 100 / sociallockmax ) * sociallock)
	GuiControl,, bar_chat, % 100 - (ret := ( 100 / chatlockmax ) * chatlock)
	
	GuiControl,, zone%zone%, 1
	GuiControl,, dungeon%dungeon%, 1
	
	GuiControl,, is_pve, %is_pve%
	GuiControl,, is_pvp, %is_pvp%
	GuiControl,, is_mana, %is_mana%
	GuiControl,, is_quest, %is_quest%
	GuiControl,, is_chat, %is_chat%
	GuiControl,, is_social, %is_social%
	GuiControl,, is_log, %is_log%
}

gui_savesettings()
{
	global pvplock
	global pvplockmax
	global pvelock
	global pvelockmax
	global chatlock
	global chatlockmax
	global manalock
	global manalockmax
	global sociallock
	global sociallockmax
	global questlock
	global questlockmax
	global niveau
	global pvereplay
	global difficulty
	global zone
	global dungeon
	
	global is_pve
	global is_pvp
	global is_mana
	global is_quest
	global is_chat
	global is_social
	global is_log
	
	global loop_wait
	global gcd
	global img_detect_try
	global force_arene
	
	Gui, Submit, NoHide
	
	Loop, 10
	If ( zone%A_Index% ) {
		zone := A_Index
		Break
	}
	Loop, 10
	If ( dungeon%A_Index% ) {
		dungeon := A_Index
		Break
	}
	cfg_set( "PVE", "zone", zone )
	cfg_set( "PVE", "dungeon", dungeon )
	
	GuiControlGet, difficulty
	GuiControlGet, pvereplay
	GuiControlGet, niveau
	
	cfg_set( "PVE", "difficulty", difficulty )
	cfg_set( "PVE", "pvereplay", pvereplay )
	cfg_set( "PVE", "niveau", niveau )
	
	zzz_set( "LOOP", "loop_wait", loop_wait )
	zzz_set( "LOOP", "gcd", gcd )
	cfg_set( "APP", "img_detect_try", img_detect_try )
	cfg_set( "ARENE", "force_arene", force_arene )
	
	cfg_set( "LOCK", "pve", pvelock )
	cfg_set( "LOCK-MAX", "pve", pvelockmax )
	cfg_set( "LOCK", "pvp", pvplock )
	cfg_set( "LOCK-MAX", "pvp", pvplockmax )
	cfg_set( "LOCK", "chat", chatlock )
	cfg_set( "LOCK-MAX", "chat", chatlockmax )
	cfg_set( "LOCK", "mana", manalock )
	cfg_set( "LOCK-MAX", "mana", manalockmax )
	cfg_set( "LOCK", "social", sociallock )
	cfg_set( "LOCK-MAX", "social", sociallockmax )
	cfg_set( "LOCK", "quest", questlock )
	cfg_set( "LOCK-MAX", "quest", questlockmax )
	
	gui_refresh()
	
	gui_msg( "SAVING LOCK SETTINGS" )

	GuiControlGet, is_pve
	GuiControlGet, is_pvp
	GuiControlGet, is_mana
	GuiControlGet, is_quest
	GuiControlGet, is_chat
	GuiControlGet, is_social
	GuiControlGet, is_log
	
	cfg_set( "SETTINGS", "is_pve", is_pve)
	cfg_set( "SETTINGS", "is_pvp", is_pvp)
	cfg_set( "SETTINGS", "is_mana", is_mana)
	cfg_set( "SETTINGS", "is_quest", is_quest)
	cfg_set( "SETTINGS", "is_chat", is_chat)
	cfg_set( "SETTINGS", "is_social", is_social)
	cfg_set( "SETTINGS", "is_log", is_log)

}

gui_box_init()
{
	global box_init
	global box_size_x
	global box_size_y
	global box_pos_x
	global box_pos_y
	global menu_size_x
	global menu_size_y
	global menu_pos_x
	global menu_pos_y
	
	box_size_x := % (ret := cfg( "GUI", "fullsize" )) ? x("GUI", "boxfull") : x("GUI", "boxsmall") 
	box_size_y := % (ret := cfg( "GUI", "fullsize" )) ? y("GUI", "boxfull") : y("GUI", "boxsmall") 
	box_pos_x := % (ret := cfg( "GUI", "fullsize" )) ? x("GUI", "boxposfull") : x("GUI", "boxpossmall") 
	box_pos_y := % (ret := cfg( "GUI", "fullsize" )) ? y("GUI", "boxposfull") : y("GUI", "boxpossmall")
	
	menu_size_x := % x("GUI", "menusize")
	menu_size_y := % y("GUI", "menusize")
	menu_pos_x := % x("GUI", "menupos")
	menu_pos_y := % y("GUI", "menupos")
	box_init = 1
}

gui_msg( msg )
{
	global box_init
	global box_size_x
	global box_size_y
	global box_pos_x
	global box_pos_y
	global box_msg_last
	global console_display
	global dodo_txt
	
	GuiControl,, dodo_txt, %msg%
	if (box_msg_last != 0)
		msg = %msg%`n%box_msg_last%
	if (console_display == 1)
	{
		SplashTextOn, %box_size_x%, %box_size_y%, SWBOT, %msg%
		WinMove, SWBOT, , %box_pos_x%, %box_pos_y%
	}
	box_msg_last = %msg%
}

gui_mobizen()
{
	IfWinExist Mobizen
	{
		IfWinActive, Mobizen
		{
			; cool
		} else
			WinActivate, Mobizen
		WinGetPos, X, Y, width, height, Mobizen
		if ((width != 309 && width != 548) || (height != 620 && height != 381))
			return (-2)
		else if (X != 0 || Y != 0)
			WinMove, Mobizen, , 0, 0
		return (1)
	}
	return (-1)
}
	

gui_display()
{
	if (( ret := cfg( "DEBUG", "mobizenoff" )) != 1 && ( ret := gui_mobizen()) < 1)
		return (ret)

	if (!box_init)
		gui_box_init()		

	gui_build()
	gui_refresh()
	
	box_size_x := % (ret := cfg( "GUI", "fullsize" )) ? x("GUI", "boxfull") : x("GUI", "boxsmall") 
	box_size_y := % (ret := cfg( "GUI", "fullsize" )) ? y("GUI", "boxfull") : y("GUI", "boxsmall") 
	return (1)
}