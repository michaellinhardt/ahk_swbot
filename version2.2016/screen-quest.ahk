displaymsg("QUEST: OPENING")
iQuestGo = 0
Click 687,523 ; clic icone quete
Sleep 3333
; LOOT LES REWARD
loop {
	ImageSearch, X, Y, ax1, ay1, ax2, ay2, *50 .\img\quest\reward.png
	if ( ErrorLevel == 1 ) {
		Sleep 3333
		break
	}
	displaymsg("QUEST: LOOT REWARD")
	Click 754,341 ; récoleter
	Sleep 3333
	Click 549,458 ; confirm
	Sleep 3333
	ImageSearch, X, Y, ax1, ay1, ax2, ay2, *50 .\img\quest\reward-confirm.png
	if ( ErrorLevel == 0 ) {
		Click 504,444 ; excedant porte dimentionnel reward
		Sleep 3333
	}
	ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\quest\reward-confirm2.png
	if ( ErrorLevel == 0 ) {
		Click %X%,%Y% ; excedant porte dimentionnel reward
		Sleep 3333
	}
}

; iQuestGo -> (Social point déja codé mais necessite le screen pour détecter qu'on a la quete)
; 1 = social point		; 2 = fight friends 3x


; QUETE COMBAT 3 FOIS AVEC UN AMIS
ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\quest\fight-friends.png
if ( ErrorLevel == 0 )
	iQuestGo = 2


; TERMINé

if ( iQuestGo == 1 )
	sMsg = QUEST: SOCIAL POINT, BACK TO BASE
else if ( iQuestGo == 2 )
	sMsg = QUEST: FIGHT WITH 3 FRIENDS, BACK TO BASE
else {
	iLockQuest = %iLockQuestLoop% ; on a plus de quete on stop 
	sMsg = QUEST: NOTHING TO DO, BACK TO BASE
}
displaymsg(sMsg)
clickback2(1) ; retour base
Loop, 10 {			
	ImageSearch, X, Y, ax1, ay1, ax2, ay2, *80 .\img\base\avatar.png
	if ( ErrorLevel == 0 )
		break
	Sleep 1500
}
