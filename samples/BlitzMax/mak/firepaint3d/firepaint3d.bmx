Import blitz3d.blitz3dsdk

Import "bbtype.bmx"
Import "blitz3d.bmx"

bbBeginBlitz3D()

Global Frag_list:TList=New TList

Global info1$="Firepaint3D Demo"
Global info2$="Features dynamically colored sprites"

Include "../start.bmx"

bbAmbientLight 0,0,0

Const grav#=-.02
Const intensity=5

Type bbFrag Extends TBBType

	Method New()
		Add(Frag_list)
	End Method

	Method After:bbFrag()
		Local t:TLink
		t=_link.NextLink()
		If t Return bbFrag(t.Value())
	End Method

	Method Before:bbFrag()
		Local t:TLink
		t=_link.PrevLink()
		If t Return bbFrag(t.Value())
	End Method

	Field ys#,alpha#
	Field entity
End Type

pivot=bbCreatePivot()

camera=bbCreateCamera( pivot )
'bbCameraClsMode camera,False,True

'create blitzlogo 'cursor'
cursor=bbCreateSphere( 8,camera )
bbEntityTexture cursor,bbLoadTexture( "blitzlogo.bmp",3 )
bbMoveEntity cursor,0,0,25
bbEntityBlend cursor,3
bbEntityFX cursor,1

'create sky sphere
sky=bbCreateSphere()
tex=bbLoadTexture( "stars.bmp" )
bbScaleTexture tex,.125,.25
bbEntityTexture sky,tex
bbScaleEntity sky,500,500,500
bbEntityFX sky,1
bbFlipMesh sky

spark=bbLoadSprite( "bluspark.bmp" )

time=MilliSecs()

bbMoveMouse 0,0
bbHidePointer 

While Not bbKeyDown(1)

	Repeat
		elapsed=MilliSecs()-time
	Until elapsed>5

	time=time+elapsed
	dt#=elapsed*60.0/1000.0
	
	Local x_speed#,y_speed#
	
	x_speed=(bbMouseXSpeed()-x_speed)/4+x_speed
	y_speed=(bbMouseYSpeed()-y_speed)/4+y_speed
	bbMoveMouse 320,240

	bbTurnEntity pivot,0,-x_speed,0	'turn player left/right
	bbTurnEntity camera,-y_speed,0,0	'tilt camera
	bbTurnEntity cursor,0,dt*5,0
	
	If bbMouseDown(1)
		For t=1 To intensity
			f:bbFrag=New bbFrag
			f.ys=0
			f.alpha=Rnd(2,3)
			f.entity=bbCopyEntity( spark,cursor )
			bbEntityColor f.entity,Rnd(255),Rnd(255),Rnd(255)
			bbEntityParent f.entity,0
			bbRotateEntity f.entity,Rnd(360),Rnd(360),Rnd(360)
			num=num+1
		Next
	EndIf
	
	For f:bbFrag=EachIn Frag_list
		f.alpha=f.alpha-dt*.02
		If f.alpha>0
			al#=f.alpha
			If al>1 Then al=1
			bbEntityAlpha f.entity,al
			bbMoveEntity f.entity,0,0,dt*.4
			ys#=f.ys+grav*dt
			dy#=f.ys*dt
			f.ys=ys
			bbTranslateEntity f.entity,0,dy,0
		Else
			bbFreeEntity f.entity
			f.entity=0
			num=num-1
		EndIf
	Next

	bbUpdateWorld 1.0
	bbRenderWorld 1.0
	bbFlip
Wend

End
