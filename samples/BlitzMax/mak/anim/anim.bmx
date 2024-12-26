Import blitz3d.blitz3dsdk

Import "bbtype.bmx"
Import "blitz3d.bmx"

bbBeginBlitz3D

Global info1$="Animation demo"
Global info2$="Hold down <return> to run"
Global info3$="Hit <space> to toggle transitions"

Include "../start.bmx"

mesh_3ds=bbLoadAnimMesh( "makbot\mak_robotic.3ds" )	'anim seq 0
bbLoadAnimSeq mesh_3ds,"makbot\mak_running.3ds"		'anim seq 1
bbPositionEntity mesh_3ds,-15,-15,0

mesh_x=bbLoadAnimMesh( "makbot\mak_robotic.x" )		'anim seq 0
bbLoadAnimSeq mesh_x,"makbot\mak_running.x"			'anim seq 1
bbPositionEntity mesh_x,+15,-15,0

pivot=bbCreatePivot()
cam=bbCreateCamera( pivot )
bbPositionEntity cam,0,0,-100

lit=bbCreateLight()
bbRotateEntity lit,45,45,0

bbAnimate mesh_3ds,2	'start ping-pong anims...
bbAnimate mesh_x,  2

trans=10

While Not bbKeyHit(1)

	If bbKeyHit(57)
		trans=10-trans
	EndIf

	If bbKeyDown(28)
		If bbAnimSeq(mesh_3ds)=0 bbAnimate mesh_3ds,1,.5,1,trans
		If bbAnimSeq(mesh_x  )=0 bbAnimate mesh_x,  1,.5,1,trans
	Else
		If bbAnimSeq(mesh_3ds)=1 bbAnimate mesh_3ds,2,1,0,trans
		If bbAnimSeq(mesh_x  )=1 bbAnimate mesh_x  ,2,1,0,trans
	EndIf
	
	If bbKeyDown(30) bbMoveEntity cam,0,0,10
	If bbKeyDown(44) bbMoveEntity cam,0,0,-10
	
	If bbKeyDown(203) bbTurnEntity pivot,0,3,0
	If bbKeyDown(205) bbTurnEntity pivot,0,-3,0

	bbUpdateWorld
	bbRenderWorld
	bbText 0,bbFontHeight()*0,"Anim seq: "+bbAnimSeq( mesh_3ds )
	bbText 0,bbFontHeight()*1,"Anim len: "+bbAnimLength( mesh_3ds )
	bbText 0,bbFontHeight()*2,"Anim time:"+bbAnimTime( mesh_3ds )
	
	bbText 0,bbFontHeight()*4,"Anim seq: "+bbAnimSeq( mesh_x )
	bbText 0,bbFontHeight()*5,"Anim len: "+bbAnimLength( mesh_x )
	bbText 0,bbFontHeight()*6,"Anim time:"+bbAnimTime( mesh_x )
	
	bbText 0,bbFontHeight()*8,"Transition time="+trans
	bbFlip
	
Wend

End
