Import blitz3d.blitz3dsdk

Import "bbtype.bmx"
Import "blitz3d.bmx"

bbBeginBlitz3D

Global Explosion_list:TList=New TList
Global Bullet_list:TList=New TList
Global Bomb_list:TList=New TList
Global Player_list:TList=New TList
Global Alien_list:TList=New TList

Global info1$="Insectoids!"
Global info2$="Features texturing of 2D graphics"

Include "../start.bmx"

image=bbCreateImage( 256,256 )

texture=bbCreateTexture( 256,256 )

cube=bbCreateCube()
bbEntityTexture cube,texture
bbEntityFX cube,1

cube2=bbCopyEntity( cube )
bbPositionEntity cube2,-2,0,0
bbScaleEntity cube2,.5,.5,.5

cube3=bbCopyEntity( cube )
bbPositionEntity cube3,2,0,0
bbScaleEntity cube3,.5,.5,.5

camera=bbCreateCamera()
bbPositionEntity camera,0,0,-3
bbCameraClsColor camera,0,0,64

bbAmbientLight 255,255,255

Global buffer=bbImageBuffer( image )

Const width=256,height=256,num_rots=64

Global alien_rots[num_rots+1]

Global game_state,game_timer,level_name$,alien_speed
Global num_aliens,num_flying,fly_timer,num_bulls,num_players
Global c_x#,c_y#,c_xs#,c_ys#,c_dir#,c_phase#,rev_dir,c_speed#,c_xsize#,c_ysize#
Global player_image,stars_image,bomb_image,bull_image,stars_scroll,boom_anim
Global mini_ship,tmp_image,insectoids_image

Global boom_sound=bbLoadSound( "sounds\boom.wav" )
Global cool_sound=bbLoadSound( "sounds\cool.wav" )
Global kazap_sound=bbLoadSound( "sounds\kazap.wav" )
Global shoot_sound=bbLoadSound( "sounds\shoot.wav" )

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

	Field x#,y#,rot,state
	Field f_x#,f_y#
	Field dest_y#,dest_rot,rot_step,bomb_cnt
End Type

Type bbPlayer Extends TBBType

	Method New()
		Add(Player_list)
	End Method

	Method After:bbPlayer()
		Local t:TLink
		t=_link.NextLink()
		If t Return bbPlayer(t.Value())
	End Method

	Method Before:bbPlayer()
		Local t:TLink
		t=_link.PrevLink()
		If t Return bbPlayer(t.Value())
	End Method

	Field x,y,state,lives,ctrl,bang,score
End Type

Type bbBomb Extends TBBType

	Method New()
		Add(Bomb_list)
	End Method

	Method After:bbBomb()
		Local t:TLink
		t=_link.NextLink()
		If t Return bbBomb(t.Value())
	End Method

	Method Before:bbBomb()
		Local t:TLink
		t=_link.PrevLink()
		If t Return bbBomb(t.Value())
	End Method

	Field x#,y#,xs#,ys#
End Type

Type bbBullet Extends TBBType

	Method New()
		Add(Bullet_list)
	End Method

	Method After:bbBullet()
		Local t:TLink
		t=_link.NextLink()
		If t Return bbBullet(t.Value())
	End Method

	Method Before:bbBullet()
		Local t:TLink
		t=_link.PrevLink()
		If t Return bbBullet(t.Value())
	End Method

	Field x,y
End Type

Type bbExplosion Extends TBBType

	Method New()
		Add(Explosion_list)
	End Method

	Method After:bbExplosion()
		Local t:TLink
		t=_link.NextLink()
		If t Return bbExplosion(t.Value())
	End Method

	Method Before:bbExplosion()
		Local t:TLink
		t=_link.PrevLink()
		If t Return bbExplosion(t.Value())
	End Method

	Field x,y,frame
End Type

bbSetFont bbLoadFont( "arial",12,True )

tmp_image=bbCreateImage( width,bbFontHeight() )

LoadGraphics()

game_state=0
game_timer=0

