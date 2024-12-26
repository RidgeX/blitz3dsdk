'Field of grass + kludged lens flare

Import blitz3d.blitz3dsdk

Import "bbtype.bmx"
Import "blitz3d.bmx"

Import "bbtype.bmx"
Import "blitz3d.bmx"

Global info1$="Grass Demo, by Adam Gore"

bbBeginBlitz3D

bbGraphics3D 800,600,0,2

'Include "../start.bmx"

Global gwidth = 640
Global gheight = 480
Global length = 16			'up this if you have a *very* fast computer
Global ystep# = .005
Global an#

Global plane[ length-1 +1]

'Graphics3D gwidth,gheight

mesh_skybox = MakeSkyBox("Data\sky") 

camera=bbCreateCamera()
bbCameraZoom camera,1
bbPositionEntity camera,0,.1,0
bbCameraFogMode camera,1
bbCameraFogRange camera,0,75
bbCameraFogColor camera,222,252,255
bbAmbientLight 255,255,255

bbClearTextureFilters

tex=bbLoadTexture( "Data\Ground.bmp",9 )
bbScaleTexture tex,4,4
tex1=bbLoadTexture( "Data\GrassClip.bmp",10 )
bbScaleTexture tex1,1.5,1.5
ground = bbCreatePlane(1)
bbEntityTexture ground,tex ; bbPositionEntity ground,0,-1-.005,0
bbEntityOrder ground,9

flare = bbCreatePivot( mesh_skybox )
bbPositionEntity flare,0,120,-300

s1 = bbLoadSprite("Data\lens1.jpg",2,camera) ; bbEntityFX s1,9 ; bbScaleSprite s1,6,6	; bbEntityColor s1,255,255,242
s2 = bbLoadSprite("Data\lens2.jpg",2,camera) ; bbEntityFX s2,9 ; bbScaleSprite s2,1.1,1.1	; bbEntityColor s2,255,255,220
s3 = bbLoadSprite("Data\lens3.jpg",2,camera) ; bbEntityFX s3,9 ; bbScaleSprite s3,1.5,1.5	; bbEntityColor s3,255,255,200
s4 = bbLoadSprite("Data\lens4.jpg",2,camera) ; bbEntityFX s4,9 ; bbScaleSprite s4,1.8,1.8	; bbEntityColor s4,255,255,180

For a#=0 To length-1
 plane(a) = bbCreatePlane()
 bbEntityTexture plane(a),tex1
 bbPositionEntity plane(a),0,-1 + (a * ystep),0
 bbEntityColor plane(a),32,96+((a/(length-1))*96),0
 bbEntityAlpha plane(a),.5+((1-(a/(length-1)))*2)
 bbEntityOrder plane(a),8
Next


While Not bbKeyHit(1)

	an=an+1 ; If an>359 Then an=0
	s# = Cos(an)/15000
	For b = 0 To length-1
		bbMoveEntity plane(b),s*b,0,0
	Next

	If bbKeyDown(203) bbTurnEntity camera,0,.5,0
	If bbKeyDown(205) bbTurnEntity camera,0,-.5,0
	If bbKeyDown(200) bbMoveEntity camera,0,0,.01
	If bbKeyDown(208) bbMoveEntity camera,0,0,-.01

	bbPositionEntity mesh_skybox,bbEntityX(camera,1),bbEntityY(camera,1),bbEntityZ(camera,1)
	
	bbCameraProject( camera,bbEntityX(flare,1),bbEntityY(flare,1),bbEntityZ(flare,1) )
	
    vx# = bbProjectedX() - (gwidth/2)
    vy# = bbProjectedY() - (gheight/2)

	sx = vx + (gwidth/2) ; sy = vy + (gheight/2)
	bbPositionEntity s1,SpriteX(sx,sy,128),SpriteY(sx,sy,128),SpriteZ(sx,sy,128)
	sx = -vx/2 + (gwidth/2) ; sy = -vy/2 + (gheight/2)
	bbPositionEntity s2,SpriteX(sx,sy,128),SpriteY(sx,sy,128),SpriteZ(sx,sy,128)
	sx = -vx/5 + (gwidth/2) ; sy = -vy/5 + (gheight/2)
	bbPositionEntity s3,SpriteX(sx,sy,128),SpriteY(sx,sy,128),SpriteZ(sx,sy,128)
	sx = -vx/1.2 + (gwidth/2) ; sy = -vy/1.2 + (gheight/2)
	bbPositionEntity s4,SpriteX(sx,sy,128),SpriteY(sx,sy,128),SpriteZ(sx,sy,128)
	
	bbRotateSprite s1,-bbEntityYaw(camera)
	bbEntityAlpha s1,bbProjectedZ()
	bbEntityAlpha s2,1-(Abs(vx)/(gwidth/2))
	bbEntityAlpha s3,1-(Abs(vx)/(gwidth/2))
	bbEntityAlpha s4,1-(Abs(vx)/(gwidth/2))	
	
	bbUpdateWorld ; bbRenderWorld ;	bbFlip

Wend
End


Function SpriteX#(x#,y#,size#)
	Return 2.0*(x-(gwidth/2))/size
End Function

Function SpriteY#(x#,y#,size#)
	Return -2.0*(y-(gheight/2))/size
End Function

Function SpriteZ#(x#,y#,size#)
	Return 1*gwidth/size
End Function

Function MakeSkyBox( file$ )

	m=bbCreateMesh()
	'front face
	b=bbLoadBrush( file$+"_FR.bmp",49 )
	s=bbCreateSurface( m,b )
	bbAddVertex s,-1,+1,-1,0,0;bbAddVertex s,+1,+1,-1,1,0
	bbAddVertex s,+1,-1,-1,1,1;bbAddVertex s,-1,-1,-1,0,1
	bbAddTriangle s,0,1,2;bbAddTriangle s,0,2,3
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

	bbScaleMesh m,100,100,100
	bbFlipMesh m
	bbEntityFX m,9
	bbEntityOrder m,10
	Return m
	
End Function
