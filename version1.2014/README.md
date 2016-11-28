# AHK_SWBOT v1
## first version
	- Date: ~ 2014
	- My first version of this bot, a script for mobile game "Summoner's war".
	- The goal is to let the script play for you as well as it can
	- Priority in avoiding crash during the long afk to ensure the efficiency.
	- This script as the version 2's script use screen position to calculate mouse coord
	- The game have to be in the center of screen with a 1024x768 resolution
	- It is designed to work in vm or dedicated computer, it constantly control the mouse
	- The version 2 handle the game position to ensure resolution compatibility

## requierments
	- Connectiong your phone on windows computer / use emulator on your computer
		- Originaly designed to run with vnc server on phone and vnc on computer
	- Software AutoHotKey to run the script

## bot feature
	- manage 2 accounts
	- switch account when resources are over
	- skip ad popup
	- looting mana
	- buying mystic scroll at the magic shop
	- use energy for pve or donjon
	- do pvp match
	- verify and set auto fight mode
	- verify and set vitesse x3


## interface
	- a "one line" box on top of screen
	- displaying the last action and timer's value

## tools (manual start/stop)
	- "add me for social quest" script to spam all chat canal
	- auto upgrade rune, spam upgrade key
	- auto summon monster, spam use of common scroll

## how it work
	- There is an infinite loop (controled with shortcut)
	- Each loop turn, a library of pictures is compared to the screen
	- If pictures match it run the corresponding sequences
	- There is priority and timing management for each decision
	- Sometimes click coordonate are hard coded and sometimes they are based on pictures detection

## about
	- This version need a particular vnc client and screen resolution.. zero compatibility..
	- But it have run many days without crashing :)
