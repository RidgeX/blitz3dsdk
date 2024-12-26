
#include "std.h"
#include "dxdevice.h"
#include "dxruntime.h"

dxDevice::dxDevice(){
	reset();
}

dxDevice::~dxDevice(){
}

void dxDevice::reset(){
	memset( down_state,0,sizeof(down_state) );
	memset( axis_states,0,sizeof(axis_states) );
	memset( hit_count,0,sizeof(hit_count) );
	put=get=0;
}

void dxDevice::downEvent( int key ){
	down_state[key]=true;
	++hit_count[key];
	if( put-get<QUE_SIZE ) que[put++&QUE_MASK]=key;
}

void dxDevice::upEvent( int key ){
	down_state[key]=false;
}

void dxDevice::setDownState( int key,bool down ){
	if( down==down_state[key] ) return;
	if( down ) downEvent( key );
	else upEvent( key );
}

void dxDevice::flush(){
	update();
	memset( hit_count,0,sizeof(hit_count) );
	put=get=0;
}

bool dxDevice::keyDown( int key ){
	update();
	return down_state[key];
}

int dxDevice::keyHit( int key ){
	update();
	int n=hit_count[key];
	hit_count[key]-=n;
	return n;
}

int dxDevice::getKey(){
	update();
	return get<put ? que[get++ & QUE_MASK] : 0;
}

float dxDevice::getAxisState( int axis ){
	update();
	return axis_states[axis];
}
