
#include "dxstd.h"
#include "dxtimer.h"
#include "dxruntime.h"

dxTimer::dxTimer( dxRuntime *rt,int hertz ): runtime(rt),ticks_get(0),ticks_put(0){
	event=CreateEvent( 0,false,false,0 );
	timerID=timeSetEvent( 1000/hertz,0,timerCallback,(DWORD)this,TIME_PERIODIC );
}

dxTimer::~dxTimer(){
	timeKillEvent( timerID );
	CloseHandle( event );
}

void CALLBACK dxTimer::timerCallback( UINT id,UINT msg,DWORD user,DWORD dw1,DWORD dw2 ){
	dxTimer *t=(dxTimer*)user;
	++t->ticks_put;
	SetEvent( t->event );
}

int dxTimer::wait(){
	for(;;){
		if( WaitForSingleObject( event,1000 )==WAIT_OBJECT_0 ) break;
	}
	int n=ticks_put-ticks_get;
	ticks_get+=n;
	return n;
}

