// blitz3dsdkexamples.cpp

// this code is used by both the consoledemo and windowsdemo projects
// and demonstrates a variety of example programs utilizing blitz3dsdk

#pragma warning( disable:4244 )	//disable float conversion warnings
#pragma warning( disable:4305 )	//disable double to float truncation warning

#include <math.h>
#include <stdio.h>
#include <stdlib.h>

#include "../../include/blitz3dsdk.h"

void insaner();
void xfighter();
void audiotest();
void timertest();
void teapottest();
void flagtest();
void dragontest();
void collidetest();
void animtest();
void timertest();
void movietest();
void firepaint();
void playtron();
void test1();

// *********************** insaner ********************************

void insaner(){
	const char *insanerinfo="Insaner demo!\nArrow keys pan, A/Z zoom\nspace to toggle hardware multitexturing\nFeatures multitextured dynamic LOD terrain\n";

	printf(insanerinfo);

	bbGraphics3D(960,540,0,2);

	BBTerrain terrain=bbLoadTerrain( "media/insaner/hmap.bmp" );
	bbTerrainDetail(terrain,500,BBTRUE);
	bbPositionEntity(terrain,-128,0,-128);
	bbScaleEntity(terrain,1,50,1);
	bbEntityFX(terrain,1);

	//setup multitexturing:
	//dest=( ( (rock-grass) * track ) + grass ) * lighting

	BBTexture tex0=bbLoadTexture( "media/insaner/CrackedStone_diff.bmp" );
	bbScaleTexture(tex0,16,16);
	BBTexture tex1=bbLoadTexture( "media/insaner/track.bmp" );
	bbScaleTexture(tex1,256,256);
	BBTexture tex2=bbLoadTexture( "media/insaner/MossyGround.bmp" );
	bbScaleTexture(tex2,16,16);
	bbTextureBlend(tex2,3);
	BBTexture tex3=bbLoadTexture( "media/insaner/lmap.bmp" );
	bbScaleTexture(tex3,256,256);

	bbEntityTexture(terrain,tex0,0,0);
	bbEntityTexture(terrain,tex1,0,1);
	bbEntityTexture(terrain,tex2,0,2);
	bbEntityTexture(terrain,tex3,0,3);

	BBCamera camera=bbCreateCamera();
	bbPositionEntity(camera,0,200,0);
	bbRotateEntity(camera,90,0,0);

	int hwmt=BBTRUE;
	int wire=BBFALSE;
	
	bbHWMultiTex(hwmt);

	while(!bbKeyHit(1)){
		if(bbKeyHit(17)) {wire=!wire;bbWireFrame(wire);}
		if(bbKeyHit(57)) {hwmt=!hwmt;bbHWMultiTex(hwmt);}
		if(bbKeyDown(30)) bbTranslateEntity(camera,0,-2,0);
		if(bbKeyDown(44)) bbTranslateEntity(camera,0,+2,0);
		if(bbKeyDown(203)) bbTranslateEntity(camera,-2,0,0);
		if(bbKeyDown(205)) bbTranslateEntity(camera,+2,0,0);
		if(bbKeyDown(200)) bbTranslateEntity(camera,0,0,+2);
		if(bbKeyDown(208)) bbTranslateEntity(camera,0,0,-2);
		bbUpdateWorld();
		bbRenderWorld();
//		bbText(0,0,"HWMultiTex ",hwmt);
		bbFlip();
	}
}

// *********************** xfighter *******************************

struct xplayer{
	BBEntity entity;
	BBCamera camera;
	int ctrl_mode,cam_mode,ignition;
	float pitch,yaw,pitch_speed,yaw_speed,roll,thrust;
	xplayer *next;
};
xplayer *xplayerlist=0;


BBTerrain CreateXScene();
BBPivot LoadXPlane(const char *file);
xplayer *CreateXPlayer( BBPivot plane,int vp_x,int vp_y,int vp_w,int vp_h,int ctrl_mode,BBTerrain terr );
void UpdateXPlayers();

void xfighter(){
	const char *xfighterinfo="Terrain demo\nArrows/A/Z move, F1-F4 change camera\nW toggle wireframe, M toggle morphing\n[ and ] alter detail level\n";

	printf(xfighterinfo);

	bbGraphics3D(960,540,0,6);
//	bbGraphics3D( 640,480,32,1 );

	bbAntiAlias(BBTRUE);

	bbCollisions(1,10,2,2);	//sphere-to-polygon, colliding collisions

	BBTerrain terr=CreateXScene();

	BBPivot plane=LoadXPlane("media/xfighter/biplane.x");
	
	xplayer *player1=CreateXPlayer(plane,0,0,bbGraphicsWidth(),bbGraphicsHeight(),1,terr);

	const float FPS=30;

	int period=1000/FPS;
	int time=bbMilliSecs()-period;

	int detail=2000;
	int morph=1;
	bbTerrainDetail(terr,detail,morph);

	int wire=0;

	while(!bbKeyHit(1)){
		int elapsed;
		do{
			elapsed=bbMilliSecs()-time;
		}while (elapsed==0);

//		how many 'frames' have elapsed	

		int ticks=(int)elapsed/period;

//	tween based render

		float tween=float(elapsed%period)/float(period);
		for(int k=1;k<=ticks;k++){
			if(k==ticks) bbCaptureWorld();
			time=time+period;
			UpdateXPlayers();
			bbUpdateWorld();
		}

//	UpdateXPlayers();
//	bbUpdateWorld();
//	float tween=0.0;

		if(bbKeyHit(17)){
			wire=!wire;
			bbWireFrame(wire);
		}
		if(bbKeyHit(26)){
			detail=detail-100;
			if(detail<100)detail=100;
			bbTerrainDetail(terr,detail,morph);
		}else if (bbKeyHit(27)){
			detail=detail+100;
			if(detail>10000)detail=10000;
			bbTerrainDetail(terr,detail,morph);
		}

		if(bbKeyHit(50)){
			morph=!morph;
			bbTerrainDetail(terr,detail,morph);
		}

		bbRenderWorld(tween);

		bbColor(255,0,0);
		char *t;

		if(morph) t="Y";else t="N";

//		bbText(0,0,"Detail:"+detail+" Morph:"+t$);

		bbFlip();
	}
}

