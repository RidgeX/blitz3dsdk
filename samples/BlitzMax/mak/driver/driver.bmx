Import blitz3d.blitz3dsdk

Import "bbtype.bmx"
Import "blitz3d.bmx"

bbBeginBlitz3D()

Global info1$="Driver"

Include "../start.bmx"

Const GRAVITY#=-.01

Const BODY=1,WHEEL=2,SCENE=3

bbCollisions BODY,SCENE,2,3
bbCollisions WHEEL,SCENE,2,3

terr=bbLoadTerrain( "heightmap_256.bmp" )
bbScaleEntity terr,1000/bbTerrainSize(terr),70,1000/bbTerrainSize(terr)
bbTerrainDetail terr,1000,True
bbTerrainShading terr,True
bbPositionEntity terr,-500,0,-500
tex=bbLoadTexture( "terrain-1.jpg" )
bbScaleTexture tex,50,50
bbEntityTexture terr,tex
bbEntityType terr,SCENE

car=bbLoadMesh( "car.x" )
bbScaleMesh car,1,1,-1
bbFlipMesh car
bbFitMesh car,-1.5,-1,-3,3,2,6
bbPositionEntity car,0,70,0
bbEntityShininess car,1
bbEntityType car,BODY

Global wheels[5]

cnt=1
For z#=1.5 To -1.5 Step -3
For x#=-1 To 1 Step 2
	wheels[cnt]=bbCreateSphere( 8,car )
	bbEntityAlpha wheels[cnt],.5
	bbScaleEntity wheels[cnt],.5,.5,.5
	bbEntityRadius wheels[cnt],.5
	bbPositionEntity wheels[cnt],x,0,z
	bbEntityType wheels[cnt],WHEEL
	cnt=cnt+1
Next
Next

light=bbCreateLight()
bbTurnEntity light,45,45,0

target=bbCreatePivot( car )
bbPositionEntity target,0,5,-12

camera=bbCreateCamera()
bbCameraClsColor camera,0,128,255

speed#=0
x_vel#=0;prev_x#=bbEntityX( car )
y_vel#=0;prev_y#=bbEntityY( car )
z_vel#=0;prev_z#=bbEntityZ( car )

While Not bbKeyHit(1)

	'align car to wheels
	zx#=(bbEntityX( wheels[2],True )+bbEntityX( wheels[4],True ))/2
	zx=zx-(bbEntityX( wheels[1],True )+bbEntityX( wheels[3],True ))/2
	zy#=(bbEntityY( wheels[2],True )+bbEntityY( wheels[4],True ))/2
	zy=zy-(bbEntityY( wheels[1],True )+bbEntityY( wheels[3],True ))/2
	zz#=(bbEntityZ( wheels[2],True )+bbEntityZ( wheels[4],True ))/2
	zz=zz-(bbEntityZ( wheels[1],True )+bbEntityZ( wheels[3],True ))/2
	bbAlignToVector car,zx,zy,zz,1
	
	zx#=(bbEntityX( wheels[1],True )+bbEntityX( wheels[2],True ))/2
	zx=zx-(bbEntityX( wheels[3],True )+bbEntityX( wheels[4],True ))/2
	zy#=(bbEntityY( wheels[1],True )+bbEntityY( wheels[2],True ))/2
	zy=zy-(bbEntityY( wheels[3],True )+bbEntityY( wheels[4],True ))/2
	zz#=(bbEntityZ( wheels[1],True )+bbEntityZ( wheels[2],True ))/2
	zz=zz-(bbEntityZ( wheels[3],True )+bbEntityZ( wheels[4],True ))/2
	bbAlignToVector car,zx,zy,zz,3
	
	'calculate car velocities	
	cx#=bbEntityX( car );x_vel=cx-prev_x;prev_x=cx
	cy#=bbEntityY( car );y_vel=cy-prev_y;prev_y=cy
	cz#=bbEntityZ( car );z_vel=cz-prev_z;prev_z=cz
	
	'resposition wheels
	cnt=1
	For z=1.5 To -1.5 Step -3
	For x=-1 To 1 Step 2
'		PositionEntity wheels[cnt],0,0,0
'		ResetEntity wheels[cnt]
		bbPositionEntity wheels[cnt],x,-1,z
		cnt=cnt+1
	Next
	Next

	'move car
	If bbKeyDown(203) bbTurnEntity car,0,3,0
	If bbKeyDown(205) bbTurnEntity car,0,-3,0
	If bbEntityCollided( car,SCENE )
		If bbKeyDown(200)
			speed=speed+.02
			If speed>.7 speed=.7
		Else If bbKeyDown(208)
			speed=speed-.02
			If speed<-.5 speed=-.5
		Else
			speed=speed*.9
		EndIf
		bbMoveEntity car,0,0,speed
		bbTranslateEntity car,0,GRAVITY,0
	Else
		bbTranslateEntity car,x_vel,y_vel+GRAVITY,z_vel
	EndIf

	'update camera
	If speed>=0	
		dx#=bbEntityX( target,True )-bbEntityX( camera )
		dy#=bbEntityY( target,True )-bbEntityY( camera )
		dz#=bbEntityZ( target,True )-bbEntityZ( camera )
		bbTranslateEntity camera,dx*.1,dy*.1,dz*.1
	EndIf
	bbPointEntity camera,car
	
	bbUpdateWorld
	bbRenderWorld
	bbFlip
Wend

End
