#include "stdafx.h"

#include "waveform.h"
#include <stdio.h>
#include <malloc.h>
#include <memory.h>

#include <windows.h>
#include <mmreg.h>
#include <msacm.h>

waveform *readwav(FILE *file,int flags);
waveform *readmp3(FILE *file,int flags);
waveform *readogg(FILE *file,int flags);

waveform *LoadWaveform(const char *path){
	FILE *file;
	waveform *wav=0;
	file=fopen(path,"rb");
	if (file) {
		wav=readwav(file,0);
		if (wav==0) {
			fseek(file,0,SEEK_CUR);
			wav=readmp3(file,0);
		}
		if (wav==0) {
			fseek(file,0,SEEK_CUR);
			wav=readogg(file,0);
		}
		fclose(file);
	}
	return wav;
}

waveform *ConvertWaveform( waveform *src,int channels,int bits ){
	return src;
}

// ogg loader

extern "C" void *OpenOgg(FILE *file,int *samples,int *channels,int *freq);
extern "C" int ReadOgg(void *ogg,void *buf,int bytes);
extern "C" int CloseOgg(void *ogg);

waveform *readogg(FILE *file,int flags){
	void *ogg;
	int samples,channels,freq;

	ogg=OpenOgg(file,&samples,&channels,&freq);
	if (ogg==0) return 0;

	int sizebytes=channels*samples*2;

	waveform *wf=new waveform();
	wf->bits=16;
	wf->capacity=sizebytes;
	wf->channels=channels;
	wf->bits=16;
	wf->hertz=freq;
	wf->length=samples;				//sizebytes/4;
	wf->samples=malloc(sizebytes);

	ReadOgg(ogg,wf->samples,sizebytes);
	CloseOgg(ogg);
	return wf;
}

// mp3 loader

#define MP3_BLOCK_SIZE 522

int g_mp3Drivers = 0;

BOOL CALLBACK acmDriverEnumCallback( HACMDRIVERID hadid, DWORD dwInstance, DWORD fdwSupport ){
  if( fdwSupport & ACMDRIVERDETAILS_SUPPORTF_CODEC ) {
    MMRESULT mmr;

    ACMDRIVERDETAILS details;
    details.cbStruct = sizeof(ACMDRIVERDETAILS);
    mmr = acmDriverDetails( hadid, &details, 0 );

    HACMDRIVER driver;
    mmr = acmDriverOpen( &driver, hadid, 0 );

    int i;
    for(i = 0; i < details.cFormatTags; i++ ){
      ACMFORMATTAGDETAILS fmtDetails;
      ZeroMemory( &fmtDetails, sizeof(fmtDetails) );
      fmtDetails.cbStruct = sizeof(ACMFORMATTAGDETAILS);
      fmtDetails.dwFormatTagIndex = i;
      mmr = acmFormatTagDetails( driver, &fmtDetails, ACM_FORMATTAGDETAILSF_INDEX );
      if( fmtDetails.dwFormatTag == WAVE_FORMAT_MPEGLAYER3 ){
	OutputDebugString( "Found an MP3-capable ACM codec: " );
	OutputDebugString( details.szLongName );
	OutputDebugString( "\n" );
	g_mp3Drivers++;
      }
    }
    mmr = acmDriverClose( driver, 0 );
  }
  return true;
}

struct id3info{
	char tag[3];
	char title[30];
	char artist[30];
	char album[30];
	char year[4];
	char comment[30];
	char genre[1];
};

struct block{
	block *prev;
	int size;
	void *mem;
};

