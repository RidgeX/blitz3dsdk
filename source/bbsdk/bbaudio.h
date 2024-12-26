
#ifndef BBAUDIO_H
#define BBAUDIO_H

class gxSound;
class gxChannel;

extern "C"{
	BBSDK_API gxSound *bbLoadSound( const char *src,int flags=0 );
	BBSDK_API void bbFreeSound( gxSound *sound );
	BBSDK_API gxChannel *bbPlaySound( gxSound *sound );
	BBSDK_API void bbLoopSound( gxSound *sound );
	BBSDK_API void bbSoundPitch( gxSound *sound,int pitch );
	BBSDK_API void bbSoundVolume( gxSound *sound,float volume );
	BBSDK_API void bbSoundPan( gxSound *sound,float pan );
	BBSDK_API gxChannel *bbPlayMusic( const char *src,int mode=1 );
	BBSDK_API gxChannel *bbPlayCDTrack( int track,int mode=1 );
	BBSDK_API void bbStopChannel( gxChannel *channel );
	BBSDK_API void bbPauseChannel( gxChannel *channel );
	BBSDK_API void bbResumeChannel( gxChannel *channel );
	BBSDK_API void bbChannelPitch( gxChannel *channel,int pitch );
	BBSDK_API void bbChannelVolume( gxChannel *channel,float volume );
	BBSDK_API void bbChannelPan( gxChannel *channel,float pan );
	BBSDK_API int bbChannelPlaying( gxChannel *channel );
}

#endif
