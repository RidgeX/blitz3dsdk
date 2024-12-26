
#ifndef DXDEVICE_H
#define DXDEVICE_H

#include "../gxruntime/gxdevice.h"

class dxDevice: public gxDevice {
public:
	float axis_states[32];

	dxDevice();
	virtual ~dxDevice();

	virtual void update(){}

	void reset();
	void downEvent( int key );
	void upEvent( int key );
	void setDownState( int key,bool down );

private:
	enum{
		QUE_SIZE=32,QUE_MASK=QUE_SIZE-1
	};
	int hit_count[256];			//how many hits of key
	bool down_state[256];			//time key went down
	int que[QUE_SIZE],put,get;

	/***** dx INTERFACE *****/
public:
	void flush();

	bool keyDown( int key );

	int keyHit( int key );

	int getKey();

	float getAxisState( int axis );
};

#endif