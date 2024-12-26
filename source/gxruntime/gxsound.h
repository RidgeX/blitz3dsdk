
#ifndef GXSOUND_H
#define GXSOUND_H

#include "gxchannel.h"

class gxAudio;

class gxSound{
public:
//actions
	virtual gxChannel *play()=0;
	virtual gxChannel *play3d( const float pos[3],const float vel[3] )=0;
//modifiers
	virtual void setLoop( bool loop )=0;
	virtual void setPitch( int hertz )=0;
	virtual void setVolume( float volume )=0;
	virtual void setPan( float pan )=0;
};

#endif
