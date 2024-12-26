
#ifndef GXMUSIC_H
#define GXMUSIC_H

class gxAudio;

class gxMusic{
public:
	virtual void play()=0;
	virtual void stop()=0;
	virtual void setPaused( bool paused )=0;
	virtual void setVolume( float volume )=0;
	virtual bool isPlaying()const=0;
};

#endif
