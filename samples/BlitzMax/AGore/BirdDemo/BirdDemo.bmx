Import blitz3d.blitz3dsdk

Import "bbtype.bmx"
Import "blitz3d.bmx"

Global KeyFrame_list:TList=New TList
Global Motion_list:TList=New TList
Global info1$="Birds Demo, by Adam Gore"
Global info2$="A small Blitz3D compatibility test"
Global info3$="Spline data imported from Lightwave"

bbBeginBlitz3D
bbGraphics3D 800,600,0,2
'Include "../start.bmx"

Include "KBSplines.bmx"

Global gwidth = 640'800
Global gheight = 480'600
Const FPS = 30
Global fstep

'Graphics3D gwidth,gheight

period=1000/FPS
time=MilliSecs()-period

cmot:bbMotion = New bbmotion
b2mot:bbMotion = New bbMotion
b1mot:bbMotion = New bbMotion

If Load_Motion( "Cam.bbm", cmot ) = False Then RuntimeError "Error loading file" ; End 
If Load_Motion( "Bird1.bbm", b1mot ) = False Then RuntimeError "Error loading file" ; End 
If Load_Motion( "Bird2.bbm", b2mot ) = False Then RuntimeError "Error loading file" ; End 

camera=bbCreateCamera()
bbCameraRange camera,1,3000

bbAmbientLight 90,90,90
light_sun = bbCreateLight(1)
bbLightColor light_sun,200,200,100
bbRotateEntity light_sun,60,-90,0

mesh_canyon = bbLoadMesh( "Canyon.x" )
mesh_skybox = MakeSkyBox("Textures\sky") 
mesh_bird = bbLoadMD2("Bird.md2")
tex1 = bbLoadTexture( "Textures\Bird.bmp" )
bbEntityTexture mesh_bird,tex1
mesh_bird2 = bbCopyEntity( mesh_bird )

bbAnimateMD2 mesh_bird,1,2.5,0,31
bbAnimateMD2 mesh_bird2,1,2.5,0,31

Apply_Motion(cmot,0,camera)
Apply_Motion(b1mot,0,mesh_bird)
Apply_Motion(b2mot,0,mesh_bird2)
fstep = 1

While bbKeyHit(1)<>True
	
	Repeat
		elapsed=MilliSecs()-time
	Until elapsed
	
	ticks=elapsed/period
	tween#=Float(elapsed Mod period)/Float(period)
	
	For k=1 To ticks
		time=time+period
		If k=ticks Then bbCaptureWorld
	
		Apply_Motion(cmot,fstep,camera)
		Apply_Motion(b1mot,fstep,mesh_bird)
		Apply_Motion(b2mot,fstep,mesh_bird2)
		fstep = fstep + 1
		If fstep > cmot.nsteps Then fstep = 1

		bbPositionEntity mesh_skybox,bbEntityX(camera,1),bbEntityY(camera,1),bbEntityZ(camera,1)

		bbUpdateWorld
	
	Next
	
	bbRenderWorld tween

	bbFlip
	
Wend
End

Function MakeSkyBox( file$ )
	m=bbCreateMesh()
	'front face
	b=bbLoadBrush( file$+"_FR.bmp",49)
	s=bbCreateSurface( m,b )
	bbAddVertex s,-1,+1,-1,0,0
	bbAddVertex s,+1,+1,-1,1,0
	bbAddVertex s,+1,-1,-1,1,1
	bbAddVertex s,-1,-1,-1,0,1
	bbAddTriangle s,0,1,2
	bbAddTriangle s,0,2,3
	bbFreeBrush b
	'right face
	b=bbLoadBrush( file$+"_LF.bmp",49 )
	s=bbCreateSurface( m,b )
	bbAddVertex s,+1,+1,-1,0,0;bbAddVertex s,+1,+1,+1,1,0
	bbAddVertex s,+1,-1,+1,1,1;bbAddVertex s,+1,-1,-1,0,1
	bbAddTriangle s,0,1,2;bbAddTriangle s,0,2,3
	bbFreeBrush b
	'back face
	b=bbLoadBrush( file$+"_BK.bmp",49 )
	s=bbCreateSurface( m,b )
	bbAddVertex s,+1,+1,+1,0,0;bbAddVertex s,-1,+1,+1,1,0
	bbAddVertex s,-1,-1,+1,1,1;bbAddVertex s,+1,-1,+1,0,1
	bbAddTriangle s,0,1,2;bbAddTriangle s,0,2,3
	bbFreeBrush b
	'left face
	b=bbLoadBrush( file$+"_RT.bmp",49 )
	s=bbCreateSurface( m,b )
	bbAddVertex s,-1,+1,+1,0,0;bbAddVertex s,-1,+1,-1,1,0
	bbAddVertex s,-1,-1,-1,1,1;bbAddVertex s,-1,-1,+1,0,1
	bbAddTriangle s,0,1,2;bbAddTriangle s,0,2,3
	bbFreeBrush b
	'top face
	b=bbLoadBrush( file$+"_UP.bmp",49 )
	s=bbCreateSurface( m,b )
	bbAddVertex s,-1,+1,+1,0,1;bbAddVertex s,+1,+1,+1,0,0
	bbAddVertex s,+1,+1,-1,1,0;bbAddVertex s,-1,+1,-1,1,1
	bbAddTriangle s,0,1,2;bbAddTriangle s,0,2,3
	bbFreeBrush b

	bbScaleMesh m,1700,1700,1700
	bbFlipMesh m
	bbEntityFX m,1
	Return m
	
End Function
