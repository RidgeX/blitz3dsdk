
#ifndef GXDEVICE_H
#define GXDEVICE_H

class gxDevice{
public:
	virtual void flush()=0;
	virtual bool keyDown( int key )=0;
	virtual int keyHit( int key )=0;
	virtual int getKey()=0;
	virtual float getAxisState( int axis )=0;
};

#endif