waveform *readmp3(FILE *file,int flags){
	MMRESULT res;
	id3info hdr;

    fseek(file,-128,SEEK_END);
	int n=fread(&hdr,sizeof(hdr),1,file);
    fseek(file,0,SEEK_SET);

	if(memcmp(hdr.tag,"TAG",3)) return 0;

	g_mp3Drivers=0;
	acmDriverEnum( acmDriverEnumCallback, 0, 0 );
	if(g_mp3Drivers==0){
		OutputDebugString( "No MP3 decoders found!\n" );
		return 0;
	}

	DWORD maxFormatSize = 0;
	res=acmMetrics(NULL,ACM_METRIC_MAX_SIZE_FORMAT,&maxFormatSize );

	WAVEFORMATEX dest={0};    
	dest.wFormatTag=WAVE_FORMAT_PCM;
	dest.nChannels=2;
	dest.nSamplesPerSec=44100;
	dest.wBitsPerSample=16;
	dest.nBlockAlign=4;
	dest.nAvgBytesPerSec=dest.nBlockAlign*dest.nSamplesPerSec;
	dest.cbSize=0;

	LPMPEGLAYER3WAVEFORMAT mp3format=(LPMPEGLAYER3WAVEFORMAT)malloc(maxFormatSize);
	mp3format->wfx.cbSize = MPEGLAYER3_WFX_EXTRA_BYTES;
	mp3format->wfx.wFormatTag = WAVE_FORMAT_MPEGLAYER3;
	mp3format->wfx.nChannels = 2;
	mp3format->wfx.nAvgBytesPerSec = 128 * (1024 / 8);  // not really used but must be one of 64, 96, 112, 128, 160kbps
	mp3format->wfx.wBitsPerSample = 0;                  // MUST BE ZERO
	mp3format->wfx.nBlockAlign = 1;                     // MUST BE ONE
	mp3format->wfx.nSamplesPerSec = 44100;              // 44.1kHz
	mp3format->fdwFlags = MPEGLAYER3_FLAG_PADDING_OFF;
	mp3format->nBlockSize = MP3_BLOCK_SIZE;             // voodoo value #1
	mp3format->nFramesPerBlock = 1;                     // MUST BE ONE
	mp3format->nCodecDelay = 1393;                      // voodoo value #2
	mp3format->wID = MPEGLAYER3_ID_MPEG;

	HACMSTREAM stream;
	res=acmStreamOpen(&stream,0,(LPWAVEFORMATEX)mp3format,&dest,NULL,0,0,0);
	free(mp3format);

	if (res) {return 0;}

	unsigned long rawbufsize = 0;
	res=acmStreamSize(stream,MP3_BLOCK_SIZE,&rawbufsize,ACM_STREAMSIZEF_SOURCE);
	if (res) return 0;
 
	LPBYTE mp3buf=(LPBYTE)malloc(MP3_BLOCK_SIZE);
	LPBYTE rawbuf=(LPBYTE)malloc(rawbufsize);
  
	ACMSTREAMHEADER mp3streamHead={0};
	mp3streamHead.cbStruct=sizeof(ACMSTREAMHEADER );
	mp3streamHead.pbSrc=mp3buf;
	mp3streamHead.cbSrcLength=MP3_BLOCK_SIZE;
	mp3streamHead.pbDst=rawbuf;
	mp3streamHead.cbDstLength=rawbufsize;
	
	res=acmStreamPrepareHeader(stream,&mp3streamHead,0);
	if (res) return 0;

	block *prev=0;
	int sizebytes=0;
	while(1) {
// suck in some MP3 data
		int count=fread(mp3buf,1,MP3_BLOCK_SIZE,file);
		if (count==0) break;
//		mp3streamHead.cbSrcLength=count;
		res=acmStreamConvert(stream,&mp3streamHead,ACM_STREAMCONVERTF_BLOCKALIGN);
		if (res) return 0;
		int n=mp3streamHead.cbDstLengthUsed;
		if (n){
			block *b=new block;
			b->prev=prev;
			b->size=n;
			b->mem=malloc(n);
			memcpy(b->mem,rawbuf,n);
			prev=b;
			sizebytes+=n;
		}
	};

	waveform *wf=new waveform();
	wf->bits=16;
	wf->capacity=sizebytes;
	wf->channels=2;
	wf->bits=16;
	wf->hertz=44100;
	wf->length=sizebytes/4;
	wf->samples=malloc(sizebytes);

	char *p=(char*)wf->samples+sizebytes;
	while (prev){
		p-=prev->size;
		memcpy(p,prev->mem,prev->size);
		free(prev->mem);
		block*b=prev;
		prev=b->prev;		
		delete b;
	}

	res=acmStreamUnprepareHeader(stream,&mp3streamHead,0);
	if (res) return 0;
	free(rawbuf);
	free(mp3buf);
	res=acmStreamClose(stream,0);
	if (res) return 0;

	return wf;
}

// wav loader

#define PCMFORMAT 1

struct wavinfo{
	short	format,channels;
	int		hz,bytespersec;
	short	pad,samplesize;
};

waveform *readwav(FILE *file,int flags){
	wavinfo		w;
	char		tag[4];
	int			len,len2;
	int			samples,freq,channels,bits,sizebytes,samplesize;

	fread(tag,4,1,file);
	if (memcmp(tag,"RIFF",4)) return 0;
	fread(&len,4,1,file);
	len-=8;

	fread(tag,4,1,file);
	if (memcmp(tag,"WAVE",4)) return 0;

	fread(tag,4,1,file);
	if (memcmp(tag,"fmt ",4)) return 0;
	fread(&len2,4,1,file);

	fread(&w,sizeof(w),1,file);
	if (w.format!=1) return 0;
	freq=w.hz;
	channels=w.channels;
	bits=w.samplesize;
	if (w.format!=PCMFORMAT) return 0;	
	if (len2>16) {
		fseek(file,len2-16,SEEK_CUR);//in->skip(len2-16);
	}
	
	while(1){
		int n;
		n=fread(tag,4,1,file);
		n=fread(&sizebytes,4,1,file);

		if (memcmp(tag,"data",4)==0){
			samplesize=channels*bits/8;
			samples=sizebytes/samplesize;
			waveform *wave;
			wave=new waveform;
			wave->capacity=sizebytes;
			wave->channels=w.channels;
			wave->bits=w.samplesize;
			wave->hertz=freq;
			wave->length=samples;
			wave->samples=malloc(sizebytes);
			fread(wave->samples,sizebytes,1,file);
			return wave;
		}
		fseek(file,sizebytes,SEEK_CUR);
	}
}