void UpdateXPlayers(){
	xplayer *p;
	for(p=xplayerlist;p;p=p->next){
		int x_dir=0,y_dir=0,z_dir=0;
		switch (p->ctrl_mode){
			case 1:
				if(bbKeyDown(203)) x_dir=-1;
				if(bbKeyDown(205)) x_dir=1;
				
				if(bbKeyDown(200)) y_dir=-1;
				if(bbKeyDown(208)) y_dir=1;
				
				if(bbKeyDown(30)) z_dir=1;
				if(bbKeyDown(44)) z_dir=-1;
				
				if(bbKeyHit(59)) p->cam_mode=1;
				if(bbKeyHit(60)) p->cam_mode=2;
				if(bbKeyHit(61)) p->cam_mode=3;
				if(bbKeyHit(62)) p->cam_mode=4;
				break;
			
			case 2:
				x_dir=bbJoyXDir();
				y_dir=bbJoyYDir();
				if(bbJoyDown(1)) z_dir=1;
				if(bbJoyDown(2)) z_dir=-1;
				
				if(bbKeyHit(63)) p->cam_mode=1;
				if(bbKeyHit(64)) p->cam_mode=2;
				if(bbKeyHit(65)) p->cam_mode=3;
				if(bbKeyHit(66)) p->cam_mode=4;			
				break;
		}
		
		if(x_dir<0){
			p->yaw_speed=p->yaw_speed + (4-p->yaw_speed)*.04;
		}else {
			if(x_dir>0){
				p->yaw_speed=p->yaw_speed + (-4-p->yaw_speed)*.04;
			}else{
				p->yaw_speed=p->yaw_speed + (-p->yaw_speed)*.02;
			}
		}
			
		if(y_dir<0){
			p->pitch_speed=p->pitch_speed + (2-p->pitch_speed)*.2;
		}else{
			if(y_dir>0){
				p->pitch_speed=p->pitch_speed + (-2-p->pitch_speed)*.2;
			}else{
				p->pitch_speed=p->pitch_speed + (-p->pitch_speed)*.1;
			}
		}
			
		p->yaw=p->yaw+p->yaw_speed;
		if(p->yaw<-180) p->yaw=p->yaw+360;
		if(p->yaw>=180) p->yaw=p->yaw-360;
		
		p->pitch=p->pitch+p->pitch_speed;
		if(p->pitch<-180) p->pitch=p->pitch+360;
		if(p->pitch>=180) p->pitch=p->pitch-360;
			
		p->roll=p->yaw_speed*30;
		bbRotateEntity(p->entity,p->pitch,p->yaw,p->roll);

		if(p->ignition){
			if(z_dir>0){			//faster?
				p->thrust=p->thrust + (1.5-p->thrust)*.04;	//	'1.5
			}else{
				if(z_dir<0){		//slower?
					p->thrust=p->thrust + (-p->thrust)*.04;
				}
			}
			bbMoveEntity(p->entity,0,0,p->thrust);
		}else{
			if(z_dir>0)p->ignition=1;
		}
		
		if(p->camera){
			switch(p->cam_mode){
				case 1:
					bbEntityParent(p->camera,p->entity);
					bbRotateEntity(p->camera,0,p->yaw,0,BBTRUE);
					bbPositionEntity(p->camera,bbEntityX(p->entity),bbEntityY(p->entity),bbEntityZ(p->entity),BBTRUE);
					bbMoveEntity(p->camera,0,1,-5);
					bbPointEntity(p->camera,p->entity,p->roll/2);
					break;
				case 2:
					bbEntityParent(p->camera,0);
					bbPositionEntity(p->camera,bbEntityX(p->entity),bbEntityY(p->entity),bbEntityZ(p->entity));
					bbTranslateEntity(p->camera,0,1,-5);
					bbPointEntity(p->camera,p->entity,0);
					break;
				case 3:
					bbEntityParent(p->camera,p->entity);
					bbPositionEntity(p->camera,0,.25,0);
					bbRotateEntity(p->camera,0,0,0);
					break;
				case 4:
					bbEntityParent(p->camera,0);
					bbPointEntity(p->camera,p->entity,0);
					break;
			}
		}
	}
}

