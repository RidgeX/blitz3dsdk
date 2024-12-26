
#ifndef DXTIMER_H
#define DXTIMER_H

#include "../gxruntime/gxtimer.h"

class dxRuntime;

class dxTimer:public gxTimer{
public:
	dxTimer( dxRuntime *rt,int hertz );
	~dxTimer();

	static void CALLBACK timerCallback( UINT id,UINT msg,DWORD user,DWORD dw1,DWORD dw2 );

private:
	dxRuntime *runtime;
	HANDLE event;
	MMRESULT timerID;
	int ticks_put,ticks_get;

	/***** GX INTERFACE *****/
public:
	int wait();
};

#endif
