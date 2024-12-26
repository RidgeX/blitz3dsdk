' ---------------------------------------------------------------
' Testbed thing -- HIGHLY UNFINISHED AND MESSY!
' ---------------------------------------------------------------

' Features

' Tracking gun emplacements (they aim ahead, depending on player's speed)
' Updating loadsa stuff via For... Each loops:
'	- Enemy shots
'	- Player shots
'	- Fading of all flames
'	- Enemies only fire within certain range
' Sprites-for-shots 'n' flames
' Blitz terrain
' Awful controls

' If you have a M$ control pad, you might need to turn off the tilt mode
' cos it makes things go all loopy!

Import blitz3d.blitz3dsdk

Import "bbtype.bmx"
Import "blitz3d.bmx"

bbBeginBlitz3D

Global AlienShot_list:TList=New TList
Global Flame_list:TList=New TList
Global Alien_list:TList=New TList


noAliens = 50' 25;10

' ---------------------------------------------------------------
' Graphics/light...
' ---------------------------------------------------------------

Global dWidth  =1024
Global dHeight = 768

bbGraphics3D dWidth, dHeight,0
'bbSetBuffer bbBackBuffer ()

'AntiAlias True

bbAmbientLight 200, 200, 200
sun = bbCreateLight ()
bbLightColor sun, 255, 220, 180
bbRotateEntity sun, 0, 45, 0

' ---------------------------------------------------------------
' Terrain...
' ---------------------------------------------------------------

terrain = bbLoadTerrain ("gfx/height.bmp")
bbScaleEntity terrain, 5, 300, 5
bbTerrainShading terrain, True
bbTerrainDetail terrain, 2500, True
bbEntityPickMode terrain, 2, True
grass = bbLoadTexture ("gfx/grass.bmp")
bbScaleTexture grass, 20, 20
bbEntityTexture terrain, grass, 0, 1

' ---------------------------------------------------------------
' Hack me an alien gun thing... ball with cylinder sticking out
' ---------------------------------------------------------------

Type bbAlien Extends TBBType

	Method New()
		Add(Alien_list)
	End Method

	Method After:bbAlien()
		Local t:TLink
		t=_link.NextLink()
		If t Return bbAlien(t.Value())
	End Method

	Method Before:bbAlien()
		Local t:TLink
		t=_link.PrevLink()
		If t Return bbAlien(t.Value())
	End Method

	Field entity
End Type

ballAlien = bbCreateSphere ()
bbScaleEntity ballAlien, 4, 4, 4
bbEntityColor ballAlien, 64, 64, 64
bbEntityShininess ballAlien, 1
ballAlienGun = bbCreateCylinder (12, 1, ballAlien)
bbScaleEntity ballAlienGun, 0.25, 2.5, 0.25
bbMoveEntity ballAlienGun, 0, 0, 2
bbRotateEntity ballAlienGun, 90, 0, 0
bbEntityColor ballAlienGun, 32, 32, 32
bbEntityShininess ballAlienGun, 1
bbEntityPickMode ballAlien, 1, True
bbEntityRadius ballAlien, 9
Const ENTITY_ALIEN = 5
bbEntityType ballAlien, ENTITY_ALIEN
bbHideEntity ballAlien

' ---------------------------------------------------------------
' Copy alien x times...
' ---------------------------------------------------------------

For a = 1 To noAliens
	ball:bbAlien = New bbAlien
	ball.entity = bbCopyEntity (ballAlien); bbShowEntity ball.entity
	bx = Rnd (bbTerrainSize (terrain) * 5)
	bz = Rnd (bbTerrainSize (terrain) * 5)
	bbPositionEntity ball.entity, bx, bbTerrainY (terrain, bx, 0, bz) + 1, bz
Next

' ---------------------------------------------------------------
' Water...
' ---------------------------------------------------------------

water = bbCreatePlane ()
h20 = bbLoadTexture ("gfx/water.bmp")
bbScaleTexture h20, 200, 200
bbEntityTexture water, h20
bbEntityAlpha water, 0.4
bbPositionEntity water, 0, 20, 0
bbEntityShininess water, 1

