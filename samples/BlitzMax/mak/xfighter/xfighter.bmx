Import blitz3d.blitz3dsdk

Import "bbtype.bmx"
Import "blitz3d.bmx"

bbBeginBlitz3D

Global Player_list:TList=New TList

Global use_fog=False
'If Lower$( Left$( bbInput$( "Use fog? :" ),1 ) )="y" use_fog=True

'game FPS
Const FPS=30

Global info1$="Terrain demo"
Global info2$="Arrows/A/Z move, F1-F4 change camera"
Global info3$="W toggle wireframe, M toggle morphing"
Global info4$="[ and ] alter detail level"

'bbGraphics3D 800,600,0,1'800,500,0,2

Include "../start.bmx"

'AntiAlias True

'*******************
'grrr..ATI - FIX IT!
' HWMultiTex False ;
'*******************
	
Type bbPlayer Extends TBBType

	Method New()
		Add(Player_list)
	End Method

	Method After:bbPlayer()
		Local t:TLink
		t=_link.NextLink()
		If t Return bbPlayer(t.Value())
	End Method

	Method Before:bbPlayer()
		Local t:TLink
		t=_link.PrevLink()
		If t Return bbPlayer(t.Value())
	End Method

	Field entity,camera
	Field ctrl_mode,cam_mode,ignition
	Field pitch#,yaw#,pitch_speed#,yaw_speed#,roll#,thrust#
End Type
 
bbCollisions 1,10,2,2	'sphere-to-polygon, colliding collisions

Global terr

CreateScene()

plane=LoadAirPlane( "biplane.x" )

player1:bbPlayer=CreatePlayer( plane,0,0,bbGraphicsWidth(),bbGraphicsHeight(),1 )
'player1.Player=CreatePlayer( plane,0,0,640,239,1 )
'player2.Player=CreatePlayer( plane,0,240,640,239,2 )

period=1000/FPS
time=MilliSecs()-period

detail=2000;morph=True
bbTerrainDetail terr,detail,morph

While Not bbKeyHit(1)
	Repeat
		elapsed=MilliSecs()-time
	Until elapsed

	'how many 'frames' have elapsed	
	ticks=elapsed/period
	
	'fractional remainder
	tween#=Float(elapsed Mod period)/Float(period)
	
	For k=1 To ticks
		If k=ticks Then bbCaptureWorld
		time=time+period
		UpdateGame()
		bbUpdateWorld
	Next
	
	If bbKeyHit(17)
		wire=Not wire
		bbWireFrame wire
	EndIf
	If bbKeyHit(26)
		detail=detail-100
		If detail<100 Then detail=100
		bbTerrainDetail terr,detail,morph
	Else If bbKeyHit(27)
		detail=detail+100
		If detail>10000 Then detail=10000
		bbTerrainDetail terr,detail,morph
	EndIf
	If bbKeyHit(50)
		morph=Not morph
		bbTerrainDetail terr,detail,morph
	EndIf
			
	bbRenderWorld tween
	
	bbColor 255,0,0
	
	If morph t$="Y" Else t$="N"
	bbText 0,0,"Detail:"+detail+" Morph:"+t$

	bbFlip
Wend

End

Function UpdateGame()
	For p:bbPlayer=EachIn Player_list
		UpdatePlayer(p)
	Next
End Function

Function UpdatePlayer( p:bbPlayer )

	Local x_dir,y_dir,z_dir

	Select p.ctrl_mode
	Case 1;
		If bbKeyDown(203) x_dir=-1
		If bbKeyDown(205) x_dir=1
		
		If bbKeyDown(200) y_dir=-1
		If bbKeyDown(208) y_dir=1
		
		If bbKeyDown(30) z_dir=1
		If bbKeyDown(44) z_dir=-1
		
		If bbKeyHit(59) p.cam_mode=1
		If bbKeyHit(60) p.cam_mode=2
		If bbKeyHit(61) p.cam_mode=3
		If bbKeyHit(62) p.cam_mode=4
		
	Case 2;
		x_dir=bbJoyXDir()
		y_dir=bbJoyYDir()
		If bbJoyDown(1) z_dir=1
		If bbJoyDown(2) z_dir=-1
		
		If bbKeyHit(63) p.cam_mode=1
		If bbKeyHit(64) p.cam_mode=2
		If bbKeyHit(65) p.cam_mode=3
		If bbKeyHit(66) p.cam_mode=4
		
	End Select
	
	If x_dir<0
		p.yaw_speed=p.yaw_speed + (4-p.yaw_speed)*.04
	Else If x_dir>0
		p.yaw_speed=p.yaw_speed + (-4-p.yaw_speed)*.04
	Else
		p.yaw_speed=p.yaw_speed + (-p.yaw_speed)*.02
	EndIf
		
	If y_dir<0
		p.pitch_speed=p.pitch_speed + (2-p.pitch_speed)*.2
	Else If y_dir>0
		p.pitch_speed=p.pitch_speed + (-2-p.pitch_speed)*.2
	Else
		p.pitch_speed=p.pitch_speed + (-p.pitch_speed)*.1
	EndIf
		
	p.yaw=p.yaw+p.yaw_speed
	If p.yaw<-180 Then p.yaw=p.yaw+360
	If p.yaw>=180 Then p.yaw=p.yaw-360
	
	p.pitch=p.pitch+p.pitch_speed
	If p.pitch<-180 Then p.pitch=p.pitch+360
	If p.pitch>=180 Then p.pitch=p.pitch-360
		
	p.roll=p.yaw_speed*30
	bbRotateEntity p.entity,p.pitch,p.yaw,p.roll

	If p.ignition
		If z_dir>0			'faster?
			p.thrust=p.thrust + (1.5-p.thrust)*.04	'1.5
		Else If z_dir<0		'slower?
			p.thrust=p.thrust + (-p.thrust)*.04
		EndIf
		bbMoveEntity p.entity,0,0,p.thrust
	Else If z_dir>0
		p.ignition=True
	EndIf
	
	If p.camera
		Select p.cam_mode
		Case 1;
			bbEntityParent p.camera,p.entity
			bbRotateEntity p.camera,0,p.yaw,0,True
			bbPositionEntity p.camera,bbEntityX(p.entity),bbEntityY(p.entity),bbEntityZ(p.entity),True
			bbMoveEntity p.camera,0,1,-5
			bbPointEntity p.camera,p.entity,p.roll/2
		Case 2;
			bbEntityParent p.camera,0
			bbPositionEntity p.camera,bbEntityX(p.entity),bbEntityY(p.entity),bbEntityZ(p.entity)
			bbTranslateEntity p.camera,0,1,-5
			bbPointEntity p.camera,p.entity,0
		Case 3;
			bbEntityParent p.camera,p.entity
			bbPositionEntity p.camera,0,.25,0
			bbRotateEntity p.camera,0,0,0
		Case 4;
			bbEntityParent p.camera,0
			bbPointEntity p.camera,p.entity,0
		End Select
	EndIf
	
