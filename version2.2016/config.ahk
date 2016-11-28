;area x1,y1 x2,y2 for image search (mobizen screen)
ax1 = 240
ay1 = 20
ax2 = 840
ay2 = 675

iWait = 3000 
iWaitSWLoad = 45000 ; secodne d'attente pendant l'ouverture de l'app

iMsgBox = 0 ; affiche la boite ou non
iAutoStart = 1 ;

iManaLoot = 0 ; Loot ou non le mana (timer à venir)
iChat = 0 ; rejoins ou non le chat
iQuest = 0 ; fais ou non les quetes
iSocialMob = 0 ;
iDoGoodList = 0 ;
iDoRival = 1 ;

iLeaveGame = 0 ; compte le nombre de fois que la box apparait
iLeaveGameLimit = 5 ; leave le jeu si on a 3 fois cette box (pour le relancer)

iReplay = 0 ; décompte (voir iReplayMax)
iReplayMax = 10 ; replay X fois un combat pve avant retour base

iDrawLimit = 30

iLockArene = 0 ; empeche larene pendant un temps (si refresh impossible)
iLockPve = 99999 ; empeche le pve en cas derreur (pas de farmeur)
iLockChat = 99999 ; si à 0, on rentre dans le tchat 
iLockMana = 99999
iLockQuest = 99999 ; ...
iLockSocialMob = 0

iLogSize = 0 ; 0- petit, 1- grand

iLockAreneLoop = 3 ; nombre de loop avant unlock
iLockAreneNew = 40 ; nombre de loop quand on a une cible mais seulement 1 point d'arene
iLockPveLoop = 100 ; nombre de loop avant unlock
iLockChatLoop = 250 ; noombre de loop avant unlock
iLockManaLoop = 50 ; ...
iLockQuestLoop = 100
iLockSocialMobLoop = 100

iAreneForceFightt = 7 ; à X plume on cherche des adversaire à 2 slot empty
iAreneForceFight = 9999999 ; à X plume on ne cherche plus les défence vide
iGoodList = 0 ; quand arene point = 0, on prépare une liste avec un attaquant sans defense
iGoodListLevel = 30 ; les level en dessous de celui ci sont gardé
iAreneSkip = 0 ; skip les x premier joueur de la list darene (pour le debug)

iDifficulty = 3 ; 1 normal 2 hard 3 hell
iNiveau = 10 ; ( de 1 à 7)

iDungeon = 1
; 1 hall magie 		; 2 vent 		; 3 = geant
; 4 dragon			; 5 necro		; 6 = feu
; 7 = eau			; 8 dark

iZone = 666
; 1 = ENERGY		; 2 = FATAL		; 3 = LAME
; 4 = RAPIDE		; 5 = FOCUS		; 6 = GARDIEN
; 7 = ENDURANCE		; 8 = PROTECTI	; 9 = VENGEANCE
; 666 = dungeon

; VARIABLE SYSTEM
iStatus = 0 ; ON/OFF ...
iJoueur = 0 ; pour faire une loop dans la list des joeuur pvp
iJoueurFocus = 0 ;
iClickRival = 0 ;
iClickArene = 0 ;
iAreneRefresh = 0 ; force un refresh
iLow = 0 ; a 1 si le joueur scanné est low level
iLoopCount = 0 ; compte les loop pendant les combat
iQuestGo = 0 ; Réglé par le bot pour savoir quelle quete il va faire
iQuestFightFriends = 0 ; compte le nombre de fois qu'on à combatu un amis pour la quete
sMsgLast = 0
iAreneFight = 0 ;
iArene = 0 ; (point darene dispo)
iGotHearth = 0 ;
iPage = 1 ;
iDraw = 0 ;