BBPivot LoadXPlane(const char *file){
	BBPivot pivot=bbCreatePivot();
	BBMeshModel plane=bbLoadMesh( file,pivot );
	bbScaleMesh(plane,.125,.25,.125);	//make it more spherical!
	bbRotateEntity(plane,0,180,0);		//and align to z axis
	bbEntityRadius(pivot,1);
	bbEntityType(pivot,1);
	bbHideEntity(pivot);
	return pivot;
}

xplayer *CreateXPlayer( BBPivot plane,int vp_x,int vp_y,int vp_w,int vp_h,int ctrl_mode,BBTerrain terr ){
	xplayer *p=new xplayer;
	p->next=xplayerlist;
	xplayerlist=p;
	p->ctrl_mode=ctrl_mode;
	p->cam_mode=1;
	float x=ctrl_mode*10;
	float z=ctrl_mode*10-2500;
	p->entity=bbCopyEntity( plane );
	p->ignition=0;
	p->pitch=0.0f;
	p->yaw=0.0f;
	p->pitch_speed=0.0f;
	p->yaw_speed=0.0f;
	p->roll=0.0f;

	p->thrust=0.0f;	bbPositionEntity(p->entity,x,bbTerrainY( terr,x,0,z )+50,z);
	bbRotateEntity(p->entity,0,180,0);
	bbResetEntity(p->entity);
	p->camera=bbCreateCamera( p->entity );
	bbPositionEntity(p->camera,0,3,-10);
	bbCameraViewport(p->camera,vp_x,vp_y,vp_w,vp_h);
	bbCameraClsColor(p->camera,0,192,255);
	bbCameraFogColor(p->camera,0,192,255);
	bbCameraFogRange(p->camera,1000,3000);
	bbCameraRange(p->camera,1,3000);
//	CameraZoom p\camera,1.5
//	if(use_fog) bbCameraFogMode(p->camera,1);
	return p;
}

BBTerrain CreateXScene(){
	//setup lighting
	BBLight l=bbCreateLight();
	bbRotateEntity(l,45,45,0);
	bbAmbientLight(32,32,32);
	
	//Load terrain
	BBTerrain terr=bbLoadTerrain( "media/xfighter/hmap_1024.bmp" );
	bbScaleEntity(terr,20,800,20);
	bbPositionEntity(terr,-20*512,0,-20*512);
	bbEntityFX(terr,1);
	bbEntityType(terr,10);

	//apply textures to terrain	
	BBTexture tex1=bbLoadTexture( "media/xfighter/coolgrass2.bmp",1 );
	bbScaleTexture(tex1,10,10);
	BBTexture tex2=bbLoadTexture( "media/xfighter/lmap_256.bmp" );
	bbScaleTexture(tex2,bbTerrainSize(terr),bbTerrainSize(terr));
	bbEntityTexture(terr,tex1,0,0);
	bbEntityTexture(terr,tex2,0,1);
	
	//and ground plane
	BBPlaneModel plane=bbCreatePlane();
	bbScaleEntity(plane,20,1,20);
	bbPositionEntity(plane,-20*512,0,-20*512);
	bbEntityTexture(plane,tex1,0,0);
	bbEntityOrder(plane,3);
	bbEntityFX(plane,1);
	bbEntityType(plane,10);
	
	//create cloud planes
	BBTexture tex=bbLoadTexture( "media/xfighter/cloud_2.bmp",3 );
	bbScaleTexture(tex,1000,1000);
	BBPlaneModel p=bbCreatePlane();
	bbEntityTexture(p,tex);
	bbEntityFX(p,1);
	bbPositionEntity(p,0,450,0);
	p=bbCopyEntity( p );
	bbRotateEntity(p,0,0,180);
	
	//create water plane
	BBTexture tex3=bbLoadTexture( "media/xfighter/water-2_mip.bmp",3 );
	bbScaleTexture(tex3,10,10);
	BBPlaneModel p1=bbCreatePlane();
	bbEntityTexture(p1,tex3);
	bbEntityBlend(p1,1);
	bbEntityAlpha(p1,.75);
	bbPositionEntity(p1,0,10,0);
	bbEntityFX(p1,1);

	return terr;
}

// *********************** audio test *******************************

void audiotest(){
	const char *audioinfo="Audio Demo\n";

	printf(audioinfo);

	bbPlayMusic("media\\tune1.mid");

	bbGraphics3D(960,540,0,2);

//	bbPlayMusic("shoot.wav");

//	bbPlayMusic("busy.mp3");
//	bbPlayMusic("c://home//blitz3dsdk//examples//GetBusy.mp3");

//	bbPlayCDTrack(9,3);

	bbFlip();

	BBTexture tex=bbLoadTexture( "media/castle_env.bmp",3);//128+8 );


	BBSound sound=bbLoadSound("media/lasergun.wav",0);//gameover.ogg",0);
//	gxSound *sound=bbLoadSound("busy.mp3",0);
	bbLoopSound(sound);
	bbPlaySound(sound);


//	gxSound *sound=bbLoadSound("shoot.wav",0);
//	bbLoopSound(sound);
//	gxChannel *channel=bbPlaySound(sound);
//	gxChannel *channel=bbLoopSound(sound);

//	while (channel->isPlaying()){
//		Sleep(10);
//	}

	bbCreateListener();

	BBPivot pivot=bbCreatePivot(0);

	BBMeshModel cube=bbCreateCube(pivot);
	bbPositionEntity(cube,0,0,20);

//	bbEmitSound(sound,cube);

	BBLight light=bbCreateLight(1,0);
	BBCamera camera=bbCreateCamera(0);

	bbCameraClsColor(camera,100,0,200);

	bbPositionEntity(camera,0,0,-4,1);
	while (!bbKeyHit(1)){
		bbUpdateWorld(1);
		bbRenderWorld(0);
		bbTurnEntity(pivot,0,2.0f,0);
		bbText(20,bbGraphicsHeight()-20,"Blitz3DSDK (C)2007 Blitz Research 2007",0,0);
		bbFlip(1);
	}
}

