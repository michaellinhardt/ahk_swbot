btn_status = 0
btn_console = 0
btn_savesettings = 0
bar_dodo = 0

dodo_text = WELCOM !

console_display := % cfg( "GUI", "fullsize" )

pvelock := % cfg( "LOCK", "pve" )
pvelockmax := % cfg( "LOCK-MAX", "pve" )
pvplock := % cfg( "LOCK", "pvp" )
pvplockmax := % cfg( "LOCK-MAX", "pvp" )
chatlock := % cfg( "LOCK", "chat" )
chatlockmax := % cfg( "LOCK-MAX", "chat" )
manalock := % cfg( "LOCK", "mana" )
manalockmax := % cfg( "LOCK-MAX", "mana" )
sociallock := % cfg( "LOCK", "social" )
sociallockmax := % cfg( "LOCK-MAX", "social" )
questlock := % cfg( "LOCK", "quest" )
questlockmax := % cfg( "LOCK-MAX", "quest" )

niveau := % cfg( "PVE", "niveau" )
difficulty := % cfg( "PVE", "difficulty" )
pvereplay := % cfg( "PVE", "pvereplay" )

bar_pve = 0
bar_pvp = 0
bar_mana = 0
bar_quest = 0
bar_chat = 0
bar_social = 0

ximg = 0
yimg = 0


is_pve := cfg( "SETTINGS", "is_pve" )
is_pvp := cfg( "SETTINGS", "is_pvp" )
is_mana := cfg( "SETTINGS", "is_mana" )
is_quest := cfg( "SETTINGS", "is_quest" )
is_chat := cfg( "SETTINGS", "is_chat" )
is_social := cfg( "SETTINGS", "is_social" )
is_log := cfg( "SETTINGS", "is_log" )

zone1 = 0
zone2 = 0
zone3 = 0
zone4 = 0
zone5 = 0
zone6 = 0
zone7 = 0
zone8 = 0
zone9 = 0
zone10 = 0

dungeon1 = 0
dungeon2 = 0
dungeon3 = 0
dungeon4 = 0
dungeon5 = 0
dungeon6 = 0
dungeon7 = 0
dungeon8 = 0
dungeon9 = 0

zone := % cfg( "PVE", "zone" )
dungeon := % cfg( "PVE", "dungeon" )

force_arene := % cfg( "ARENE", "force_arene" )

dungeon%dungeon% = 1
zone%zone% = 1

status := cfg( "APP", "status" )
verif_mobizen_in_loop := cfg( "APP", "verif_mobizen_in_loop" )

loop_wait := zzz( "LOOP", "loop_wait" )
gcd := zzz( "LOOP", "gcd" )
img_detect_try := cfg( "APP", "img_detect_try" )

zone_x1 := x( "IMG", "zone_start" )
zone_y1 := y( "IMG", "zone_start" )
zone_x2 := x( "IMG", "zone_end" )
zone_y2 := y( "IMG", "zone_end" )

global screen = none

mana_click_fontaine := zzz( "MANA_CLICK", "fontaine" )
mana_click_jardin := zzz( "MANA_CLICK", "jardin" )
mana_click_jardinmob := zzz( "MANA_CLICK", "jardinmob" )
after_finish_base := zzz( "MANA_CLICK", "after_finish_base" )

base_to_map := zzz( "LOADING", "base_to_map" )
loading_loby := zzz( "LOADING", "loading_loby" )

opening_zone := zzz( "PVE", "opening_zone" )
opening_dungeon := zzz( "PVE", "opening_dungeon" )
difficulty_change := zzz( "PVE", "difficulty_change" )
difficulty_change_over := zzz( "PVE", "difficulty_change_over" )
niveau_loading := zzz( "PVE", "niveau_loading" )
wait_after_detect := zzz( "IMG", "wait_after_detect" )

after_drag := zzz( "ACTION", "after_drag" )

arene_point = 0
pvereplay_count = 0