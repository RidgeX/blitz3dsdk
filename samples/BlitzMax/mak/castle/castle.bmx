
Framework blitz3d.blitz3dsdk

Import brl.linkedlist
Import brl.filesystem
Import brl.math
Import brl.random

Import "bbtype.bmx"
Import "blitz3d.bmx"

If bbBeginBlitz3D()=0 RuntimeError ("bbBeginRuntime failed")

Global Hole_list:TList=New TList
Global Bullet_list:TList=New TList
Global Spark_list:TList=New TList
Global ChaseCam_list:TList=New TList
Global Player_list:TList=New TList

'The castle demo!
Const FPS=30
Const n_trees=100

Global info1$="Castle Demo"
Global info2$="Featuring dynamic terrain, sliding collisions,"
Global info3$="transparency effects and an intelligent camera"
Global info4$="Arrow keys/A/Z to move, Space to jump, Left-Alt to fire"

bbGraphics3D 800,600,0,2

realtime_ref=True

Global shoot=bbLoadSound( "sounds\shoot.wav" )
Global boom=bbLoadSound( "sounds\boom.wav" )

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

	Field entity,model
	Field anim_speed#,player_y#,roll#
End Type

Type bbChaseCam Extends TBBType

	Method New()
		Add(ChaseCam_list)
	End Method

	Method After:bbChaseCam()
		Local t:TLink
		t=_link.NextLink()
		If t Return bbChaseCam(t.Value())
	End Method

	Method Before:bbChaseCam()
		Local t:TLink
		t=_link.PrevLink()
		If t Return bbChaseCam(t.Value())
	End Method

	Field entity,camera,target,heading,sky
End Type

Type bbSpark Extends TBBType

	Method New()
		Add(Spark_list)
	End Method

	Method After:bbSpark()
		Local t:TLink
		t=_link.NextLink()
		If t Return bbSpark(t.Value())
	End Method

	Method Before:bbSpark()
		Local t:TLink
		t=_link.PrevLink()
		If t Return bbSpark(t.Value())
	End Method

	Field alpha#,sprite
End Type
	
Type bbBullet Extends TBBType

	Method New()
		Add(Bullet_list)
	End Method

	Method After:bbBullet()
		Local t:TLink
		t=_link.NextLink()
		If t Return bbBullet(t.Value())
	End Method

	Method Before:bbBullet()
		Local t:TLink
		t=_link.PrevLink()
		If t Return bbBullet(t.Value())
	End Method

	Field rot#,sprite,time_out
End Type

Type bbHole Extends TBBType

	Method New()
		Add(Hole_list)
	End Method

	Method After:bbHole()
		Local t:TLink
		t=_link.NextLink()
		If t Return bbHole(t.Value())
	End Method

	Method Before:bbHole()
		Local t:TLink
		t=_link.PrevLink()
		If t Return bbHole(t.Value())
	End Method

	Field alpha#,sprite
End Type

Const TYPE_PLAYER=1,TYPE_BULLET=2,TYPE_TARGET=3

Const TYPE_SCENERY=10,TYPE_TERRAIN=11

bbCollisions TYPE_PLAYER,TYPE_TERRAIN,2,2
bbCollisions TYPE_PLAYER,TYPE_SCENERY,2,2

bbCollisions TYPE_BULLET,TYPE_TERRAIN,2,1
bbCollisions TYPE_BULLET,TYPE_SCENERY,2,1

bbCollisions TYPE_TARGET,TYPE_TERRAIN,2,2
bbCollisions TYPE_TARGET,TYPE_SCENERY,2,2

Global water_level=-98
Global laight,castle,land,ground,water,sky
Global spark_sprite,bull_sprite,player_model,hole_sprite,tree_sprite
Global bull_x#=1.5

Setup()


ChangeDir "environ"
LoadEnviron( "terrain-1.jpg","water-2_mip.bmp","sky","heightmap_256.bmp" )
'LoadEnviron( "terrain-1.jpg","water.bmp","sky","heightmap_256.bmp" )
ChangeDir "..\"

player1:bbPlayer=CreatePlayer( 0,10,0 )
camera1:bbChaseCam=CreateChaseCam( player1.entity )

listener=bbCreateListener( player1.entity,.1,1,.2 )

