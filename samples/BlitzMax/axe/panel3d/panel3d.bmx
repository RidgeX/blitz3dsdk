' panel3d.bmx

' demonstrates running a Blitz3D runtime inside a MaxGUI application

Import brl.win32maxgui
Import blitz3d.blitz3dsdk

Strict

Local b3dapp:TBlitz3DApplet
b3dapp=New TBlitz3DApplet.Create("Blitz3DSDK (C)2007 Blitz Research Ltd.")
While True
	WaitEvent
	b3dapp.OnEvent(CurrentEvent)
Wend

End

Const MENU_NEW=101
Const MENU_OPEN=102
Const MENU_SAVE=103
Const MENU_CLOSE=104
Const MENU_EXIT=105

Const MENU_CUT=106
Const MENU_COPY=107
Const MENU_PASTE=108

Const MENU_ABOUT=109

Type TBlitz3DApplet

	Field camera,light
	Field cube,cube2
	Field lost=True
	
	Method InitWorld(hwnd,maxwidth,maxheight)
		bbSetBlitz3DHWND(hwnd)
		bbBeginBlitz3D 
		bbGraphics3D maxwidth,maxheight,0,2
'		Local brush=bbLoadBrush("b3dlogo.png",3)
		Local brush=bbCreateBrush(255,100,50)
		cube=bbCreateCube()
		bbPaintEntity cube,brush
		bbFitMesh cube,-20,-20,-2,40,40,4	
		cube2=bbCreateCube()
		bbPaintEntity cube2,brush
		bbFitMesh cube2,-2,-20,-20,4,40,40
		light=bbCreateLight()
		camera=bbCreateCamera()
		bbCameraClsColor camera,255,100,80
		bbPositionEntity camera,0,0,-64
		lost=False
	End Method

	Method DrawWorld(w,h)
		If lost Return
		bbCameraViewport camera,0,0,w,h		
		bbTurnEntity cube,0,1,0
		bbTurnEntity cube2,0,1,0
		bbRenderWorld
		bbFlip 
	End Method

	Field	window:TGadget
	Field	canvas:TGadget
	Field	timer:TTimer
	Field	image:TImage

	Field filemenu:TGadget
	Field editmenu:TGadget
	Field helpmenu:TGadget

	Method Create:TBlitz3DApplet(name$)
		Local	w,h,hwnd
		
		image=LoadImage("fltkwindow.png")
		window=CreateWindow(name,20,20,512,512)

		filemenu=CreateMenu("&File",0,WindowMenu(window))
		CreateMenu"&New",MENU_NEW,filemenu,KEY_N,MODIFIER_COMMAND
		CreateMenu"&Open",MENU_OPEN,filemenu,KEY_O,MODIFIER_COMMAND
		CreateMenu"&Close",MENU_CLOSE,filemenu,KEY_W,MODIFIER_COMMAND
		CreateMenu"",0,filemenu
		CreateMenu"&Save",MENU_SAVE,filemenu,KEY_S,MODIFIER_COMMAND
		CreateMenu"",0,filemenu
		CreateMenu"E&xit",MENU_EXIT,filemenu,KEY_F4,MODIFIER_COMMAND
		
		editmenu=CreateMenu("&Edit",0,WindowMenu(window))
		CreateMenu "Cu&t",MENU_CUT,editmenu,KEY_X,MODIFIER_COMMAND
		CreateMenu "&Copy",MENU_COPY,editmenu,KEY_C,MODIFIER_COMMAND
		CreateMenu "&Paste",MENU_PASTE,editmenu,KEY_V,MODIFIER_COMMAND
		
		helpmenu=CreateMenu("&Help",0,WindowMenu(window))
		CreateMenu "&About",MENU_ABOUT,helpmenu
		
		UpdateWindowMenu window
	
		w=ClientWidth(window)
		h=ClientHeight(window)
		canvas=CreatePanel(0,0,w,h,window)
		canvas.SetLayout 1,1,1,1

		w=ClientWidth(Desktop())
		h=ClientHeight(Desktop())
		hwnd=QueryGadget(canvas,QUERY_HWND)
		InitWorld(hwnd,w,h)
		
		timer=CreateTimer(30)
		Return Self		
	End Method
	
	Field rendertime=MilliSecs()
	
	Method OnEvent:Object(Event:TEvent)
		Select event.id
		Case EVENT_WINDOWCLOSE
			End
		Case EVENT_TIMERTICK
			If (MilliSecs()-rendertime<10) Return
			DrawWorld ClientWidth(canvas),ClientHeight(canvas)
			rendertime=MilliSecs()
			Return Null
'			RedrawGadget canvas
		Case EVENT_GADGETPAINT
			DrawWorld ClientWidth(canvas),ClientHeight(canvas)
		Case EVENT_MENUACTION
			Select EventData()
				Case MENU_EXIT
					End
				Case MENU_ABOUT
					Notify "Incrediabler~n(C)2005 Incredible Software"
			End Select
		End Select
	End Method

	
End Type

