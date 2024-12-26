Import blitz3d.blitz3dsdk

Import "bbtype.bmx"
Import "blitz3d.bmx"

bbBeginBlitz3D

bbGraphics3D 640,480

tex=bbCreateTexture( 64,64 )
bbSetBuffer bbTextureBuffer( tex )
bbColor 255,0,0;bbRect 0,0,32,32;bbRect 32,32,32,32
bbColor 255,128,0;bbRect 32,0,32,32;bbRect 0,32,32,32
bbSetBuffer bbBackBuffer()
bbColor 255,255,255

cone=bbCreateCone(20)
bbEntityTexture cone,tex

sphere=bbCreateSphere(10)
bbPositionEntity sphere,2,0,0
bbEntityTexture sphere,tex

cylinder=bbCreateCylinder(20)
bbPositionEntity cylinder,-2,0,0
bbEntityTexture cylinder,tex

light=bbCreateLight()
bbTurnEntity light,45,45,0

pivot=bbCreatePivot()

z_cam=bbCreateCamera( pivot )
bbCameraViewport z_cam,0,0,320,240
bbPositionEntity z_cam,0,0,-5

y_cam=bbCreateCamera( pivot )
bbCameraViewport y_cam,320,0,320,240
bbPositionEntity y_cam,0,5,0
bbTurnEntity y_cam,90,0,0

x_cam=bbCreateCamera( pivot )
bbCameraViewport x_cam,0,240,320,240
bbTurnEntity x_cam,0,-90,0
bbPositionEntity x_cam,-5,0,0

While Not bbKeyHit(1)

	If bbKeyDown(203) bbMoveEntity pivot,-.1,0,0
	If bbKeyDown(205) bbMoveEntity pivot,.1,0,0
	If bbKeyDown(200) bbMoveEntity pivot,0,.1,0
	If bbKeyDown(208) bbMoveEntity pivot,0,-.1,0
	If bbKeyDown(30) bbMoveEntity pivot,0,0,.1
	If bbKeyDown(44) bbMoveEntity pivot,0,0,-.1

	bbUpdateWorld
	bbRenderWorld
	bbText 0,0,"Front"
	bbText 320,0,"Top"
	bbText 0,240,"Left"
	bbFlip

Wend

End
