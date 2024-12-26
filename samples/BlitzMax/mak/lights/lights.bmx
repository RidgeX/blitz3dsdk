Import blitz3d.blitz3dsdk

Import "bbtype.bmx"
Import "blitz3d.bmx"

bbBeginBlitz3D

Global info1$="Lights demo"
Global info2$="Features directional, point and spot lights"

Include "../start.bmx"

bbAmbientLight 0,0,0

sphere=bbCreateSphere(32)

camera=bbCreateCamera()
bbPositionEntity camera,0,0,-3

'directional light
light1=bbCreateLight( 1 )
bbTurnEntity light1,0,-30,0
bbLightColor light1,255,0,0
bbHideEntity light1

'point light
light2=bbCreateLight( 2 )
bbPositionEntity light2,5,0,-10
bbLightColor light2,0,255,0
bbLightRange light2,15
bbHideEntity light2

'spot light
light3=bbCreateLight( 3 )
bbPositionEntity light3,0,0,-10
bbLightColor light3,0,0,255
bbLightConeAngles light3,0,10
bbLightRange light3,15
bbHideEntity light3

on1=True
on2=True
on3=True

If on1 Then bbShowEntity light1
If on2 Then bbShowEntity light2
If on3 Then bbShowEntity light3

While Not bbKeyHit(1)
	If bbKeyHit(59)
		on1=Not on1
		If on1 Then bbShowEntity light1 Else bbHideEntity light1
	EndIf
	If bbKeyHit(60)
		on2=Not on2
		If on2 Then bbShowEntity light2 Else bbHideEntity light2
	EndIf
	If bbKeyHit(61)
		on3=Not on3
		If on3 Then bbShowEntity light3 Else bbHideEntity light3
	EndIf
	
	If on3
		bbRotateEntity light3,Sin(MilliSecs()*.07)*5,Sin(MilliSecs()*.05)*5,0
'		TurnEntity light3,0,1,0
	EndIf
	
	bbUpdateWorld
	bbRenderWorld
	
	bbText 0,bbFontHeight()*0,"(F1) Light1="+on1
	bbText 0,bbFontHeight()*1,"(F2) Light2="+on2
	bbText 0,bbFontHeight()*2,"(F3) Light3="+on3
	bbFlip
Wend

End