' ---------------------------------------------------------------
' Camera and fog...
' ---------------------------------------------------------------

Global cam = bbCreatePivot ()
Global camera = bbCreateCamera (cam)
bbCameraViewport camera, 0, 0, dWidth, dHeight
bbCameraFogMode camera, 1
bbCameraFogColor camera, 200, 220, 255
range = 2500
bbCameraRange camera, 1, range
bbCameraFogRange camera, 1, range - 10
bbCameraClsColor camera, 200, 220, 255

' ---------------------------------------------------------------
' Player...
' ---------------------------------------------------------------

Global ship = bbCreatePivot ()
Global shipMesh = bbLoadMesh ("msh/ship.x", ship)
bbMoveEntity shipMesh, -2.5, 0, -1
bbScaleEntity shipMesh, 0.5, 0.5, 0.5
bbEntityRadius ship, 1.6
bbEntityShininess shipMesh, 1

Global aliensTarget = bbCreatePivot (ship) ' Sphere (5, ship)
bbMoveEntity aliensTarget, 0, 0, 200

' ---------------------------------------------------------------
' Attach camera to player...
' ---------------------------------------------------------------

bbPositionEntity cam, 0, bbEntityY (ship) + 0.85, -4
bbEntityParent cam, ship
bbPositionEntity ship, 10, 50, 10

' ---------------------------------------------------------------
' 2D stuff...
' ---------------------------------------------------------------

' Target...
target = bbLoadImage ("gfx/target.bmp")
bbMaskImage target, 255, 0, 255
bbMidHandle target

' Flame...
Global fire = bbLoadSprite ("gfx/fire.bmp")
bbHandleSprite fire, 0, -1
bbScaleSprite fire, 5, 5
bbEntityAlpha fire, 0.25
bbEntityFX fire, 8
bbHideEntity fire

' Splash...
Global splash = bbLoadSprite ("gfx/splash.bmp")
bbHandleSprite splash, 0, -1
bbScaleSprite splash, 5, 5
bbEntityAlpha splash, 0.25
bbEntityFX splash, 8
bbHideEntity splash

' Alien shot...
Global afire = bbLoadSprite ("gfx/ashot.bmp")
bbHandleSprite afire, 0, -1
bbScaleSprite afire, 3, 3
bbEntityFX afire, 8
bbEntityRadius afire, 4
bbHideEntity afire

Global hits

' ---------------------------------------------------------------
' Collisions...
' ---------------------------------------------------------------
	
Const ENTITY_TERRAIN = 1
Const ENTITY_SHIP	 = 2
Const ENTITY_WATER	 = 3
Const ENTITY_AFIRE	 = 4

bbEntityType terrain, ENTITY_TERRAIN
bbEntityType ship, ENTITY_SHIP
bbEntityType water, ENTITY_WATER
bbEntityType afire, ENTITY_AFIRE

bbCollisions ENTITY_SHIP, ENTITY_TERRAIN, 2, 2
bbCollisions ENTITY_SHIP, ENTITY_WATER, 2, 2
bbCollisions ENTITY_AFIRE, ENTITY_SHIP, 1, 1

' ---------------------------------------------------------------
' Auto-updated entity functions...
' ---------------------------------------------------------------

Type bbFlame Extends TBBType

	Method New()
		Add(Flame_list)
	End Method

	Method After:bbFlame()
		Local t:TLink
		t=_link.NextLink()
		If t Return bbFlame(t.Value())
	End Method

	Method Before:bbFlame()
		Local t:TLink
		t=_link.PrevLink()
		If t Return bbFlame(t.Value())
	End Method

	Field entity
	Field alpha#
End Type