While Not bbKeyHit(1)

	UpdateGame

	bbSetBuffer buffer
	RenderGame

	bbSetBuffer bbBackBuffer()
	
	bbCopyRect 0,0,256,256,0,0,bbImageBuffer( image ),bbTextureBuffer( texture )

	If bbKeyDown(26) bbTurnEntity cube,0,-2,0
	If bbKeyDown(27) bbTurnEntity cube,0,+2,0
	
	If bbKeyDown(30) bbMoveEntity camera,0,0,.1
	If bbKeyDown(44) bbMoveEntity camera,0,0,-.1	
	
	Local p:bbPlayer
	
	If Not Player_list.isEmpty() p=bbPlayer(Player_list.First())
	If p<>Null
		bbRotateEntity cube,0,(p.x-128)/10.0,0
	Else
		bbRotateEntity cube,0,0,0
	EndIf
	bbTurnEntity cube2,-1,0,.5
	bbTurnEntity cube3,1,0,-.5
	
	bbUpdateWorld
	bbRenderWorld
	bbFlip
Wend

End

Function CreatePlayer( ctrl )
	p:bbPlayer=New bbPlayer
	p.lives=3
	p.ctrl=ctrl
	ResetPlayer( p )
	num_players=num_players+1
End Function

Function ResetPlayer( p:bbPlayer )
	p.x=width/2
	p.y=height-20
	p.state=1
End Function

Function UpdatePlayer( p:bbPlayer )

	If p.state<>1 Then Return

	Local l,r,f
	Select p.ctrl
	Case 1
		l=bbKeyDown( 203 )
		r=bbKeyDown( 205 )
		f=bbKeyHit( 57 )
	Case 2
'		jx=JoyXDir()
		If jx<0 Then l=1 Else If jx>0 Then r=1
'		f=JoyHit(1)
	End Select
	If l
		If p.x>16 Then p.x=p.x-4
	Else If r
		If p.x<width-16 Then p.x=p.x+4
	EndIf
	
	If game_state<>2 Then Return
	
	If f And num_bulls<3
		Local chan=bbPlaySound( shoot_sound )
		bbChannelVolume chan,.1
		b:bbBullet=New bbBullet
		b.x=p.x;b.y=p.y-16
		num_bulls=num_bulls+1
	EndIf

	dead=False	
	For a:bbAlien=EachIn Alien_list
		If bbImagesOverlap( player_image,p.x,p.y,alien_rots( a.rot*num_rots/360 ),a.x,a.y )
			dead=True
			Exit
		EndIf
	Next
	For bb:bbBomb=EachIn Bomb_list
		If bbImagesOverlap( player_image,p.x,p.y,bomb_image,bb.x,bb.y )
			dead=True
			Exit
		EndIf
	Next
	
	If Not dead Then Return
	
	bbPlaySound boom_sound
	
	For k=-105 To 0 Step 15
		CreateExplosion( p.x+Rnd(-10,10),p.y+Rnd(-10,10),k )
	Next
	
	p.bang=1
	p.state=2
	p.lives=p.lives-1
	game_state=3
	
End Function

Function RenderPlayer( p:bbPlayer )

	bbColor 255,255,255
	bbText width/2,4,""+p.score,1

	For k=1 To p.lives
		bbDrawImage mini_ship,k*12+4,14
	Next
	
	If p.state=1
		bbDrawImage player_image,p.x,p.y
		Return
	EndIf
	
	p.bang=p.bang+8
	
	r#=p.bang
	For i=255 To 1 Step -15
		bbColor i,i,i
		For an=0 To 359 Step 6
			x=p.x+Cos(an)*r
			y=p.y+Sin(an)*r
			bbRect x,y,3,3
		Next
		r=r-6;If r<=0 Then Exit
	Next
	
End Function

Function AddPoints( p:bbPlayer,pnts )
	t=p.score/5000
	p.score=p.score+pnts
	If p.score/5000<>t Then p.lives=p.lives+1
End Function

Function UpdateBullet( b:bbBullet )
	b.y=b.y-5
		
	For a:bbAlien=EachIn Alien_list
		If bbImagesOverlap( bull_image,b.x,b.y,alien_rots( a.rot*num_rots/360 ),a.x,a.y )
			bbPlaySound kazap_sound
			If a.state=1
				pnts=25
			Else If a.state=2
				pnts=50
			Else
				pnts=100
			EndIf
			
			AddPoints( bbPlayer(Player_list.First()),pnts )
			CreateExplosion( a.x,a.y )
			b.Remove();num_bulls=num_bulls-1
			If a.state<>1 num_flying=num_flying-1
			num_aliens=num_aliens-1
			a.Remove()
			Return
		EndIf
	Next
	
	If b.y>0 Then Return
	b.Remove();num_bulls=num_bulls-1
	
