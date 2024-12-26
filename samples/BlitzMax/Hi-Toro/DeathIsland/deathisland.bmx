
' ---------------------------------------------------------------
' An exercise in atmosphere...
' ---------------------------------------------------------------

' Run it at night with the lights off (NOT during the day!).

' Use MOUSE and CURSORS, QIII-style...

' DO NOT try to learn anything from this program, apart from the effects
' of tweaking various parameters, perhaps. This is a serious hack-job!

' ---------------------------------------------------------------
' It's ugly down there, men...
' ---------------------------------------------------------------


Import blitz3d.blitz3dsdk


Import "bbtype.bmx"
Import "blitz3d.bmx"

Global Timer_list:TList=New TList

bbBeginBlitz3D

Type bbTimer Extends TBBType

	Method New()
		Add(Timer_list)
	End Method

	Method After:bbTimer()
		Local t:TLink
		t=_link.NextLink()
		If t Return bbTimer(t.Value())
	End Method

	Method Before:bbTimer()
		Local t:TLink
		t=_link.PrevLink()
		If t Return bbTimer(t.Value())
	End Method

	Field start
	Field timeOut
End Type

Function SetTimer:bbTimer (timeOut)
	t:bbTimer = New bbTimer
	t.start   = MilliSecs ()
	t.timeOut = t.start + timeOut
	Return t
End Function

Function TimeOut (test:bbTimer)
	If test <> Null
		If test.timeOut < MilliSecs ()
			test.Remove()
			Return 1
		EndIf
	EndIf
End Function

' ---------------------------------------------------------------
' Lens stuff...
' ---------------------------------------------------------------

Global lensDiameter = 25
Include "incs/lensIncs.bmx"

' ---------------------------------------------------------------
' Graphics/light...
' ---------------------------------------------------------------

Global dWidth  = 640
Global dHeight = 480

bbGraphics3D dWidth, dHeight
bbSetBuffer bbBackBuffer ()

bbAmbientLight 0, 0, 0

wind 	 = bbLoadSound ("snd/seawind2.wav")
sea  	 = bbLoadSound ("snd/wavdance.wav")
rain 	 = bbLoadSound ("snd/rainroof.wav")
thunder1 = bbLoadSound ("snd/thunder.wav")
thunder2 = bbLoadSound ("snd/txstorm.wav")
run	 	 = bbLoadSound ("snd/gravel.wav")
wade	 = bbLoadSound ("snd/water2.wav")

' ---------------------------------------------------------------
' 747...
' ---------------------------------------------------------------

Function CenterPivot (model)
	bbFitMesh model, 0, 0, 0, bbMeshWidth (model), bbMeshHeight (model), bbMeshDepth (model)
	modelPivot = bbCreatePivot ()
	bbPositionEntity modelPivot, bbMeshWidth (model) / 2, bbMeshHeight (model) / 2, bbMeshDepth (model) / 2
	bbEntityParent model, modelPivot
	Return modelPivot
End Function

gimme747 = 1'0

' ---------------------------------------------------------------
' Don't ask...
' ---------------------------------------------------------------

If gimme747
	b747Model = bbLoadMesh ("msh/747.x")
	bbEntityShininess b747Model, 0.1
	b747 = CenterPivot (b747Model)
	bbScaleEntity b747, 600, 600, 600 ' 500
	bbPositionEntity b747, 3750, 400, 1300
	bbRotateEntity b747, 3, 45, -1
	scaler = 2
EndIf

' ---------------------------------------------------------------
' Terrain...
' ---------------------------------------------------------------

terrain = bbLoadTerrain ("gfx/height.bmp")
bbScaleEntity terrain, 5, 150, 5
bbTerrainShading terrain, True
bbTerrainDetail terrain, 2500, True
grass = bbLoadTexture ("gfx/greygrass.bmp")
bbScaleTexture grass, 20, 20
bbEntityTexture terrain, grass, 0, 1
bbMoveEntity terrain, 0, -4, 0

seabed = bbCreatePlane ()
bbEntityTexture seabed, grass
bbMoveEntity seabed, 0, -3.9, 0

' ---------------------------------------------------------------
' Water...
' ---------------------------------------------------------------

water = bbCreatePlane ()
h20 = bbLoadTexture ("gfx/greywater.bmp")
bbEntityAlpha water, 0.75
bbPositionEntity water, 0, 2.5, 0
bbScaleTexture h20, 200, 200
bbEntityTexture water, h20
bbEntityColor water, 64, 64, 64
bbEntityShininess water, 0.05

' ---------------------------------------------------------------
' Camera and fog...
' ---------------------------------------------------------------

cam = bbCreatePivot ()
bbEntityRadius cam, 2