End Function

Function LoadAirPlane( file$ )
	pivot=bbCreatePivot()
	plane=bbLoadMesh( file$,pivot )
	bbScaleMesh plane,.125,.25,.125	'make it more spherical!
	bbRotateEntity plane,0,180,0	'and align to z axis
	bbEntityRadius pivot,1
	bbEntityType pivot,1
	bbHideEntity pivot
	Return pivot
End Function

Function CreatePlayer:bbPlayer( plane,vp_x,vp_y,vp_w,vp_h,ctrl_mode )
	p:bbPlayer=New bbPlayer
	p.ctrl_mode=ctrl_mode
	p.cam_mode=1
	x#=ctrl_mode*10
	z#=ctrl_mode*10-2500
	p.entity=bbCopyEntity( plane )
	bbPositionEntity p.entity,x,bbTerrainY( terr,x,0,z )+50,z
	bbRotateEntity p.entity,0,180,0
	bbResetEntity p.entity
	p.camera=bbCreateCamera( p.entity )
	bbPositionEntity p.camera,0,3,-10
	bbCameraViewport p.camera,vp_x,vp_y,vp_w,vp_h
	bbCameraClsColor p.camera,0,192,255
	bbCameraFogColor p.camera,0,192,255
	bbCameraFogRange p.camera,1000,3000
	bbCameraRange p.camera,1,3000
'	CameraZoom p\camera,1.5
	If use_fog Then bbCameraFogMode p.camera,1
	Return p
End Function

Function CreateScene()

	'setup lighting
	l=bbCreateLight()
	bbRotateEntity l,45,45,0
	bbAmbientLight 32,32,32
	
	'Load terrain
	terr=bbLoadTerrain( "hmap_1024.bmp" )
	bbScaleEntity terr,20,800,20
	bbPositionEntity terr,-20*512,0,-20*512
	bbEntityFX terr,1
	bbEntityType terr,10

	'apply textures to terrain	
	tex1=bbLoadTexture( "coolgrass2.bmp",1 )
	bbScaleTexture tex1,10,10
	tex2=bbLoadTexture( "lmap_256.bmp" )
	bbScaleTexture tex2,bbTerrainSize(terr),bbTerrainSize(terr)
	bbEntityTexture terr,tex1,0,0
	bbEntityTexture terr,tex2,0,1
	
	'and ground plane
	plane=bbCreatePlane()
	bbScaleEntity plane,20,1,20
	bbPositionEntity plane,-20*512,0,-20*512
	bbEntityTexture plane,tex1,0,0
	bbEntityOrder plane,3
	bbEntityFX plane,1
	bbEntityType plane,10
	
	'create cloud planes
	tex=bbLoadTexture( "cloud_2.bmp",3 )
	bbScaleTexture tex,1000,1000
	p=bbCreatePlane()
	bbEntityTexture p,tex
	bbEntityFX p,1
	bbPositionEntity p,0,450,0
	p=bbCopyEntity( p )
	bbRotateEntity p,0,0,180
	
	'create water plane
	tex=bbLoadTexture( "water-2_mip.bmp",3 )
	bbScaleTexture tex,10,10
	p=bbCreatePlane()
	bbEntityTexture p,tex
	bbEntityBlend p,1
	bbEntityAlpha p,.75
	bbPositionEntity p,0,10,0
	bbEntityFX p,1
	
End Function