// *********************** teapot test *******************************

void teapottest(){
	const char *info="Teapot Demo\nFeatures Cubic/spherical reflection mapping\nArrows keys to pan camera\n";

	bbGraphics3D(640,480,32,2);
	
	int cube_ref=1;

//If GfxDriverCaps3D()>=110
//	If Left$(Lower$(Input$("Select (c)ubic or (s)pherical mapping :")),1)="c" cube_ref=True
//EndIf

	BBMeshModel teapot=bbLoadMesh( "media/teapot/teapot.x" );
	BBTexture tex;
	if (cube_ref){
		tex=bbLoadTexture( "media/teapot/castle_env.bmp",128+8 );
	}else{
		tex=bbLoadTexture( "media/teapot/spheremap.bmp",64+1 );
	}
	bbEntityTexture(teapot,tex,0,0);
	bbEntityFX(teapot,1);

	BBPivot cam_pivot=bbCreatePivot();
	BBCamera camera=bbCreateCamera( cam_pivot );
	bbPositionEntity(camera,0,0,-3);

	while (!bbKeyHit(1)){
		if(bbKeyDown(200)) bbTurnEntity(cam_pivot,3,0,0);
		if(bbKeyDown(208)) bbTurnEntity(cam_pivot,-3,0,0);
		if(bbKeyDown(203)) bbTurnEntity(cam_pivot,0,3,0);
		if(bbKeyDown(205)) bbTurnEntity(cam_pivot,0,-3,0);	
		bbTurnEntity(teapot,.1,.3,0);	
		bbUpdateWorld();
		bbRenderWorld();
		bbFlip();
	}
}

// *********************** flag test *******************************

const float PI=3.14159265359f;		//180 degrees

float bbSin(double f){
	return sin(f*2*PI/360.0);
}

void flagtest(){
	const char *info="Flag Demo\nFeatures mesh deformation\n";

	bbGraphics3D(640,480,32,2);

	float segs=128;
	float width=4.0;
	float depth=.125;

	BBMeshModel mesh=bbCreateMesh();
	BBSurface surf=bbCreateSurface( mesh );

	for(int k=0;k<=segs;k++){
		float x=k*width/segs-width/2;
		float u=k/segs;
		bbAddVertex(surf,x,1,0,u,0);
		bbAddVertex(surf,x,-1,0,u,1);
	}
	for(int k=0;k<segs;k++){
		bbAddTriangle(surf,k*2,k*2+2,k*2+3);
		bbAddTriangle(surf,k*2,k*2+3,k*2+1);
	}
	BBBrush b=bbLoadBrush( "media/b3dlogo.jpg" );
	bbPaintSurface(surf,b);

	BBCamera camera=bbCreateCamera();
	bbPositionEntity(camera,0,0,-5);

	BBLight light=bbCreateLight();
	bbTurnEntity(light,45,45,0);

	while(!bbKeyHit(1)){
		float ph=bbMilliSecs()/4.0;
		int cnt=bbCountVertices(surf)-1;
		for(int k=0;k<=cnt;k++){
			float x=bbVertexX(surf,k);
			float y=bbVertexY(surf,k);
			float z=bbSin(ph+x*300)*depth;
			bbVertexCoords(surf,k,x,y,z);
		}
		bbUpdateNormals(mesh);
		
		if (bbKeyDown(26)) bbTurnEntity(camera,0,1,0);
		if (bbKeyDown(27)) bbTurnEntity(camera,0,-1,0);
		if (bbKeyDown(30)) bbMoveEntity(camera,0,0,.1);
		if (bbKeyDown(44)) bbMoveEntity(camera,0,0,-.1);
		
		if (bbKeyDown(203)) bbTurnEntity(mesh,0,1,0,BBTRUE);
		if (bbKeyDown(205)) bbTurnEntity(mesh,0,-1,0,BBTRUE);
		if (bbKeyDown(200)) bbTurnEntity(mesh,1,0,0,BBTRUE);
		if (bbKeyDown(208)) bbTurnEntity(mesh,-1,0,0,BBTRUE);
		
		bbUpdateWorld();
		bbRenderWorld();
		bbFlip();
	}
}

// *********************** dragon test *****************************

