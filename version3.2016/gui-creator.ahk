#SingleInstance,Force
global settings,window,conxml,TreeView,v:=[]
settings:=new xml("settings","lib\Settings.xml"),TreeView:=new xml("TreeView")
filecheck(),Gui()
/*
	re-explore the WheelDown/WheelUp to change edit modes
	give it a StatusBar to display the mode or window title
	escape de=selects all
	change{
		first item to:{
			for anything that is just Text
				Control Text:
			for anything that needs a list
				Control List:
			for Tab
				Control Tabs:
			and so on
		}
	}
	info window{
		have the add items display the hotkeys
	}
	Tab Logic{
		when you make a tab control
		<control type="tab">
		<tab tab="1">
		if you add tabs
			add the <tab tab="A_Index"> per tab|dec|la|ra|tion
		
		if change tabs and and dec|la|ra is less than <tab>.length{
			WARN! and ask what to do with the orphaned tab items
			if delete
				delete the controls
			else
				Ask where to move the tabs
		}
	}
*/
FileCheck(){
	if !FileExist("lib")
		FileCreateDir,lib
	conxml:=new xml("controls","lib\controls.xml")
	if (conxml.ssn("//version").text!="0.000.2")
		FileDelete,lib\controls.xml
	if !FileExist("lib\controls.xml")
		ctrl:=URLDownloadToVar("http://files.maestrith.com/GUI_Creator/Controls.xml"),conxml:=new xml("control","lib\Controls.xml"),conxml.xml.loadxml(ctrl),conxml.save(1)
	if !FileExist("tile.bmp")
		MakeBackground()
}
URLDownloadToVar(url){
	http:=ComObjCreate("WinHttp.WinHttpRequest.5.1")
	http.Open("GET",url),http.Send()
	return http.ResponseText
}
class xml{
	keep:=[]
	__New(param*){
		if !FileExist(A_ScriptDir "\lib")
			FileCreateDir,%A_ScriptDir%\lib
		root:=param.1,file:=param.2
		file:=file?file:root ".xml"
		temp:=ComObjCreate("MSXML2.DOMDocument"),temp.setProperty("SelectionLanguage","XPath")
		this.xml:=temp
		ifexist %file%
			temp.load(file),this.xml:=temp
		else
			this.xml:=this.CreateElement(temp,root)
		this.file:=file
		xml.keep[root]:=this
	}
	CreateElement(doc,root){
		return doc.AppendChild(this.xml.CreateElement(root)).parentnode
	}
	search(node,find,return=""){
		found:=this.xml.SelectNodes(node "[contains(.,'" RegExReplace(find,"&","')][contains(.,'") "')]")
		while,ff:=found.item(a_index-1)
			if (ff.text=find){
				if return
					return ff.SelectSingleNode("../" return)
				return ff.SelectSingleNode("..")
			}
	}
	lang(info){
		info:=info=""?"XPath":"XSLPattern"
		this.xml.temp.setProperty("SelectionLanguage",info)
	}
	unique(info){
		if (info.check&&info.text)
			return
		if info.under{
			if info.check
				find:=info.under.SelectSingleNode("*[@" info.check "='" info.att[info.check] "']")
			if info.Text
				find:=this.cssn(info.under,"*[text()='" info.text "']")
			if !find
				find:=this.under({under:info.under,att:info.att,node:info.path})
			for a,b in info.att
				find.SetAttribute(a,b)
		}
		else
		{
			if info.check
				find:=this.ssn("//" info.path "[@" info.check "='" info.att[info.check] "']")
			else if info.text
				find:=this.ssn("//" info.path "[text()='" info.text "']")
			if !find
				find:=this.add({path:info.path,att:info.att,dup:1})
			for a,b in info.att
				find.SetAttribute(a,b)
		}
		if info.text
			find.text:=info.text
		return find
	}
	add(info){
		path:=info.path,p:="/",dup:=this.ssn("//" path)?1:0
		if next:=this.ssn("//" path)?this.ssn("//" path):this.ssn("//*")
			Loop,Parse,path,/
				last:=A_LoopField,p.="/" last,next:=this.ssn(p)?this.ssn(p):next.appendchild(this.xml.CreateElement(last))
		if (info.dup&&dup)
			next:=next.parentnode.appendchild(this.xml.CreateElement(last))
		for a,b in info.att
			next.SetAttribute(a,b)
		if info.text!=""
			next.text:=info.text
		return next
	}
	find(info){
		if info.att.1&&info.text
			return m("You can only search by either the attribut or the text, not both")
		search:=info.path?"//" info.path:"//*"
		for a,b in info.att
			search.="[@" a "='" b "']"
		if info.text
			search.="[text()='" info.text "']"
		current:=this.ssn(search)
		return current
	}
	under(info){
		new:=info.under.appendchild(this.xml.createelement(info.node))
		for a,b in info.att
			new.SetAttribute(a,b)
		new.text:=info.text
		return new
	}
	ssn(node){
		return this.xml.SelectSingleNode(node)
	}
	sn(node){
		return this.xml.SelectNodes(node)
	}
	__Get(x=""){
		return this.xml.xml
	}
	Get(path,Default){
		return value:=this.ssn(path).text!=""?this.ssn(path).text:Default
	}
	transform(){
		static
		if !IsObject(xsl){
			xsl:=ComObjCreate("MSXML2.DOMDocument")
			style=
			(
			<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
			<xsl:output method="xml" indent="yes" encoding="UTF-8"/>
			<xsl:template match="@*|node()">
			<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
			<xsl:for-each select="@*">
			<xsl:text></xsl:text>		
			</xsl:for-each>
			</xsl:copy>
			</xsl:template>
			</xsl:stylesheet>
			)
			xsl.loadXML(style),style:=null
		}
		this.xml.transformNodeToObject(xsl,this.xml)
	}
	save(x*){
		if x.1=1
			this.Transform()
		filename:=this.file?this.file:x.1.1
		file:=fileopen(filename,3,"UTF-8"),file.seek(0),file.write(this[]),file.length(file.position)
	}
	remove(rem){
		if !IsObject(rem)
			rem:=this.ssn(rem)
		rem.ParentNode.RemoveChild(rem)
	}
	ea(path){
		list:=[]
		if nodes:=path.nodename
			nodes:=path.SelectNodes("@*")
		else if path.text
			nodes:=this.sn("//*[text()='" path.text "']/@*")
		else if !IsObject(path)
			nodes:=this.sn(path "/@*")
		else
			for a,b in path
				nodes:=this.sn("//*[@" a "='" b "']/@*")
		while,n:=nodes.item(A_Index-1)
			list[n.nodename]:=n.text
		return list
	}
}
ssn(node,path){
	return node.selectsinglenode(path)
}
sn(node,path){
	return node.selectnodes(path)
}
m(x*){
	for a,b in x
		list.=b "`n"
	MsgBox,0,GUI Creator,%list%
}
t(x*){
	for a,b in x
		list.=b "`n"
	ToolTip %list%
}
Gui(){
	static
	Gui,+Resize +hwndmain
	hwnd(1,main),OnMessage(0x136,"Display_Grid"),OnMessage(0x231,"KillSelect"),OnMessage(0x232,"highlight")
	DetectHiddenWindows,On
	OnMessage(0x201,"LButton")
	Gui,1:Menu,% Menu()
	Gui,2:+parent1 +Resize +hwndhwnd -0x20000 -0x10000 0x400 -ToolWindow 
	Gui,2:Add,TreeView,x0 y0 w150 h500 gtv AltSubmit hwndtv
	Gui,2:Default
	add:=TreeView.Add({path:"Add",att:{tv:TV_Add("Add Control")}}),ea:=TreeView.ea(add),hwnd("tv",tv)
	for a,b in StrSplit(Menu({menu:1}).Add,"|")
		TreeView.under({under:add,node:b,att:{tv:TV_Add(b,ea.tv,"Vis")}})
	TreeView.Add({path:"displaypos",att:{tv:TV_Add("Display Positions")}})
	TreeView.Add({path:"selected",att:{tv:TV_Add("Selected")}})
	TreeView.add({path:"windowtitle",att:{tv:TV_Add("Window Title")}})
	TreeView.add({path:"windowname",att:{tv:TV_Add("Window Name")}})
	hwnd(2,hwnd),ea:=settings.ea("//gui/settings")
	if (ea.w)
		ControlMove,SysTreeView321,,,% ea.w,% ea.h,% hwnd([2])
	Gui,2:Show,% guipos("//gui/settings","x5 y5 w150 h500"),Settings
	Gui,3:+Resize +hwndhwnd -0x20000 -0x10000 +parent1 -ToolWindow 
	hwnd(3,hwnd),ea:=settings.ea("//gui/workarea"),pos:=""
	Gui,3:Show,% guipos("//gui/workarea","x176 y5 w500 h500"),Work Area
	Gui,3:Margin,0,0
	for a,b in {Border:33,Caption:4,Menu:15}{
		SysGet,value,%b%
		v[a]:=value
	}
	Gui,1:Show,% guipos("//gui/main","w700 h550"),GUI Creator
	Hotkey,IfWinActive,% hwnd([1])
	Hotkey,^a,SelectAll,On
	Hotkey,+^a,SelectAll,On
	Hotkey,^z,Undo,On
	Hotkey,^y,Redo,On
	Hotkey,~Escape,Escape,On
	Hotkey,Delete,Delete,On
	WinSet,Redraw,,% hwnd([3])
	hotkeys(),options(1),new()
	if last:=settings.ssn("//last/@file").text
		open(last),DisplaySelected()
	new Undo()
	return
	2GuiSize:
	ControlMove,SysTreeView321,,,A_GuiWidth,A_GuiHeight,% hwnd([2])
	return
	2GuiClose:
	3GuiClose:
	exit(1)
	return
}
hwnd(win,hwnd=""){
	static winkeep:=[]
	if (win.rem){
		Gui,% win.rem ":Destroy"
		return winkeep.remove(win.rem)
	}
	if IsObject(win)
		return "ahk_id" winkeep[win.1]
	if !hwnd
		return winkeep[win]
	winkeep[win]:=hwnd
	return % "ahk_id" hwnd
}
Menu(info:=""){
	static menu:={order:["File","Edit","Options","Add","Help"],File:"&New|&Save|S&ave As|&Open|Ex&port|&Test GUI|E&xit|&Update Program",Add:"Button|Checkbox|ComboBox|DateTime|DropDownList|Edit|GroupBox|Hotkey|ListBox|ListView|MonthCal|Picture|Progress|Radio|Slider|Tab|Text|TreeView|UpDown",Options:"&Snap To Grid|Display &Grid|Grid &Dot Color|Grid &Background|Debug &Window",Edit:"Edit GLabels|Select All|Invert Selection|Edit &Hotkeys|Redraw",Help:"Help|Online Help"}
	if info.menu
		return menu
	for a,b in Menu.order{
		for c,d in StrSplit(Menu[b],"|"){
			HotkeyXML({check:d})
			Menu,%b%,Add,% GetMenuItem(d),menucmd
		}
	}
	for a,b in Menu.order
		Menu,Main,Add,&%b%,:%b%
	return "main"
	menucmd:
	MenuItem:=clean(A_ThisMenuItem)
	if(A_ThisMenu="options"&&MenuItem~="(Snap_To_Grid|Display_Grid|Debug_Window)")
		return options(MenuItem)
	if(A_ThisMenuItem="Debug Window")
		m("here")
	if(IsFunc(MenuItem))
		%MenuItem%()
	else if(A_ThisMenu="Add")
		GetInfo(MenuItem)
	else
		m("Feature not implemented yet. Coming Soon")
	return
}
HotkeyXML(item){
	if item.check
		if !settings.ssn("//hotkeys/*[@menu='" item.check "']")
			settings.Add({path:"hotkeys/" clean(item.check),att:{menu:item.check}})
}
Clean(info,type:=0){
	if InStr(info,"`t")
		info:=RegExReplace(info,"(\t.*)")
	if type=1
		info:=RegExReplace(info,"_"," ")
	else if(type=2)
		info:=RegExReplace(info,"&")
	else if(type=0)
		info:=RegExReplace(RegExReplace(info," ","_"),"&")
	return info
}
GuiPos(path,default){
	ea:=settings.ea(path)
	for a,b in ea
		if (b!="")
			pos.=a b " "
	return pos:=pos?pos:default
}
Open(filename=""){
	last:=settings.ssn("//last/@file").text,tabcount:=0
	SplitPath,last,,dir
	if !filename
		FileSelectFile,filename,,%dir%,Select a Saved GUI,*.xml
	if (ErrorLevel||!FileExist(filename))
		return
	New(),window.xml.load(filename),list:=window.sn("//*[@type]")
	while,ll:=list.Item[A_Index-1]
		ll.RemoveAttribute("hwnd")
	while,ll:=window.sn("//window/descendant::*").Item[A_Index-1],ea:=xml.ea(ll){
		if(InStr(ea.type,"tab"))
			tabcount++
		if(ll.nodename="tab"){
			Gui,3:Tab,% ea.tab,% SubStr(GetClassNN(ssn(ll,"ancestor::control[@type='Tab' or @type='Tab2']/@hwnd").text),16)
			ll.SetAttribute("hwnd",ssn(ll.ParentNode,"@hwnd").text)
			Continue
		}
		if !ssn(ll,"ancestor::control[@type='Tab' or @type='Tab2']")
			Gui,3:Tab
		AddControl(ll)
	}
	ea:=window.ea("//workarea")
	ControlMove,,% ea.x,% ea.y,% ea.w,% ea.h,% hwnd([3])
	settings.Add({path:"last",att:{file:filename}}),Highlight(),eval()
	Gui,3:Tab
}
GetMenuItem(menu,tv:=0){
	hotkey:=settings.ssn("//hotkeys/" clean(menu) "/@hotkey").text
	space:=tv?" = ":"`t",menu:=tv?RegExReplace(menu,"&"):menu
	hotkey:=hotkey?menu space Convert_Hotkey(hotkey):menu
	return hotkey
}
Options(x:=""){
	if (x=1){
		for a,b in StrSplit(menu({menu:1}).options,"|"){
			if settings.ssn("//options/" clean(b)).text
				Menu,options,Check,%b%
			else
				Menu,options,UnCheck,%b%
		}
		func:=clean(b)
		if IsFunc(func)
			%func%()
		WinSet,Redraw,,% hwnd([3])
		return
	}
	settings.Add({path:"options/" clean(x),text:settings.ssn("//options/" clean(x)).text?0:1}),options(1)
	if(clean(x)="debug_window")
		debug(0)
}
Dlg_Color(Color,hwnd:=""){
	static
	VarSetCapacity(cccc,16*A_PtrSize,0),cc:=1,size:=VarSetCapacity(CHOOSECOLOR,9*A_PtrSize,0)
	Loop,16
		NumPut(settings.ssn("//colors/@color" A_Index).text,cccc,(A_Index-1)*4,"UInt")
	NumPut(size,CHOOSECOLOR,0,"UInt"),NumPut(hwnd,CHOOSECOLOR,A_PtrSize,"UPtr"),NumPut(Color,CHOOSECOLOR,3*A_PtrSize,"UInt"),NumPut(3,CHOOSECOLOR,5*A_PtrSize,"UInt"),NumPut(&cccc,CHOOSECOLOR,4*A_PtrSize,"UPtr")
	ret:=DllCall("comdlg32\ChooseColorW","UPtr",&CHOOSECOLOR,"UInt")
	colors:=[]
	Loop,16
		colors["color" A_Index]:=NumGet(cccc,(A_Index-1)*4,"UInt")
	settings.Add({path:"colors",att:colors})
	if !ret
		exit
	return NumGet(CHOOSECOLOR,3*A_PtrSize)
}
MakeBackground(){
	ea:=settings.ea("//settings/grid"),Dot:=ea.Dot?ea.Dot:0,Grid:=ea.Grid!=""?ea.Grid:0xAAAAAA
	dot:=RGB(dot),Grid:=RGB(Grid)
	Image:=ComObjCreate("WIA.ImageFile"),vector:=ComObjCreate("WIA.Vector"),Dot+=0,Grid+=0,vector.add(Dot)
	loop,99
		vector.add(Grid)
	Image:=vector.Imagefile(10,10)
	FileDelete,tile.bmp
	Image.savefile("tile.bmp"),Display_Grid("removebrush")
	WinSet,Redraw,,% hwnd([3])
}
GetInfo(hotkey){
	MouseGetPos,x,y
	xx:=x,yy:=y
	ControlGetPos,cx,cy,cw,ch,,% hwnd([3])
	if (x>cx&&x<cx+cw&&y>cy+v.Caption&&y<cy+ch){
		x:=x-cx,y:=y-cy
		Grid(x,y,1)
	}else
		x:=0,y:=0
	value:=hotkey="TreeView"?"":Hotkey="DateTime"?"LongDate":Hotkey="Progress"?100:Hotkey
	if (hotkey="picture"){
		FileSelectFile,value,,,Select an image,*.bmp;*.jpg;*.gif;*.png
		if (ErrorLevel||value="")
			return
		if !FileExist(value)
			return
	}
	undo.add()
	control:=window.add({path:"gui/window/control",att:{type:hotkey,x:x,y:y,value:value},dup:1})
	pos:=WinPos(xx,yy),con:=window.ssn("//*[@x<" pos.x " and @x+@w>" pos.x " and @y<" pos.y " and @y+@h>" pos.y " and @type='Tab' or @type='Tab2']")
	if(con){
		tt:=xml.ea(con),nn:=GetClassNN(tt.hwnd)
		top:=window.ssn("//control[@hwnd='" tt.hwnd "']")
		ControlGet,tabnum,tab,,%nn%,% hwnd([3])
		Gui,3:Tab,%tabnum%,% SubStr(nn,16)
		if !tb:=ssn(top,"tab[@tab='" tabnum "']")
			tb:=window.under({under:top,node:"tab",att:{tab:tabnum,hwnd:tt.hwnd}})
		tb.SetAttribute("hwnd",tt.hwnd)
		tb.AppendChild(control)
		new:=AddControl(control)
	}else
		new:=AddControl(control)
	debug(),eval(),undo.redo:=[]
}
Convert_Hotkey(key){
	StringUpper,key,key
	for a,b in [{Shift:"+"},{Ctrl:"^"},{Alt:"!"}]
		for c,d in b
			key:=RegExReplace(key,"\" d,c "+")
	return key	
}
RGB(c){
	SetFormat,IntegerFast,H
	c:=(c&255)<<16|(c&65280)|(c>>16),c:=SubStr(c,1)
	SetFormat,IntegerFast,D
	return c
}
Display_Grid(x:=""){
	Static wBrush
	if (x="removebrush")
		wBrush:=""
	if(A_Gui!=3)
		return
	if settings.ssn("//options/Display_Grid").text
		tile:="tile.bmp"
	else
		return
	If !wBrush
		wBrush:=DllCall("CreatePatternBrush",UInt,DllCall("LoadImage",Int,0,Str,"tile.bmp",Int,0,Int,0,Int,0,UInt,0x2010,"UInt"),"UInt")
	Return wBrush
}
Grid(ByRef x,ByRef y,adjust:=0){
	if adjust
		x-=v.Border,y-=v.border+v.caption
	if settings.ssn("//options/Snap_To_Grid").text
		x:=Round(x,-1),y:=Round(y,-1)
}
AddControl(info){
	ea:=xml.ea(info)
	for a,b in {x:ea.x,y:ea.y,w:ea.w,h:ea.h}
		if(b~="\d")
			pos.=a b " "
	if(ea.type="ListView")
		pos.=" -Multi"
	value:=ea.value~="(ComboBox|DDL|DropDownList)"?ea.value "||":ea.value
	notify:=(ea.type~="Tab")?"gtabnotify":""
	if(ea.font){
		Gui,3:Font,% CompileFont(info),% ea.font
		Gui,3:Add,% ea.type,%pos% hwndhwnd %notify% %Disable%,% value
		Gui,3:Font
	}else{
		Gui,3:Add,% ea.type,%pos% hwndhwnd %notify% %disable%,% value
	}
	if(ea.type="TreeView"){
		Gui,3:Default
		TV_Add("Treeview (Placeholder)")
	}if(InStr(ea.type,"tab"))
		Gui,3:Tab
	ControlGetPos,x,y,w,h,,ahk_id%hwnd%
	wh:=!(ea.type~="(ComboBox|DDL|DropDownList)")?[["w",w],["h",h]]:[["w",w]]
	for a,b in wh
		info.SetAttribute(b.1,b.2)
	info.SetAttribute("hwnd",hwnd+0)
	WinGet,cl,ControlListHWND,% hwnd([3])
	if(ea.type~="ComboBox|ListView|DropDownList|DDL"){
		for a,b in StrSplit(cl,"`n")
			if !window.ssn("//*[@hwnd='" b+0 "']")
				info.SetAttribute("married",b+0)
	}
	debug()
	return info
}
Debug(info:=""){
	if(info=0)
		if(hwnd(55))
			return hwnd({rem:55})
	if !settings.ssn("//options/Debug_Window").text
		return
	if !hwnd(55){
		Gui,55:Destroy
		Gui,55:Default
		Gui,+hwndhwnd +Resize
		hwnd(55,hwnd)
		Gui,Margin,0,0
		Gui,Add,Edit,x0 y0 w900 h300 -Wrap
		Gui,Show,x0 y0 NA,Debug
		Gui,1:+AlwaysOnTop
		Gui,1:-AlwaysOnTop
	}
	info:=info?info:window
	Loop,2
		info.Transform()
	text:=info[]?info[]:window[]
	ControlSetText,Edit1,%text%,% hwnd([55])
	return
	55GuiEscape:
	55GuiClose:
	hwnd({rem:55})
	return
	55GuiSize:
	GuiControl,55:Move,Edit1,w%A_GuiWidth% h%A_GuiHeight%
	return
}
tv(){
	tv:
	if(A_GuiEvent!="Normal")
		return
	if((current:=TreeView.ssn("//*[@tv='" A_EventInfo "']")).ParentNode.nodename="Add"){
		GetInfo(current.nodename)
	}else if(tv:=treeview.ssn("//*[@tv='" A_EventInfo "']")){
		ea:=xml.ea(tv),Control:=window.ssn("//*[@hwnd='" ssn(tv.ParentNode,"@hwnd").text "']"),ItemInfo:=xml.ea(Control),undo.add()
		if (ea.value~="(x|y|w|h)"){
			InputBox,newvalue,Enter a new value,% "Enter a new value for " conxml.ssn("//*[@value='" ea.value "']/@desc").text,,,,,,,,% ItemInfo[ea.value]
			if ErrorLevel
				return
			if RegExMatch(newvalue,"\D")
				return m("Must be an integer")
			Gui,2:Default
			if (tv.ParentNode.nodename="all"){
				sel:=window.sn("//control[@selected='1']")
				while,Control:=sel.Item[A_Index-1]{
					Control.SetAttribute(ea.value,newvalue),new:=xml.ea(Control)
					info:=treeview.ssn("//*[@hwnd='" new.hwnd "']/*[@value='" ea.value "']"),info:=xml.ea(info)
					TV_Modify(info.tv,"",info.desc " = " newvalue)
					GuiControl,3:movedraw,% new.hwnd,% ea.value newvalue
				}
			}else{
				Control:=window.ssn("//*[@hwnd='" ssn(tv.ParentNode,"@hwnd").text "']")
				info:=treeview.ssn("//*[@hwnd='" ssn(control,"@hwnd").text "']/*[@value='" ea.value "']"),info:=xml.ea(info)
				TV_Modify(info.tv,"",info.desc " = " newvalue)
				Control.SetAttribute(ea.value,newvalue),new:=xml.ea(Control)
				GuiControl,3:movedraw,% new.hwnd,% ea.value newvalue
			}
		}else if(ea.value~="\b(v|g)\b"){
			InputBox,newvalue,Enter a new value,% "Enter a new value for " conxml.ssn("//*[@value='" ea.value "']/@desc").text,,,,,,,,% ItemInfo[ea.value]
			if ErrorLevel
				return
			newvalue:=clean(newvalue)
			if(ea.value="g"){
				sel:=window.sn("//control[@selected='1']")
				while,ss:=sel.Item[A_Index-1]{
					if label:=window.ssn("//label[@name='" ssn(ss,"@g").text "']"){
						if(newvalue="")
							label.ParentNode.RemoveChild(label)
						else
							label.SetAttribute("name",newvalue)
					}
					tv:=TreeView.ssn("//*[@hwnd='" ssn(ss,"@hwnd").text "']/info[@value='g']/@tv").text
					if(newvalue="")
						ss.RemoveAttribute("g"),TV_Modify(tv,"","G-Label")
					else
						ss.SetAttribute("g",newvalue)TV_Modify(tv,"","G-Label = " newvalue)
				}
			}if(ea.value="v"){
				tv:=TreeView.ssn("//*[@hwnd='" ssn(Control,"@hwnd").text "']/info[@value='v']/@tv").text
				if(newvalue="")
					Control.RemoveAttribute("v"),TV_Modify(tv,"","Variable")
				else
					Control.SetAttribute("v",newvalue)TV_Modify(tv,"","Variable = " newvalue)
				
			}
		}else if(ea.value="font"){
			ea:=xml.ea(control)
			if !ea.font
				ea:=window.ea("//control[@selected='1']")
			dlg_font(ea,1,hwnd(1))
			selected:=window.sn("//control[@selected='1']")
			while,Control:=selected.Item[A_Index-1]{
				for a,b in ea
					if(a~="i)(bold|italic|strikeout|color|font|size|underline)")
						Control.SetAttribute(a,b)
				con:=xml.ea(Control)
				style:=CompileFont(Control),name:=ea.font
				Gui,3:Font
				Gui,3:Font,%style%,%name%
				GuiControl,3:Font,% con.hwnd
				GuiControl,% "3:+c" ea.color,% con.hwnd
				WinSet,Redraw,,% hwnd([3])
				Gui,3:Font
		}}else if(ea.value="value"){
			InputBox,new,Input Required,% "Input a new value for " ea.desc,,,,,,,,% ItemInfo[ea.value]
			if ErrorLevel
				return
			ea:=xml.ea(control),control.SetAttribute("value",new)
			GuiControl,3:,% ea.hwnd,% _:=ea.value~="i)tab|tab2|ComboBox|DropDownList"?"|" new:new
			if((iteminfo.type="ComboBox"||iteminfo.type="DropDownList")&&!InStr(new,"||"))
				GuiControl,3:Choose,% ea.hwnd,1
			if(StrSplit(new,"|").MaxIndex()<sn(control,"tab").length){
				m("This feature 'should' be asking if you want to get rid of the controls on the tabs you are removing....")
			}
			if(iteminfo.type~="Tab"){
				for a,b in StrSplit(new,"|")
					if(!ssn(control,"tab[@tab='" a "']"))
						tb:=window.under({under:control,node:"tab",att:{tab:a}}),
			}
			Debug()
		}else if(ea.value="option"){
			InputBox,new,Additional Options,% "Input a value for" ea.desc,,,,,,,,% ItemInfo[ea.value]
			if ErrorLevel
				return
			control.SetAttribute("option",new),ea:=xml.ea(control)
		}
		else if(tv.nodename="windowtitle"){
			node:=window.ssn("//window")
			InputBox,new,Enter New Name,Please enter the new name for the window title,,,,,,,,% ssn(node,"@windowtitle").text
			if(ErrorLevel)
				return
			node.SetAttribute("windowtitle",new)
		}
		else if(tv.nodename="windowname"){
			node:=window.ssn("//window")
			InputBox,new,Enter New Name,Please enter the new name for the window title,,,,,,,,% ssn(node,"@windowname").text
			if(ErrorLevel)
				return
			node.SetAttribute("windowname",Clean(new))
		}
		Highlight(),DisplaySelected()
		SetTimer,Redraw,-100
	}
	return
}
Highlight(a:=""){
	if(A_Gui>3&&a!="show")
		return
	hwnd({rem:99})
	Gui,99:+LastFound +owner1 +E0x20 -Caption +hwndsh
	hwnd(99,sh)
	WinSet,TransColor,0xF0F0F0 100
	Gui,99:Color,0xF0F0F0,0xFF
	Gui,99:Default
	WinGetPos,x,y,w,h,% hwnd([3])
	x+=v.Border,y+=v.border+v.Caption,h-=(v.Border*2)+(v.Caption),w-=(v.Border*2)
	Gui,99:Show,x%x% y%y% w%w% h%h% NoActivate
	ll:=window.sn("//control[@selected='1']/@hwnd")
	while,l:=ll.item(A_Index-1).text{
		ControlGetPos,cx,cy,w,h,,ahk_id%l%
		if (cx&&cy&&w&&h){
			pos:=WinPos(cx,cy)
			Gui,Add,Progress,% "c" color " x" pos.x " y" pos.y " w" w " h" h,100
		}
	}
	if a=0
		SetTimer,Redraw,-10
}
Redraw(win:=3){
	WinSet,Redraw,,% hwnd([win])
}
Exit(close:=0){
	GuiClose:
	WinGetPos,xx,yy,w,h,% hwnd([1])
	adj:=adjust(xx,yy,w,h),att:={main:{x:xx,y:yy,w:adj.w,h:adj.h-v.menu}}
	for a,b in {settings:2,workarea:3}{
		ControlGetPos,x,y,w,h,,% hwnd([b])
		adjust:=adjust(x,y,w,h)
		att[a]:={x:adjust.x,y:adjust.y-v.menu,w:adjust.w,h:adjust.h}
	}
	for a,b in att
		settings.Add({path:"gui/" a,att:att[a]})
	file:=window.ssn("//filename").text
	settings.Add({path:"last",text:file}),settings.save(1)
	temp:=new xml("project",file),rem:=window.sn("//*")
	while,rr:=rem.Item[A_Index-1]
		for a,b in StrSplit("offsetx,offsety,married,hwnd,ow,oh",",")
			rr.RemoveAttribute(b)
	if !(temp[]==window[]){
		MsgBox,35,File Changed,Would you like to save your GUI?
		if !FileExist(file)
			rem:=window.ssn("//filename"),rem.ParentNode.RemoveChild(rem)
		IfMsgBox,Yes
			save()
		IfMsgBox,Cancel
			return
	}
	if(close)
		return new()
	ExitApp
	return
}
Hotkeys(state:=1){
	state:=state?"On":"Off"
	Hotkey,IfWinActive,% hwnd([1])
	hotkey:=settings.sn("//hotkeys/*[@hotkey!='']/@hotkey")
	while,key:=hotkey.item[A_Index-1].text
		Hotkey,%key%,hotkey,%state%
	return
	hotkey:
	hotkey:=settings.ssn("//*[@hotkey='" A_ThisHotkey "']").NodeName
	MouseGetPos,,,,Control,2
	if(control+0!=hwnd(3))
		if(window.ssn("//*[@hwnd='" control+0 "']/@type")~="i)Tab|Tab2|ComboBox"=0){
			ControlSend,,{%A_ThisHotkey%},ahk_id%control%
			return
		}
	if IsFunc(hotkey)
		%hotkey%()
	else if(hotkey~="(" Menu({menu:1}).add ")")
		getinfo(hotkey)
	return
}
Edit_Hotkeys(){
	static tv:=[]
	Gui,4:Destroy
	Gui,4:Default
	Gui,Add,TreeView,w300 r20
	Gui,Add,Button,gedithotkey Default,Edit Hotkey
	menu:=Menu({menu:1}),tv:=[],hotkeys(0)
	for a,b in Menu.order{
		for c,d in StrSplit(Menu[b],"|"){
			if !tv[b]
				root:=tv[b]:=TV_Add(b)
			if !(settings.ssn("//hotkeys/" clean(d)))
				settings.Add({path:"hotkeys/" clean(d),att:{menu:d}})
			tv[TV_Add(GetMenuItem(d,1),root,"Vis")]:={parent:b,xml:settings.ssn("//hotkeys/" clean(d))}
		}
	}
	TV_Modify(TV_GetChild(0),"Select Vis Focus")
	Gui,4:Show,,Hotkeys
	return
	4GuiEscape:
	Gui,4:Destroy
	hotkeys()
	return
	edithotkey:
	Gui,4:Default
	value:=tv[TV_GetSelection()]
	oldmenu:=GetMenuItem(ssn(value.xml,"@menu").text)
	InputBox,new,New Hotkey,Enter a new hotkey,,,,,,,,% ssn(value.xml,"@hotkey").text
	if ErrorLevel
		return
	value.xml.SetAttribute("hotkey",new)
	newmenu:=GetMenuItem(ssn(value.xml,"@menu").text)
	Menu,% value.parent,Rename,%oldmenu%,%newmenu%
	TV_Modify(TV_GetSelection(),"",GetMenuItem(ssn(value.xml,"@menu").text,1))
	return
}
Adjust(ByRef x,byref y,w:="",h:=""){
	if (IsObject(x)=0&&y!=""&&x!=""&&w&&h)
		return {x:x-v.Border,y:y-(v.Border+v.Caption),w:w-(v.border*2),h:h-(v.border*2+v.Caption)}
	if (IsObject(x)=0&&y&&x)
		return {x:x-v.Border,y:y-(v.Border+v.Caption)}
}
New(){
	Gui,3:Destroy
	Gui,3:+Resize +hwndhwnd -0x20000 -0x10000 +parent1 -ToolWindow 
	hwnd(3,hwnd),ea:=settings.ea("//gui/workarea"),pos:=""
	Gui,3:Show,% guipos("//gui/workarea","x176 y5 w500 h500"),Work Area
	Gui,3:Margin,0,0
	window:=new xml("gui"),Display_Grid(),Select(0,0)
	WinSet,Redraw,,% hwnd([3])
}
Save(filename:=""){
	if !FileExist("Projects")
		FileCreateDir,Projects
	Loop,2
		window.Transform()
	if !(filename){
		if !filename:=window.ssn("//filename").text
			FileSelectFile,filename,S16,%A_ScriptDir%\Projects,Save Project As,*.xml
		if ErrorLevel
			return
		filename:=InStr(filename,".xml")?filename:filename ".xml"
	}
	window.Add({path:"filename",text:filename}),filename:=SubStr(filename,-3)!=".xml"?filename ".xml":filename,window.file:=filename
	ControlGetPos,x,y,w,h,,% hwnd([3])
	att:={x:x,y:y,w:w,h:h},window.add({path:"workarea",att:att}),window.Transform(),window.save(1)
	SplitPath,filename,file
	TrayTip,GUI Creator,File '%file%' has been saved
	WinSetTitle,% hwnd([1]),,GUI Creator: %file%
	debug()
}
Move(){
	MouseGetPos,x,y,win,Ctrl,2
	pos:=WinPos(x,y),moved:=0,ctrl+=0,xx:=x,yy:=y,lastx:=x,lasty:=y
	if !control:=window.ssn("//*[@hwnd='" ctrl "' or @married='" ctrl "']")
		control:=window.ssn("//window/*[@x<" pos.x " and @y<" pos.y " and @x+@w>" pos.x " and @y+@h>" pos.y "]")
	if(ctrl=hwnd(3)&&control.xml="")
		return pos:=WinPos(x,y),Select(pos.x,pos.y)
	if((control.nodename!="control")||(win!=hwnd(1)||ctrl=hwnd("tv")))
		return
	Gui,99:Destroy
	if(control+0=hwnd("tv"))
		return
	ea:=xml.ea(control)
	list:=ea.selected?window.sn("//control[@selected='1']/descendant-or-self::control"):window.sn("//control[@hwnd='" ea.hwnd "']/descendant-or-self::control")
	while,ll:=list.Item[A_Index-1]
		ea:=xml.ea(ll),ll.SetAttribute("offsetx",ea.x-pos.x),ll.SetAttribute("offsety",ea.y-pos.y)
	if(list.length){
		while,GetKeyState("LButton"){
			MouseGetPos,xx,yy
			if(Abs(x-xx)>3||Abs(y-yy)>3){
				while,ll:=list.item[A_Index-1],ea:=xml.ea(ll)
					if(ea.type="DropDownList")
						SendMessage,0x14F,0,0,,% "ahk_id" ea.hwnd
				undo.add()
				break
			}
		}
		if(Abs(x-xx)=0&&Abs(y-yy)=0)
			return CreateSelection(window.sn("//*[@hwnd='" ssn(control,"@hwnd").text "']"))
		if(GetKeyState("shift")){
			SetTimer,Resize,-1
			return
		}
		while,GetKeyState("LButton"){
			MouseGetPos,xx,yy
			if(Abs(lastx-xx)>0||Abs(lasty-yy)>0){
				pos:=WinPos(xx,yy)
				while,ll:=list.Item[A_Index-1],ea:=xml.ea(ll){
					nx:=pos.x+ea.offsetx,ny:=pos.y+ea.offsety,Grid(nx,ny)
					GuiControl,3:MoveDraw,% ea.hwnd,% "x" nx " y" ny
					ll.SetAttribute("x",nx),ll.SetAttribute("y",ny)
				}
			}
			lastx:=xx,lasty:=yy
		}
	}
	pos:=WinPos(xx,yy),con:=window.ssn("//*[@x<" pos.x " and @x+@w>" pos.x " and @y<" pos.y " and @y+@h>" pos.y " and @type='Tab' or @type='Tab2']")
	if con
		AddToTab(con,list)
	UpdateTV(list),Eval(),highlight(),debug(),DisplaySelected()
	return
}
Select(xx,yy){
	Random,Color,0xcccccc,0xeeeeee
	Gui,59:-Caption +AlwaysOnTop +E0x20 +hwndselect +Owner1
	WinGetPos,wx,wy,ww,wh,% hwnd([3])
	WinGetPos,mx,my,,,% hwnd([1])
	Gui,59:Color,%Color%
	Gui,59:Show,% "x" wx+v.border " y" wy+v.border+v.caption " w" ww-(v.border*2) " h" wh-(v.border*2)-v.Caption " noactivate hide"
	Gui,59:Show,NoActivate
	WinSet,Transparent,50,ahk_id%select%
	while,GetKeyState("LButton"){
		MouseGetPos,x,y
		x:=x-(wx-mx)-v.Border,y:=y-(wy-my)-v.Border-v.Caption
		WinSet,Region,%xx%-%yy% %x%-%yy% %x%-%y% %xx%-%y% %xx%-%yy%,ahk_id %select%
	}
	start:={x:xx,y:yy},end:={x:x,y:y},pos:=[],pos.x:=[],pos.y:=[]
	for a,b in [start,end]
		pos.x[b.x]:=1,pos.y[b.y]:=1
	Gui,59:Destroy
	List:=window.sn("//*[@x>" pos.x.MinIndex() " and @x<" pos.x.MaxIndex() " and @y>" pos.y.MinIndex() " and @y<" pos.y.MaxIndex() "]"),CreateSelection(list)
}
CreateSelection(selections,toggle:=0){
	if ((GetKeyState("Control","P")=0&&GetKeyState("Shift","P")=0)&&toggle=0){
		sel:=window.sn("//window/descendant::control[@selected]")
		while,ss:=sel.Item[A_Index-1]
			ss.RemoveAttribute("selected")
	}
	while,ss:=selections.item[A_Index-1]{
		if(ss.nodename!="control")
			Continue
		if ((GetKeyState("Control","P")||toggle)&&ssn(ss,"@selected").text)
			ss.RemoveAttribute("selected")
		else
			ss.SetAttribute("selected",1)
	}
	highlight(),DisplaySelected(),debug()
}
Inside(inside){
		pos:=xml.ea(inside)
		return window.sn("//*[@x>" pos.x " and @x<" pos.x+pos.w " and @y>" pos.y " and @y<" pos.y+pos.h "]")
}
DisplaySelected(){
	static lastselected,type:={windowname:"Window Name",windowtitle:"Window Title"}
	selected:=window.sn("//control[@selected='1']"),top:=TreeView.ssn("//selected")
	Gui,2:Default
	GuiControl,2:-Redraw,SysTreeView321
	sel:=TreeView.sn("//control")
	while,ss:=sel.Item[A_Index-1]
		if !window.ssn("//*[@hwnd='" ssn(ss,"@hwnd").text "']/@selected")
			TV_Delete(ssn(ss,"@tv").text),ss.ParentNode.RemoveChild(ss)
	if(selected.length>1){
		if all:=TreeView.ssn("//all")
			TV_Delete(ssn(all,"@tv").text),all.ParentNode.RemoveChild(all)
		all:=TreeView.under({under:top,node:"all",att:{tv:TV_Add("All Controls",ssn(top,"@tv").text,"First")}})
		constants:=conxml.sn("//constants/info")
		while,cc:=constants.Item[A_Index-1]
			if !ssn(all,"*[@value='" ssn(cc,"@value").text "']")
				TreeView.under({under:all,node:"allset",att:{value:ssn(cc,"@value").text,tv:TV_Add(ssn(cc,"@desc").text,ssn(all,"@tv").text)}})
		while,ss:=selected.Item[A_Index-1]{
			ea:=xml.ea(ss),info:=xml.ea(conxml.ssn("//" ea.type)),info.v:=1,info.value:=1
			for a in info
				if rem:=TreeView.ssn("//allset[@value='" a "']")
					TV_Delete(ssn(rem,"@tv").text),rem.ParentNode.RemoveChild(rem)
		}
		TV_Modify(ssn(all,"@tv").text,"Expand")
	}else if(selected.length<=1)
		if all:=TreeView.ssn("//all")
			TV_Delete(ssn(all,"@tv").text),all.ParentNode.RemoveChild(all)
	/*
		Work on:
		-Add all of the main info to the control itself
		--Add optional stuff below it like all of the extra settings for the controls
		-Fix the "All" edits in the tv
		--make it move all the selected stuff.
	*/
	while,ss:=selected.Item[A_Index-1],ea:=xml.ea(ss){
		if !tvi:=TreeView.ssn("//control[@hwnd='" ssn(ss,"@hwnd").text "']"){
			constants:=conxml.sn("//" ea.type "/constants|//constants/*"),rem:=xml.ea(conxml.ssn("//" ea.type))
			next:=TreeView.under({under:top,node:"control",att:{hwnd:ea.hwnd,tv:TV_Add(ea.type,ssn(top,"@tv").text,"Vis")}})
			while,cc:=constants.Item[A_Index-1],cea:=xml.ea(cc)
				if !rem[cea.value]
					value:=(vv:=ssn(ss,"@" cea.value).text)?cea.desc " = " vv:cea.desc,TreeView.under({under:next,node:"info",att:{tv:TV_Add(value,ssn(next,"@tv").text),value:cea.value,desc:cea.desc}})
			TV_Modify(ssn(next,"@tv").text,"Expand")
		}else{
			set:=sn(tvi,"descendant::*")
			while,sc:=set.item[A_Index-1],sa:=xml.ea(sc)
				TV_Modify(sa.tv,"",sa.desc _:=ea[sa.value]?" = " ea[sa.value]:"")
		}
	}
	ea:=xml.ea(window.ssn("//window"))
	for a,b in ea{
		text:=b?type[a] " = " b:type[a]
		node:=TreeView.ssn("//" a)
		TV_Modify(ssn(node,"@tv").text,"",text)
	}
	GuiControl,2:+Redraw,SysTreeView321
	TV_Modify(TreeView.ssn("//Add/@tv").text,selected.length?"-Expand":"Expand"),Highlight()
}
KillSelect(){
	Gui,99:Destroy
}
Select_All(){
	SelectAll:
	all:=window.sn("//window/descendant::control")
	while,aa:=all.Item[A_Index-1],ea:=xml.ea(aa){
		if InStr(A_ThisHotkey,"+")
			ea.selected?aa.RemoveAttribute("selected"):aa.SetAttribute("selected",1)
		else
			aa.SetAttribute("selected",1)
	}
	Highlight(),DisplaySelected()
	return
}
Save_As(){
	filename:=window.ssn("//filename").text
	SplitPath,filename,,dir
	FileSelectFile,filename,,%dir%,Save Window As,*.xml
	if !(ErrorLevel){
		window.ssn("//filename").text:=filename
		save()
	}
}
LButton(){
	SetTimer,lb,-1
	return
	lb:
	MouseGetPos,x,y,win,ctrl,2
	node:=window.ssn("//*[@hwnd='" ctrl+0 "']"),ea:=xml.ea(node)
	if(ssn(node,"@type").text~="Tab"){
		Sleep,80
		if(v.tabbutton)
			return v.tabbutton:=0
	}
	SetTimer,move,-1
	return
}
Edit_GLabels(){
	if !window.sn("//*[@g!='']").length
		return m("This project does not have any labels associated with any of the controls","Please add label associations first")
	Gui,99:Destroy
	Gui,5:Destroy
	Gui,5:Default
	Gui,5:+hwndhwnd
	hwnd(5,hwnd)
	Gui,Add,ListView,w100 h400 AltSubmit gegl,Labels
	Gui,Add,Edit,x+10 w500 h400 geditgl
	labels:=window.sn("//@g")
	while,ll:=labels.item[A_Index-1]{
		if !window.ssn("//labels/label[@name='" ll.text "']")
			window.add({path:"labels/label",att:{name:ll.text},dup:1})
	}
	labels:=window.sn("//labels/label")
	while,ll:=labels.Item[A_Index-1]{
		if !window.ssn("//*[@g='" ssn(ll,"@name").text "']")
			ll.ParentNode.RemoveChild(ll)
		else
			LV_Add("",ssn(ll,"@name").text)
	}
	WinGetPos,x,y,w,h,% hwnd([1])
	Gui,5:Show,% Center(5),Label Editor
	LV_Modify(1,"Select Vis Focus")
	return
	editgl:
	if !LV_GetNext()
		return
	LV_GetText(label,LV_GetNext())
	if !info:=window.ssn("//labels/label[@name='" label "']")
		info:=window.add({path:"labels/label",att:{name:label},dup:1})
	ControlGetText,text,Edit1,% hwnd([5])
	info.text:=text
	return
	egl:
	if !LV_GetNext()
		return
	LV_GetText(label,LV_GetNext())
	text:=window.ssn("//label[@name='" label "']").text
	ControlSetText,Edit1,%text%,% hwnd([5])
	return
	5GuiClose:
	5GuiEscape:
	Gui,5:Destroy
	Highlight("show")
	return
}
Center(hwnd){
	Gui,%hwnd%:Show,Hide
	WinGetPos,x,y,w,h,% hwnd([1])
	WinGetPos,xx,yy,ww,hh,% hwnd([hwnd])
	centerx:=(Abs(w-ww)/2),centery:=Abs(h-hh)/2
	return "x" x+centerx " y" y+centery
}
Grid_Dot_Color(){
	color:=settings.Add({path:"grid"})
	dot:=Dlg_Color(ssn(color,"@dot").text,hwnd(1)),color.SetAttribute("dot",dot),MakeBackground(),settings.Add({path:"options/Grid",text:1})
}
Grid_Background(){
	color:=settings.Add({path:"grid"})
	dot:=Dlg_Color(ssn(color,"@grid").text,hwnd(1)),color.SetAttribute("grid",dot),MakeBackground(),settings.Add({path:"options/Grid",text:1})
}
Resize(){
	static wia:=ComObjCreate("wia.imagefile")
	MouseGetPos,x,y,win,Ctrl,2
	pos:=WinPos(x,y),moved:=0,ctrl+=0,xx:=x,yy:=y,lastx:=x,lasty:=y
	if !control:=window.ssn("//*[@hwnd='" ctrl "' or @married='" ctrl "']")
		control:=window.ssn("//window/*[@x<" pos.x " and @y<" pos.y " and @x+@w>" pos.x " and @y+@h>" pos.y "]")
	ea:=xml.ea(control)
	list:=ea.selected?window.sn("//control[@selected='1']"):window.sn("//control[@hwnd='" ea.hwnd "']")
	while,ll:=list.Item[A_Index-1],ea:=xml.ea(ll){
		ControlGetPos,,,w,h,,% "ahk_id" ea.hwnd
		ll.SetAttribute("ow",w),ll.SetAttribute("oh",h)
		if(ea.width=""&&ea.height=""&&ea.type="Picture"){
			wia.loadfile(ea.value)
			for a,b in {width:wia.width,height:wia.height}
				ll.SetAttribute(a,b)
		}
	}
	while,GetKeyState("LButton"){
		MouseGetPos,x,y
		if(lastx=x&&lasty=y)
			Continue
		break
	}
	while,GetKeyState("LButton"){
		MouseGetPos,x,y
		if(lastx=x&&lasty=y)
			Continue
		while,ll:=list.Item[A_Index-1],ea:=xml.ea(ll){
			nw:=x-xx,nh:=y-yy,Grid(nw,nh),command:="Move"
			if(ea.type="Picture")
				nh:=Round(nw*ea.height/ea.width),command:="MoveDraw"
			GuiControl,3:%command%,% ea.hwnd,% "w" ea.ow+nw " h" ea.oh+nh
			ll.SetAttribute("w",ea.ow+nw),ll.SetAttribute("h",ea.oh+nh)
			lastx:=x,lasty:=y
		}
	}
	Highlight(),eval(),DisplaySelected()
	SetTimer,Redraw,-10
}
Update_Program(){
	m("Coming soon (if not soon ask maestrith nicely)")
	/*
		if FileExist("gui.ahk")
			return m("NO!")
		FileMove,%A_ScriptName%,deleteme.ahk,1
		UrlDownloadToFile,http://files.maestrith.com/GUI_Creator/GUI_Creator.ahk,%A_ScriptName%
		FileDelete,deleteme.ahk
		Reload
		ExitApp
	*/
}
Dlg_Font(ByRef Style,Effects=1,window=""){
	VarSetCapacity(LOGFONT,60),strput(style.font,&logfont+28,32,"CP0")
	LogPixels:=DllCall("GetDeviceCaps","uint",DllCall("GetDC","uint",0),"uint",90),Effects:=0x041+(Effects?0x100:0)
	for a,b in font:={16:"bold",20:"italic",21:"underline",22:"strikeout"}
		if style[b]
			NumPut(b="bold"?700:1,logfont,a)
	style.size?NumPut(Floor(style.size*logpixels/72),logfont,0):NumPut(16,LOGFONT,0)
	VarSetCapacity(CHOOSEFONT,60,0),NumPut(60,CHOOSEFONT,0),NumPut(&LOGFONT,CHOOSEFONT,12),NumPut(Effects,CHOOSEFONT,20),NumPut(RGB(style.color),CHOOSEFONT,24),NumPut(window,CHOOSEFONT,4)
	if !r:=DllCall("comdlg32\ChooseFontA","uint",&CHOOSEFONT)
		return
	Color:=NumGet(CHOOSEFONT,24),bold:=NumGet(LOGFONT,16)>=700?1:0
	style:={size:NumGet(CHOOSEFONT,16)//10,font:StrGet(&logfont+28,"CP0"),color:RGB(color)}
	for a,b in font
		style[b]:=NumGet(LOGFONT,a,"UChar")?1:0
	style["bold"]:=bold
	return 1
}
CompileFont(XMLObject,text:=1){
	ea:=xml.ea(XMLObject),style:=[],name:=ea.name,styletext:="norm"
	for a,b in {bold:"",color:"c",italic:"",size:"s",strikeout:"",underline:""}
		if ea[a]
			styletext.=" " _:=b?b ea[a]:a
	style:=text?styletext:style
	if(style="norm")
		return
	return style
}
Delete(){
	all:=window.sn("//window/descendant::*[@selected='1']")
	undo.add()
	while,aa:=all.item[A_Index-1],ea:=xml.ea(aa)
		DllCall("DestroyWindow",ptr,ea.hwnd),aa.ParentNode.RemoveChild(aa)
	Select(0,0)
}
Eval(){
	tab:=window.sn("descendant::control[@type='Tab' or @type='Tab2']"),list:=window.sn("//*[contains(@type,'Tab')]/descendant::control")
	while,ll:=list.item[A_Index-1]{
		parent:=ssn(ll,"ancestor::control[contains(@type,'Tab')]"),pa:=xml.ea(parent),ea:=xml.ea(ll)
		if(!(ea.x>pa.x&&ea.x<pa.x+pa.w&&ea.y>pa.y&&ea.y<pa.y+pa.h)){
			if new:=window.ssn("//control[contains(@type,'Tab')][@x<" ea.x " and @x+@y>" ea.x " and @y<" ea.y " and @y+@h>" ea.y "]"){
				tt:=xml.ea(new),nn:=GetClassNN(tt.hwnd),top:=window.ssn("//control[@hwnd='" tt.hwnd "']")
				ControlGet,tabnum,tab,,%nn%,% hwnd([3])
				Gui,3:Tab,%tabnum%,% SubStr(nn,16)
				if(!tb:=ssn(new,"tab[@tab='" tabnum "']")){
					Loop,%tabnum%
						if(!ssn(new,"tab[@tab='" A_Index "']"))
							window.under({under:top,node:"tab",att:{tab:A_Index}})
					tb:=ssn(new,"tab[@tab='" tabnum "']")
				}
				tb.AppendChild(ll),new:=AddControl(ll)
				DllCall("DestroyWindow",ptr,ea.hwnd)
			}else{
				window.ssn("//window").AppendChild(ll)
				Gui,3:Tab
				DllCall("DestroyWindow",ptr,ea.hwnd),AddControl(ll)
	}}}
	gb:=window.sn("descendant::control[@type='GroupBox']"),inside:=[]
	while,gg:=gb.item[A_Index-1]{
		while,in:=inside(gg).item[A_Index-1],ea:=xml.ea(in){
			if(gg.xml!=in.ParentNode.xml&&gg.ParentNode.xml=in.ParentNode.xml)
				gg.AppendChild(in)
			inside[ea.hwnd]:=1
		}
	}
	ngb:=window.sn("//descendant::control[@type!='GroupBox' and @type!='Tab' and @type!='Tab2']")
	while,move:=ngb.item[A_Index-1],ea:=xml.ea(move){
		if(inside[ea.hwnd]!=1&&ssn(move.ParentNode,"@type").text="GroupBox")
			move.ParentNode.ParentNode.AppendChild(move)
	}
	debug()
}
GetClassNN(ctrl){
	WinGet,list,ControlList,% hwnd([3])
	for a,b in StrSplit(list,"`n"){
		ControlGet,hwnd,hwnd,,%b%,% hwnd([3])
		if(hwnd=ctrl)
			return b
	}
}
UpdateTV(list){
	while,ll:=list.Item[A_Index-1]{
		if tv:=TreeView.ssn("//*[@hwnd='" ssn(ll,"@hwnd").text "']"){
			x:=xml.ea(ssn(tv,"*[@value='x']")),y:=xml.ea(ssn(tv,"*[@value='y']"))
			Gui,2:Default
			for a,b in {x:[x.tv,x.desc],y:[y.tv,y.desc]}
				TV_Modify(b.1,"",b.2 " = " ssn(ll,"@" a).text)
		}
	}
}
AddToTab(tab,list){
	tt:=xml.ea(tab),nn:=GetClassNN(tt.hwnd)
	top:=window.ssn("//control[@hwnd='" tt.hwnd "']")
	ControlGet,tabnum,tab,,%nn%,% hwnd([3])
	Gui,3:Tab,%tabnum%,% SubStr(nn,16)
	while,ll:=list.item[A_Index-1],ea:=xml.ea(ll){
		if(InStr(ea.type,"tab"))
			Continue
		if(ssn(ll,"ancestor::control[@type='Tab' or @type='Tab2']"))
			Continue
		if !tb:=ssn(top,"tab[@tab='" tabnum "']")
			tb:=window.under({under:top,node:"tab",att:{tab:tabnum}})
		tb.AppendChild(ll)
		DllCall("DestroyWindow",ptr,ea.hwnd)
		AddControl(ll)
	}
	debug()
}
UpdatePos(ctrl){
	ControlGetPos,x,y,w,h,,% "ahk_id" xml.ea(ctrl).hwnd
	pos:=WinPos(x,y)
	for a,b in {x:pos.x,y:pos.y,w:w,h:h}
		ctrl.SetAttribute(a,b)
	window.transform(1)
}
Export(return:=0){
	glabel:=[],winname:=window.ssn("//window/@name").text,program:=winname?"Gui," winname ":Default`n":"",main:=window.sn("//window/control"),top:=window.ssn("//window"),obj:=[]
	while,mm:=main.item[A_Index-1],ea:=xml.ea(mm)
		obj[ea.y,ea.x,ea.hwnd]:=mm
	for a,b in obj
		for c,d in b
			for e,f in d
				top.AppendChild(f)
	obj:=[],gb:=window.sn("//*[@type='GroupBox']/*")
	while,gg:=gb.item[A_Index-1],ea:=xml.ea(gg)
		obj[ea.y,ea.x,ea.hwnd]:={parent:gg.ParentNode,item:gg}
	for a,b in obj
		for c,d in b
			for e,f in d
				f.parent.AppendChild(f.item)
	tab:=[],tabs:=window.sn("//window/control[@type='Tab' or @type='Tab2']")
	while,tt:=tabs.item[A_Index-1],ea:=xml.ea(tt)
		tab[ea.y,ea.x,ea.hwnd]:=tt
	for a,b in tab
		for c,d in b
			for e,f in d
				top.AppendChild(f)
	tabs:=window.sn("//*[@type='Tab' or @type='Tab2']/tab")
	while,tt:=tabs.item[A_Index-1]{
		items:=[],ctrls:=sn(tt,"control")
		while,cc:=ctrls.item[A_Index-1],ea:=xml.ea(cc)
			items[ea.y,ea.x,ea.hwnd]:=cc
		for a,b in items
			for c,d in b
				for e,f in d
					tt.AppendChild(f)
	}
	all:=window.sn("//window/descendant::*")
	while,aa:=all.item[A_Index-1],ea:=xml.ea(aa){
		if(aa.NodeName="tab"){
			line:="Gui,Tab," ea.tab "`n"
			program.=line
			Continue
		}
		font:=CompileFont(aa)
		if(ea.g)
			glabel[ea.g]:=1
		if(font!=lastfont&&font)
			Program.="Gui,Font," font "," ea.font "`n"
		if(font!=lastfont&&!font)
			program.="Gui,Font`n"
		Program.=CompileItem(aa) "`n",lastfont:=font
	}
	;/Compile GUI
	pos:=WinPos(),title:=window.ssn("//window/@windowtitle").text,title:=title?title:"Created with GUI Creator by maestrith"
	Program.="Gui,Show,w" pos.w " h" pos.h "," title
	/*
		this needs to check cexml to see if the labels already exist
		if it doesn't
			create the labels below the ;/gui[] tag
		else
			they exist, duh, no need to add them :)
		do a quick scan to be safe
	*/
	for a in glabel
		program.="`n" a ":`n" window.ssn("//labels/label[@name='" a "']").text "`nreturn"
	/*
		/yea, above thing
	*/
	m("Text copied to your clipboard:",Clipboard:=program)
	return
	
	
	
	
	/*
		ControlGetPos,,,w,h,,% hwnd([3])
		
		program.="Gui,Show,w" w-(v.Border*2) " h" h-(v.Border*2+v.Caption) ",Created with GUI Creator by Maestrith :)`nreturn"
	*/
	StringReplace,program,program,`n,`r`n,All
	if(return)
		return program
	Clipboard:=program
	TrayTip,GUI Creator,GUI Copied to the Clipboard
	return
	control:
	ff:="Gui,Font," cf "," ea.font,_:=(cf="norm"&&lastfont="")?ff:="":(cf="norm"&&lastfont!="")?(ff:="Gui,Font",lastfont:="",program.=ff "`n"):(cf!="norm"&&ff!=lastfont)?(lastfont:=ff:="Gui,Font," cf "," ea.font,program.=ff "`n")
	add:=""
	for a,b in {v:ea.v,g:ea.g}
		if(b)
			add.=" " a b
	program.="Gui,Add," ea.type ",x" ea.x " y" ea.y " w" ea.w " h" ea.h add "," ea.value "`n"
	if ea.g
		glabel[ea.g]:=1
	return
}
Help(){
	MsgBox,262176,Help,Left Click and drag to create a selection`n-Shift+Left Click to add items to the selection`n-Ctrl+Left Click to toggle the items selected state`n`nRight Click and drag to Resize selected controls`n`nCtrl+A to Select All and Ctrl+Shift+A to Toggle Select All`n`nTo delete selected controls press Delete
}
Test_GUI(){
	DynaRun(Export(1))
}
DynaRun(Script,debug=0){
	static exec
	exec.terminate()
	Name:="GUI Creator Test",Pipe:=[],cr:= Chr(34) Chr(96)"n" Chr(34)
	script:="#SingleInstance,Force`n" script
	script.="`nreturn`nguiescape:`nguiclose:`nexitapp`nreturn"
	Loop, 2
		Pipe[A_Index]:=DllCall("CreateNamedPipe","Str","\\.\pipe\" name,"UInt",2,"UInt",0,"UInt",255,"UInt",0,"UInt",0,"UPtr",0,"UPtr",0,"UPtr")
	Call:=Chr(34) A_AhkPath Chr(34) " /ErrorStdOut /CP65001 " Chr(34) "\\.\pipe\" Name Chr(34),Shell:=ComObjCreate("WScript.Shell"),Exec:=Shell.Exec(Call)
	for a,b in Pipe
		DllCall("ConnectNamedPipe","UPtr",b,"UPtr",0)
	FileOpen(Pipe[2],"h","UTF-8").Write(Script)
	for a,b in Pipe
		DllCall("CloseHandle","UPtr",b)
	return exec
}
Undo(){
	undo.undogo()
}
class undo{
	undo:=[],redo:=[]
	__New(){
		undo.undo:=[],undo.redo:=[]
	}
	add(){
		undo.undo.Insert(window.ssn("//*").clonenode(1))
	}
	undogo(){
		undo.undo.1?undo.fix("undo","redo"):m("Nothing more to undo")
	}
	redogo(){
		undo.redo.1?undo.fix("redo","undo"):m("Nothing more to redo")
	}
	fix(in,out){
		last:=undo[in].pop(),list1:=window.sn("//control"),list2:=sn(last,"//control"),undo[out].Insert(window.ssn("//*").clonenode(1))
		while,ll:=list1.item[A_Index-1],ea:=xml.ea(ll)
			if !ssn(last,"//*[@hwnd='" ea.hwnd "']")
				DllCall("DestroyWindow",ptr,ea.hwnd),ll.ParentNode.RemoveChild(ll),action:=1
		while,ll:=list2.item[A_Index-1],ea:=xml.ea(ll)
			if !window.ssn("//*[@hwnd='" ea.hwnd "']")
				top:=ll.ParentNode.NodeName="window"?window.ssn("//window"):window.ssn("//*[@hwnd='" ssn(ll.ParentNode,"@hwnd").text "']"),top.AppendChild(ll),AddControl(ll),action:=1
		while,ll:=list2.item[A_Index-1],ea:=xml.ea(ll){
			ctrl:=window.ssn("//*[@hwnd='" ea.hwnd "']"),cea:=xml.ea(ctrl),move:=""
			for a,b in ea{
				if(ea[a]!=cea[a]&&a~="\b(x|y|w|h)")
					move.=a b " "
				ctrl.SetAttribute(a,b)
			}
			if move
				GuiControl,3:MoveDraw,% ea.hwnd,%move%
		}
		highlight(),DisplaySelected()
		SetTimer,Redraw,-10
	}
}
Redo(){
	undo.redogo()
}
Testing(){
	
}
WinPos(x:="",y:=""){
	ControlGetPos,xx,yy,ww,hh,,% hwnd([3])
	VarSetCapacity(rect,16),DllCall("GetClientRect",ptr,hwnd(3),ptr,&rect),x-=xx+v.Border,y-=yy+v.Border+v.Caption,w:=NumGet(rect,8,"int"),h:=NumGet(rect,12,"int")
	return {x:x,y:y,w:w,h:h}
}
CompileItem(node){
	ea:=xml.ea(node),index:=0
	item:="Gui,Add," ea.type ","
	for a,b in StrSplit("x,y,w,h,g,v",",")
		if(ea[b]!="")
			item.=(index=0?"":" ") b ea[b],index++
	if(ea.option)
		item.=" " ea.option
	item.="," ea.value
	return item
}
f1::
file:=window.ssn("//filename").text
;SplitPath,file,,dir
Run,%file%
return
TabNotify(){
	v.tabbutton:=1
}
Escape(){
	all:=window.sn("//*[@selected]")
	while,aa:=all.item[A_Index-1]
		aa.RemoveAttribute("selected")
	Highlight()
}