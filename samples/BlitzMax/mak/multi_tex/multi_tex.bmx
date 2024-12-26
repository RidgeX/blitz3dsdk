Import blitz3d.blitz3dsdk

Import "bbtype.bmx"
Import "blitz3d.bmx"

bbBeginBlitz3D()

Global info1$="Multitexturing demo"

Include "../start.bmx"

bbAmbientLight 0,0,0

'Load base texture
logo=bbLoadTexture( "blitzlogo.bmp" )

'create next grid texture
grid=bbCreateTexture( 64,64,0 )
bbScaleTexture grid,.5,.5
bbSetBuffer bbTextureBuffer( grid )
bbColor 255,255,255;bbRect 0,0,32,32
bbColor 128,128,128;bbRect 32,0,32,32
bbColor 128,128,128;bbRect 0,32,32,32
bbColor 255,255,255;bbRect 32,32,32,32
bbColor 0,0,255
bbSetBuffer bbBackBuffer()
bbColor 255,255,255

'load top environment texture
env=bbLoadTexture( "spheremap.bmp",67 )

'create cube
cube=bbCreateCube()
bbEntityTexture cube,logo,0,0
bbEntityTexture cube,grid,0,1
bbEntityTexture cube,env,0,2
bbUpdateNormals cube

camera=bbCreateCamera()
bbPositionEntity camera,0,0,-4

light=bbCreateLight()
bbTurnEntity light,45,45,0
bbLightColor light,255,0,0

light=bbCreateLight()
bbTurnEntity light,-45,45,0
bbLightColor light,0,255,0

light=bbCreateLight()
bbTurnEntity light,45,-45,0
bbLightColor light,0,0,255

'hw=True
'HWMultiTex hw

blend1=2
blend2=2
blend3=1
bbTextureBlend logo,blend1
bbTextureBlend grid,blend2
bbTextureBlend env,blend3

While Not bbKeyHit(1)
	If bbKeyHit(59)
		blend1=blend1+1
		If blend1=4 blend1=0
		bbTextureBlend logo,blend1
	EndIf
	If bbKeyHit(60)
		blend2=blend2+1
		If blend2=4 blend2=0
		bbTextureBlend grid,blend2
	EndIf
	If bbKeyHit(61)
		blend3=blend3+1
		If blend3=4 blend3=0
		bbTextureBlend env,blend3
	EndIf
	If bbKeyHit(57)
		hw=Not hw
		bbHWMultiTex hw
	EndIf
	If bbKeyDown(30)
		bbTranslateEntity camera,0,0,.1
	EndIf
	If bbKeyDown(44)
		bbTranslateEntity camera,0,0,-.1
	EndIf

	off#=off#-.01
	bbPositionTexture logo,off,0
	
	bbTurnEntity cube,.1,.2,.3
	
	bbUpdateWorld
	bbRenderWorld
	
	bbText 0,bbFontHeight()*0,"(F1) TextureBlend 1="+mode$(blend1)
	bbText 0,bbFontHeight()*1,"(F2) TextureBlend 2="+mode$(blend2)
	bbText 0,bbFontHeight()*2,"(F3) TextureBlend 3="+mode$(blend3)
	If hw t$="On" Else t$="Off"
	bbText 0,bbFontHeight()*4,"(SPC) HW Multitexture="+t$
	
	bbFlip
Wend

End

Function mode$( mode )
	Select mode
	Case 0;Return "0 (Off)"
	Case 1;Return "1 (Alpha)"
	Case 2;Return "2 (Multiply)"
	Case 3;Return "3 (Add)"
	End Select
	Return "Unkown"
End Function
