Import blitz3d.blitz3dsdk

Import "bbtype.bmx"
Import "blitz3d.bmx"

bbBeginBlitz3D

Global info1$="Insaner demo!"
Global info2$="Arrow keys pan, A/Z zoom"
Global info3$="space to toggle hardware multitexturing"
Global info4$="Features multitextured dynamic LOD terrain"

'Include "../start.bmx"

bbGraphics3D  800,500,0,2

terrain=bbLoadTerrain( "hmap.bmp" )
bbTerrainDetail terrain,500,True
bbPositionEntity terrain,-128,0,-128
bbScaleEntity terrain,1,50,1
bbEntityFX terrain,1

'setup multitexturing:
'
'dest=( ( (rock-grass) * track ) + grass ) * lighting
'
tex0=bbLoadTexture( "CrackedStone_diff.bmp" )
bbScaleTexture tex0,16,16
tex1=bbLoadTexture( "track.bmp" )
bbScaleTexture tex1,256,256
tex2=bbLoadTexture( "MossyGround.bmp" )
bbScaleTexture tex2,16,16
bbTextureBlend tex2,3
tex3=bbLoadTexture( "lmap.bmp" )
bbScaleTexture tex3,256,256

bbEntityTexture terrain,tex0,0,0
bbEntityTexture terrain,tex1,0,1
bbEntityTexture terrain,tex2,0,2
bbEntityTexture terrain,tex3,0,3

camera=bbCreateCamera()
bbPositionEntity camera,0,200,0
bbRotateEntity camera,90,0,0

hwmt=True
bbHWMultiTex hwmt

While Not bbKeyHit(1)
	If bbKeyHit(17) wire=Not wire;bbWireFrame wire
	If bbKeyHit(57) hwmt=Not hwmt;bbHWMultiTex hwmt
	If bbKeyDown(30) bbTranslateEntity camera,0,-2,0
	If bbKeyDown(44) bbTranslateEntity camera,0,+2,0
	If bbKeyDown(203) bbTranslateEntity camera,-2,0,0
	If bbKeyDown(205) bbTranslateEntity camera,+2,0,0
	If bbKeyDown(200) bbTranslateEntity camera,0,0,+2
	If bbKeyDown(208) bbTranslateEntity camera,0,0,-2
	bbUpdateWorld
	bbRenderWorld
	bbText 0,0,"HWMultiTex "+hwmt
	bbFlip
Wend
End