'create cubic env map stuff...
If bbGfxDriverCaps3D()>=110
	teapot=bbCreateSphere(32)
	bbPositionEntity teapot,0,12,30
	bbScaleEntity teapot,3,3,3
	bbEntityFX teapot,1

	tex_sz=128
	If realtime_ref tex_flags=128+256 Else tex_flags=128+8
	ref_tex=bbCreateTexture( tex_sz,tex_sz,tex_flags )
	bbEntityTexture teapot,ref_tex

	ref_cam=bbCreateCamera()
	bbPositionEntity ref_cam,0,12,30
	bbCameraClsMode ref_cam,False,True
	bbCameraViewport ref_cam,0,0,tex_sz,tex_sz
	bbHideEntity ref_cam
	If Not realtime_ref
		bbHideEntity teapot
		bbHideEntity player1.entity
		bbHideEntity camera1.camera
		bbShowEntity ref_cam
		UpdateRefCube( ref_tex,ref_cam )
		bbHideEntity ref_cam
		bbShowEntity camera1.camera
		bbShowEntity player1.entity
		bbShowEntity teapot
		
		For k=0 To 5
			bbSetCubeFace ref_tex,k
'			bbSaveBuffer bbTextureBuffer(ref_tex),"f:\dev\castle_cube"+k+".bmp"
		Next
	EndIf
EndIf

'initialize timer stuff...
period=1000/FPS
time=MilliSecs()-period

While Not bbKeyHit(1)
	If bbKeyHit(17)
		wire=Not wire
		bbWireFrame wire
	EndIf
	Repeat
		elapsed=MilliSecs()-time
	Until elapsed

	'how many 'frames' have elapsed	
	ticks=elapsed/period
	
	'fractional remainder
	tween#=Float(elapsed Mod period)/Float(period)
	
	For k=1 To ticks
		time=time+period
		If k=ticks Then bbCaptureWorld
		
		UpdateGame()
		bbUpdateWorld
		bbPositionEntity water,Sin(time*.01)*10,water_level+Sin(time*.05)*.5,Cos(time*.02)*10
		For c:bbChaseCam=EachIn ChaseCam_list
			UpdateChaseCam( c )
			bbPositionEntity sky,bbEntityX(c.camera),bbEntityY(c.camera),bbEntityZ(c.camera)
		Next
	Next
	
	If realtime_ref
		bbHideEntity teapot
		bbHideEntity camera1.camera
		bbShowEntity ref_cam
		UpdateRefCube( ref_tex,ref_cam )
		bbHideEntity ref_cam
		bbShowEntity camera1.camera
		bbShowEntity teapot
	EndIf

	bbRenderWorld tween

	e=Camera1.entity
	bbText 0,0,"cam pos="+bbEntityX(e,1)+","+bbEntityY(e,1)+","+bbEntityZ(e,1)+","
	
	bbFlip
	
Wend

End

Function UpdateRefCube( tex,camera )

	tex_sz=bbTextureWidth(tex)

	'do left view	
	bbSetCubeFace tex,0
	bbRotateEntity camera,0,90,0
	bbRenderWorld
	bbCopyRect 0,0,tex_sz,tex_sz,0,0,bbBackBuffer(),bbTextureBuffer(tex)
	
	'do forward view
	bbSetCubeFace tex,1
	bbRotateEntity camera,0,0,0
	bbRenderWorld
	bbCopyRect 0,0,tex_sz,tex_sz,0,0,bbBackBuffer(),bbTextureBuffer(tex)
	
	'do right view	
	bbSetCubeFace tex,2
	bbRotateEntity camera,0,-90,0
	bbRenderWorld
	bbCopyRect 0,0,tex_sz,tex_sz,0,0,bbBackBuffer(),bbTextureBuffer(tex)
	
	'do backward view
	bbSetCubeFace tex,3
	bbRotateEntity camera,0,180,0
	bbRenderWorld
	bbCopyRect 0,0,tex_sz,tex_sz,0,0,bbBackBuffer(),bbTextureBuffer(tex)
	
	'do up view
	bbSetCubeFace tex,4
	bbRotateEntity camera,-90,0,0
	bbRenderWorld
	bbCopyRect 0,0,tex_sz,tex_sz,0,0,bbBackBuffer(),bbTextureBuffer(tex)
	
	'do down view
	bbSetCubeFace tex,5
	bbRotateEntity camera,90,0,0
	bbRenderWorld
	bbCopyRect 0,0,tex_sz,tex_sz,0,0,bbBackBuffer(),bbTextureBuffer(tex)
End Function	