End Function

Function RenderBullet( b:bbBullet )
	bbDrawImage bull_image,b.x,b.y
End Function

Function UpdateBomb( b:bbBomb )
	b.x=b.x+b.xs
	b.y=b.y+b.ys
	If b.y>height Then b.Remove()
End Function

Function RenderBomb( b:bbBomb )
	bbDrawImage bomb_image,b.x,b.y
End Function

Function UpdateAlien( a:bbAlien )

	Select a.state
	Case 1
		If a.rot<>0
			If a.rot>180 a.rot=a.rot+6 Else a.rot=a.rot-6
			If a.rot<0 Or a.rot>=360 Then a.rot=0
		EndIf
		dx=c_x+a.f_x*c_xs - a.x
		dy=c_y+a.f_y*c_ys - a.y
		If dx<-alien_speed Then dx=-alien_speed Else If dx>alien_speed Then dx=alien_speed
		If dy<-alien_speed Then dy=-alien_speed Else If dy>alien_speed Then dy=alien_speed
		a.x=a.x+dx;a.y=a.y+dy
		If c_dir<0 And a.x<16 Then rev_dir=True
		If c_dir>0 And a.x>width-16 Then rev_dir=True
	Case 2
		a.rot=a.rot+a.rot_step
		If a.rot<0 Then a.rot=a.rot+360 Else If a.rot>=360 Then a.rot=a.rot-360
		If a.rot<90 Or a.rot>270
			a.dest_rot=Rnd(180-40,180+40)
			a.dest_y=a.dest_y+Rnd( 100,300 )
			a.state=3
		EndIf
		a.x=a.x+Cos( a.rot-90 )*alien_speed
		a.y=a.y+Sin( a.rot-90 )*alien_speed
		DropBomb( a )
	Case 3		
		dr=a.rot-a.dest_rot
		If Abs(dr)>Abs(a.rot_step)
			a.rot=a.rot+a.rot_step
			If a.rot<0 Then a.rot=a.rot+360 Else If a.rot>=360 Then a.rot=a.rot-360
		EndIf
		a.x=a.x+Cos( a.rot-90 )*alien_speed
		a.y=a.y+Sin( a.rot-90 )*alien_speed
		If a.y>height
			a.x=Rnd(width/2)+width/4;a.y=0
			num_flying=num_flying-1
			a.state=1
		Else If a.y>a.dest_y
			a.rot_step=-a.rot_step
			a.state=2
		EndIf
		DropBomb( a )
	End Select
End Function

Function RenderAlien( a:bbAlien )
	bbDrawImage alien_rots( a.rot*num_rots/360 ),a.x,a.y
End Function

Function UpdateExplosion( e:bbExplosion )
	e.frame=e.frame+1
	If e.frame=18 Then e.Remove()
End Function

Function RenderExplosion( e:bbExplosion )
	If e.frame<0 Then Return
	bbDrawImage boom_anim,e.x,e.y,e.frame/3
End Function

Function CreateExplosion( x,y,frame=0 )
	e:bbExplosion=New bbExplosion
	e.x=x;e.y=y;e.frame=frame
End Function

Function DropBomb( a:bbAlien )
	If a.bomb_cnt=0 Then a.bomb_cnt=Rnd(50,100)
	a.bomb_cnt=a.bomb_cnt-1
	If a.bomb_cnt>0 Then Return
	p:bbPlayer=bbPlayer(Player_list.First())
	If p=Null Then Return
	b:bbBomb=New bbBomb
	b.x=a.x
	b.y=a.y
	If a.x<p.x Then b.xs=1 Else b.xs=-1
	b.ys=4
End Function

Function UpdateFormation()

	c_phase=(c_phase+c_speed)Mod 360
	t#=Sin( c_phase )*.5+.5
	c_xs=t*c_xsize+1;c_ys=t*c_ysize+1
	
	If game_state<>1 Then c_x=c_x+c_dir
	
End Function

