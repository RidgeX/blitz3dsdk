Import blitz3d.blitz3dsdk

Import "bbtype.bmx"
Import "blitz3d.bmx"

bbBeginBlitz3D()

Global info1$="Detail texturing"
Global info2$="Space to toggle, arrows to zoom"

Include "../start.bmx"

tex1=bbLoadTexture( "texture.jpg" )
tex2=bbLoadTexture( "detail2.jpg" )

bbScaleTexture tex2,.1,.1

sphere=bbCreateSphere( 16 )
bbScaleMesh sphere,10,10,10

bbEntityTexture sphere,tex1,0,0
bbEntityTexture sphere,tex2,0,1

camera=bbCreateCamera()
bbPositionEntity camera,0,0,-100

light=bbCreateLight()
bbTurnEntity light,45,45,0

on=1

While Not bbKeyHit(1)

	If bbKeyHit(57)
		on=1-on
		If on bbTextureBlend(tex2,2) Else bbTextureBlend(tex2,0)
	EndIf

	bbTurnEntity sphere,0,.1,0

	If bbKeyDown( 200 ) bbMoveEntity camera,0,0,.5
	If bbKeyDown( 208 ) bbMoveEntity camera,0,0,-.5

	bbUpdateWorld
	bbRenderWorld
	If on bbText 0,0,"Detail On" Else bbText 0,0,"Detail Off"
	bbFlip

Wend
