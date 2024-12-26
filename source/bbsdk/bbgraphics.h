
#ifndef BBGRAPHICS_H
#define BBGRAPHICS_H

#include "stdutil.h"
#include "../gxruntime/gxgraphics.h"

#define bbFalse 0
#define bbTrue 1

extern gxGraphics *gx_graphics;
extern gxCanvas *gx_canvas;
extern gxScene *gx_scene;

class bbImage;

extern "C"{
	BBSDK_API void bbGraphics3D( int w,int h,int d,int mode );

	BBSDK_API int bbCountGfxModes3D();
	BBSDK_API int bbGfxMode3DExists( int w,int h,int d );

	BBSDK_API int bbCountGfxDrivers();
	BBSDK_API const char *bbGfxDriverName( int n );
	BBSDK_API int bbGfxDriver3D( int n );
	BBSDK_API int	  bbGfxDriverX(int n);
	BBSDK_API int	  bbGfxDriverY(int n);
	BBSDK_API int	  bbGfxDriverHz(int n);
	BBSDK_API void bbSetGfxDriver( int n );

	BBSDK_API int bbGfxModeExists( int w,int h,int d );
	BBSDK_API int bbWindowed3D();

	BBSDK_API int bbCountGfxModes();
	BBSDK_API int bbGfxMode3D( int n );
	BBSDK_API int bbGfxModeWidth( int n );
	BBSDK_API int bbGfxModeHeight( int n );
	BBSDK_API int bbGfxModeDepth( int n );

	BBSDK_API int bbGraphicsWidth();
	BBSDK_API int bbGraphicsHeight();
	BBSDK_API int bbGraphicsDepth();
	BBSDK_API int bbAvailVidMem();
	BBSDK_API int bbTotalVidMem();

	//mode functions

	BBSDK_API void bbGraphics( int w,int h,int d,int mode );
	BBSDK_API gxCanvas * bbFrontBuffer();
	BBSDK_API gxCanvas * bbBackBuffer();
	BBSDK_API void bbEndGraphics();
	BBSDK_API int bbGraphicsLost();
	BBSDK_API int bbScanLine();
	BBSDK_API void bbVWait( int n );
	BBSDK_API void bbFlip( int vwait=1 );
	BBSDK_API void bbPaint( int hwnd );

	//graphics buffer functions

	BBSDK_API void bbSetBuffer( gxCanvas *buff );
	BBSDK_API gxCanvas * bbGraphicsBuffer();
	BBSDK_API int bbLoadBuffer( gxCanvas *surf,const char *str );
	BBSDK_API int bbSaveBuffer( gxCanvas *surf,const char *str );
	BBSDK_API void bbBufferDirty( gxCanvas *surf );

	//fast read/write operations...

	BBSDK_API void bbLockBuffer( gxCanvas *buff );
	BBSDK_API void bbUnlockBuffer( gxCanvas *buff );
	BBSDK_API int bbReadPixel( int x,int y,gxCanvas *buff );
	BBSDK_API void bbWritePixel( int x,int y,int argb,gxCanvas *buff );
	BBSDK_API int bbReadPixelFast( int x,int y,gxCanvas *buff );
	BBSDK_API void bbWritePixelFast( int x,int y,int argb,gxCanvas *buff );
	BBSDK_API void bbCopyPixel( int src_x,int src_y,gxCanvas *src,int dest_x,int dest_y,gxCanvas *buff );
	BBSDK_API void bbCopyPixelFast( int src_x,int src_y,gxCanvas *src,int dest_x,int dest_y,gxCanvas *buff );

	//2d rendering functions

	BBSDK_API void bbOrigin( int x,int y );
	BBSDK_API void bbViewport( int x,int y,int w,int h );
	BBSDK_API void bbColor( int r,int g,int b );
	BBSDK_API void bbClsColor( int r,int g,int b );
	BBSDK_API void bbCls();
	BBSDK_API void bbPlot( int x,int y );
	BBSDK_API void bbLine( int x1,int y1,int x2,int y2 );
	BBSDK_API void bbRect( int x,int y,int w,int h,int solid=1 );
	BBSDK_API void bbOval( int x,int y,int w,int h,int solid=1 );
	BBSDK_API void bbText( int x,int y,const char *t,int centre_x=0,int centre_y=0 );
	BBSDK_API void bbCopyRect( int sx,int sy,int w,int h,int dx,int dy,gxCanvas *src,gxCanvas *dest );
	BBSDK_API void bbGetColor( int x,int y );
	BBSDK_API int bbColorRed();
	BBSDK_API int bbColorGreen();
	BBSDK_API int bbColorBlue();

	//font functions

	BBSDK_API gxFont * bbLoadFont( const char *name,int height,int bold,int italic,int underline );
	BBSDK_API void bbFreeFont( gxFont *f );
	BBSDK_API void bbSetFont( gxFont *f );
	BBSDK_API int bbFontWidth();
	BBSDK_API int bbFontHeight();
	BBSDK_API int bbStringWidth( const char *str );
	BBSDK_API int bbStringHeight( const char *str );

	//image functions

	BBSDK_API bbImage* bbLoadImage( const char *s );
	BBSDK_API bbImage* bbCopyImage( bbImage *i );
	BBSDK_API bbImage* bbCreateImage( int w,int h,int n );
	BBSDK_API bbImage* bbLoadAnimImage( const char *s,int w,int h,int first,int cnt );
	BBSDK_API void bbFreeImage( bbImage *i );
	BBSDK_API int bbSaveImage( bbImage *i,const char *filename,int frame );
	BBSDK_API void bbGrabImage( bbImage *i,int x,int y,int n );
	BBSDK_API gxCanvas * bbImageBuffer( bbImage *i,int n );
	BBSDK_API void bbDrawImage( bbImage *i,int x,int y,int frame );
	BBSDK_API void bbDrawBlock( bbImage *i,int x,int y,int frame );
	BBSDK_API void bbTileImage( bbImage *i,int x,int y,int frame );
	BBSDK_API void bbTileBlock( bbImage *i,int x,int y,int frame );
	BBSDK_API void bbDrawImageRect( bbImage *i,int x,int y,int r_x,int r_y,int r_w,int r_h,int frame );
	BBSDK_API void bbDrawBlockRect( bbImage *i,int x,int y,int r_x,int r_y,int r_w,int r_h,int frame );
	BBSDK_API void bbMaskImage( bbImage *i,int r,int g,int b );
	BBSDK_API void bbHandleImage( bbImage *i,int x,int y );
	BBSDK_API void bbScaleImage( bbImage *i,float w,float h );
	BBSDK_API void bbResizeImage( bbImage *i,float w,float h );
	BBSDK_API void bbRotateImage( bbImage *i,float angle );
	BBSDK_API void bbTFormImage( bbImage *i,float a,float b,float c,float d );
	BBSDK_API void bbTFormFilter( int enable );
	BBSDK_API void bbAutoMidHandle( int enable );
	BBSDK_API void bbMidHandle( bbImage *i );
	BBSDK_API int bbImageWidth( bbImage *i );
	BBSDK_API int bbImageHeight( bbImage *i );
	BBSDK_API int bbImageXHandle( bbImage *i );
	BBSDK_API int bbImageYHandle( bbImage *i );
	BBSDK_API int bbImagesOverlap( bbImage *i1,int x1,int y1,bbImage *i2,int x2,int y2 );
	BBSDK_API int bbImagesCollide( bbImage *i1,int x1,int y1,int f1,bbImage *i2,int x2,int y2,int f2 );
	BBSDK_API int bbRectsOverlap( int x1,int y1,int w1,int h1,int x2,int y2,int w2,int h2 );
	BBSDK_API int bbImageRectOverlap( bbImage *i,int x,int y,int r_x,int r_y,int r_w,int r_h );
	BBSDK_API int bbImageRectCollide( bbImage *i,int x,int y,int f,int r_x,int r_y,int r_w,int r_h );

	//simple print functions

	BBSDK_API void bbWrite( const char *str );
	BBSDK_API void bbPrint( const char *str );
	BBSDK_API const char * bbInput( const char *prompt );
	BBSDK_API void bbLocate( int x,int y );

	// movie commands

	BBSDK_API gxMovie *bbOpenMovie( const char *s );
	BBSDK_API int bbDrawMovie( gxMovie *movie,int x,int y,int w,int h );
	BBSDK_API int bbMovieWidth( gxMovie *movie );
	BBSDK_API int bbMovieHeight( gxMovie *movie );
	BBSDK_API int bbMoviePlaying( gxMovie *movie );
	BBSDK_API void bbCloseMovie( gxMovie *movie );


	// gamma commands

	BBSDK_API void bbSetGamma( int r,int g,int b,float dr,float dg,float db );
	BBSDK_API void bbUpdateGamma( int calibrate );
	BBSDK_API float bbGammaRed( int n );
	BBSDK_API float bbGammaGreen( int n );
	BBSDK_API float  bbGammaBlue( int n );
}

#endif
