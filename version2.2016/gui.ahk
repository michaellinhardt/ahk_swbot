myGui()



myGui() {
	static thisVar, thatVar

	gui, SomeGuiName: new

	gui,Default

	gui,+LastFound

	gui, add, groupbox, w250 h130,example

	gui, add, text, xm12 ym30 section, this Label

	gui, add, text, xm12 yp+30, that label

	gui, add, button, yp+30 gDone, Ok

	gui, add, edit, ys ym30 vthisVar,

	gui, add, edit, yp+30  vthatVar,

	gui, add, button, yp+30  gguiclose, cancel

	gui, show,, gui in a function

	return winexist()



	Done:

		{

		gui,submit,nohide

		ListVars

		msgbox your values `nthisVar :%thisVar%`nthatVar :%thatVar%

		return

		}



	guiclose:

		{

		gui,destroy

		ExitApp

		return

		}

}
	
	
	
	
	
/*
Gui 1:Add, CheckBox, w115 y10 vOptDM, Dialog Model
Gui 1:Add, CheckBox, w115 vOptBS, Subroutine Set
Gui 1:Add, CheckBox, w115 vOptDS Checked, Data Section
Gui 1:Add, CheckBox, w115 vOptDX, Dialog Box
Gui 1:Add, CheckBox, w115 y10 x+5 vOptFD, Buffer
Gui 1:Add, CheckBox, w115 y+6 vOptRUS, Standard Text
Gui 1:Add, CheckBox, w115 y+6 vOptAll, Tout sauf StdTxt
Gui 1:Add, CheckBox, w115 y+6 vOptAllRUS, Tout

Gui 1:Add, Button, w90 y10 vStartSearch Default, Rechercher
Gui 1:Add, Button, w90 y+10, Construire index
Gui 1:Add, Button, w90 y+10, Afficher l'index
Gui 1:Add, Button, w90 y+10, Extracteur
Gui 1:Add, Text, x10 yp-15,Recherche dans un répertoire spécifique :

Gui 1:Add, DropDownList, vDirSpec w75, C:\|D:\||E:\
Gui 1:Add, Text, ,Texte recherché (mot complet, exemple : test ne ramènera pas tests) :
Gui 1:Add, Edit, vSearch w335, Texte
Gui 1:Add, CheckBox, x10 vReBuild, Remplacer fichiers déjà indexés
Gui 1:Add, CheckBox, x10 vNoCache Checked, Ne pas utiliser de cache


Gui 1:Show

*/