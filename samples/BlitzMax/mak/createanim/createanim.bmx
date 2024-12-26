Import blitz3d.blitz3dsdk

Import "bbtype.bmx"
Import "blitz3d.bmx"

bbBeginBlitz3D()


Global info1$="Manual animation creation demo"
Global info2$="Hit <return> to swap between sequences"
Global info3$="Hit <space> to toggle transitions"

Include "../start.bmx"

tex=bbCreateTexture( 64,64 )
bbSetBuffer bbTextureBuffer( tex )
bbColor 255,0,0;bbRect 0,0,32,32;bbRect 32,32,32,32
bbColor 255,128,0;bbRect 32,0,32,32;bbRect 0,32,32,32
bbSetBuffer bbBackBuffer()
bbColor 255,255,255

cube=bbCreateCube()
bbEntityTexture cube,tex

'set animation keys
bbRotateEntity cube,0,0,0
bbPositionEntity cube,0,0,0
bbSetAnimKey cube,0

bbRotateEntity cube,0,90,0
bbPositionEntity cube,0,0,10
bbSetAnimKey cube,60

bbRotateEntity cube,0,180,0
bbPositionEntity cube,10,0,10
bbSetAnimKey cube,120

bbRotateEntity cube,0,270,0
bbPositionEntity cube,10,0,0
bbSetAnimKey cube,180

bbRotateEntity cube,0,0,0
bbPositionEntity cube,0,0,0
bbSetAnimKey cube,240

'create animation sequence 0
bbAddAnimSeq cube,240

'set animation keys
bbScaleEntity cube,1,1,1
bbPositionEntity cube,5,0,5
bbSetAnimKey cube,0

bbScaleEntity cube,5,1,1
bbSetAnimKey cube,30

bbScaleEntity cube,1,1,1
bbSetAnimKey cube,60

bbScaleEntity cube,1,5,1
bbSetAnimKey cube,90

bbScaleEntity cube,1,1,1
bbSetAnimKey cube,120

bbAddAnimSeq cube,120

camera=bbCreateCamera()
bbPositionEntity camera,5,3,-10

light=bbCreateLight()
bbTurnEntity light,45,45,0

bbAnimate cube

bbFlushKeys

trans=20

While Not bbKeyHit(1)

	If bbKeyHit(57) trans=20-trans

	If bbKeyHit(28) bbAnimate cube,1,1,1-bbAnimSeq(cube),trans
		
	bbUpdateWorld
	bbRenderWorld
	bbText 0,bbFontHeight()*0,"Anim seq: "+bbAnimSeq( cube )
	bbText 0,bbFontHeight()*1,"Anim len: "+bbAnimLength( cube )
	bbText 0,bbFontHeight()*2,"Anim time:"+bbAnimTime( cube )
	bbText 0,bbFontHeight()*4,"Transition time:"+trans
	
	bbFlip
Wend

End
