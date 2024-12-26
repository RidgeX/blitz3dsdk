Import blitz3d.blitz3dsdk

Import "bbtype.bmx"
Import "blitz3d.bmx"

bbBeginBlitz3D

Global info1$="Teapot demo"
Global info2$="Features Cubic/spheriocal reflection mapping"
Global info3$="Arrows keys to pan camera"

Include "../start.bmx"

cube_ref=False

bbFlushKeys()

DebugLog bbGfxDriverCaps3D()

If bbGfxDriverCaps3D()>=110
	Local i$=bbInput("Select (c)ubic or (s)pherical mapping :")
	If Left$(Lower$(i),1)="c" cube_ref=True
EndIf

teapot=bbLoadMesh( "teapot.x" )
If cube_ref
	tex=bbLoadTexture( "castle_env.bmp",128+8 )
Else
	tex=bbLoadTexture( "spheremap.bmp",64+1 )
EndIf
bbEntityTexture teapot,tex,0,0
bbEntityFX teapot,1

cam_pivot=bbCreatePivot()' teapot )
camera=bbCreateCamera( cam_pivot )
bbPositionEntity camera,0,0,-3

While Not bbKeyHit(1)

	If bbKeyDown(200) bbTurnEntity cam_pivot,3,0,0
	If bbKeyDown(208) bbTurnEntity cam_pivot,-3,0,0
	If bbKeyDown(203) bbTurnEntity cam_pivot,0,3,0
	If bbKeyDown(205) bbTurnEntity cam_pivot,0,-3,0
	
	bbTurnEntity teapot,.1,.3,0
	
	bbUpdateWorld
	bbRenderWorld
	bbFlip
Wend
End
