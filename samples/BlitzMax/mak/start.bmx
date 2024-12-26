
SetGfx()

Function SetGfx()
	If info1$<>""
		bbSetBlitz3DTitle info1$,"Exit "+info1$+" ?"
	EndIf
	
	bbFlushKeys()
	
	mode_cnt=bbCountGfxModes3D()
	If Not mode_cnt RuntimeError "Can't find any 3D graphics modes"
	
	Local mode=0	
	If Not bbWindowed3D() mode=1
	
	bbGraphics 640,480,16,2
	bbSetBuffer bbBackBuffer()
	
	image=bbLoadImage( "b3dlogo.jpg" )
	If Not image image=bbLoadImage( "../b3dlogo.jpg" )
	bbMidHandle image
	
	font=bbLoadFont( "verdana",16 )
	bbSetFont font
	
	tx=640+160
	nx=-160
	ty=280
	
	url$="www.blitzbasic.com"
	url_x=640-bbStringWidth( url$ )
	url_y=480-bbFontHeight()

	Repeat
		bbCls
		
		bbDrawBlock image,320,144
					
		bbColor 0,255,0
		bbText tx,ty+bbFontHeight()*0,info1$,True
		bbText nx,ty+bbFontHeight()*1,info2$,True
		bbText tx,ty+bbFontHeight()*2,info3$,True
		bbText nx,ty+bbFontHeight()*3,info4$,True
	
		bbColor 255,255,255
		If mode=0
			bbText tx,ty+bbFontHeight()*5,"Windowed",True
		Else
			bbText tx,ty+bbFontHeight()*5,bbGfxModeWidth( mode )+","+bbGfxModeHeight( mode )+","+bbGfxModeDepth( mode ),True
		EndIf
		
		bbColor 255,0,0
		bbText nx,ty+bbFontHeight()*7,"[Return] to begin",True
		bbText tx,ty+bbFontHeight()*8,"[Arrows] change mode",True
		bbText nx,ty+bbFontHeight()*9,"[Escape] to exit",True
		
		bbColor 0,0,255
		bbText url_x,url_y,url$
		
		If bbKeyHit( 1 ) End
		If bbKeyHit( 28 )
			bbCls;bbFlip
			bbCls;bbFlip
			bbFreeFont font
			bbFreeImage image
			bbEndGraphics
			If mode
				bbGraphics3D bbGfxModeWidth(mode),bbGfxModeHeight(mode),bbGfxModeDepth(mode),1
			Else
				bbGraphics3D 640,480,0,2
			EndIf
			bbSetBuffer bbBackBuffer()
			Return
		EndIf
		If bbKeyHit( 203 )
			mode=mode-1
			If mode<0 Or (mode=0 & (Not bbWindowed3D()))
				mode=mode_cnt
			EndIf
		Else If bbKeyHit( 205 )
			mode=mode+1
			If mode>mode_cnt
				mode=0
				If Not bbWindowed3D() mode=1
			EndIf
		EndIf
		
		If tx>320 tx=tx-8
		If nx<320 nx=nx+8
		
		bbFlip
		
	Forever
	
End Function
