
#include "dxstd.h"
#include "dxaudio.h"

static int mcount=1;

struct MusicChannel : public gxChannel{
	char _path[1024];
	char _alias[1024];
	char _errbuffer[1024];
	char _buffer[1024];
	int playing;

	MusicChannel(){_path[0]=0;playing=0;}
	~MusicChannel(){stop();}

	const char *mci(const char *cmd){
		mciSendString(cmd,_errbuffer,1024,0);
		return _errbuffer;		
	}
	void play(const char *path,int flags){
		strcpy_s(_path,1024,path);
		sprintf_s(_alias,1024,"song%d",mcount++);
		sprintf_s(_buffer,1024,"open %s alias %s",_path,_alias);
		mci(_buffer);
		sprintf_s(_buffer,1024,"play %s from 0",_alias);
		mci(_buffer);
		playing=1;
	}
	void stop(){
		if (!playing) return;
		sprintf_s(_buffer,1024,"stop %s",_alias);
		mci(_buffer);
		sprintf_s(_buffer,1024,"close %s",_alias);
		mci(_buffer);
		playing=0;
	}
	void setPaused( bool paused ){
		if (!playing) return;
		if (paused)
			sprintf_s(_buffer,1024,"pause %s",_alias);
		else
			sprintf_s(_buffer,1024,"resume %s",_alias);
		mci(_buffer);
	}
	void setPitch( int pitch ){}
	void setVolume( float volume ){}
	void setPan( float pan ){}
	void set3d( const float pos[3],const float vel[3] ){}
	bool isPlaying(){return playing!=0;}
};

struct CDChannel : public gxChannel{
	char _buffer[1024];
	int playing;

	CDChannel(){playing=0;}
	~CDChannel(){stop();}

	const char *mci(const char *cmd){
		mciSendString(cmd,_buffer,1024,0);
		return _buffer;		
	}
	void play( int track,int mode ){
		stop();
		mci("open cdaudio");
		mci("set cdaudio time format tmsf");
		switch(mode){
			case 1: //single track
				sprintf_s(_buffer,1024,"play cdaudio from %d to %d",track,track+1);
				break;
			case 2: //repeatedly
				sprintf_s(_buffer,1024,"play cdaudio from %d to %d repeat",track,track+1);
				break;
			default://case 3: to end
				sprintf_s(_buffer,1024,"play cdaudio from %d",track);
				break;
		}
		mci(_buffer);
		mci("close cdaudio");
		playing=1;
	}
	void stop(){
		if (!playing) return;
		mci("open cdaudio");
		mci("stop cdaudio");
		mci("close cdaudio");
		playing=0;
	}
	void setPaused( bool paused ){
		mci("open cdaudio");
		mci("pause cdaudio");
		mci("close cdaudio");
	}
	void setPitch( int pitch ){
	}
	void setVolume( float volume ){
	}
	void setPan( float pan ){
	}
	void set3d( const float pos[3],const float vel[3] ){
	}
	bool isPlaying(){return playing!=0;}
};


struct dxChannel : public gxChannel{
	dxChannel():_buffer(0),_buffer3d(0){
	}
	~dxChannel(){
		stop();
	}
	void set( IDirectSoundBuffer *buffer,IDirectSound3DBuffer *buffer3d ){
		_buffer=buffer;
		_buffer3d=buffer3d;
	}
	void stop(){
		if(_buffer){
			_buffer->Stop();
			_buffer=0;
		}
	}
	void setPaused( bool paused ){
		if (!_buffer) return;
		if (paused){
			_buffer->Stop();
		}else{
			_buffer->Play(0,0,0);
		}
	}
	void setPitch( int pitch ){
		if (!_buffer) return;
		_buffer->SetFrequency(pitch);
	}
	void setVolume( float volume ){
		if (!_buffer) return;
		int v=(1-powf(volume,0.1))*-10000;
		_buffer->SetVolume(v);
	}
	void setPan( float pan ){
		if (!_buffer) return;
		LONG p;
		p=(LONG)pan*10000;
		_buffer->SetPan(p);
	}
	void set3d( const float pos[3],const float vel[3] ){
		if (!_buffer) return;
		if (_buffer3d){
			_buffer3d->SetPosition(pos[0],pos[1],pos[2],DS3D_IMMEDIATE);
			_buffer3d->SetVelocity(vel[0],vel[1],vel[2],DS3D_IMMEDIATE);
		}
	}
	bool isPlaying(){
		if (!_buffer) return 0;
		DWORD status;
		if (_buffer->GetStatus(&status)==0)
			return status&DSBSTATUS_PLAYING;
		return 0;
	}
private:
	IDirectSoundBuffer *_buffer;
	IDirectSound3DBuffer *_buffer3d;
};