void dragontest(){
	const char *info="Dragon Demo\nUse arrows keys to pan, A/Z to zoom\nMD2 Dragon model courtesy of Polycount\n";

	bbGraphics3D(640,480,32,2);


/*
;0,40  : idle
;40,46 : run
;46,54 : attack
;54,58 : paina
;58,62 : painb
;62,66 : painc
;66,72 : jump
;72,84 : flip
*/

//environment cube
	BBMeshModel cube=bbCreateCube();
	bbFitMesh(cube,-250,0,-250,500,500,500);
	bbFlipMesh(cube);
	BBTexture tex=bbLoadTexture("media/dragon/chorme-2.bmp");
	bbScaleTexture(tex,1.0/3,1.0/3);
	bbEntityTexture(cube,tex);
	bbEntityAlpha(cube,.4);
	bbEntityFX(cube,1);

	BBMirror m=bbCreateMirror();

//simple light
	BBLight light=bbCreateLight();
	bbTurnEntity(light,45,45,0);

//camera

	BBCamera camera=bbCreateCamera();
	float cam_xr=30;
	float cam_yr=0;
	float cam_zr=0;
	float cam_z=-100;

//cool dragon model!

	BBTexture tex2=bbLoadTexture( "media/dragon/dragon.bmp" );
	BBMD2Model dragon=bbLoadMD2( "media/dragon/dragon.md2" );
	bbEntityTexture(dragon,tex2);
	bbPositionEntity(dragon,0,25,0);
	bbTurnEntity(dragon,0,150,0);

	bbAnimateMD2(dragon,1,.05,0,40);

	while(!bbKeyHit(1)){
		if(bbKeyDown(203)) cam_yr=cam_yr-2;
		if(bbKeyDown(205)) cam_yr=cam_yr+2;
	
		if(bbKeyDown(200)) {
			cam_xr=cam_xr+2;
			if(cam_xr>90)cam_xr=90;
		}
		if(bbKeyDown(208)){
			cam_xr=cam_xr-2;
			if(cam_xr<5)cam_xr=5;
		}
		if(bbKeyDown(26)) cam_zr=cam_zr+2;
		if(bbKeyDown(27)) cam_zr=cam_zr-2;
	
		if(bbKeyDown(30)){
			cam_z=cam_z+1;
			if(cam_z>-10)cam_z=-10;
		}
		if(bbKeyDown(44)){
			cam_z=cam_z-1;
			if(cam_z<-180)cam_z=-180;
		}
		bbPositionEntity(camera,0,0,0);
		bbRotateEntity(camera,cam_xr,cam_yr,cam_zr);
		bbMoveEntity(camera,0,0,cam_z);

		bbUpdateWorld();
		bbRenderWorld();
		bbFlip();
	}
}

// *********************** collision test *****************************

int Rnd(int n){
	return rand()*n/RAND_MAX;
}

struct Dude{
	BBModel entity;
	float speed;
	Dude *next;
};
Dude *dudelist=0;

void collidetest(){
	const char *info="Collision demo\nArrow keys/A/Z To drive, Tab To repel";
	enum {T_DUDE=1,T_WALLS=2};

	int n_dudes=100;

	bbGraphics3D(640,480,32,0);


	bbCollisions(T_DUDE,T_DUDE,1,2);		//sphere-to-sphere, sliding collisions
	bbCollisions(T_DUDE,T_WALLS,2,2);	//sphere-to-polygon, sliding collisions

	BBMeshModel walls=bbCreateCube();
	bbEntityColor(walls,0,32,192);
	bbFitMesh(walls,-40,0,-40,80,80,80);
	bbFlipMesh(walls);
	bbEntityType(walls,T_WALLS);

	BBMeshModel col=bbCreateCube();
	bbFitMesh(col,-1,0,-1,2,40,2);
	bbEntityColor(col,255,0,0);
	bbEntityAlpha(col,.75);
	bbEntityType(col,T_WALLS);
	for(int k=30;k<360+30;k+=60){
		BBEntity t=bbCopyEntity( col );
		bbRotateEntity(t,0,k,0);
		bbMoveEntity(t,0,0,34);
	}
	bbFreeEntity(col);

	BBCamera camera=bbCreateCamera();
	bbPositionEntity(camera,0,50,-46);
	bbTurnEntity(camera,45,0,0);

	BBLight light=bbCreateLight();
	bbTurnEntity(light,45,45,0);

	BBMeshModel player=bbCreateCube();
	bbEntityColor(player,0,255,0);
	bbPositionEntity(player,0,3,0);
	bbEntityRadius(player,2);
	bbEntityType(player,T_DUDE);

	BBMeshModel nose=bbCreateCube( player );
	bbEntityColor(nose,0,255,0);
	bbScaleEntity(nose,.5,.5,.5);
	bbPositionEntity(nose,0,0,1.5);

	BBMeshModel sphere=bbCreateSphere();
	bbEntityShininess(sphere,.5);
	bbEntityType(sphere,T_DUDE);

	float an=0.0;
	float an_step=360.0/n_dudes;

	for(int k=1;k<n_dudes;k++){
		Dude *d=new Dude;
		d->entity=bbCopyEntity( sphere );//->getModel();
		bbEntityColor(d->entity,Rnd(255),Rnd(255),Rnd(255));
		bbTurnEntity(d->entity,0,an,0);
		bbMoveEntity(d->entity,0,2,37);
		bbResetEntity(d->entity);
//		d->speed=Rnd( .4,.49 );
		d->speed=.4+.0001*Rnd(900);
		d->next=dudelist;
		dudelist=d;
		an=an+an_step;
	}

	bbFreeEntity(sphere);

	int ok=1;

	while(!bbKeyHit(1)){
		if(bbKeyDown(203)) bbTurnEntity(player,0,5,0);
		if(bbKeyDown(205)) bbTurnEntity(player,0,-5,0);
		if(bbKeyDown(200)) bbMoveEntity(player,0,0,.5);
		if(bbKeyDown(208)) bbMoveEntity(player,0,0,-.5);
		if(bbKeyDown(30)) bbTranslateEntity(player,0,.2,0);
		if(bbKeyDown(44)) bbTranslateEntity(player,0,-.2,0);
	
		for(Dude *d=dudelist;d;d=d->next){
			if(bbEntityDistance( player,d->entity )>2){
				bbPointEntity(d->entity,player);
				if(bbKeyDown(15)) bbTurnEntity(d->entity,0,180,0);
			}
			bbMoveEntity(d->entity,0,0,d->speed);
		}

		bbUpdateWorld();
		bbRenderWorld();

//	Goto skip

//sanity check!
//make sure nothings gone through anything else...

		char *bad="";
		if(ok){
			for(Dude *d=dudelist;d;d=d->next){
				if(bbEntityY( d->entity )<.9){
					ok=0;
					bad="Bad Dude Y: ";//+EntityY( d->entity );
				}
				for(Dude *d2=dudelist;d2;d2=d2->next){
					if(d2==d) break;
					if(bbEntityDistance( d->entity,d2->entity )<.9){
						ok=0;
						bad="Dude overlap!";
					}
				}
			}
		}
	
		if(ok){
			bbText(0,0,"Dudes OK");
		}else{
			bbCameraClsColor(camera,255,0,0);
			bbText(0,0,bad);
		}
		
		bbFlip();
	}
}

