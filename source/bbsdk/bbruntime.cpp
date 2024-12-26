// bbruntime.cpp

#include "stdafx.h"

#include "stdutil.h"

#include "bbruntime.h"
#include "../gxruntime/gxruntime.h"
#include "../dxruntime/dxruntime.h"

// default error handler
extern "C" void messageboxexit( const char *err );

bool input_create();
bool input_destroy();

// basic runtime state

const char *lasterror=0;
class gxRuntime *def_runtime=0;
class gxRuntime *gx_runtime=0;
HWND parent_hwnd=0;

int debug_mode=1;

void (__cdecl *error_handler)(const char *)=messageboxexit;
int (_cdecl *event_handler)(int hwnd,int msg,int wparam,int lparam)=0;

void messageboxexit( const char *err ){
	lasterror=err;
	if (err){
		MessageBoxA(0,err,"Blitz3D Runtime Error",MB_SYSTEMMODAL);
	}
	exit(1);
}

//#include "../blitz3d/loader_x.h"

// internal usage

extern "C" void RuntimeError( const char * );

void RuntimeError( const char *err ){
	error_handler(err);
}


// public bbruntime interface

/*
	BBSDK_API void bbSetBlitz3DRuntime(void *gx);
	BBSDK_API void bbSetBlitz3DDebugMode(int debugmode);
	BBSDK_API void bbSetBlitz3dDebugCallback(void (*callback)(const char *));
	BBSDK_API void bbSetBlitz3dEventCallback(int (*callback)(int hwnd,int msg,int wparam,int lparam));
	BBSDK_API void bbSetBlitz3DHWND(int hwndparent);
*/

void bbSetBlitz3DRuntime(void *gx){
	def_runtime=(gxRuntime*)gx;
}

void bbSetBlitz3DDebugMode(int debugmode){
	debug_mode=debugmode;
}

void bbSetBlitz3DDebugCallback(void (*callback)(const char *)){
	if (callback)
		error_handler=callback;
	else
		error_handler=messageboxexit;
}

void bbSetBlitz3DEventCallback(int (*callback)(int hwnd,int msg,int wparam,int lparam)){
	event_handler=callback;
}

void bbSetBlitz3DHWND(int hwndparent){
	parent_hwnd=(HWND)hwndparent;
}

int bbBeginBlitz3D(){
	if (gx_runtime) return 0;	//error!
//	atexit(bbEndBlitz3D);
	gxRuntime *gx;
	gx=def_runtime;
	if (!gx) gx=dxRuntime::openRuntime((int)parent_hwnd,event_handler);
	gx_runtime=(gxRuntime*)gx;
	if (!gx_runtime) return 0;
	if (!event_handler) input_create();
	return 1;
}

void bbRuntimeError(const char *err){
	bbEndBlitz3D();
	error_handler(err);
}

void bbEndBlitz3D(){
	if (gx_runtime==0) return;
	input_destroy();
	dxRuntime::closeRuntime(gx_runtime);
	gx_runtime=0;
}

int bbMilliSecs(){
	return gx_runtime->getMilliSecs();
}

void bbSetBlitz3DTitle(const char *title,const char *close){
	gx_runtime->setTitle(title,close);
}

void bbDelay(int ms){
	gx_runtime->delay( ms );
}

void bbShowPointer(){
	gx_runtime->setPointerVisible( true );
}

void bbHidePointer(){
	gx_runtime->setPointerVisible( false );
}

// timer commands

gxTimer *bbCreateTimer( int hz ){
	return gx_runtime->createTimer(hz);
}

void bbFreeTimer(gxTimer *t){
	gx_runtime->freeTimer(t);
//	delete t;
}

void bbWaitTimer(gxTimer *t){
	t->wait();
}

const char *bbSystemProperty(const char *name){
	return gx_runtime->systemProperty(name);
}


/*
	switch(driver){
	case 0:
//		gx_runtime=bmxRuntime::openRuntime();
		break;
#ifdef _WIN32
	case 1:
		gx_runtime=dxRuntime::openRuntime();
		break;
#endif
	}

//bool input_create();
//bool input_destroy();

void woosh(){
//	MessageBoxA(0,"WHOOSH","Blitz3D Runtime Error",MB_SYSTEMMODAL);
}
	
	void *gx,int hwndparent,int debugmode){
*/

//	xlibnotfound();
//	linkdsound();
//	debug_mode=debugmode;

/*
extern "C" void RuntimeError( const char * );

void RuntimeError( const char *err ){
	bbRuntimeError(err);
}

void bbRuntimeError( const char *err ){
	gx_runtime->debugError(err);
}
*/