static int next_chan;
static vector<dxChannel*> soundChannels;

static set<gxSound*> sound_set;
static vector<gxChannel*> channels;
static map<string,MusicChannel*> songs;
static CDChannel *cdChannel;

static dxChannel *allocChannel(IDirectSoundBuffer *ibuffer,IDirectSound3DBuffer *ibuffer3d){

	dxChannel *chan=0;
	for( int k=0;k<soundChannels.size();++k ){
		chan=soundChannels[next_chan];
		if( !chan ){
			chan=soundChannels[next_chan]=d_new dxChannel();
			channels.push_back(chan);
		}else if( chan->isPlaying() ){
			chan=0;
		}
		if( ++next_chan==soundChannels.size() ) next_chan=0;
		if( chan ) break;
	}

	if( !chan ){
		next_chan=soundChannels.size();
		soundChannels.resize(soundChannels.size()*2);
		for( int k=next_chan;k<soundChannels.size();++k ) soundChannels[k]=0;
		chan=soundChannels[next_chan++]=d_new dxChannel();
		channels.push_back( chan );
	}

	chan->set(ibuffer,ibuffer3d);
	return chan;
}

struct dxSound : gxSound{

	dxAudio *_owner;
	waveform *_wav;
	int _loop;
	int _freq;
	float _volume;
	float _pan;

	dxSound(dxAudio *audio,waveform *wav){
		_owner=audio;
		_wav=wav;
		_loop=0;
		_freq=wav->hertz;
		_volume=1.0;
		_pan=0.0;
	}
	
	gxChannel *play(){
		return _owner->play(this);
	}
	
	gxChannel *play3d( const float pos[3],const float vel[3] ){
		return _owner->play3d(this,pos,vel);
	}

	//modifiers
	void setLoop( bool loop ){_loop=loop;}
	void setPitch( int hertz ){_freq=hertz;}
	void setVolume( float volume ){_volume=volume;}
	void setPan( float pan ){_pan=pan;}
};


dxAudio::dxAudio( dxRuntime *r ): runtime(r){
	next_chan=0;
	soundChannels.resize( 4096 );
	for( int k=0;k<4096;++k ) soundChannels[k]=0;
	cdChannel=d_new CDChannel();
	channels.push_back( cdChannel );
	listener=0;
}

HMODULE dsoundlib=0;
HRESULT (_stdcall *myDirectSoundCreate)(LPGUID,LPDIRECTSOUND*,LPUNKNOWN);

int linkdsound(){
	if (dsoundlib) return 0;
	dsoundlib=LoadLibraryA("dsound");	
	if (dsoundlib==0) return -1;
	myDirectSoundCreate=(HRESULT (_stdcall *)(LPGUID,LPDIRECTSOUND*,LPUNKNOWN))GetProcAddress(dsoundlib,"DirectSoundCreate");
	if (!myDirectSoundCreate) {dsoundlib=0;return -1;}
	return 0;
}

DSCAPS dxaudiocaps;

