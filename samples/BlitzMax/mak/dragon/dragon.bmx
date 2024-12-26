Import blitz3d.blitz3dsdk

Import "bbtype.bmx"
Import "blitz3d.bmx"

bbBeginBlitz3D()

'0,40  : idle
'40,46 : run
'46,54 : attack
'54,58 : paina
'58,62 : painb
'62,66 : painc
'66,72 : jump
'72,84 : flip

Global info1$="Dragon Demo"
Global info2$="Use arrows keys to pan, A/Z to zoom"
Global info3$="MD2 Dragon model courtesy of Polycount"

'Include "../start.bb"

bbGraphics3D 400,300,0,2

'environment cube
cube=bbCreateCube()
bbFitMesh cube,-250,0,-250,500,500,500
bbFlipMesh cube
tex=bbLoadTexture( "chorme-2.bmp" )
bbScaleTexture tex,1.0/3,1.0/3
bbEntityTexture cube,tex
bbEntityAlpha cube,.4
bbEntityFX cube,1

'floor mirror
m=bbCreateMirror()

'simple light
light=bbCreateLight()
bbTurnEntity light,45,45,0

'camera
camera=bbCreateCamera()
cam_xr#=30;cam_yr#=0;cam_zr#=0;cam_z#=-100

'cool dragon model!
tex=bbLoadTexture( "model\dragon.bmp" )
dragon=bbLoadMD2( "model\dragon.md2" )
bbEntityTexture dragon,tex
bbPositionEntity dragon,0,25,0
bbTurnEntity dragon,0,150,0

bbAnimateMD2 dragon,1,.05,0,40

While Not bbKeyHit(1)

	If bbKeyDown(203)
		cam_yr=cam_yr-2
	Else If bbKeyDown(205)
		cam_yr=cam_yr+2
	EndIf
	
	If bbKeyDown(200)
		cam_xr=cam_xr+2
		If cam_xr>90 cam_xr=90
	Else If bbKeyDown(208)
		cam_xr=cam_xr-2
		If cam_xr<5 cam_xr=5
	EndIf
	
	If bbKeyDown(26)
		cam_zr=cam_zr+2
	Else If bbKeyDown(27)
		cam_zr=cam_zr-2
	EndIf
	
	If bbKeyDown(30)
		cam_z=cam_z+1;If cam_z>-10 cam_z=-10
	Else If bbKeyDown(44)
		cam_z=cam_z-1;If cam_z<-180 cam_z=-180
	EndIf
	
	bbPositionEntity camera,0,0,0
	bbRotateEntity camera,cam_xr,cam_yr,cam_zr
	bbMoveEntity camera,0,0,cam_z

	bbUpdateWorld
	bbRenderWorld
	bbFlip
Wend

End
