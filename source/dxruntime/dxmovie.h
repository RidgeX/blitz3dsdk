
#ifndef DXMOVIE_H
#define DXMOVIE_H

#include "../gxruntime/gxmovie.h"

#include "dxstd.h"
#include "dxcanvas.h"

class dxGraphics;

//simon was here
#include "rpcsal.h"

#include "ddstream.h"    // DirectDraw multimedia stream interfaces
#include "mmstream.h"    // multimedia stream interfaces
//#include "amstream.h"    // DirectShow multimedia stream interfaces

class dxMovie:public gxMovie{

private:
	bool playing;
	RECT src_rect;
	dxGraphics *gfx;
	dxCanvas *canvas;
	IDirectDrawSurface *dd_surf;
	IMediaStream *vid_stream;
	IDirectDrawMediaStream *dd_stream;
	IDirectDrawStreamSample *dd_sample;
	IMultiMediaStream *mm_stream;
public:
	dxMovie( dxGraphics *gfx,IMultiMediaStream *mm_stream );
	dxMovie( dxGraphics *gfx,void *mm_stream );
	~dxMovie();

// ***** GX INTERFACE *****
public:
	bool draw( gxCanvas *dest,int x,int y,int w,int h );
	bool isPlaying()const{ return playing; }
	int getWidth()const{ return src_rect.right; }
	int getHeight()const{ return src_rect.bottom; }
};


#endif
