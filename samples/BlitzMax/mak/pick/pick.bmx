Import blitz3d.blitz3dsdk

Import "bbtype.bmx"
Import "blitz3d.bmx"

bbBeginBlitz3D

Global info1$="Pick demo"
Global info2$="Hit A/Z To change camera zoom"

Include "../start.bmx"

sphere=bbCreateSphere()
bbEntityPickMode sphere,3

For k=1 To 100
	model=bbCopyEntity( sphere )
	bbEntityColor model,Rnd(255),Rnd(255),Rnd(255)
	bbEntityShininess model,Rnd(1)
	
	rad#=Rnd(1,2)
	bbEntityRadius model,rad
	bbScaleEntity model,rad,rad,rad
	bbTurnEntity model,Rnd(360),Rnd(360),0
	bbMoveEntity model,0,0,Rnd(20)+20
Next

bbFreeEntity sphere

light=bbCreateLight()
bbTurnEntity light,45,45,0

camera=bbCreateCamera()
bbCameraRange camera,.1,1000

entity=0

zoom#=1

While Not bbKeyHit(1)

	If bbKeyDown(30) zoom=zoom*1.1
	If bbKeyDown(44) zoom=zoom/1.1
	bbCameraZoom camera,zoom

	x=bbMouseX()
	y=bbMouseY()
	
	If y<32 bbTurnEntity camera,-2,0,0
	If y>480-32 bbTurnEntity camera,2,0,0
	
	If x<32 bbTurnEntity camera,0,2,0
	If x>640-32 bbTurnEntity camera,0,-2,0
	
	e=bbCameraPick( camera,x,y )
	If e<>entity
		If entity Then bbEntityAlpha entity,1
		entity=e
	EndIf
	
	If entity
		bbEntityAlpha entity,Sin( MilliSecs() )*.5+.5
	EndIf
	
	bbUpdateWorld
	bbRenderWorld 1
	
	bbRect x,y-3,1,7	
	bbRect x-3,y,7,1
	
	bbFlip

Wend
