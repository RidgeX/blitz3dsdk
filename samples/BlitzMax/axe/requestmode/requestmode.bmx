' requestmode.bmx

' RequestMode - prompts user for 3D graphics device and display mode
' SetMode - creates 3D graphics display using mode returned from RequestMode

' windowed mode = 0
' fullscreen mode = gfxdevice*65536+gfxmode for fullscreen

' 2007.5.3 added driverskip code so drivers == monitors

Strict

Import blitz3d.blitz3dsdk
Import brl.win32maxgui
'Import axe.win32maxgui
Import brl.eventqueue

bbBeginBlitz3D()

Local gfxmode=RequestMode()
If gfxmode<0 Return
SetMode(gfxmode)

Local cube=bbCreateCube()
Local light=bbCreateLight()
Local camera=bbCreateCamera()

bbPositionEntity camera,0,0,-4

While Not bbKeyHit(BBKEY_ESCAPE)
	bbTurnEntity cube,1,2,3
	bbRenderWorld
	bbFlip 
Wend

End

Function RequestMode(defaultmode=1)
	Global window:TGadget
	Local ok:TGadget
	Local cancel:TGadget
	Global devlist:TGadget
	Global mode32:TGadget
	Global mode16:TGadget
	
	Global modewindow:TGadget
	Global modefullscreen:TGadget

	Global modelists:TGadget[,]
	Global drv=defaultmode Shr 16
	Global depth,res,winmode
	Global gfxmode=defaultmode
	
	Global driverskip

	If defaultmode=0 winmode=1

	Local w=440
	Local h=400
	Local x=(ClientWidth(Desktop())-w)/2
	Local y=(ClientHeight(Desktop())-h)/2

	Local n=bbCountGfxDrivers()
	If n<1 Return -1

	window=CreateWindow("Select 3D Display Mode",x,y,w,h,Null,WINDOW_TITLEBAR|WINDOW_CLIENTCOORDS)
	
	ok=CreateButton("OK",w-100,h-30,80,26,window,BUTTON_OK)
	cancel=CreateButton("Cancel",20,h-30,80,26,window,BUTTON_CANCEL)
		
	Local p0:TGadget=CreatePanel(10,4,w-20,52,window,PANEL_GROUP,"Display Mode")
	modewindow=CreateButton("Windowed",10,4,80,24,p0,BUTTON_RADIO)
	modefullscreen=CreateButton("Full Screen",90,4,80,24,p0,BUTTON_RADIO)

	devlist=CreateComboBox(10,80,w-20,80,window)

	Local p1:TGadget=CreatePanel(10,114,w-20,54,window,PANEL_GROUP,"Color Depth")
	mode32=CreateButton("True Color",10,4,80,24,p1,BUTTON_RADIO)
	mode16=CreateButton("Half Color",90,4,80,24,p1,BUTTON_RADIO)

	Local p2:TGadget=CreatePanel(10,180,w-20,180,window,PANEL_GROUP,"Resolution")

	
	driverskip=1
	If n>1
		driverskip=2
		n=n-1
	EndIf
	modelists=New TGadget[n,2]
	drv:+1-driverskip

	For Local i=0 Until n
		Local g$=bbGfxDriverName(i+driverskip)
		AddGadgetItem devlist,"Monitor #"+(i+1)+":"+g

		bbSetGfxDriver i+driverskip
		Local m=bbCountGfxModes3D()
		Local himode=0

		For Local d=0 To 1
			modelists[i,d]=CreateListBox(10,4,w-50,140,p2)
			HideGadget modelists[i,d]
			For Local j=1 To m
				Local gw=bbGfxModeWidth(j)
				Local gh=bbGfxModeHeight(j)
				Local gd=bbGfxModeDepth(j)
				If himode=0 And gd>16 himode=gd
				If (d=0 And gd=himode) Or (d=1 And gd=16) 
					If drv=i And (defaultmode&$ffff)=j 
						depth=d
						res=CountGadgetItems(modelists[i,d])						
					EndIf
					AddGadgetItem modelists[i,d]," "+gw+" x "+gh,0,-1," (mode"+j+")",String(j)
				EndIf
			Next
		Next
	Next

	setmode drv,depth,res,winmode
	
	Function setmode(g,d,r,w)
		HideGadget modelists[drv,depth]
		drv=g
		depth=d
		res=r
		winmode=w
		bbSetGfxDriver drv+driverskip
		SelectGadgetItem devlist,drv
		ShowGadget modelists[drv,depth]
		If depth 
			SetButtonState mode16,True
		Else
			SetButtonState mode32,True
		EndIf
		SelectGadgetItem modelists[drv,depth],res
		If w
			SetButtonState modewindow,True
			DisableGadget modelists[drv,depth]
			DisableGadget devlist
			DisableGadget mode16
			DisableGadget mode32
			gfxmode=0
		Else
			SetButtonState modefullscreen,True
			EnableGadget modelists[drv,depth]
			EnableGadget devlist
			EnableGadget mode16
			EnableGadget mode32
			gfxmode=((drv+driverskip) Shl 16) | Int(GadgetItemExtra(modelists[drv,depth],res).toString())
		EndIf
		DebugLog "mode: drv="+g+" depth="+d+" res="+r+" winmode="+w+" gfxmode="+gfxmode		
	End Function
	
	While True
		WaitEvent()
		DebugLog CurrentEvent.toString()
		Select EventID()
			Case EVENT_WINDOWCLOSE
				FreeGadget window
				Return -1
			Case EVENT_GADGETACTION
				Select EventSource()
					Case ok
						FreeGadget window
						Return gfxmode
					Case cancel
						FreeGadget window
						Return -1
					Case devlist 
						setmode EventData(),depth,res,winmode
					Case mode16
						setmode drv,1,res,winmode
					Case mode32
						setmode drv,0,res,winmode
					Case modewindow
						setmode drv,depth,res,True
					Case modefullscreen
						setmode drv,depth,res,False
				End Select
			Case EVENT_GADGETSELECT
				setmode drv,depth,EventData(),winmode
		End Select
	Wend
End Function

Function SetMode(mode)
	Local drv,w,h,d
	drv=mode Shr 16
	mode=mode&65535
	If mode=0
		bbGraphics3D 640,480,0,2
		Return
	EndIf
	bbSetGfxDriver drv
	bbCountGfxModes3D()
	w=bbGfxModeWidth(mode)
	h=bbGfxModeHeight(mode)
	d=bbGfxModeDepth(mode)
	bbGraphics3D w,h,d,1
End Function

