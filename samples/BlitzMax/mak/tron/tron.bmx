Import blitz3d.blitz3dsdk

Import "bbtype.bmx"
Import "blitz3d.bmx"

bbBeginBlitz3D

smooth=True

Global info1$="Tron demo"
Global info2$="Features dynamic mesh creation"
Global info3$="Use arrow keys to steer, A/Z to zoom"

Include "../start.bmx"

grid_tex=bbCreateTexture( 32,32,8 )
bbScaleTexture grid_tex,10,10
bbSetBuffer bbTextureBuffer( grid_tex )
bbColor 0,0,64;bbRect 0,0,32,32
bbColor 0,0,255;bbRect 0,0,32,32,False
bbSetBuffer bbBackBuffer()

grid_plane=bbCreatePlane()
bbEntityTexture grid_plane,grid_tex
bbEntityBlend grid_plane,1
bbEntityAlpha grid_plane,.6
bbEntityFX grid_plane,1

mirror=bbCreateMirror()

pivot=bbCreatePivot()

p=bbCreatePivot( p )
cube=bbCreateCube( p )
bbScaleEntity cube,1,1,5
bbSetAnimKey cube,0
bbRotateEntity cube,0,120,0
bbSetAnimKey cube,60
bbRotateEntity cube,0,240,0
bbSetAnimKey cube,120
bbRotateEntity cube,0,0,0
bbSetAnimKey cube,180
bbAddAnimSeq p,180

For x=-100 To 100 Step 25
For z=-100 To 100 Step 25
e=bbCopyEntity( p,pivot )
bbPositionEntity e,x,5,z
bbAnimate e
Next
Next
bbFreeEntity cube

trail_mesh=bbCreateMesh()
trail_brush=bbCreateBrush()
bbBrushColor trail_brush,255,0,0
bbBrushBlend trail_brush,3
bbBrushFX trail_brush,1
trail_surf=bbCreateSurface( trail_mesh,trail_brush )
bbAddVertex trail_surf,0,2,0,0,0
bbAddVertex trail_surf,0,0,0,0,1
bbAddVertex trail_surf,0,2,0,0,0
bbAddVertex trail_surf,0,0,0,0,1
bbAddTriangle trail_surf,0,2,3
bbAddTriangle trail_surf,0,3,1
bbAddTriangle trail_surf,0,3,2
bbAddTriangle trail_surf,0,1,3
trail_vert=2

bike=bbCreateSphere()
bbScaleMesh bike,.75,1,2
bbPositionEntity bike,0,1,0
bbEntityShininess bike,1
bbEntityColor bike,192,0,255

camera=bbCreateCamera()
bbTurnEntity camera,45,0,0
cam_d#=30

light=bbCreateLight()
bbTurnEntity light,45,45,0

add_flag=False

While Not bbKeyHit(1)

	If bbKeyHit(17)
		wire=Not wire
		bbWireFrame wire
	EndIf
	
	If bbKeyDown(30) cam_d=cam_d-1
	If bbKeyDown(44) cam_d=cam_d+1
	
	turn=0
	If smooth
		If bbKeyDown(203) turn=5
		If bbKeyDown(205) turn=-5
		If turn
			add_cnt=add_cnt+1
			If add_cnt=3
				add_cnt=0
				add_flag=True
			Else
				add_flag=False
			EndIf
		Else If add_cnt
			add_cnt=0
			add_flag=True
		Else
			add_flag=False
		EndIf
	Else
		If bbKeyHit(203) turn=90
		If bbKeyHit(205) turn=-90
		If turn Then add_flag=True Else add_flag=False
	EndIf
	
	If turn
		bbTurnEntity bike,0,turn,0
	EndIf
	
	bbMoveEntity bike,0,0,1
	
	If add_flag
		bbAddVertex trail_surf,bbEntityX(bike),2,bbEntityZ(bike),0,0
		bbAddVertex trail_surf,bbEntityX(bike),0,bbEntityZ(bike),0,1
		bbAddTriangle trail_surf,trail_vert,trail_vert+2,trail_vert+3
		bbAddTriangle trail_surf,trail_vert,trail_vert+3,trail_vert+1
		bbAddTriangle trail_surf,trail_vert,trail_vert+3,trail_vert+2
		bbAddTriangle trail_surf,trail_vert,trail_vert+1,trail_vert+3
		trail_vert=trail_vert+2
	Else
		bbVertexCoords trail_surf,trail_vert,bbEntityX(bike),2,bbEntityZ(bike)
		bbVertexCoords trail_surf,trail_vert+1,bbEntityX(bike),0,bbEntityZ(bike)
	EndIf
	
	bbUpdateWorld
	
	bbPositionEntity camera,bbEntityX(bike)-5,0,bbEntityZ(bike)
	bbMoveEntity camera,0,0,-cam_d

'	PositionEntity camera,0,20,0
'	PointEntity camera,bike
	
	bbRenderWorld
	bbFlip

Wend
End
