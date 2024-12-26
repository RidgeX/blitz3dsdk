
IncludeFile "../include/blitz3dsdk.pbi"

Global suspended=0

Procedure WinCallback( hwnd,msg,wparam,lparam )

	Select msg
	Case #WM_PAINT	;A reasonably sane place to validate graphics...
		Select bbValidateGraphics()
		Case 0
			;graphics are unavailable
			;(eg: another app has gone fullscreen)
			suspended=1
		Case -1
			;graphics are *borked*
			;(eg: desktop resolution has changed in windowed mode)
			Print( "FATAL GRAPHICS PROBLEM" )
			End
		Default
			;>0, graphics are OK.
			;(returned value is number of times graphics have been 'restored').
			If suspended
				;this refreshes graphics if app is suspended
				;(just keeps window 'clean' when bits are revealed - not really necessary in fullscreen)
				bbFlip( 0 )
			EndIf
		EndSelect
	Case #WM_ERASEBKGND
		ProcedureReturn 1
	Case #WM_ACTIVATEAPP
	  If wparam
	    suspended=0
    Else
	    suspended=1
	  EndIf
	Case #WM_CLOSE
	  End
	EndSelect
  ProcedureReturn #PB_ProcessPureBasicEvents
EndProcedure

OpenWindow( 0,32,32,640,480,"Blitz3D Window",#PB_Window_SystemMenu|#PB_Window_ScreenCentered )

SetWindowCallback( @WinCallback(),0 )

bbBeginBlitz3DEx( WindowID( 0 ),0 )

;bbGraphics3D( 640,480,32,1 )
bbGraphics3D( 640,480,0,2 )

;Create a brush
tex=bbCreateTexture( 64,64 )
bbScaleTexture( tex,0.125,0.125 )
bbSetBuffer( bbTextureBuffer( tex ) )
bbColor( 64,192,255 )
bbRect( 32,0,32,32 )
bbRect( 0,32,32,32 )
bbColor( 255,255,255 )
bbRect( 0,0,32,32 )
bbRect( 32,32,32,32 )
bbSetBuffer( bbBackBuffer() )
bbColor( 255,255,255 )
brush=bbCreateBrush()
bbBrushTexture( brush,tex,0,0 )

;Create a camera
camera=bbCreateCamera()
bbCameraClsColor( camera,128,0,255 )
bbPositionEntity( camera,0,0,-6 )

;Create a light
light=bbCreateLight()
bbTurnEntity( light,45,45,0 )

;Create a cube
cube=bbCreateCube()
bbPaintEntity( cube,brush )

Repeat
  Repeat
    While suspended
      WaitWindowEvent()
    Wend
    While WindowEvent()
    Wend
  Until Not suspended

	;App is up and running!

  bbTurnEntity( cube,0,3,0 )
  bbUpdateWorld()
  bbRenderWorld()
  bbFlip( 1 )
   
ForEver


  

; IDE Options = PureBasic 4.20 (Windows - x86)
; CursorPosition = 36
; Folding = -
; EnableXP