// *********************** anim test *****************************

void animtest(){
	const char *info="Animation demo\nHold down <return> to run\nHit <space> to toggle transitions";

//	bbGraphics3D(1440,900,32,0,0);
	bbGraphics3D(1440/2,900/2,32,2);

	BBMeshModel mesh_3ds=bbLoadAnimMesh("media/makbot/mak_robotic.3ds");	//anim seq 0
	bbLoadAnimSeq(mesh_3ds,"media/makbot/mak_running.3ds");		//anim seq 1
	bbPositionEntity(mesh_3ds,-15,-45,0);

	BBMeshModel mesh_x=bbLoadAnimMesh("media/makbot/mak_robotic.x");		//anim seq 0
	bbLoadAnimSeq(mesh_x,"media/makbot/mak_running.x");			//anim seq 1
	bbPositionEntity(mesh_x,+15,-45,0);

#define MAXCLONES 100

	BBMeshModel clones[MAXCLONES];
	for (int i=0;i<MAXCLONES;i++){
		clones[i]=(BBMeshModel)bbCopyEntity(mesh_x);
		float x=((i%20)-10)*15;
		float z=(int(i/20))*45;
		bbPositionEntity(clones[i],x,-45,20+z);
		bbAnimate(clones[i],2);
	}

	BBPivot pivot=bbCreatePivot();
	BBCamera cam=bbCreateCamera( pivot );
	bbPositionEntity(cam,0,0,-100);

	BBLight lit=bbCreateLight();
	bbRotateEntity(lit,45,45,0);

	bbAnimate(mesh_3ds,2);	//start ping-pong anims...
	bbAnimate(mesh_x,2);

	int trans=10;
	int fps=0;
	int ms=bbMilliSecs();
	int fcount=0;
	int ucount=0;
	int rcount=0;

	while(!bbKeyHit(1)){
		if(bbKeyHit(57)){
			trans=10-trans;
		}
		if(bbKeyDown(28)){
			if(bbAnimSeq(mesh_3ds)==0) bbAnimate(mesh_3ds,1,.5,1,trans);
			if(bbAnimSeq(mesh_x)==0) bbAnimate(mesh_x,  1,.5,1,trans);
		}else{
			if(bbAnimSeq(mesh_3ds)==1) bbAnimate(mesh_3ds,2,1,0,trans);
			if(bbAnimSeq(mesh_x)==1) bbAnimate(mesh_x  ,2,1,0,trans);
		}

		for (int i=0;i<MAXCLONES;i++){
			if(bbAnimSeq(clones[i])==1) bbAnimate(clones[i],2,1,0,trans);
		}


		if(bbKeyDown(30)) bbMoveEntity(cam,0,0,10);
		if(bbKeyDown(44)) bbMoveEntity(cam,0,0,-10);
		
		if(bbKeyDown(203)) bbTurnEntity(pivot,0,3,0);
		if(bbKeyDown(205)) bbTurnEntity(pivot,0,-3,0);

		bbCls();
		int m;
		m=bbMilliSecs();
		bbUpdateWorld();
		ucount+=bbMilliSecs()-m;

		m=bbMilliSecs();
		bbRenderWorld();
		rcount+=bbMilliSecs()-m;

		if (++fcount==10){
			int ms2=bbMilliSecs();
			fps=10000/(ms2-ms);
			ms=ms2;
			fcount=0;
		}
		char buffer[256];
		sprintf_s(buffer,256,"FPS=%d ucount=%d rcount=%d trisrendered=%d",fps,ucount,rcount,bbTrisRendered());

		bbColor(255,55,255);
		bbText(0,10,buffer);
		
	/*
		bbText(0,FontHeight()*0,"Anim seq: "+bbAnimSeq( mesh_3ds ));
		bbText(0,FontHeight()*1,"Anim len: "+bbAnimLength( mesh_3ds ));
		bbText(0,FontHeight()*2,"Anim time:"+bbAnimTime( mesh_3ds ));
		
		bbText(0,FontHeight()*4,"Anim seq: "+bbAnimSeq( mesh_x ));
		bbText(0,FontHeight()*5,"Anim len: "+bbAnimLength( mesh_x ));
		bbText(0,FontHeight()*6,"Anim time:"+bbAnimTime( mesh_x ));
		
		bbText(0,FontHeight()*8,"Transition time="+trans);
*/
		bbFlip(0);
	}
}

