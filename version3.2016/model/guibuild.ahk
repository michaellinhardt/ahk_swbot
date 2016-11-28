status:
	status_change()
return

console:
	gui_size()
return

save:
	gui_savesettings()
return

gui_build()
{


Gui,Add,Button,x10 y10 w90 h23 gstatus vbtn_status,ON / OFF
Gui,Add,Button,x120 y10 w43 h23 gsave vbtn_savesettings,SAVE
Gui,Add,Button,x220 y10 w120 h23 gconsole vbtn_console,Console
Gui,Add,GroupBox,x0 y50 w340 h215,-=[ LOCK CONTROL ]=-
Gui,Add,Progress,x10 y70 w150 h16 vbar_pve,100
Gui,Add,Progress,x180 y70 w150 h16 vbar_pvp,100
Gui,Add,Text,x10 y90 w40 h13,PVE
Gui,Add,Edit,x50 y90 w50 h21 vpvelock,0
Gui,Add,Edit,x110 y90 w50 h21 vpvelockmax,0
Gui,Add,Text,x180 y90 w40 h13,PVP
Gui,Add,Edit,x220 y90 w50 h21 vpvplock,0
Gui,Add,Edit,x280 y90 w50 h21 vpvplockmax,0
Gui,Add,Progress,x10 y120 w150 h16 vbar_chat,100
Gui,Add,Progress,x180 y120 w150 h16 vbar_mana,100
Gui,Add,Text,x10 y140 w40 h13,CHAT
Gui,Add,Edit,x50 y140 w50 h21 vchatlock,0
Gui,Add,Edit,x110 y140 w50 h21 vchatlockmax,0
Gui,Add,Text,x180 y140 w40 h13,MANA
Gui,Add,Edit,x220 y140 w50 h21 vmanalock,0
Gui,Add,Edit,x280 y140 w50 h21 vmanalockmax,0
Gui,Add,Progress,x10 y170 w150 h16 vbar_social,100
Gui,Add,Progress,x180 y170 w150 h16 vbar_quest,100
Gui,Add,Text,x10 y190 w40 h13,SOCIAL
Gui,Add,Edit,x50 y190 w50 h21 vsociallock,0
Gui,Add,Edit,x110 y190 w50 h21 vsociallockmax,0
Gui,Add,Text,x180 y190 w40 h13,QUEST
Gui,Add,Edit,x220 y190 w50 h21 vquestlock,0
Gui,Add,Edit,x280 y190 w50 h21 vquestlockmax,0
Gui,Add,Text,x10 y220 w320 h13 vdodo_txt,DODO RAISON
Gui,Add,Progress,x10 y240 w325 h16 vbar_dodo,100
Gui,Add,Text,x350 y50 w100 h13,MAIN LOOP SLEEP
Gui,Add,Edit,x360 y70 w70 h21 vloop_wait,0
Gui,Add,Text,x350 y100 w100 h13,MAIN LOOP GCD
Gui,Add,Edit,x360 y120 w70 h21 vgcd,Edit
Gui,Add,Text,x350 y150 w100 h13,IMG DETECT TRY
Gui,Add,Edit,x360 y170 w70 h21 vimg_detect_try,Edit
Gui,Add,Text,x350 y200 w90 h13,FORCE ARENE
Gui,Add,Edit,x360 y220 w70 h21 vforce_arene,Edit
Gui,Add,GroupBox,x0 y280 w340 h85,-=[ ZONE ]=-
Gui,Add,Radio,x10 y300 w90 h13 gsave vzone1,DUNGEON
Gui,Add,Radio,x100 y300 w70 h13 gsave vzone2,ENERGY
Gui,Add,Radio,x190 y300 w80 h13 gsave vzone3,FATAL
Gui,Add,Radio,x270 y300 w55 h13 gsave vzone4,LAME
Gui,Add,Radio,x10 y320 w80 h13 gsave vzone5,RAPIDE
Gui,Add,Radio,x100 y320 w90 h13 gsave vzone6,FOCUS
Gui,Add,Radio,x190 y320 w70 h13 gsave vzone7,GARDIEN
Gui,Add,Radio,x270 y320 w50 h13 gsave vzone8,ENDU
Gui,Add,Radio,x10 y340 w90 h13 gsave vzone9,PROTECT
Gui,Add,Radio,x100 y340 w90 h13 gsave vzone10,VENGEANCE
Gui,Add,GroupBox,x0 y380 w340 h65,-=[ DUNGEON ]=-
Gui,Add,Radio,x10 y400 w60 h13 gsave vdungeon1,MAGIE
Gui,Add,Radio,x80 y400 w60 h13 gsave vdungeon2,GEANT
Gui,Add,Radio,x150 y400 w60 h13 gsave vdungeon3,NECRO
Gui,Add,Radio,x220 y400 w70 h13 gsave vdungeon4,DRAGON
Gui,Add,Radio,x10 y420 w60 h13 gsave vdungeon5,VENT
Gui,Add,Radio,x80 y420 w60 h13 gsave vdungeon6,EAU
Gui,Add,Radio,x150 y420 w50 h13 gsave vdungeon7,FEU
Gui,Add,Radio,x220 y420 w50 h13 gsave vdungeon8,DARK
Gui,Add,Radio,x280 y420 w50 h13 gsave vdungeon9,LIGHT
Gui,Add,GroupBox,x0 y460 w120 h50,-=[ PVE REPLAY ]=-
Gui,Add,DropDownList,x10 y480 w100 gsave vpvereplay choose1,1|2|3|4|5|6|7|8|9|10
Gui,Add,GroupBox,x130 y460 w210 h150,-=[ SETTINGS ]=-
Gui,Add,Checkbox,x140 y490 w70 h13 gsave vis_pve,PVE
Gui,Add,Checkbox,x240 y490 w70 h13 gsave vis_pvp,PVP
Gui,Add,Checkbox,x140 y520 w90 h13 gsave vis_mana,MANA LOOT
Gui,Add,Checkbox,x240 y520 w80 h13 gsave vis_quest,DO QUEST
Gui,Add,Checkbox,x140 y550 w90 h13 gsave vis_chat,CHAT JOIN
Gui,Add,Checkbox,x240 y550 w90 h13 gsave vis_social,DO SOCIAL
Gui,Add,Checkbox,x140 y580 w70 h13 gsave vis_log,LOG
Gui,Add,GroupBox,x0 y510 w120 h50,-=[ DIFFICULTY ]=-
Gui,Add,DropDownList,x10 y530 w100 gsave vdifficulty choose1,1|2|3
Gui,Add,GroupBox,x0 y560 w120 h50,-=[ NIVEAU ]=-
Gui,Add,DropDownList,x10 y580 w100 gsave vniveau choose1,1|2|3|4|5|6|7|8|9|10
Gui,Show,w454 h629,SWBOT Settings


}