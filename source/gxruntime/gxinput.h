
#ifndef GXINPUT_H
#define GXINPUT_H

#include "gxdevice.h"

class gxInput{
public:
	enum{
		ASC_HOME=1,ASC_END=2,ASC_INSERT=3,ASC_DELETE=4,
		ASC_PAGEUP=5,ASC_PAGEDOWN=6,
		ASC_UP=28,ASC_DOWN=29,ASC_RIGHT=30,ASC_LEFT=31
	};
	virtual void moveMouse( int x,int y )=0;
	virtual gxDevice *getMouse()const=0;
	virtual gxDevice *getKeyboard()const=0;
	virtual gxDevice *getJoystick( int port )const=0;
	virtual int getJoystickType( int port )const=0;
	virtual int numJoysticks()const=0;
	virtual int toAscii( int key )const=0;
};

#endif
