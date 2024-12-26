Import blitz3d.blitz3dsdk

Import "bbtype.bmx"
Import "blitz3d.bmx"

bbBeginBlitz3D()

Global info1$="Fakelighting demo"
Global info2$="Hit <return> to toggle real/fake lighting"
Include "../start.bmx"

bbAmbientLight 0,0,0

cube=bbCreateSphere( 32 )
tex=bbLoadTexture( "brick.bmp" )
bbEntityTexture cube,tex

range#=5

For k=1 To 6
	ReadData lx#,ly#,lz#,lr#,lg#,lb#
	light=bbCreateLight(2,cube)
	bbLightRange light,range
	bbLightColor light,lr,lg,lb
	bbPositionEntity light,lx,ly,lz
	bbLightMesh cube,lr,lg,lb,range,lx,ly,lz
Next

camera=bbCreateCamera()
bbPositionEntity camera,0,0,-5

fake=0

While Not bbKeyHit(1)

	bbTurnEntity cube,.1,.2,.3

	If bbKeyHit(28)
		fake=3-fake
		bbEntityFX cube,fake
	EndIf

	bbUpdateWorld
	bbRenderWorld
	If fake t$="Y" Else t$="N"
	bbText 0,0,"Fake light:"+t$
	bbFlip
Wend

End

DefData -2,0,0,255,0,0
DefData +2,0,0,0,255,0
DefData 0,+2,0,255,255,0
DefData 0,-2,0,255,0,255
DefData 0,0,-2,0,255,255
DefData 0,0,+2,255,255,255