int dxAudio::reset(HWND hwnd){			//HWND hwnd
	PCMWAVEFORMAT pcmwf; 
	DSBUFFERDESC dsbdesc; 
	int res;

	if (linkdsound()) return -1;
// init device
	directsound=0;
	primarybuffer=0;

	res=myDirectSoundCreate(0,&directsound,0);
	if (res) return res;		

	res=directsound->SetCooperativeLevel(hwnd,DSSCL_NORMAL);//DSSCL_PRIORITY);	//GetDesktopWindow()
	if (res) return res;	
//		printf("dsoundlib=%d soundcreate=%d res=%d\n",dsoundlib,(int)DirectSoundCreate,res);	
//		fflush(stdout);
	dxaudiocaps.dwSize=sizeof(DSCAPS);
	res=directsound->GetCaps(&dxaudiocaps);	
	if (res) return res;	
// set primary buffer format
	memset(&dsbdesc,0,sizeof(DSBUFFERDESC)); 	// Zero it out. 
	dsbdesc.dwSize=sizeof(DSBUFFERDESC); 
	dsbdesc.dwFlags=DSBCAPS_PRIMARYBUFFER|DSBCAPS_CTRL3D;	//3d capable please
	res=directsound->CreateSoundBuffer(&dsbdesc,&primarybuffer,0); 
	if (res) return res;
	memset(&pcmwf, 0, sizeof(PCMWAVEFORMAT)); 
	pcmwf.wf.wFormatTag=WAVE_FORMAT_PCM; 
	pcmwf.wf.nChannels=2;
	pcmwf.wf.nSamplesPerSec=44100;
	pcmwf.wBitsPerSample=16; 
	pcmwf.wf.nBlockAlign=4;
	pcmwf.wf.nAvgBytesPerSec=pcmwf.wf.nSamplesPerSec * pcmwf.wf.nBlockAlign; 
	res=primarybuffer->SetFormat((LPWAVEFORMATEX)&pcmwf);
//	if (res) return res;

	res=primarybuffer->QueryInterface(IID_IDirectSound3DListener,(LPVOID *)&listener);
	if (res) return res;

	return 0;
}

dxAudio::~dxAudio(){
	//free all channels
	for( ;channels.size();channels.pop_back() ) delete channels.back();
	//free all sound_set
	while( sound_set.size() ) freeSound( *sound_set.begin() );
	soundChannels.clear();
	songs.clear();
//	FSOUND_Close();
}

IDirectSoundBuffer *dxAudio::loadbuffer( dxSound *sample,int is3d ){
	IDirectSoundBuffer *ibuffer;
	PCMWAVEFORMAT pcmwf; 
	DSBUFFERDESC dsbdesc; 
	waveform *wav;

	wav=sample->_wav;
	
	memset(&pcmwf, 0, sizeof(PCMWAVEFORMAT)); 
	pcmwf.wf.wFormatTag=WAVE_FORMAT_PCM; 
	pcmwf.wf.nChannels=wav->channels;
	pcmwf.wf.nSamplesPerSec=sample->_freq;
	pcmwf.wBitsPerSample=wav->bits; 
	pcmwf.wf.nBlockAlign=(wav->channels*wav->bits)/8;
	pcmwf.wf.nAvgBytesPerSec=pcmwf.wf.nSamplesPerSec * pcmwf.wf.nBlockAlign; 

	memset(&dsbdesc,0,sizeof(DSBUFFERDESC)); 	// Zero it out. 
	dsbdesc.dwSize=sizeof(DSBUFFERDESC); 
	dsbdesc.dwFlags=DSBCAPS_GLOBALFOCUS|DSBCAPS_STATIC|DSBCAPS_CTRLPAN|DSBCAPS_CTRLVOLUME|DSBCAPS_CTRLFREQUENCY;

	if (is3d) dsbdesc.dwFlags|=DSBCAPS_CTRL3D;

	dsbdesc.lpwfxFormat=(LPWAVEFORMATEX)&pcmwf;

	int size=wav->capacity;

	if (size>0x1000000) size=0x1000000;

	dsbdesc.dwBufferBytes=size;

	int res=directsound->CreateSoundBuffer(&dsbdesc,&ibuffer,0); 
	if (res) return 0;

	void *ptr1,*ptr2;
	DWORD bytes1,bytes2;

	res=ibuffer->Lock( 0,size,&ptr1,&bytes1,&ptr2,&bytes2,0 );
	if (res) return 0;

	if (bytes1) memcpy(ptr1,wav->samples,bytes1);
	if (bytes2) memcpy(ptr2,(char*)wav->samples+bytes1,bytes2);
	res=ibuffer->Unlock(ptr1,bytes1,ptr2,bytes2);

	return ibuffer;
}

