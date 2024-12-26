
#ifndef DXAUDIO_H
#define DXAUDIO_H

#include <string>
#include <dsound.h>

//#include "dxruntime.h"

#include "../gxruntime/gxaudio.h"
#include "../bbsdk/waveform.h"

int linkdsound();

class dxRuntime;

//struct FSOUND_SAMPLE;

struct dxSound;

class dxAudio:public gxAudio{

	IDirectSound *directsound;
	IDirectSoundBuffer *primarybuffer;
	IDirectSound3DListener *listener;

	IDirectSoundBuffer *loadbuffer( dxSound *sample,int is3d );
public:
	dxRuntime *runtime;

	dxAudio( dxRuntime *runtime );
	~dxAudio();

	int reset(HWND hwnd);	//ok=0 err<>0 

	gxChannel *play( dxSound *sample );
	gxChannel *play3d( dxSound *sample,const float pos[3],const float vel[3] );

	void pause();
	void resume();

	gxSound *loadSound( const char *filename,int flags );
	gxSound *verifySound( gxSound *sound );
	void freeSound( gxSound *sound );

	void setPaused( bool paused );	//master pause
	void setVolume( float volume );	//master volume

	void set3dOptions( float roll,float dopp,float dist );

	void set3dListener( const float pos[3],const float vel[3],const float forward[3],const float up[3] );

	gxChannel *playCDTrack( int track,int mode );
	gxChannel *playFile( const char *filename,int flags );

};

#endif
