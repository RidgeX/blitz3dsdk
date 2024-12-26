
#ifndef GXGRAPHICS_H
#define GXGRAPHICS_H

#include "gxfont.h"
#include "gxcanvas.h"
#include "gxscene.h"
#include "gxmesh.h"
#include "gxmovie.h"

class gxRuntime;

class gxGraphics{
public:
	enum{
		GRAPHICS_WINDOWED=1,	//windowed mode
		GRAPHICS_SCALED=2,		//scaled window
		GRAPHICS_3D=4,			//3d mode! Hurrah!
		GRAPHICS_REUSED=8,		//new for maxgui
		GRAPHICS_AUTOSUSPEND=16	//app should auto suspend when inactive
	};

	//MANIPULATORS
	virtual void vwait()=0;
	virtual void flip( bool vwait )=0;
	virtual void paint( int hwnd )=0;

	//SPECIAL!
	virtual void copy( gxCanvas *dest,int dx,int dy,int dw,int dh,gxCanvas *src,int sx,int sy,int sw,int sh )=0;

	//NEW! Gamma control!
	virtual void setGamma( int r,int g,int b,float dr,float dg,float db )=0;
	virtual void getGamma( int r,int g,int b,float *dr,float *dg,float *db )=0;
	virtual void updateGamma( bool calibrate )=0;

	//ACCESSORS
	virtual int getWidth()const=0;
	virtual int getHeight()const=0;
	virtual int getDepth()const=0;
	virtual int getScanLine()const=0;
	virtual int getAvailVidmem()const=0;
	virtual int getTotalVidmem()const=0;

	virtual gxCanvas *getFrontCanvas()const=0;
	virtual gxCanvas *getBackCanvas()const=0;
	virtual gxFont *getDefaultFont()const=0;

	//OBJECTS
	virtual gxCanvas *createCanvas( int width,int height,int flags )=0;
	virtual gxCanvas *loadCanvas( const char *file,int flags )=0;
	virtual gxCanvas *verifyCanvas( gxCanvas *canvas )=0;
	virtual void freeCanvas( gxCanvas *canvas )=0;

	virtual gxMovie *openMovie( const char *file,int flags )=0;
	virtual gxMovie *verifyMovie( gxMovie *movie )=0;
	virtual void closeMovie( gxMovie *movie )=0;

	virtual gxFont *loadFont( const char *font,int height,int flags )=0;
	virtual gxFont *verifyFont( gxFont *font )=0;
	virtual void freeFont( gxFont *font )=0;

	virtual gxScene *createScene( int flags )=0;
	virtual gxScene *verifyScene( gxScene *scene )=0;
	virtual void freeScene( gxScene *scene )=0;

	virtual gxMesh *createMesh( int max_verts,int max_tris,int flags )=0;
	virtual gxMesh *verifyMesh( gxMesh *mesh )=0;
	virtual void freeMesh( gxMesh *mesh )=0;
};

#endif