Function UpdateFlyTimer()

	If num_aliens>3
		If fly_timer=0 Then fly_timer=600
		fly_timer=fly_timer-1
		If fly_timer>120 Then Return
		If fly_timer Mod 30<>0 Then Return
	EndIf
	
	n=Rnd( num_aliens-num_flying )
	
	For a:bbAlien=EachIn Alien_list
		If a.state=1
			If n=0
				a.dest_y=a.y
				a.rot_step=3;If Rnd(1)<.5 Then a.rot_step=-3
				num_flying=num_flying+1
				a.state=2
				Return
			EndIf
			n=n-1
		EndIf
	Next
End Function

Function UpdateGame()

	Select game_state
	Case 0
		game_timer=game_timer+1
		If bbKeyHit(57) Then BeginGame()
	Case 1
		game_timer=game_timer+1
		If game_timer=150 Then game_state=2
		UpdateFormation()
	Case 2
		UpdateFlyTimer()
		UpdateFormation()
		If num_aliens=0 Then BeginLevel()
	Case 3
		UpdateFormation()
		If num_flying=0 And bbExplosion(Explosion_list.First())=Null
			p:bbPlayer=bbPlayer(Player_list.First())
			If p.lives>0
				ResetPlayer( p )
				game_state=2
				bbFlushKeys
			Else
				game_state=4
				game_timer=0
			EndIf
		EndIf
	Case 4
		UpdateFlyTimer()
		UpdateFormation()
		game_timer=game_timer+1
		If game_timer=150 Then EndGame()
	End Select
	
	rev_dir=False
	For a:bbAlien=EachIn Alien_list
		UpdateAlien( a )
	Next
	If rev_dir Then c_dir=-c_dir
	
	For bb:bbBomb=EachIn Bomb_list
		UpdateBomb( bb )
	Next
	
	For p:bbPlayer=EachIn Player_list
		UpdatePlayer( p )
	Next
	
	For b:bbBullet=EachIn Bullet_list
		UpdateBullet( b )
	Next
	
	For e:bbExplosion=EachIn Explosion_list
		UpdateExplosion( e )
	Next
End Function

Function RenderGame()

	bbTileBlock stars_image,0,stars_scroll
	bbTileImage stars_image,7,stars_scroll*2
	bbTileImage stars_image,23,stars_scroll*3
	stars_scroll=(stars_scroll+1) Mod bbImageHeight( stars_image )
	
	For a:bbAlien=EachIn Alien_list
		RenderAlien( a )
	Next
	
	For bb:bbBomb=EachIn Bomb_list
		RenderBomb( bb )
	Next
	
	For p:bbPlayer=EachIn Player_list
		RenderPlayer( p )
	Next
	
	For b:bbBullet=EachIn Bullet_list
		RenderBullet( b )
	Next
	
	For e:bbExplosion=EachIn Explosion_list
		RenderExplosion( e )
	Next
	
	Select game_state
	Case 0
		bbDrawImage insectoids_image,width/2,height/3
		If game_timer<150 Or (game_timer-150) Mod 80<40
			bbColor 255,255,255;TitleText( "PRESS SPACE TO START",width/2,height-bbFontHeight()*2,game_timer )
		EndIf
	Case 1
		Rainbow( game_timer*5 )
		TitleText( level_name$,width/2,height/2,game_timer*2 )
	Case 4
		bbColor 255,255,255
		bbText width/2,height/2,"GAME OVER",1,1
	End Select
	
End Function

Function TitleText( txt$,x,y,time )
	n=0
	If time<100 Then n=100-time
	If n=1
		bbText x,y,txt$,1,1
	Else
		ExplodeText( x,y,txt$,n*.5+1,n+1 )
	EndIf
End Function

Function LoadGraphics()

	bbAutoMidHandle True
	
	stars_image=bbLoadImage( "graphics\stars.bmp" )
	player_image=bbLoadImage( "graphics\player.bmp" );bbScaleImage player_image,.5,.5
	mini_ship=bbCopyImage( player_image );bbScaleImage mini_ship,.4,.4
	bull_image=bbLoadImage( "graphics\bullet.bmp" );bbScaleImage bull_image,.25,.5
	bomb_image=bbLoadImage( "graphics\bbomb.bmp" );bbScaleImage bomb_image,.3,.3
	boom_anim=bbLoadAnimImage( "graphics\kaboom.bmp",60,48,0,6 )
	insectoids_image=bbLoadImage( "graphics\insectoids_logo.bmp" )
	bbResizeImage insectoids_image,256,64
	bbResizeImage boom_anim,8,8;bbResizeImage boom_anim,16,16
	i=bbLoadImage( "graphics\alien.bmp" );bbScaleImage i,.3,.3
	For k=0 To num_rots-1
		alien_rots(k)=bbCopyImage( i )
		bbRotateImage alien_rots(k),k*360/num_rots
	Next
