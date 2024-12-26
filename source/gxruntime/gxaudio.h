
#ifndef GXAUDIO_H
#define GXAUDIO_H

#include "gxsound.h"

class gxAudio{
public:
	enum{
		CD_MODE_ONCE=1,CD_MODE_LOOP,CD_MODE_ALL
	};

	virtual gxSound *loadSound( const char *filename,int flags )=0;
	virtual gxSound *verifySound( gxSound *sound )=0;
	virtual void freeSound( gxSound *sound )=0;

	virtual void setPaused( bool paused )=0;	//master pause
	virtual void setVolume( float volume )=0;	//master volume

	virtual void set3dOptions( float roll,float dopp,float dist )=0;

	virtual void set3dListener( const float pos[3],const float vel[3],const float forward[3],const float up[3] )=0;

	virtual gxChannel *playCDTrack( int track,int mode )=0;
	virtual gxChannel *playFile( const char *filename,int mode )=0;
};

#endif