// *********************** movie test *****************************

void movietest(){
	const char *info="Firepaint3D Demo\nFeatures dynamically colored sprites\n";

	bbGraphics3D(640,480,32,0);
	bbAmbientLight(0,0,0);

	BBMovie movie=bbOpenMovie("c:/windows/clock.avi");

	while (!bbKeyHit(1)){
		bbCls();
		bbDrawMovie(movie,0,0,640,480);
		bbFlip();
	}
}

// *********************** firepaint demo *****************************

struct Frag{
	float ys,alpha;
	BBModel entity;
	Frag *next;
};
Frag *fraglist=0;

void firepaint(){
	const char *info="Firepaint3D Demo\nFeatures dynamically colored sprites\n";

	bbGraphics3D(640,480,32,1);
	bbAmbientLight(0,0,0);

	bbHidePointer();

	const float grav=-.02;
	const float intensity=15;

	BBPivot pivot=bbCreatePivot();

	BBCamera camera=bbCreateCamera( pivot );
	bbCameraClsMode(camera,BBFALSE,BBTRUE);

// create blitzlogo 'cursor'

	BBMeshModel cursor=bbCreateSphere( 8,camera );
	bbEntityTexture(cursor,bbLoadTexture( "media/firepaint/blitzlogo.bmp",3 ));
	bbMoveEntity(cursor,0,0,25);
	bbEntityBlend(cursor,3);
	bbEntityFX(cursor,1);

// create sky sphere

	BBMeshModel sky=bbCreateSphere(); 
	BBTexture tex=bbLoadTexture( "media/firepaint/stars.bmp" );
	bbScaleTexture(tex,.125,.25);
	bbEntityTexture(sky,tex);
	bbScaleEntity(sky,500,500,500);
	bbEntityFX(sky,1);
	bbFlipMesh(sky);

	BBSprite spark=bbLoadSprite( "media/firepaint/bluspark.bmp" );
	bbMoveMouse(0,0);

	int num=0;

	int time=bbMilliSecs();
	float x_speed=0;
	float y_speed=0;

	while (!bbKeyDown(1)){
		int elapsed;
		do{
			elapsed=bbMilliSecs()-time;
		}while(elapsed<=0);
		
		time=time+elapsed;
		float dt=elapsed*60.0/1000.0;
				
		x_speed=(bbMouseXSpeed()-x_speed)/4+x_speed;
		y_speed=(bbMouseYSpeed()-y_speed)/4+y_speed;

		bbMoveMouse(320,240);

		bbTurnEntity(pivot,0,-x_speed,0);	//turn player left/right
		bbTurnEntity(camera,-y_speed,0,0);	//tilt camera
		bbTurnEntity(cursor,0,dt*5,0);
		
		if(bbMouseDown(1)){
			for (int t=1;t<=intensity;t++){
				Frag *f=new Frag;
				f->ys=0;
				f->alpha=2+rand()/(float)RAND_MAX;
				f->entity=bbCopyEntity( spark,cursor );//->getModel();
				f->next=fraglist;
				fraglist=f;
				bbEntityColor(f->entity,Rnd(255),Rnd(255),Rnd(255));
				bbEntityParent(f->entity,0);
				bbRotateEntity(f->entity,Rnd(360),Rnd(360),Rnd(360));
				num=num+1;
			}
		}
		
		Frag *prevf=0;
		Frag *nextf=0;
		for (Frag *f=fraglist;f;f=nextf){
			nextf=f->next;
			f->alpha=f->alpha-dt*.02;
			if(f->alpha>0){
				float al=f->alpha;
				if(al>1) al=1;
				bbEntityAlpha(f->entity,al);
				bbMoveEntity(f->entity,0,0,dt*.4);
				float ys=f->ys+grav*dt;
				float dy=f->ys*dt;
				f->ys=ys;
				bbTranslateEntity(f->entity,0,dy,0);
				prevf=f;
			}else{
				bbFreeEntity(f->entity);
				delete f;
				if (prevf) prevf->next=nextf;else fraglist=nextf;
				num=num-1;
			}
		}

		bbUpdateWorld();
		bbRenderWorld();

		bbColor(255,0,255);
		bbRect(0,bbScanLine(),640,1);

		bbFlip(1);
	}
}

// *********************** tron demo *****************************