End Function

Function BeginLevel()

	bbPlaySound cool_sound
	
	ReadData level_name$
	If level_name$=""
		RestoreData levels
		ReadData level_name$
		alien_speed=alien_speed+1
		If alien_speed>6 Then alien_speed=6
	EndIf
	
	c_x=width/2;c_y=height/4;c_phase=0;c_dir=1
	
	ReadData c_speed,c_xsize,c_ysize
	
	Repeat
		ReadData x
		If x=999 Then Exit
		ReadData y,cnt
		For k=1 To cnt
			a:bbAlien=New bbAlien
			a.x=c_x
			a.y=c_y
			a.rot=0
			a.state=1
			a.f_x=x*16
			a.f_y=y*12
			x=x+1
		Next
		num_aliens=num_aliens+cnt
	Forever

	game_state=1
	game_timer=0
	
End Function

Function BeginGame()
	
	level=0
	num_bulls=0
	num_aliens=0
	num_flying=0
	game_state=0
	num_players=0
	alien_speed=3
	
	CreatePlayer( 1 )
	
	RestoreData levels
	
	BeginLevel()
	
	bbFlushKeys
	
End Function

Function EndGame()

	DeleteEach bb32
	DeleteEach bb32
	DeleteEach bb32
	DeleteEach bb32

	game_state=0
	game_timer=0

	bbFlushKeys

End Function

Function Rainbow( time )
	r=time Mod 768;If r>255 Then r=511-r
	g=(time+256)Mod 768;If g>255 Then g=511-g
	b=(time+512) Mod 768;If b>255 Then b=511-b
	If r<0 Then r=0
	If g<0 Then g=0
	If b<0 Then b=0
	bbColor r,g,b
End Function

Function ExplodeText( x,y,txt$,xn#,yn# )
	w=bbStringWidth( txt$ )
	h=bbFontHeight()
	bbSetBuffer bbImageBuffer( tmp_image )
	bbCls;bbText 0,0,txt$
	bbSetBuffer buffer
	For ty=0 To h-1 Step 4
		For tx=0 To w-1 Step 4
			xo#=(tx-w/2)*xn
			yo#=(ty-h/2)*yn
			bbDrawImageRect tmp_image,x+xo,y+yo,tx,ty,4,4
		Next
	Next
End Function

#levels

DefData "LEVEL 1"
DefData 1,.25,0
DefData -2,-2,5
DefData -3,-1,7
DefData -3,0,7
DefData -3,1,7
DefData -3,2,7
DefData 999

DefData "LEVEL 2"
DefData 1,.25,.25
DefData 0,-2,1
DefData -1,-1,3
DefData -2,0,5
DefData -3,1,7
DefData -4,2,9
DefData -5,3,11
DefData 999

DefData "LEVEL 3"
DefData 3,.25,.5
DefData -5,-2,11
DefData -4,-1,9
DefData -3,0,7
DefData -4,1,9
DefData -5,2,11
DefData 999

DefData "LEVEL 4"
DefData 2,0,1
DefData -5,-1,11
DefData -5,0,11
DefData -5,1,11
DefData -5,2,11
DefData -5,3,11
DefData -5,4,11
DefData -5,5,11
DefData 999

DefData "LEVEL 5"
DefData 1,.25,.125
DefData -3,-2,7
DefData -4,-1,9
DefData -5,0,11
DefData -5,1,11
DefData -5,2,11
DefData -5,3,11
DefData -5,4,11
DefData -5,5,11
DefData -5,6,11
DefData -5,7,11
DefData 999

DefData "LEVEL 6"
DefData 1,.25,.125
DefData -7,-2,15
DefData -7,-1,15
DefData -7,0,15
DefData -7,1,15
DefData -7,2,15
DefData -7,3,15
DefData -7,4,15
DefData -7,5,15
DefData -7,6,15
DefData -7,7,15
DefData -7,8,15
DefData -7,9,15
DefData -7,10,15
DefData -7,11,15
DefData 999

DefData ""