Function CreateFlame (x#, y#, z#, image)
	flame:bbFlame = New bbFlame
	flame.entity = bbCopyEntity (image); bbShowEntity flame.entity
	bbPositionEntity flame.entity, x, y, z
	flame.alpha = 1
End Function

Function UpdateFlames ()
	For a:bbFlame = EachIn Flame_list
		a.alpha = a.alpha - 0.001
		bbEntityAlpha a.entity, a.alpha
		If a.alpha < 0.01 Then bbFreeEntity a.entity; a.Remove()
	Next
End Function

Type bbAlienShot Extends TBBType

	Method New()
		Add(AlienShot_list)
	End Method

	Method After:bbAlienShot()
		Local t:TLink
		t=_link.NextLink()
		If t Return bbAlienShot(t.Value())
	End Method

	Method Before:bbAlienShot()
		Local t:TLink
		t=_link.PrevLink()
		If t Return bbAlienShot(t.Value())
	End Method

	Field entity ' 'afire' sprite
	Field alpha#
End Type

Function AlienShoot (a:bbAlien, image)
	aShot:bbAlienShot = New bbAlienShot
	aShot.entity = bbCopyEntity (image); bbShowEntity aShot.entity
	bbRotateEntity aShot.entity, bbEntityPitch (a.entity) + Rnd (-1, 1), bbEntityYaw (a.entity) + Rnd (-1, 1), 0'EntityRoll (a\entity) + Rnd (-1, 1)
	bbPositionEntity aShot.entity, bbEntityX (a.entity), bbEntityY (a.entity), bbEntityZ (a.entity)
	aShot.alpha = 1
End Function

Function UpdateAlienShots ()
	For a:bbAlienShot = EachIn AlienShot_list
		bbMoveEntity a.entity, 0, 0, 5
		If bbEntityCollided (a.entity, ENTITY_SHIP)
'			CreateFlame (EntityX (shipMesh), EntityY (shipMesh), EntityZ (shipMesh), fire)
			hits = hits + 1
		EndIf
		a.alpha = a.alpha - 0.0025
		bbEntityAlpha a.entity, a.alpha
		If a.alpha < 0.01 Then bbFreeEntity a.entity; a.Remove()
	Next
End Function

' ---------------------------------------------------------------
' Reduce roll rate to zero...
' ---------------------------------------------------------------

Function Diminish# (value#, amount#)
	If Abs (value) <= Abs (amount) Then Return 0
	value = value - (amount * Sgn (value))
	Return value
End Function

' ---------------------------------------------------------------
' Player control variables...
' ---------------------------------------------------------------

Global zAcc# = 0
Global shipRoll#  = 0
Global shipPitch# = 0

' ---------------------------------------------------------------
' Main loop...
' ---------------------------------------------------------------

bbMoveMouse bbGraphicsWidth () / 2, bbGraphicsHeight () / 2

Global topSpeed = 3
FPS = 50

period = 1000 / FPS
time = MilliSecs () - period

Global kills
Global damage

'WireFrame 1

Repeat
	
	Repeat
		elapsed = MilliSecs () - time
	Until elapsed

	ticks = elapsed / period
	
	tween# = Float (elapsed Mod period) / Float (period)
	
	For framelimit = 1 To ticks
		If framelimit = ticks Then bbCaptureWorld
		time = time + period
		UpdateGame ()
		bbUpdateWorld
		bbPositionEntity water, Sin (time * 0.01) * 10, bbEntityY (water) + (Sin (time * 0.05) * 0.5) * 0.2, Cos (time * 0.02) * 10
	Next
	
	If bbKeyHit (17)
		w = 1 - w
		bbWireFrame w
	EndIf
	
	bbRenderWorld tween

	' -----------------------------------------------------------
	' Draw target...
	' -----------------------------------------------------------

	x = (bbMouseX () - x) / 3 + x
	y = (bbMouseY () - y) / 3 + y
		
	bbDrawImage target, x, y

	' -----------------------------------------------------------
	' Instructions...
	' -----------------------------------------------------------

	bbText 20, bbGraphicsHeight () - 60, "Cursors to move"
	bbText 20, bbGraphicsHeight () - 40, "Right mouse button to accelerate"
	bbText 20, bbGraphicsHeight () - 20, "Mouse + left button to fire"

'	Text 20, 20, EntityX (shipMesh)
'	Text 20, 40, EntityY (shipMesh)
'	Text 20, 60, EntityZ (shipMesh)

	bbText 20, 80,  "Kills: "  + kills + " dead alien scum"
	bbText 20, 100, "Hits: "   + "Hit by aliens " + hits  + " times"
	bbText 20, 120, "Ground damage: " + damage
	
	bbFlip
	
	PollSystem
	
Until bbKeyDown (1)

End

Function UpdateGame ()

	' -----------------------------------------------------------
	' Left/right/up/down...
	' -----------------------------------------------------------

	If bbKeyDown (203) Or bbJoyXDir () = -1
		If shipRoll < 2 Then shipRoll = shipRoll + 0.125
	EndIf
	
	If bbKeyDown (205) Or bbJoyXDir () = 1
		If shipRoll > -2 Then shipRoll = shipRoll - 0.125
	EndIf
	
	If bbKeyDown (200) Or bbJoyYDir () = -1
		If shipPitch < 1 Then shipPitch = shipPitch + 0.02
	EndIf

	If bbKeyDown (208) Or bbJoyYDir () = 1
		If shipPitch > -3 Then shipPitch = shipPitch - 0.023
	EndIf

	' -----------------------------------------------------------
	' Speed up/slow down...
	' -----------------------------------------------------------
	
	If bbMouseDown (2) | bbJoyDown (8)
		If zAcc < topSpeed Then zAcc = zAcc + 0.05
	Else
		If zAcc > 0.025 Then zAcc = zAcc - (0.025 * zAcc / 10)
	EndIf

	' -----------------------------------------------------------
	' Ship "inertia"...
	' -----------------------------------------------------------

	shipRoll = Diminish (shipRoll, 0.05)
	shipRoll = shipRoll + Rnd (-0.075, 0.075)
	shipPitch = Diminish (shipPitch, 0.0125)
	
	' -----------------------------------------------------------
	' Position player and camera...
	' -----------------------------------------------------------

	bbTurnEntity ship, shipPitch, 0, shipRoll
'	TurnEntity ship, 0, ((Sin (EntityRoll (ship))) / topSpeed) * zAcc, 0, 1
	bbTurnEntity ship, 0, 2 * (((Sin (bbEntityRoll (ship))) / topSpeed) * zAcc), 0, 1
	bbTurnEntity cam, 0, bbEntityRoll (ship) / 90, 0, 1
	bbMoveEntity ship, 0, 0, zAcc
	bbPointEntity cam, ship
	
	bbPositionEntity aliensTarget, 0, 0, 5 + zAcc * 50
	
	' -----------------------------------------------------------
	' Fire button...
	' -----------------------------------------------------------

	If bbMouseDown (1) | bbJoyDown (1)
		picked = bbCameraPick (camera, bbMouseX (), bbMouseY ())
		If picked
			For a:bbAlien = EachIn Alien_list
				If picked = a.entity Then kills = kills + 1; bbFreeEntity a.entity; a.Remove(); Exit
			Next
			CreateFlame (bbPickedX (), bbPickedY (), bbPickedZ (), fire)
		EndIf
	EndIf
	
	' -----------------------------------------------------------
	' Player-to-terrain collision check...
	' -----------------------------------------------------------
	
	If bbEntityCollided (ship, ENTITY_TERRAIN)
		CreateFlame (bbEntityX (ship), bbEntityY (ship), bbEntityZ (ship), fire)
		damage = damage + 1
	EndIf

	If bbEntityCollided (ship, ENTITY_WATER)
		CreateFlame (bbEntityX (ship), bbEntityY (ship), bbEntityZ (ship), splash)
	EndIf

	' -----------------------------------------------------------
	' Aliens fire at player... sorta :)
	' -----------------------------------------------------------

	For gun:bbAlien = EachIn Alien_list
		bbPointEntity gun.entity, aliensTarget'ship
		If Rnd (1000) > 950 And bbEntityDistance (gun.entity, ship) < 750
			AlienShoot (gun, afire)
		EndIf
	Next

	' -----------------------------------------------------------
	' Auto-update stuff...
	' -----------------------------------------------------------

	UpdateFlames ()
	UpdateAlienShots ()
	
End Function
