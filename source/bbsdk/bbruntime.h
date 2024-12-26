
#ifndef BBRUNTIME_H
#define BBRUNTIME_H

#include "stdutil.h"
#include "../gxruntime/gxtimer.h"

extern "C"{
	BBSDK_API int bbVersion();

	BBSDK_API void bbSetBlitz3DRuntime(void *gx);

	BBSDK_API void bbSetBlitz3DDebugMode(int debugmode);
	BBSDK_API void bbSetBlitz3DDebugCallback(void (*callback)(const char *));
	BBSDK_API void bbSetBlitz3DEventCallback(int (*callback)(int hwnd,int msg,int wparam,int lparam));
	BBSDK_API void bbSetBlitz3DHWND(int hwndparent);
	BBSDK_API void bbSetBlitz3DTitle(const char *title,const char *close);

	BBSDK_API int bbBeginBlitz3D();
	BBSDK_API void bbEndBlitz3D();

	BBSDK_API void bbRuntimeError( const char * );

	BBSDK_API int bbMilliSecs();
	BBSDK_API void bbDelay( int ms );
	BBSDK_API void bbShowPointer();
	BBSDK_API void bbHidePointer();

	BBSDK_API gxTimer *bbCreateTimer( int hz );
	BBSDK_API void bbFreeTimer(gxTimer *);
	BBSDK_API void bbWaitTimer(gxTimer *);

	BBSDK_API const char *bbSystemProperty(const char *name);
}

#endif

//	BBSDK_API int bbBeginRuntime(void *gxruntime,int parenthwnd,int debugmode);
