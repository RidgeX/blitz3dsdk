// oggdecoder.c

#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>

#include <vorbis/vorbisfile.h>

static int quiet = 0;
static int bits = 16;
#if __APPLE__ && __BIG_ENDIAN__
static int endian = 1;
#else
static int endian = 0;
#endif
static int raw = 0;
static int sign = 1;

void *OpenOgg(FILE *file,int *samples,int *channels,int *freq){
    OggVorbis_File *ogg;
	int res;
	ogg_int64_t samples64;

	*samples=-1;
	ogg=(OggVorbis_File*)malloc(sizeof(OggVorbis_File));
	res=ov_open(file,ogg,0,0);
	if (res<0) {free(ogg);return 0;}
	samples64=ov_pcm_total(ogg,0);
	*samples=(int)samples64;
	*channels=ov_info(ogg,-1)->channels;
	*freq=ov_info(ogg,-1)->rate;
	return ogg;
}

int ReadOgg(OggVorbis_File *ogg,char *buf,int bytes){
	int res,bs;
	while (bytes>0){
		res=ov_read(ogg,buf,bytes,endian,bits/8,sign,&bs);
		if (res<0){
			if (bs) return -1;	// Only one logical bitstream currently supported
			return -2;			// Warning: hole in data
		}
		buf+=res;
		bytes-=res;
	}
	return 0;
}

int CloseOgg(OggVorbis_File *ogg){
	return ov_clear(ogg);
}
