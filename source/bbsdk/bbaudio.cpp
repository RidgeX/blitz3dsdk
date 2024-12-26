
#include "stdutil.h"
#include "bbaudio.h"

#include "../gxruntime/gxruntime.h"
#include "../gxruntime/gxaudio.h"

extern class gxAudio *gx_audio;

gxChannel *bbPlayMusic( const char *src,int mode ){return gx_audio->playFile(src,mode);}
gxChannel *bbPlayCDTrack( int track,int mode ){return gx_audio->playCDTrack(track,mode);}

gxSound *bbLoadSound( const char *src,int flags ){
	if (!gx_audio) return 0;
	return gx_audio->loadSound(src,flags);
}

void bbFreeSound( gxSound *sound ){
	if (sound) gx_audio->freeSound(sound);
}

gxChannel *bbPlaySound( gxSound *sound ){
	if (sound) return sound->play();
	return 0;
}

void bbLoopSound( gxSound *sound ){
	if (sound) sound->setLoop(1);
}

void bbSoundPitch( gxSound *sound,int pitch ){
	if (sound) sound->setPitch(pitch);
}

void bbSoundVolume( gxSound *sound,float volume ){
	if (sound) sound->setVolume(volume);
}

void bbSoundPan( gxSound *sound,float pan ){
	if (sound) sound->setPan(pan);
}

void bbStopChannel( gxChannel *channel ){channel->stop();}
void bbPauseChannel( gxChannel *channel ){channel->setPaused(1);}
void bbResumeChannel( gxChannel *channel ){channel->setPaused(0);}
void bbChannelPitch( gxChannel *channel,int pitch ){channel->setPitch(pitch);}
void bbChannelVolume( gxChannel *channel,float volume ){channel->setVolume(volume);}
void bbChannelPan( gxChannel *channel,float pan ){channel->setPan(pan);}
int bbChannelPlaying( gxChannel *channel ){return channel->isPlaying();}
