; CONFIG DU SCRIPT AHK
#Singleinstance force
#Persistent
CoordMode, Pixel, Screen
CoordMode, Mouse, Screen
SendMode, Input
SetKeyDelay, 60, 60

cfg_set( "APP", "status", 0 )

#Include global.ahk

if ( (ret := gui_display()) == -1)
	MsgBox, BUG impossible de trouver Mobizen
else if (ret == -2)
	MsgBox, BUG Mobizen mauvaise taille

#Include .\model\input.ahk
#Include .\model\config.ahk
#Include .\model\gui.ahk
#Include .\model\guibuild.ahk
#Include .\model\status.ahk
#Include .\model\progress.ahk
#Include .\model\lock.ahk
#Include .\model\screen.ahk
#Include .\model\loop.ahk
#Include .\model\img.ahk
#Include .\model\click.ahk

#Include .\script\mana.ahk
#Include .\script\drag.ahk

#Include .\screen\base.ahk
#Include .\screen\map_run_pve.ahk
