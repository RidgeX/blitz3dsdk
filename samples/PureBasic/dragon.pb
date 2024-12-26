;0,40  : idle
;40,46 : run
;46,54 : attack
;54,58 : paina
;58,62 : painb
;62,66 : painc
;66,72 : jump
;72,84 : flip

Global info1$="Dragon Demo"
Global info2$="Use arrows keys to pan, A/Z to zoom"
Global info3$="MD2 Dragon model courtesy of Polycount"


; Run start code

; Converted to PB by ozak!

IncludeFile "start.pb"

path$ = "../../samples/BlitzMax/mak/dragon/"

;environment cube
cube=bbCreateCube()
bbFitMesh(cube,-250,0,-250,500,500,500)
bbFlipMesh(cube)
tex=bbLoadTexture( path$ + "chorme-2.bmp" )
bbScaleTexture(tex,1.0/3,1.0/3)
bbEntityTexture(cube,tex)
bbEntityAlpha(cube,0.4)
bbEntityFX(cube,1)

;floor mirror
m=bbCreateMirror()

;simple light
light=bbCreateLight()
bbTurnEntity(light,45,45,0)

;camera
camera=bbCreateCamera()
cam_xr.f=30:cam_yr.f=0:cam_zr.f=0:cam_z.f=-100

;cool dragon model!
tex=bbLoadTexture( path$ + "model\dragon.bmp" )
dragon=bbLoadMD2( path$ + "model\dragon.md2" )
bbEntityTexture(dragon,tex)
bbPositionEntity(dragon,0,25,0)
bbTurnEntity(dragon,0,150,0)

bbAnimateMD2(dragon,1,0.05,0,40)

While Not bbKeyHit(1)

	If bbKeyDown(203)
		cam_yr=cam_yr-2
	ElseIf bbKeyDown(205)
		cam_yr=cam_yr+2
	EndIf
	
	If bbKeyDown(200)
		cam_xr=cam_xr+2
		If cam_xr>90 
		cam_xr=90
		EndIf
	ElseIf bbKeyDown(208)
		cam_xr=cam_xr-2
		If cam_xr<5 
		cam_xr=5
		EndIf
	EndIf
	
	If bbKeyDown(26)
		cam_zr=cam_zr+2
	ElseIf bbKeyDown(27)
		cam_zr=cam_zr-2
	EndIf
	
	If bbKeyDown(30)
		cam_z=cam_z+1:If cam_z>-10 
		cam_z=-10
		EndIf
	ElseIf bbKeyDown(44)
		cam_z=cam_z-1:If cam_z<-180 
		cam_z=-180
		EndIf
	EndIf
	
	bbPositionEntity(camera,0,0,0)
	bbRotateEntity(camera,cam_xr,cam_yr,cam_zr)
	bbMoveEntity(camera,0,0,cam_z)

	bbUpdateWorld()
	bbRenderWorld()
	bbFlip()
Wend

; Close down Blitz3D engine...
bbEndBlitz3D ()

End

; IDE Options = PureBasic 4.30 (Windows - x86)
; CursorPosition = 17
; FirstLine = 15
; Folding = -
; EnableXP