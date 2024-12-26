
Rem

This demo shows you how to render direct to an HWND.

It's written in BlitzMax, but should be easy enough to understand assuming some general Win32 coding 
experience.

Key points:

* Use bbBeginBlitz3DEx( hwnd,flags ) to startup Blitz3d. Flags are reserved for future use - set to 0 for
now. Starting up this way will cause Blitz3D to NOT create an internal HWND but instead use the one provided.
Blitz3D will not attempt to resize or otherwise manipulate the hwnd, so make sure it's of the correct size
before calling bbGraphics3D.

* Use bbValidateGraphics() to determine whether graphics are 'functional'. This returns a value >0 if 
graphics are functional, otherwise you shouldn't do any rendering.

* You will need to implement your own input code for key/mouse etc. A future 'bbUpdateInputState( msg,wp,lp )'
is a possibility.

End Rem

Strict

Import blitz3d.blitz3dsdk

Global suspended

Function WindowProc( hwnd,msg,wparam,lparam )
	Select msg
	Case WM_PAINT	'A reasonably sane place to validate graphics...
		Local n=bbValidateGraphics()
		
		'a little debugging...
		Global base_ms=MilliSecs()
		Print "WM_PAINT:Validate="+n+" time="+(MilliSecs()-base_ms)/1000.0

		Select n
		Case 0
			'graphics are unavailable
			'(eg: another app has gone fullscreen)
			suspended=True
		Case -1
			'graphics are *borked*
			'(eg: desktop resolution has changed in windowed mode)
			Print "FATAL GRAPHICS PROBLEM"
			End
		Default
			'>0, graphics are OK.
			'(returned value is number of times graphics have been 'restored').
			If suspended
				'this refreshes graphics if app is suspended
				'(just keeps window 'clean' when bits are revealed - not really necessary in fullscreen)
				bbFlip False
			EndIf
		End Select
	Case WM_ERASEBKGND
		Return 1
	Case WM_ACTIVATEAPP
		suspended=Not wparam
	Case WM_KEYDOWN
		'Print "KeyDown!"
		If wparam=27 End	'catch ESC!
	Case WM_MOUSEMOVE 
		'Print "MouseMove!"
	Case WM_CLOSE
		End
	End Select
	Return DefWindowProcA( hwnd,msg,wparam,lparam )
End Function

'Create window class
Local wndclass:WNDCLASS=New WNDCLASS
wndclass.style=CS_HREDRAW|CS_VREDRAW|CS_OWNDC
wndclass.lpfnWndProc=WindowProc
wndclass.hInstance=GetModuleHandleA( Null )
wndclass.lpszClassName="My Class!".ToCString()
wndclass.hCursor=LoadCursorA( 0,Byte Ptr(IDC_ARROW) );
wndclass.hbrBackground=GetStockObject( BLACK_BRUSH );
RegisterClassA( wndclass )

'Create window
Local ws=WS_CAPTION|WS_VISIBLE|WS_SYSMENU
Local window=CreateWindowExA( 0,"My Class!".ToCString(),"My Window!".ToCString(),ws,0,0,777,666,Null,0,0,Null )

'Start Blitz3D
bbBeginBlitz3DEx window,0

'full screen
'bbGraphics3D 640,480,32,1	

'windowed
Local rect[4]
GetClientRect window,rect
bbgraphics3D rect[2],rect[3],0,2

'Create a b3d brush
Local tex=bbCreateTexture( 64,64 )
bbScaleTexture tex,.125,.125
bbSetBuffer bbTextureBuffer( tex )
bbColor 64,192,255;bbRect 32,0,32,32;bbRect 0,32,32,32
bbColor 255,255,255;bbRect 0,0,32,32;bbRect 32,32,32,32
bbSetBuffer bbBackBuffer()
bbColor 255,255,255
Local brush=bbCreateBrush()
bbBrushTexture brush,tex

'Create a camera
Local camera=bbCreateCamera()
bbCameraClsColor camera,128,0,255
bbPositionEntity camera,0,0,-6

'Create a light
Local light=bbCreateLight()
bbTurnEntity light,45,45,0

'Create a cube
Local cube=bbCreateCube()
bbPaintEntity cube,brush

Repeat
	Local msg:MSG=New MSG
	Repeat
		While suspended 
			GetMessageA( msg,0,0,0 )
			TranslateMessage msg
			DispatchMessageA msg
		Wend
		While PeekMessageA( msg,0,0,0,PM_REMOVE )
			TranslateMessage msg
			DispatchMessageA msg
		Wend
	Until Not suspended

	'App is up and running!

	bbTurnEntity cube,0,3,0
	bbUpdateWorld
	bbRenderWorld
	bbFlip

Forever
