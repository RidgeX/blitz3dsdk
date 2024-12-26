
#ifndef BBINPUT_H
#define BBINPUT_H

#include "stdutil.h"

#include <vector>

//#include "bbsys.h"
#include "../gxruntime/gxdevice.h"
#include "../gxruntime/gxinput.h"

extern gxInput *gx_input;
extern gxDevice *gx_mouse;
extern gxDevice *gx_keyboard;
extern std::vector<gxDevice*> gx_joysticks;

extern "C"{

//keyboard
	BBSDK_API int bbKeyDown( int n );
	BBSDK_API int bbKeyHit( int n );
	BBSDK_API int bbGetKey();
	BBSDK_API int bbWaitKey();
	BBSDK_API void bbFlushKeys();

//mouse
	BBSDK_API int bbMouseDown( int n );
	BBSDK_API int bbMouseHit( int n );
	BBSDK_API int bbGetMouse();
	BBSDK_API int bbWaitMouse();
	BBSDK_API int bbMouseX();
	BBSDK_API int bbMouseY();
	BBSDK_API int bbMouseZ();
	BBSDK_API int bbMouseXSpeed();
	BBSDK_API int bbMouseYSpeed();
	BBSDK_API int bbMouseZSpeed();
	BBSDK_API void bbMoveMouse( int x,int y );
	BBSDK_API void bbFlushMouse();

//joysticks
	BBSDK_API int bbJoyType( int port );
	BBSDK_API int bbJoyDown( int n,int port );
	BBSDK_API int bbJoyHit( int n,int port );
	BBSDK_API int bbGetJoy( int port );
	BBSDK_API int bbWaitJoy( int port );
	BBSDK_API float bbJoyX( int port );
	BBSDK_API float bbJoyY( int port );
	BBSDK_API float bbJoyZ( int port );
	BBSDK_API float bbJoyU( int port );
	BBSDK_API float bbJoyV( int port );
	BBSDK_API float bbJoyPitch( int port );
	BBSDK_API float bbJoyYaw( int port );
	BBSDK_API float bbJoyRoll( int port );
	BBSDK_API float bbJoyHat( int port );
	BBSDK_API int bbJoyXDir( int port );
	BBSDK_API int bbJoyYDir( int port );
	BBSDK_API int bbJoyZDir( int port );
	BBSDK_API int bbJoyUDir( int port );
	BBSDK_API int bbJoyVDir( int port );
	BBSDK_API void bbFlushJoy();
}

#endif