camera = bbCreateCamera (cam)
bbCameraViewport camera, 0, 0, dWidth, dHeight
bbCameraFogMode camera, 1
bbCameraFogRange camera, 1, 1600' * scaler
bbCameraFogColor camera, 0, 0, 0'75, 75, 75
bbCameraRange camera, 1, 1600 * scaler
bbPositionEntity cam, 2340, 0, 2390 ' 1394, 0, 4660 ;1298, 0, 4653 ; 3750, 45, 1370

dome = bbCreateSphere (12)
clouds = bbLoadTexture ("gfx/realsky.bmp")
'ScaleEntity dome, 1300 * scaler, 1300 * scaler, 1300 * scaler
bbScaleEntity dome, 1600 * scaler, 1600 * scaler, 1600 * scaler
bbEntityTexture dome, clouds
bbScaleTexture clouds, 0.25, 0.25
bbEntityOrder dome, 1
bbFlipMesh dome
bbEntityAlpha dome, 0.25
bbEntityFX dome, 8

flash = bbCreateLight ()
bbLightColor flash, 0, 0, 0
bbPositionEntity flash, 1900, 100, 0
bbRotateEntity flash, 90, 0, 0

' ---------------------------------------------------------------
' Collisions...
' ---------------------------------------------------------------
	
Const ENTITY_TERRAIN = 1
Const ENTITY_CAM	 = 2
Const ENTITY_PLANE	 = 3

bbEntityType terrain, ENTITY_TERRAIN
bbEntityType cam, ENTITY_CAM

If gimme747
	bbEntityType b747Model, ENTITY_PLANE
EndIf

bbCollisions ENTITY_CAM, ENTITY_TERRAIN, 2, 2
bbCollisions ENTITY_CAM, ENTITY_PLANE, 2, 2

Function CurveValue#(current#,destination#,curve)
	current#=current#+((destination#-current#)/curve)
	Return current#
End Function

' ---------------------------------------------------------------
' Main loop...
' ---------------------------------------------------------------

FPS = 50

period = 1000 / FPS
time = MilliSecs () - period

bbSoundVolume wind, 0.25
bbSoundVolume sea, 0.65
bbSoundVolume rain, 0.75
bbSoundVolume run, 0
bbSoundVolume wade, 0

bbLoopSound wind
bbLoopSound sea
bbLoopSound rain
bbLoopSound run
bbLoopSound wade

bbPlaySound wind
bbPlaySound sea
bbPlaySound rain
runChannel = bbPlaySound (run)
wadeChannel = bbPlaySound (wade)

' ---------------------------------------------------------------
' Lens stuff...
' ---------------------------------------------------------------

diameter = lensDiameter
magnification = 5

CreateLens (diameter, magnification)

dropx# = 0
dropy# = 0

dropx2# = 0
dropy2# = 0

sky# = 0

startlite# = 0
foglite# = 0
sunlite# = 0

'CameraFogColor camera, 36, 36, 36

' Titles...
horror = bbLoadSprite ("gfx/di.bmp", 48, camera)
bbScaleSprite horror, 9, 5
bbPositionEntity horror, 0, 0, 10
horrorAlpha# = 0
bbEntityAlpha horror, horrorAlpha
showHorror = 1

steps# = 1.5

bbHidePointer

'chapel = LoadMesh ("G:\My Documents\Temp\chapel.x")
'RotateEntity chapel, -90, 0, 0
'PositionEntity chapel, 0, 400, 0
'EntityShininess chapel, 0

disclaimer$ = "Run it at night or you won't see a thing :)"
bbSetFont bbLoadFont ("arial")