gxChannel *dxAudio::play( dxSound *sample ){
	IDirectSoundBuffer *ibuffer;
	int res;

	res=0;
	ibuffer=loadbuffer(sample,0);
	if (ibuffer){
		if (sample->_loop){
			res=ibuffer->Play(0,0,DSBPLAY_LOOPING);
			if (res) res=ibuffer->Play(0,0,0);
		}else{
			res=ibuffer->Play(0,0,0);
		}
		if (res==0) return allocChannel(ibuffer,0);
	}
	switch(res){
		case DSERR_BUFFERLOST:
		case DSERR_OUTOFMEMORY:
//		case DSERR_HWUNAVAIL:
		case DSERR_INVALIDCALL:  
		case DSERR_INVALIDPARAM:  
		case DSERR_PRIOLEVELNEEDED:
			break;
	}
	return 0;
}

gxChannel *dxAudio::play3d( dxSound *sample,const float pos[3],const float vel[3] ){
	dxChannel *channel;
	IDirectSoundBuffer *ibuffer;
	IDirectSound3DBuffer *ibuffer3d;
	int res;

	ibuffer=loadbuffer(sample,1);
	if (ibuffer){
		res=ibuffer->QueryInterface(IID_IDirectSound3DBuffer,(LPVOID*)&ibuffer3d);
		if (res) return 0;
		channel=(dxChannel*)allocChannel(ibuffer,ibuffer3d);
		channel->set3d(pos,vel);
		if (sample->_loop){
			ibuffer->Play(0,0,DSBPLAY_LOOPING);
		}else{
			ibuffer->Play(0,0,0);
		}
		return channel;
	}
	return 0;
}

void dxAudio::pause(){
}

void dxAudio::resume(){
}

gxSound *dxAudio::loadSound( const char *f,int flags ){
	waveform *sample;
	sample=LoadWaveform(f);
	if (!sample) return 0;
	dxSound *sound=d_new dxSound( this,sample );
	sound_set.insert( sound );
	return sound;
}

gxSound *dxAudio::verifySound( gxSound *s ){
	return sound_set.count( s )  ? s : 0;
}

void dxAudio::freeSound( gxSound *s ){
	if( sound_set.erase( s ) ) delete s;
}

void dxAudio::setPaused( bool paused ){
//	FSOUND_SetPaused( FSOUND_ALL,paused );
}

void dxAudio::setVolume( float volume ){
}

void dxAudio::set3dOptions( float roll,float dopp,float dist ){
	listener->SetRolloffFactor(roll,DS3D_DEFERRED);
	listener->SetDopplerFactor(dopp,DS3D_DEFERRED);
	listener->SetDistanceFactor(dist,DS3D_IMMEDIATE);
}

void dxAudio::set3dListener( const float pos[3],const float vel[3],const float front[3],const float top[3] ){
	listener->SetPosition(pos[0],pos[1],pos[2],DS3D_DEFERRED);
	listener->SetVelocity(vel[0],vel[1],vel[2],DS3D_DEFERRED);
	listener->SetOrientation(front[0],front[1],front[2],top[0],top[1],top[2],DS3D_IMMEDIATE);
}

gxChannel *dxAudio::playFile( const char *t,int flags ){
	string f=tolower( t );
	MusicChannel *chan=0;
	map<string,MusicChannel*>::iterator it=songs.find(f);
	if( it!=songs.end() ){
		chan=it->second;
		chan->play(t,flags);
		return chan;
	}
	chan=d_new MusicChannel();
	chan->play(t,flags);
	channels.push_back( chan );
	songs[f]=chan;
	return chan;
}

gxChannel *dxAudio::playCDTrack( int track,int mode ){
	cdChannel->play( track,mode );
	return cdChannel;
}