void playtron(){
	const char *troninfo="Tron demo\nFeatures dynamic mesh creation\nUse arrow keys to steer, A/Z to zoom";

	int smooth=BBTRUE;

	printf(troninfo);

	bbGraphics3D( 640,480,0,2 );

// draw our own floor texture

	BBTexture grid_tex=bbCreateTexture( 32,32,0 );	//was 8 but crash???
	bbScaleTexture(grid_tex,10,10);

	bbSetBuffer(bbTextureBuffer( grid_tex ));
	bbColor(0,0,64);
	bbRect(0,0,32,32);
	bbColor(0,0,255);
	bbRect(0,0,32,32,BBFALSE);
	bbSetBuffer(bbBackBuffer());

	BBPlaneModel grid_plane=bbCreatePlane();
	bbEntityTexture(grid_plane,grid_tex);
	bbEntityBlend(grid_plane,1);
	bbEntityAlpha(grid_plane,.6f);
	bbEntityFX(grid_plane,1);

	BBMirror mirror=bbCreateMirror();

	BBPivot pivot=bbCreatePivot();

	BBPivot p=bbCreatePivot( );//p???
	BBMeshModel cube=bbCreateCube( p );
	bbScaleEntity(cube,1,1,5);
	bbSetAnimKey(cube,0);
	bbRotateEntity(cube,0,120,0);
	bbSetAnimKey(cube,60);
	bbRotateEntity(cube,0,240,0);
	bbSetAnimKey(cube,120);
	bbRotateEntity(cube,0,0,0);
	bbSetAnimKey(cube,180);
	bbAddAnimSeq(p,180);

	for (int x=-100;x<=100;x+=25){
		for(int z=-100;z<=100;z+=25){
			BBEntity e=bbCopyEntity( p,pivot );
			bbPositionEntity(e,x,5,z);
			bbAnimate(e);//->getObject());
		}
	}
	bbFreeEntity(cube);

	BBMeshModel trail_mesh=bbCreateMesh();
	BBBrush trail_brush=bbCreateBrush();
	bbBrushColor(trail_brush,255,0,0);
	bbBrushBlend(trail_brush,3);
	bbBrushFX(trail_brush,1);
	BBSurface trail_surf=bbCreateSurface(trail_mesh,trail_brush);
	bbAddVertex(trail_surf,0,2,0,0,0);
	bbAddVertex(trail_surf,0,0,0,0,1);
	bbAddVertex(trail_surf,0,2,0,0,0);
	bbAddVertex(trail_surf,0,0,0,0,1);
	bbAddTriangle(trail_surf,0,2,3);
	bbAddTriangle(trail_surf,0,3,1);
	bbAddTriangle(trail_surf,0,3,2);
	bbAddTriangle(trail_surf,0,1,3);
	int trail_vert=2;

	bbPositionEntity( trail_mesh,0,.01,0);

	BBMeshModel bike=bbCreateSphere();
	bbScaleMesh(bike,.75,1,2);
	bbPositionEntity(bike,0,1,0);
	bbEntityShininess(bike,1);
	bbEntityColor(bike,192,0,255);

	BBCamera camera=bbCreateCamera();
	bbTurnEntity(camera,45,0,0);

	BBLight light=bbCreateLight();
	bbTurnEntity(light,45,45,0);

	float cam_d=30;
	int add_flag=BBFALSE;
	int wire=0;
	int turn=0;
	int add_cnt=0;

	while(!bbKeyHit(1)){
		if(bbKeyHit(17)){
			wire=!wire;
			bbWireFrame(wire);
		}
		if(bbKeyDown(30)) cam_d=cam_d-1;
		if(bbKeyDown(44)) cam_d=cam_d+1;
		
		turn=0;
		if(smooth){
			if(bbKeyDown(203))turn=5;
			if(bbKeyDown(205))turn=-5;
			if(turn){
				add_cnt=add_cnt+1;
				if(add_cnt=3){
					add_cnt=0;
					add_flag=BBTRUE;
				}else{
					add_flag=BBFALSE;
				}
			}else{
				if(add_cnt){
					add_cnt=0;
					add_flag=BBTRUE;
				}else{
					add_flag=BBFALSE;
				}
			}
		}else{
			if(bbKeyHit(203)) turn=90;
			if(bbKeyHit(205)) turn=-90;
			if(turn) add_flag=BBTRUE; else add_flag=BBFALSE;
		}
		
		if(turn){
			bbTurnEntity(bike,0,turn,0);
		}
		
		bbMoveEntity(bike,0,0,1);
		
		if(add_flag){
			bbAddVertex(trail_surf,bbEntityX(bike),2,bbEntityZ(bike),0,0);
			bbAddVertex(trail_surf,bbEntityX(bike),0,bbEntityZ(bike),0,1);
			bbAddTriangle(trail_surf,trail_vert,trail_vert+2,trail_vert+3);
			bbAddTriangle(trail_surf,trail_vert,trail_vert+3,trail_vert+1);
			bbAddTriangle(trail_surf,trail_vert,trail_vert+3,trail_vert+2);
			bbAddTriangle(trail_surf,trail_vert,trail_vert+1,trail_vert+3);
			trail_vert=trail_vert+2;
		}else{
			bbVertexCoords(trail_surf,trail_vert,bbEntityX(bike),2,bbEntityZ(bike));
			bbVertexCoords(trail_surf,trail_vert+1,bbEntityX(bike),0,bbEntityZ(bike));
		}
		
		bbUpdateWorld();
		
		bbPositionEntity(camera,bbEntityX(bike)-5,0,bbEntityZ(bike));
		bbMoveEntity(camera,0,0,-cam_d);

		bbRenderWorld();
		bbFlip();	//simon come here!
	}
}
