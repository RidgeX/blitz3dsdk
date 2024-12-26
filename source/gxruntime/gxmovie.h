
#ifndef GXMOVIE_H
#define GXMOVIE_H

#include "gxcanvas.h"

class gxGraphics;

class gxMovie{
public:
	virtual bool draw( gxCanvas *dest,int x,int y,int w,int h )=0;
	virtual bool isPlaying()const=0;
	virtual int getWidth()const=0;
	virtual int getHeight()const=0;
};

#endif
