Import blitz3d.blitz3dsdk

Import "bbtype.bmx"
Import "blitz3d.bmx"

bbBeginBlitz3D

bbGraphics 400,300

Global Dude_list:TList=New TList

Repeat
	a$=bbInput( "Number of dudes")' (1-50):" )
	n_dudes=Int(a)
Until n_dudes>=1 And n_dudes<=100

Global info1$="Collision demo"
Global info2$="Arrow keys/A/Z To drive, Tab To repel"

'Include "../start.bmx"

bbGraphics3D 800,600,0

Type bbDude Extends TBBType

	Method New()
		Add(Dude_list)
	End Method

	Method After:bbDude()
		Local t:TLink
		t=_link.NextLink()
		If t Return bbDude(t.Value())
	End Method

	Method Before:bbDude()
		Local t:TLink
		t=_link.PrevLink()
		If t Return bbDude(t.Value())
	End Method

	Field entity,speed#
End Type

Const T_DUDE=1,T_WALLS=2

bbCollisions T_DUDE,T_DUDE,1,2	'sphere-to-sphere, sliding collisions
bbCollisions T_DUDE,T_WALLS,2,2	'sphere-to-polygon, sliding collisions

walls=bbCreateCube()
bbEntityColor walls,0,32,192
bbFitMesh walls,-40,0,-40,80,80,80
bbFlipMesh walls
bbEntityType walls,T_WALLS

col=bbCreateCube()
bbFitMesh col,-1,0,-1,2,40,2
bbEntityColor col,255,0,0
bbEntityAlpha col,.75
bbEntityType col,T_WALLS
For k=30 To 359+30 Step 60
	t=bbCopyEntity( col )
	bbRotateEntity t,0,k,0
	bbMoveEntity t,0,0,34
Next
bbFreeEntity col

camera=bbCreateCamera()
bbPositionEntity camera,0,50,-46
bbTurnEntity camera,45,0,0

bbCameraClsColor camera,255,255,255

light=bbCreateLight()
bbTurnEntity light,45,45,0

player=bbCreateCube()
bbEntityColor player,0,255,0
bbPositionEntity player,0,3,0
bbEntityRadius player,2
bbEntityType player,T_DUDE

nose=bbCreateCube( player )
bbEntityColor nose,0,255,0
bbScaleEntity nose,.5,.5,.5
bbPositionEntity nose,0,0,1.5

sphere=bbCreateSphere()
bbEntityShininess sphere,.5
bbEntityType sphere,T_DUDE

an#=0
an_step#=360.0/n_dudes

For k=1 To n_dudes
	d:bbDude=New bbDude
	d.entity=bbCopyEntity( sphere )
	bbEntityColor d.entity,Rnd(255),Rnd(255),Rnd(255)
	bbTurnEntity d.entity,0,an,0
	bbMoveEntity d.entity,0,2,37
	bbResetEntity d.entity
	d.speed=Rnd( .4,.49 )
	an=an+an_step
Next

bbFreeEntity sphere

ok=True	

While Not bbKeyHit(1)

	If bbKeyDown(203) bbTurnEntity player,0,5,0
	If bbKeyDown(205) bbTurnEntity player,0,-5,0
	If bbKeyDown(200) bbMoveEntity player,0,0,.5
	If bbKeyDown(208) bbMoveEntity player,0,0,-.5
	If bbKeyDown(30) bbTranslateEntity player,0,.2,0
	If bbKeyDown(44) bbTranslateEntity player,0,-.2,0
	
	For d:bbDude=EachIn Dude_list
		If bbEntityDistance( player,d.entity )>2
			bbPointEntity d.entity,player
			If bbKeyDown(15) bbTurnEntity d.entity,0,180,0
		EndIf
		bbMoveEntity d.entity,0,0,d.speed
	Next

	bbUpdateWorld
	bbRenderWorld

'	Goto skip
	If ok
		'
		'sanity check!
		'make sure nothings gone through anything else...
		'
		For d=EachIn Dude_list
			If bbEntityY( d.entity )<.9
				ok=False
				bad$="Bad Dude Y: "+bbEntityY( d.entity )
			EndIf
			For d2:bbDude=EachIn Dude_list
				If d=d2 Then Exit
				If bbEntityDistance( d.entity,d2.entity )<.9
					ok=False
					bad$="Dude overlap!"
				EndIf
			Next
		Next
	EndIf
	
	If ok
		bbText 0,0,"Dudes OK"
	Else
		bbCameraClsColor camera,255,0,0
		bbText 0,0,bad$
	EndIf
#skip
	
	bbFlip
Wend
