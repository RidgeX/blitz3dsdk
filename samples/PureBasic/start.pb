
; Demo startup code for texrender.pb, multicam.pb, teapot.pb, dragon.pb and tron.pb

; Converted to PB by ozak!

IncludeFile "../../include/blitz3dsdk.pbi"

Declare SetGfx()

SetGfx()

Procedure SetGfx()

  ; Initialise Blitz3D engine...
  bbBeginBlitz3D ()
  
  ; Set debug mode (it's on by default -- just added this so you can turn it off)...
  bbSetBlitz3DDebugMode(0) ; 1 = DEBUG ON, 0 = DEBUG OFF



	If info1$<>""
		bbSetBlitz3DTitle( info1$, "Exit "+info1$+"?")
	EndIf
	
	bbFlushKeys()
	
	mode_cnt=bbCountGfxModes3D()
	If Not mode_cnt 
	  bbRuntimeError("Can't find any 3D graphics modes")
	EndIf
	
	mode=0	
	If Not bbWindowed3D()
	 mode=1	
	EndIf
	
	bbGraphics(640,480,16,2)
	bbSetBuffer(bbBackBuffer())
	
	image=bbLoadImage( "b3dlogo.jpg" )
	If Not image 
	  image=bbLoadImage( "../../samples/BlitzMax/mak/b3dlogo.jpg" )
	EndIf
	bbMidHandle(image)
	
	font=bbLoadFont( "verdana",16,0,0,0 )
	bbSetFont(font)
	
	tx=640+160
	nx=-160
	ty=280
	
	url$="www.blitzbasic.com"
	url_x=640-bbStringWidth( url$ )
	url_y=480-bbFontHeight()

	Repeat
		bbCls()
		
		bbDrawBlock(image,320,144,0)
					
		bbColor(0,255,0)		
		bbText(tx,ty+bbFontHeight()*0,info1$,#True)
		If (info2$ <> "")
		  bbText(nx,ty+bbFontHeight()*1,info2$,#True)
		EndIf
		If (info3$ <> "")
		  bbText(tx,ty+bbFontHeight()*2,info3$,#True)
		EndIf
		If (info4$ <> "")
		  bbText(nx,ty+bbFontHeight()*3,info4$,#True)
		EndIf
	
		bbColor(255,255,255)
		If mode=0
			bbText(tx,ty+bbFontHeight()*5,"Windowed",#True)
		Else
			bbText(tx,ty+bbFontHeight()*5,Str(bbGfxModeWidth( mode ))+","+Str(bbGfxModeHeight( mode ))+","+Str(bbGfxModeDepth( mode )),#True)
		EndIf
		
		bbColor(255,0,0)
		bbText(nx,ty+bbFontHeight()*7,"[Return] to begin",#True)
		bbText(tx,ty+bbFontHeight()*8,"[Arrows] change mode",#True)
		bbText(nx,ty+bbFontHeight()*9,"[Escape] to exit",#True)
		
		bbColor(0,0,255)
		bbText(url_x,url_y,url$)
		
		If bbKeyHit( 1 ) 
		End
		EndIf
		If bbKeyHit( 28 )
			bbCls():bbFlip()
			bbCls():bbFlip()
			bbFreeFont(font)
			bbFreeImage(image)
			bbEndGraphics()
			If mode
				bbGraphics3D(bbGfxModeWidth(mode),bbGfxModeHeight(mode),bbGfxModeDepth(mode),1)
			Else
				bbGraphics3D(640,480,0,2)
			EndIf
			bbSetBuffer(bbBackBuffer())
			ProcedureReturn
		EndIf
		If bbKeyHit( 203 )
			mode=mode-1
			If mode<0 Or (mode=0 And (Not bbWindowed3D()))
				mode=mode_cnt
			EndIf
		ElseIf bbKeyHit( 205 )
			mode=mode+1
			If mode>mode_cnt
				mode=0
				If Not bbWindowed3D() 
				mode=1
				EndIf
			EndIf
		EndIf
		
		If tx>320 
		tx=tx-8
		EndIf
		If nx<320 
		nx=nx+8
		EndIf
		
		bbFlip()
		
	ForEver
	
EndProcedure

; IDE Options = PureBasic 4.30 (Windows - x86)
; CursorPosition = 1
; Folding = -
; EnableXP