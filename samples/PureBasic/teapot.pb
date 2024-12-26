
; Converted to PB by ozak!

Global info1$="Teapot demo"
Global info2$="Features Cubic/spheriocal reflection mapping"
Global info3$="Arrows keys to pan camera"

IncludeFile "start.pb"

path$ = "../../samples/BlitzMax/mak/teapot/"

cube_ref=#False

If bbGfxDriverCaps3D()>=110
Global out$ = PeekS(bbInput("")); First call fails? Is this a bug?
bbLocate(0,0) ; Oh well, place it on top of failed one :)
	If Left(LCase(PeekS(bbInput("Select (c)ubic or (s)pherical mapping :"))),1)="c" 
	  cube_ref=#True
	EndIf
EndIf

teapot=bbLoadMesh( path$ + "teapot.x" )
If cube_ref
	tex=bbLoadTexture( path$ + "castle_env.bmp",128+8 )
Else
	tex=bbLoadTexture( path$ + "spheremap.bmp",64+1 )
EndIf
bbEntityTexture(teapot,tex,0,0)
bbEntityFX(teapot,1)

cam_pivot=bbCreatePivot(); teapot )
camera=bbCreateCamera( cam_pivot )
bbPositionEntity(camera,0,0,-3)

While Not bbKeyHit(1)

	If bbKeyDown(200) 
	  bbTurnEntity(cam_pivot,3,0,0)
	EndIf
	If bbKeyDown(208) 
	  bbTurnEntity(cam_pivot,-3,0,0)
	EndIf
	If bbKeyDown(203)
	  bbTurnEntity(cam_pivot,0,3,0)
	EndIf
	If bbKeyDown(205) 
	  bbTurnEntity(cam_pivot,0,-3,0)
	EndIf
	
	bbTurnEntity(teapot,0.1,0.3,0)
	
	bbUpdateWorld()
	bbRenderWorld()
	bbFlip()
Wend
End

; IDE Options = PureBasic 4.30 (Windows - x86)
; CursorPosition = 2
; Folding = -
; EnableXP