Function UpdateGame()
	For h:bbHole=EachIn Hole_list
		UpdateHole( h )
	Next
	For b:bbBullet=EachIn Bullet_list
		UpdateBullet( b )
	Next
	For s:bbSpark=EachIn Spark_list
		UpdateSpark( s )
	Next
	For p:bbPlayer=EachIn Player_list
		UpdatePlayer( p )
	Next
End Function

Function UpdateHole( h:bbHole )
	h.alpha=h.alpha-.005
	If h.alpha>0
		bbEntityAlpha h.sprite,h.alpha
	Else
		bbFreeEntity h.sprite
		h.Remove()
	EndIf
End Function

Function CreatePlayer:bbPlayer( x#,y#,z# )
	p:bbPlayer=New bbPlayer
	p.entity=bbCreatePivot()
	p.model=bbCopyEntity( player_model,p.entity )
	p.player_y=y
	bbPositionEntity p.entity,x,y,z
	bbEntityType p.entity,TYPE_PLAYER
	bbEntityRadius p.entity,1.5
	bbResetEntity p.entity
	Return p
End Function

Function CreateBullet:bbBullet( p:bbPlayer )
	bull_x=-bull_x
	b:bbBullet=New bbBullet
	b.time_out=150
	b.sprite=bbCopyEntity( bull_sprite,p.entity )
	bbTranslateEntity b.sprite,bull_x,1,.25
	bbEntityParent b.sprite,0
	bbEmitSound( shoot,b.sprite )
	Return b
End Function

Function UpdateBullet( b:bbBullet )
	If bbCountCollisions( b.sprite )
		If bbEntityCollided( b.sprite,TYPE_TERRAIN )
			bbEmitSound boom,b.sprite
			ex#=bbEntityX(b.sprite)
			ey#=bbEntityY(b.sprite)
			ez#=bbEntityZ(b.sprite)
			bbTFormPoint( ex,ey,ez,0,land )
			hi#=bbTerrainHeight( land,bbTFormedX(),bbTFormedZ() )
			If hi>0
				hi=hi-.02;If hi<0 Then hi=0
				bbModifyTerrain land,bbTFormedX(),bbTFormedZ(),hi,True
			EndIf
			CreateSpark( b )
			bbFreeEntity b.sprite
			b.Remove()
			Return
		EndIf
		If bbEntityCollided( b.sprite,TYPE_SCENERY )
			For k=1 To bbCountCollisions( b.sprite )
				If bbGetEntityType( bbCollisionEntity( b.sprite,k ) )=TYPE_SCENERY
					cx#=bbCollisionX( b.sprite,k )
					cy#=bbCollisionY( b.sprite,k )
					cz#=bbCollisionZ( b.sprite,k )
					nx#=bbCollisionNX( b.sprite,k )
					ny#=bbCollisionNY( b.sprite,k )
					nz#=bbCollisionNZ( b.sprite,k )
					th:bbHole=New bbHole
					th.alpha=1
					th.sprite=bbCopyEntity( hole_sprite )
					bbPositionEntity th.sprite,cx,cy,cz
					bbAlignToVector th.sprite,-nx,-ny,-nz,3
					bbMoveEntity th.sprite,0,0,-.1
					Exit
				EndIf
			Next
			bbEmitSound boom,b.sprite
			CreateSpark( b )
			bbFreeEntity b.sprite
			b.Remove()
			Return
		EndIf
	EndIf
	b.time_out=b.time_out-1
	If b.time_out=0
		bbFreeEntity b.sprite
		b.Remove()
		Return
	EndIf
	b.rot=b.rot+30
	bbRotateSprite b.sprite,b.rot
	bbMoveEntity b.sprite,0,0,2
End Function

Function CreateSpark:bbSpark( b:bbBullet )
	s:bbSpark=New bbSpark
	s.alpha=-90
	s.sprite=bbCopyEntity( spark_sprite,b.sprite )
	bbEntityParent s.sprite,0
	Return s
End Function

Function UpdateSpark( s:bbSpark )
	If s.alpha<270
		sz#=Sin(s.alpha)*5+5
		bbScaleSprite s.sprite,sz,sz
		bbRotateSprite s.sprite,Rnd(360)
		s.alpha=s.alpha+15
	Else
		bbFreeEntity s.sprite
		s.Remove()
	EndIf
End Function

Function UpdatePlayer( p:bbPlayer )
	If bbKeyHit(56)	'fire?
		CreateBullet( p )
	EndIf
	
	If bbKeyDown(203)	'left/right
		bbTurnEntity p.entity,0,6,0	'turn player left/right
	Else If bbKeyDown(205)
		bbTurnEntity p.entity,0,-6,0
	EndIf
	
	If bbKeyDown(30)		'forward
		If p.anim_speed<=0
			p.anim_speed=1.75
			bbAnimate p.model,1,p.anim_speed
		EndIf
		bbMoveEntity p.entity,0,0,1
	Else If bbKeyDown(44)	'back
		If p.anim_speed>=0
			p.anim_speed=-1.75
			bbAnimate p.model,1,p.anim_speed
		EndIf
		bbMoveEntity p.entity,0,0,-1
	Else If p.anim_speed	'stop animating
		p.anim_speed=0
		bbAnimate p.model,0
	EndIf

	Goto skip	
	ex#=bbEntityX(p.entity);ez#=bbEntityZ(p.entity)
	bbPositionEntity p.entity,ex,bbTerrainY( land,ex,0,ez )+1.5,ez
	Return
#skip
	
	ty#=bbEntityY(p.entity)
	y_vel#=(ty-p.player_y)
	p.player_y=ty
	
	If bbKeyHit(57)	'jump?
		y_vel=5	'2.4
	Else
		y_vel=y_vel-.5	'2
	EndIf
	bbTranslateEntity p.entity,0,y_vel,0
	
End Function

Function CreateChaseCam:bbChaseCam( entity )
	c:bbChaseCam=New bbChaseCam
	c.entity=entity
	c.camera=bbCreateCamera()
	
	c.target=bbCreatePivot( entity )
	bbPositionEntity c.target,0,3,-10
	bbEntityType c.target,TYPE_TARGET
	
	c.heading=bbCreatePivot( entity )
	bbPositionEntity c.heading,0,0,20
	c.sky=bbCopyEntity( sky )
	Return c
End Function

Function UpdateChaseCam( c:bbChaseCam )

	If bbKeyDown(200)
		bbTranslateEntity c.heading,0,-3,0
	Else If bbKeyDown(208)
		bbTranslateEntity c.heading,0,+3,0
	EndIf
	
	dx#=bbEntityX(c.target,True)-bbEntityX(c.camera,True)
	dy#=bbEntityY(c.target,True)-bbEntityY(c.camera,True)
	dz#=bbEntityZ(c.target,True)-bbEntityZ(c.camera,True)
	
	bbTranslateEntity c.camera,dx*.1,dy*.1,dz*.1
	
	bbPointEntity c.camera,c.heading
		
	bbPositionEntity c.target,0,0,0
	bbResetEntity c.target
	bbPositionEntity c.target,0,3,-10

	bbPositionEntity c.sky,bbEntityX(c.camera),bbEntityY(c.camera),bbEntityZ(c.camera)
End Function

Function LoadEnviron( landtex$,watertex$,skytex$,heightmap$ )

	light=bbCreateLight()
	bbTurnEntity light,45,45,0
DebugLog "landtex "+landtex	
	land_tex=bbLoadTexture( landtex$,1 )
	bbScaleTexture land_tex,10,10

DebugLog "heightmap="+heightmap	
	land=bbLoadTerrain( heightmap$ )
	bbEntityTexture land,land_tex
	
	bbTerrainShading land,True
	bbPositionEntity land,-1000,-100,-1000
	bbScaleEntity land,2000.0/256,100,2000.0/256
	bbEntityType land,TYPE_TERRAIN
	bbTerrainDetail land,750,True

	For k=1 To n_trees
		Repeat
			tx#=Rnd(-70,70)-150
			tz#=Rnd(-70,70)+400
			ty#=bbTerrainY( land,tx,0,tz )
		Until ty>water_level
		Local t=bbCopyEntity( tree_sprite )
		bbPositionEntity t,tx,ty,tz
'		bbScaleSprite t,Rnd(2,3),Rnd(4,6)
		DebugLog "tree:tx="+tx+" ty="+ty+" tz="+tz	
	Next

DebugLog "ground"
	ground=bbCreatePlane()
	bbEntityTexture ground,land_tex
	bbPositionEntity ground,0,-100,0
	bbEntityOrder ground,9

DebugLog "water "+watertex
	water_tex=bbLoadTexture( watertex$,3 )
DebugLog "water"
	bbScaleTexture water_tex,20,20
	
DebugLog "water"
	water=bbCreatePlane(3)
DebugLog "water"
	bbEntityTexture water,water_tex
DebugLog "water"
	bbPositionEntity water,0,water_level,0
		
DebugLog "sky"
	sky=LoadSkyBox( skytex$ )
	bbEntityOrder sky,10
	bbHideEntity sky
DebugLog "done"

End Function

Function LoadSkyBox( file$ )
	m=bbCreateMesh()
	'front face
	b=bbLoadBrush( file$+"_FR.jpg",49 )
	s=bbCreateSurface( m,b )
	bbAddVertex s,-1,+1,-1,0,0;bbAddVertex s,+1,+1,-1,1,0
	bbAddVertex s,+1,-1,-1,1,1;bbAddVertex s,-1,-1,-1,0,1
	bbAddTriangle s,0,1,2;bbAddTriangle s,0,2,3
	bbFreeBrush b
	'right face
	b=bbLoadBrush( file$+"_LF.jpg",49 )
	s=bbCreateSurface( m,b )
	bbAddVertex s,+1,+1,-1,0,0;bbAddVertex s,+1,+1,+1,1,0
	bbAddVertex s,+1,-1,+1,1,1;bbAddVertex s,+1,-1,-1,0,1
	bbAddTriangle s,0,1,2;bbAddTriangle s,0,2,3
	bbFreeBrush b
	'back face
	b=bbLoadBrush( file$+"_BK.jpg",49 )
	s=bbCreateSurface( m,b )
	bbAddVertex s,+1,+1,+1,0,0;bbAddVertex s,-1,+1,+1,1,0
	bbAddVertex s,-1,-1,+1,1,1;bbAddVertex s,+1,-1,+1,0,1
	bbAddTriangle s,0,1,2;bbAddTriangle s,0,2,3
	bbFreeBrush b
	'left face
	b=bbLoadBrush( file$+"_RT.jpg",49 )
	s=bbCreateSurface( m,b )
	bbAddVertex s,-1,+1,+1,0,0;bbAddVertex s,-1,+1,-1,1,0
	bbAddVertex s,-1,-1,-1,1,1;bbAddVertex s,-1,-1,+1,0,1
	bbAddTriangle s,0,1,2;bbAddTriangle s,0,2,3
	bbFreeBrush b
	'top face
	b=bbLoadBrush( file$+"_UP.jpg",49 )
	s=bbCreateSurface( m,b )
	bbAddVertex s,-1,+1,+1,0,1;bbAddVertex s,+1,+1,+1,0,0
	bbAddVertex s,+1,+1,-1,1,0;bbAddVertex s,-1,+1,-1,1,1
	bbAddTriangle s,0,1,2;bbAddTriangle s,0,2,3
	bbFreeBrush b
	'bottom face	
	b=bbLoadBrush( file$+"_DN.jpg",49 )
	s=bbCreateSurface( m,b )
	bbAddVertex s,-1,-1,-1,1,0;bbAddVertex s,+1,-1,-1,1,1
	bbAddVertex s,+1,-1,+1,0,1;bbAddVertex s,-1,-1,+1,0,0
	bbAddTriangle s,0,1,2;bbAddTriangle s,0,2,3
	bbFreeBrush b
	bbScaleMesh m,100,100,100
	bbFlipMesh m
	bbEntityFX m,1
	Return m
End Function

Function Setup()
	castle=bbLoadMesh( "castle\castle1.x" )
	bbScaleEntity castle,.15,.15,.15
	bbEntityType castle,TYPE_SCENERY

	player_model=bbLoadAnimMesh( "markio\mariorun.x" )
	bbScaleEntity player_model,.2,.2,.2
	bbTranslateEntity player_model,0,-1.25,0
	bbHideEntity player_model

	spark_sprite=bbLoadSprite( "sprites\bigspark.bmp" )
	bbHideEntity spark_sprite

	bull_sprite=bbLoadSprite( "sprites\bluspark.bmp" )
	bbScaleSprite bull_sprite,3,3
	bbEntityRadius bull_sprite,1.5
	bbEntityType bull_sprite,TYPE_BULLET
	bbHideEntity bull_sprite
	
	hole_sprite=bbLoadSprite( "sprites\bullet_hole.bmp",1 )
	bbEntityBlend hole_sprite,2
	bbSpriteViewMode hole_sprite,2
	bbHideEntity hole_sprite
	
	tree_sprite=bbLoadSprite( "sprites\tree.bmp",7 )
	bbHandleSprite tree_sprite,0,-1
	bbScaleSprite tree_sprite,2,4
	bbPositionEntity tree_sprite,0,0,-100
	bbSpriteViewMode tree_sprite,3
'	bbEntityAutoFade tree_sprite,120,150
End Function
