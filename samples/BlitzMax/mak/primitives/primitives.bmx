Import blitz3d.blitz3dsdk

Import "bbtype.bmx"
Import "blitz3d.bmx"

bbBeginBlitz3D

Global info1$="Primitives demo"

Include "../start.bmx"

tex=bbCreateTexture( 64,64 )
bbScaleTexture tex,.125,.125
bbSetBuffer bbTextureBuffer( tex )
bbColor 64,192,255;bbRect 32,0,32,32;bbRect 0,32,32,32
bbColor 255,255,255;bbRect 0,0,32,32;bbRect 32,32,32,32
bbSetBuffer bbBackBuffer()
bbColor 255,255,255

cam=bbCreateCamera()
bbPositionEntity cam,0,0,-6

light=bbCreateLight()
bbTurnEntity light,45,45,0

segs=16
rebuild=True

brush=bbCreateBrush()
bbBrushTexture brush,tex

pivot=bbCreatePivot()

While Not bbKeyHit(1)

	If bbKeyHit(17)
		wire=Not wire
		bbWireFrame wire
	EndIf
	If bbKeyHit(26)
		If segs>3 Then segs=segs-1;rebuild=True
	Else If bbKeyHit(27)
		If segs<100 Then segs=segs+1;rebuild=True
	EndIf
	
	If rebuild
		If cube bbFreeEntity cube
		If sphere bbFreeEntity sphere
		If cylinder bbFreeEntity cylinder
		If cone bbFreeEntity cone
		cube=bbCreateCube( pivot )
		bbPaintEntity cube,brush
		bbPositionEntity cube,-3,0,0
		cylinder=bbCreateCylinder( segs,True,pivot )
		bbPaintEntity cylinder,brush
		bbPositionEntity cylinder,1,0,0
		cone=bbCreateCone( segs,True,pivot )
		bbPaintEntity cone,brush
		bbPositionEntity cone,-1,0,0
		sphere=bbCreateSphere( segs,pivot )
		bbPaintEntity sphere,brush
		bbPositionEntity sphere,3,0,0
		rebuild=False
	EndIf
	
	If bbKeyDown(203) bbTurnEntity pivot,0,-3,0
	If bbKeyDown(205) bbTurnEntity pivot,0,+3,0
	If bbKeyDown(200) bbTurnEntity pivot,-3,0,0
	If bbKeyDown(208) bbTurnEntity pivot,+3,0,0
	If bbKeyDown(30) bbTranslateEntity pivot,0,0,-.2
	If bbKeyDown(44) bbTranslateEntity pivot,0,0,+.2
	
	bbUpdateWorld
	bbRenderWorld
	bbText 0,0,"Segs="+segs+" - [] to adjust, 'W' for wireframe"
	bbFlip
	
Wend
End
