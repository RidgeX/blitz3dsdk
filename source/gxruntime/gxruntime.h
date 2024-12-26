
#ifndef GXRUNTIME_H
#define GXRUNTIME_H

#include "gxgraphics.h"
#include "gxinput.h"
#include "gxtimer.h"
#include "gxaudio.h"

extern class gxRuntime *gx_runtime;

class gxRuntime{
public:
	enum{
		GFXMODECAPS_3D=1
	};

	virtual bool idle()=0;	//return true if program should continue, or false for quit.
	virtual void setTitle( const char *title,const char *close )=0;
	virtual int getMilliSecs()=0;
	virtual void setPointerVisible( bool vis )=0;
	virtual bool delay(int ms)=0;

	virtual int numGraphicsDrivers()=0;
	virtual void graphicsDriverInfo( int driver,const char **name,int *caps,int *x,int *y,int *hz )=0;

	virtual int numGraphicsModes( int driver )=0;
	virtual void graphicsModeInfo( int driver,int mode,int *w,int *h,int *d,int *caps )=0;

	virtual void windowedModeInfo( int *caps )=0;

	virtual gxInput *openInput( int flags )=0;
	virtual void closeInput( gxInput *input )=0;

	virtual gxGraphics *openGraphics( int w,int h,int d,int driver,int flags )=0;
	virtual void closeGraphics( gxGraphics *graphics )=0;
	virtual bool graphicsLost()=0;

	virtual gxAudio *openAudio( int flags )=0;
	virtual void closeAudio( gxAudio *audio )=0;

	virtual gxTimer *createTimer( int hertz )=0;
	virtual void freeTimer( gxTimer *timer )=0;

	virtual const char *systemProperty( const char *name )=0;
};

#endif

//	virtual void debugError( const char *t )=0;
//	virtual void debugLog( const char *t )=0;
//	virtual const char *error()=0;
