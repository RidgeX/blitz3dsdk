Import blitz3d.blitz3dsdk

Import "bbtype.bmx"
Import "blitz3d.bmx"

Global KeyFrame_list:TList=New TList
Global Motion_list:TList=New TList
Global info1$="The Head Demo, by Adam Gore"

bbBeginBlitz3D

bbGraphics3D 800,600,0,2

'Include "../start.bmx"
Include "KBSplines.bmx"

Const FPS = 24
Global fstep

period=1000/FPS
time=MilliSecs()-period

headmot:bbMotion = New bbMotion
eyetmot:bbMotion = New bbMotion

If Load_Motion( "Head.bbm", headmot ) = False Then RuntimeError "Error loading file" ; End 
If Load_Motion( "EyeFocus.bbm", eyetmot ) = False Then RuntimeError "Error loading file" ; End 

camera=bbCreateCamera()
bbCameraRange camera,.05,150
bbPositionEntity camera,0,0,-1
bbRotateEntity camera,0,0,0

mesh_head = bbLoadMesh("Head.x")
mesh_reye = bbLoadMesh("Eye.x",mesh_head)
brush=bbLoadBrush( "Eye.jpg",1)
bbBrushShininess brush,1
bbPaintMesh mesh_reye,brush
mesh_leye = bbCopyEntity(mesh_reye,mesh_head)
piv_eyet = bbCreatePivot(mead_hesh)

bkgd=bbCreateMesh()
s=bbCreateSurface(bkgd)
bbAddVertex s,+1,+1,+1,0,0;bbAddVertex s,-1,+1,+1,1,0
bbAddVertex s,-1,-1,+1,1,1;bbAddVertex s,+1,-1,+1,0,1
bbAddTriangle s,0,1,2;bbAddTriangle s,0,2,3
bbScaleMesh bkgd,130,130,100'225,225,225
bbEntityFX bkgd,1
bbFlipMesh bkgd
bbEntityOrder bkgd,10

bbPositionEntity mesh_reye,-.058,.256,-.146
bbPositionEntity mesh_leye,.058,.256,-.146

tex0=bbLoadTexture("Face.jpg")
tex1=bbLoadTexture("Reflection.jpg",64)
tex2=bbLoadTexture("Bkgd.jpg")
bbEntityTexture mesh_head,tex0
bbEntityTexture bkgd,tex2

bbAmbientLight 5,5,5
light1=bbCreateLight(1)
bbLightColor light1,255,255,255
bbRotateEntity light1,0,60,0
light2=bbCreateLight(1)
bbLightColor light2,200,0,0
bbRotateEntity light2,-5,-95,0

fstep = 1
Apply_Motion(headmot,fstep,mesh_head)
Apply_Motion(eyetmot,fstep,piv_eyet)

While bbKeyHit(1)<>True
	
	Repeat
		elapsed=MilliSecs()-time
	Until elapsed
	
	ticks=elapsed/period
	tween#=Float(elapsed Mod period)/Float(period)
	
	For k=1 To ticks
		time=time+period
		If k=ticks Then bbCaptureWorld

		fstep = fstep + 1 ; If fstep > headmot.nsteps Then fstep = 1
		Apply_Motion(headmot,fstep,mesh_head)
		Apply_Motion(eyetmot,fstep,piv_eyet)
		bbPointEntity mesh_reye,piv_eyet ; bbPointEntity mesh_leye,piv_eyet
		bbTurnEntity bkgd,0,0,1
		If fstep = 574 bbEntityTexture mesh_head,tex1
		If fstep = 1 bbEntityTexture mesh_head,tex0

		bbUpdateWorld
	Next
	
	bbRenderWorld tween
	bbFlip
	
Wend
End
