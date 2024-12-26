
#ifndef GXCANVAS_H
#define GXCANVAS_H

class gxFont;
class gxGraphics;

class gxCanvas{
public:
	enum{
		CANVAS_TEX_RGB=0x0001,
		CANVAS_TEX_ALPHA=0x0002,
		CANVAS_TEX_MASK=0x0004,
		CANVAS_TEX_MIPMAP=0x0008,
		CANVAS_TEX_CLAMPU=0x0010,
		CANVAS_TEX_CLAMPV=0x0020,
		CANVAS_TEX_SPHERE=0x0040,
		CANVAS_TEX_CUBE=0x0080,
		CANVAS_TEX_VIDMEM=0x0100,
		CANVAS_TEX_HICOLOR=0x0200,
		CANVAS_TEX_COMPRESSED=0x0400,
		CANVAS_TEXTURE=0x1000,
		CANVAS_NONDISPLAY=	0x2000,
		CANVAS_HIGHCOLOR=	0x4000
	};

	enum{
		CUBEMODE_REFLECTION=1,
		CUBEMODE_NORMAL=2,
		CUBEMODE_POSITION=3,

		CUBESPACE_WORLD=0,
		CUBESPACE_CAMERA=4
	};

	//MANIPULATORS
	virtual void setFont( gxFont *font )=0;
	virtual void setMask( unsigned argb )=0;
	virtual void setColor( unsigned argb )=0;
	virtual void setClsColor( unsigned argb )=0;
	virtual void setOrigin( int x,int y )=0;
	virtual void setHandle( int x,int y )=0;
	virtual void setViewport( int x,int y,int w,int h )=0;

	virtual void cls()=0;
	virtual void plot( int x,int y )=0;
	virtual void line( int x,int y,int x2,int y2 )=0;
	virtual void rect( int x,int y,int w,int h,bool solid )=0;
	virtual void oval( int x,int y,int w,int h,bool solid )=0;
	virtual void text( int x,int y,const char *t )=0;
	virtual void blit( int x,int y,gxCanvas *src,int src_x,int src_y,int src_w,int src_h,bool solid )=0;

	virtual bool collide( int x,int y,const gxCanvas *src,int src_x,int src_y,bool solid )const=0;
	virtual bool rect_collide( int x,int y,int rect_x,int rect_y,int rect_w,int rect_h,bool solid )const=0;

	virtual void backup()const=0;
	virtual bool lock()const=0;
	virtual void setPixel( int x,int y,unsigned argb )=0;
	virtual void setPixelFast( int x,int y,unsigned argb )=0;
	virtual void copyPixel( int x,int y,gxCanvas *src,int src_x,int src_y )=0;
	virtual void copyPixelFast( int x,int y,gxCanvas *src,int src_x,int src_y )=0;
	virtual unsigned getPixel( int x,int y )const=0;
	virtual unsigned getPixelFast( int x,int y )const=0;
	virtual void unlock()const=0;

	virtual void setCubeMode( int mode )=0;
	virtual void setCubeFace( int face )=0;

	//ACCESSORS
	virtual int getWidth()const=0;
	virtual int getHeight()const=0;
	virtual int getDepth()const=0;
	virtual int getFlags()const=0;//{ return flags=0; }
	virtual int cubeMode()const=0;//{ return cube_mode=0; }
	virtual void getOrigin( int *x,int *y )const=0;
	virtual void getHandle( int *x,int *y )const=0;
	virtual void getViewport( int *x,int *y,int *w,int *h )const=0;
	virtual unsigned getMask()const=0;
	virtual unsigned getColor()const=0;
	virtual unsigned getClsColor()const=0;
};

#endif
