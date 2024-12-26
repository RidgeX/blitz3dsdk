
Global info1$="Texture render demo"
Global info2$="Renders a 3D scene onto a texture"
Global info3$="Use Arrow keys to Pan, A/Z to zoom"

; Converted to PB by ozak!

; Run start code
IncludeFile "start.pb"

grid_tex=bbCreateTexture( 16,16,8,1 )
bbScaleTexture(grid_tex,10,10)
bbSetBuffer(bbTextureBuffer( grid_tex ))
bbClsColor(255,255,255):bbCls():bbClsColor(0,0,0)
bbColor(192,192,192):bbRect(0,0,8,8):bbRect(8,8,8,8)
bbSetBuffer(bbBackBuffer())

plane=bbCreatePlane()
bbEntityTexture(plane,grid_tex)

pivot=bbCreatePivot()
bbPositionEntity(pivot,0,2,0)

t_sphere=bbCreateSphere( 8 )
bbEntityShininess(t_sphere,0.2)
For t=0 To 359 Step 36
	sphere=bbCopyEntity( t_sphere,pivot )
	bbEntityColor(sphere,Random(256),Random(256),Random(256))
	bbTurnEntity(sphere,0,t,0)
	bbMoveEntity(sphere,0,0,10)
Next
bbFreeEntity(t_sphere)

texture=bbCreateTexture( 128,128,256 )

cube=bbCreateCube()
bbEntityTexture(cube,texture)
bbPositionEntity(cube,0,7,0)
bbScaleEntity(cube,3,3,3)

light=bbCreateLight()
bbTurnEntity(light,45,45,0)

camera=bbCreateCamera()

plan_cam=bbCreateCamera()
bbTurnEntity(plan_cam,90,0,0)
bbPositionEntity(plan_cam,0,20,0)
bbCameraViewport(plan_cam,0,0,128,128)
bbCameraClsColor(plan_cam,0,128,0)

d.f=-20

While Not bbKeyHit(1)

	If bbKeyDown(30) 
	  d=d+1
	EndIf
	If bbKeyDown(44) 
	  d=d-1
	EndIf
	If bbKeyDown(203)
	 bbTurnEntity(camera,0,-3,0)
	EndIf
	If bbKeyDown(205) 
	  bbTurnEntity(camera,0,3,0)
	EndIf
	bbPositionEntity(camera,0,7,0)
	bbMoveEntity(camera,0,0,d)
	
	bbTurnEntity(cube,0.1,0.2,0.3)
	bbTurnEntity(pivot,0,1,0)
	
	bbUpdateWorld()
	
	bbHideEntity(camera)
	bbShowEntity(plan_cam)
	bbRenderWorld()
	
	bbCopyRect(0,0,128,128,0,0,0,bbTextureBuffer( texture ))
	
	bbShowEntity(camera)
	bbHideEntity(plan_cam)
	bbRenderWorld()
	
	bbFlip()
Wend
; IDE Options = PureBasic 4.30 (Windows - x86)
; CursorPosition = 5
; FirstLine = 4
; Folding = -
; EnableXP