Repeat

	If startlite < 40
		startlite = startlite + 0.5
		bbAmbientLight startlite, startlite, startlite
	EndIf

	If makesun = 0
		sun = bbCreateLight ()
		bbLightColor sun, 0, 0, 0
		bbPositionEntity sun, 3000, 500, 3000
		bbRotateEntity sun, 45, 0, 0
		makesun = 1
	Else
		' Titles... requesting the services of Major Hack... Major Hack, you're needed for some titles...
		If Not noMoreHorror
			bbEntityAlpha horror, horrorAlpha
			If Not reduce
				If horrorAlpha <= 1
					horrorAlpha = horrorAlpha + 0.05
				Else
					reduce = 1
				EndIf
			Else
				If horrorAlpha => 0
					horrorAlpha = horrorAlpha - 0.005
				EndIf
			EndIf	
			If horrorAlpha <= 0
				bbFreeEntity horror
				noMoreHorror = 1
			EndIf
		EndIf
		
	EndIf
	
	If sunlite < 70
		sunlite = sunlite + 0.5
		If sun
			bbLightColor sun, sunlite, sunlite, sunlite
		EndIf
	EndIf

	If foglite < 20
		foglite = foglite + 0.5
		bbCameraFogColor camera, foglite, foglite, foglite
		bbCameraClsColor camera, foglite, foglite, foglite
	EndIf

	Repeat
		elapsed = MilliSecs () - time
	Until elapsed

	ticks = elapsed / period
	
	tween# = Float (elapsed Mod period) / Float (period)
	
	For framelimit = 1 To ticks
	
		If framelimit = ticks Then bbCaptureWorld
		time = time + period

		bbPositionEntity cam, bbEntityX (cam), bbTerrainY (terrain, bbEntityX (cam), bbEntityY (cam), bbEntityZ (cam)) + 25, bbEntityZ (cam)
	
		mxs = bbMouseXSpeed()
		mys = bbMouseYSpeed()
		
		dest_xang# = dest_xang + mys
		dest_yang# = dest_yang - mxs
	
		xang# = CurveValue (xang, dest_xang, 5)
		yang# = CurveValue (yang, dest_yang, 5)
	
		bbRotateEntity camera, xang, 0, 0
		bbRotateEntity cam, 0, yang, 0
		
		bbMoveMouse bbGraphicsWidth()/2,bbGraphicsHeight()/2
		
		running# = 0
		
		If bbKeyDown (200)
			bbMoveEntity cam, 0, 0, steps
			running = Rnd (0.35, 0.75)
		EndIf
	
		If bbKeyDown (208)
			bbMoveEntity cam, 0, 0, -steps
			running = Rnd (0.55, 0.95)
		EndIf
	
		If running > 0
			bbChannelPitch runChannel, Rnd (8000, 14000)
			bbChannelPitch wadeChannel, Rnd (7000, 9000)
		EndIf
		
		wading# = 0
		
		If running
			If bbEntityY (cam) < bbEntityY (water) + 24
				wading = Rnd (0.5, 1)
				running = 0
			EndIf
		EndIf
		
		bbChannelVolume wadeChannel, wading
		bbChannelVolume runChannel, running
		
		bbPositionEntity dome, bbEntityX (cam), bbEntityY (cam), bbEntityZ (cam)
		bbTurnEntity dome, 0.005, 0.025, 0.005
		
		bbUpdateWorld
		
		' Mark's code, hacked cluelessly...
		bbPositionEntity water, Sin (time * 0.01) * 10, (bbEntityY (water) + (Sin (time * 0.05) * 0.2) * 0.25), Cos (time * 0.02) * 10

		If (Rnd (1000) > 998.8) | (bbKeyDown (28))
			startlite = 0
			sunlite = 40'255;10
			sky = 255
			foglite = 255
			thunderGo = 1
			thunderTimer:bbTimer = SetTimer (Rnd (500, 1500))
		EndIf

		If thunderGo
			If TimeOut (thunderTimer)
				If Rnd (0, 2) > 1
					thunder = thunder1
				Else thunder = thunder2
				EndIf
				bbSoundPitch thunder, Rnd (9000, 14000)
				bbPlaySound thunder
				thunderGo = 0
				thunderTimer.Remove()
			EndIf
		EndIf
				
		If sky > 10
			sky = sky - Rnd (5, 20)
		EndIf
		bbLightColor flash, sky, sky, sky

		If foglite > 20
			foglite = foglite - 10
			If foglite < 20 Then foglite = 20
		EndIf
		bbCameraClsColor camera, foglite, foglite, foglite					
'		CameraFogColor camera, foglite, foglite, foglite					

	Next
	
	' W is for Wireframe...
	If bbKeyHit (17)
		w = 1 - w
		bbWireFrame w
	EndIf
	
	bbRenderWorld tween

	If Not nomorehorror
		bbText (bbGraphicsWidth () / 2) - (bbStringWidth (disclaimer$) / 2), bbGraphicsHeight () - (bbStringHeight (disclaimer$) * 2), disclaimer$
	EndIf
	
	' Raindrops on lens...
	If dropy <= bbGraphicsHeight () - diameter - 2
		DrawLens (dropx, dropy, diameter)
		dropy = dropy + 2
	Else
		dropx = Rnd (0, bbGraphicsWidth () - diameter)
		dropy = 0
	EndIf

	If dropy2 <= bbGraphicsHeight () - diameter - 7
		DrawLens (dropx2, dropy2, diameter)
		dropy2 = dropy2 + 7
	Else
		dropx2 = Rnd (0, bbGraphicsWidth () - diameter)
		dropy2 = 0
	EndIf

'	Text 20, 20, EntityX (cam)
'	Text 20, 40, EntityY (cam)
'	Text 20, 60, EntityZ (cam)
	
	bbFlip

'	If KeyDown (57)
'		SaveBuffer FrontBuffer (), "grab" + grab + ".bmp"
'		grab = grab + 1
'	EndIf
		
Until bbKeyDown (1)

End
